/*
 * Copyright (c) 2014 Robert Blust (Z�rich, Switzerland) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *    Robert Blust - initial API and implementation
 */
package ch.flatland.cdo.util

import com.google.gson.Gson
import com.google.gson.JsonArray
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.google.gson.JsonParser
import com.google.gson.JsonPrimitive
import java.math.BigDecimal
import java.math.BigInteger
import java.text.SimpleDateFormat
import java.util.Date
import java.util.LinkedHashMap
import java.util.List
import java.util.Map
import org.apache.commons.codec.binary.Base64
import org.eclipse.emf.cdo.CDOObject
import org.eclipse.emf.cdo.common.revision.delta.CDOFeatureDelta
import org.eclipse.emf.cdo.common.security.NoPermissionException
import org.eclipse.emf.cdo.eresource.CDOResourceNode
import org.eclipse.emf.common.util.Diagnostic
import org.eclipse.emf.common.util.Enumerator
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EAttribute
import org.eclipse.emf.ecore.EClassifier
import org.eclipse.emf.ecore.EEnum
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.EStructuralFeature
import org.eclipse.emf.ecore.util.EcoreUtil
import org.eclipse.emf.edit.EMFEditPlugin
import org.eclipse.emf.edit.provider.AdapterFactoryItemDelegator
import org.eclipse.emf.edit.provider.ComposedAdapterFactory
import org.eclipse.emf.internal.cdo.object.CDOLegacyAdapter
import org.slf4j.LoggerFactory

import static ch.flatland.cdo.util.Constants.*
import static javax.servlet.http.HttpServletResponse.*

class JsonConverter {
	val logger = LoggerFactory.getLogger(this.class)

	val gson = new Gson
	val parser = new JsonParser
	val dateFormat = new SimpleDateFormat(DATE_FORMAT);
	val extension EMF = new EMF
	val extension View = new View
	val extension HttpStatus = new HttpStatus

	val diagnostics = new LinkedHashMap<EObject, List<Diagnostic>>
	val revisionDeltas = new LinkedHashMap<EObject, List<CDOFeatureDelta>>

	val ITEM_DELEGATOR = new AdapterFactoryItemDelegator(new ComposedAdapterFactory(EMFEditPlugin.getComposedAdapterFactoryDescriptorRegistry))

	static val ignoredAttributes = newArrayList("uRI", "resourceSet", "modified", "loaded", "trackingModification", "errors", "warnings", "timeStamp")

	var JsonConverterConfig jsonConverterConfig

	new(JsonConverterConfig jsonConverterConfig) {
		this.jsonConverterConfig = jsonConverterConfig
	}

	new() {
		this.jsonConverterConfig = new JsonConverterConfig
	}

	def getConfig() {
		jsonConverterConfig
	}

	def getDiagnostics() {
		diagnostics
	}

	def isValid() {
		diagnostics.size == 0
	}

	def getRevisionDeltas() {
		revisionDeltas
	}

	def JsonObject safeFromJson(String jsonString) {
		try {
			parser.parse(jsonString).asJsonObject
		} catch(Exception e) {
			throw new FlatlandException(SC_BAD_REQUEST, "Failed to parse json")
		}
	}

	def toEObject(JsonObject jsonObject, EObject eObject) {
		jsonObject.entrySet.filter[it.key != ID].forEach [
			val jsonName = it.key
			val jsonElement = it.value
			logger.debug("Found json element with name '{}'", jsonName)
			if(jsonName == ATTRIBUTES) {
				jsonElement.attributes = eObject
			}
			if(jsonName == REFERENCES) {
				jsonElement.references = eObject
			}
		]
		eObject
	}

	def okToJson() {
		newObjectWithStatus().toString
	}

	def dispatch String safeToJson(Object object) {
		try {
			gson.toJson(object)
		} catch(Exception e) {
			throw new FlatlandException(SC_INTERNAL_SERVER_ERROR, e.message)
		}
	}

	def dispatch String safeToJson(List<EObject> objects) {
		try {
			val jsonArray = new JsonArray

			for (object : objects) {
				val jsonBaseObject = object.toJsonBase

				jsonBaseObject.addAttributes(object)
				if(jsonConverterConfig.showReferences) {
					jsonBaseObject.addReferences(object)
				}
				jsonBaseObject.addMessagesAndMeta(object)
				jsonArray.add(jsonBaseObject)
			}

			// finally add status with messages
			val objectWithStatus = newObjectWithStatus

			objectWithStatus.add(DATA, jsonArray)

			objectWithStatus.toString
		} catch(NoPermissionException npe) {
			throw new FlatlandException(SC_FORBIDDEN, npe.message)
		} catch(Exception e) {
			throw new FlatlandException(SC_BAD_REQUEST, e.message)
		}
	}

	def dispatch String safeToJson(EObject object) {
		try {
			val jsonBaseObject = object.toJsonBase

			jsonBaseObject.addAttributes(object)
			if(jsonConverterConfig.showReferences) {
				jsonBaseObject.addReferences(object)
			}

			jsonBaseObject.addMessagesAndMeta(object)

			// finally add status with messages
			val objectWithStatus = newObjectWithStatus

			objectWithStatus.add(DATA, jsonBaseObject)

			objectWithStatus.toString
		} catch(NoPermissionException npe) {
			throw new FlatlandException(SC_FORBIDDEN, npe.message)
		} catch(Exception e) {
			throw new FlatlandException(SC_BAD_REQUEST, e.message)
		}
	}

	def dispatch String safeToJson(FlatlandException object) {
		val jsonStatusObject = new JsonObject
		jsonStatusObject.addProperty(STATUS, FlatlandException.STATUS.name)
		val error = new JsonObject
		jsonStatusObject.add(ERROR, error)

		if(object.origin == null) {
			error.addProperty(ORIGIN, object.class.simpleName)
		} else {
			error.addProperty(ORIGIN, object.origin.url)
		}
		error.addProperty(MESSAGE, object.message)
		error.addProperty(HTTP_STATUS, object.httpStatus)
		error.addProperty(HTTP_STATUS_DESCRIPTION, object.httpStatus.description)

		jsonStatusObject.toString
	}

	def private toJsonBase(EObject object) {
		val jsonBaseObject = new JsonObject
		jsonBaseObject.addType(object.eClass)

		// CDO Legacy Adapter implements EObject but is not an EObject
		// ITEM_DELEGATOR does a cast to EObject
		if(object instanceof CDOLegacyAdapter) {
			jsonBaseObject.addProperty(LABEL, object.toString)
		} else {
			jsonBaseObject.addProperty(LABEL, ITEM_DELEGATOR.getText(object))
		}
		jsonBaseObject.addProperty(ID, object.oid)
		jsonBaseObject.addProperty(HREF, object.url)
		if(object.eContainer != null) {
			jsonBaseObject.addProperty(CONTAINER, object.eContainer.url)
		} else {

			// it must be contained in a CDOResourceNode
			jsonBaseObject.addProperty(CONTAINER, (object.eResource as CDOResourceNode).url)
		}
		if(object instanceof CDOObject) {
			jsonBaseObject.addProperty(PERMISSION, object.cdoPermission.name)
			jsonBaseObject.addProperty(REVISION, REVISION_PREFIX + object.cdoRevision.version)
			jsonBaseObject.addRevisions(object)

		}
		return jsonBaseObject
	}

	def private addRevisions(JsonObject jsonBaseObject, CDOObject object) {
		if(jsonConverterConfig.revisions) {
			object.cdoHistory.triggerLoad
			while(object.cdoHistory.loading) {
				//TODO could be long running!
			}
			val historySize = object.cdoHistory.size
			if(historySize > 1) {
				val jsonRevisionsArray = new JsonArray
				jsonBaseObject.add(REVISIONS, jsonRevisionsArray)
				for (var i = historySize - 1; i > 0; i--) {
					val commitInfo = object.cdoHistory.getElement(i)
					val jsonRevsionObject = new JsonObject
					jsonRevsionObject.addProperty(REVISION_PREFIX + (historySize - i), object.url + "?" + PARAM_TIMESTAMP + "=" + commitInfo.timeStamp)
					logger.debug("'{}' resolved revsion '{}'", object, REVISION_PREFIX + (historySize - i))
					jsonRevisionsArray.add(jsonRevsionObject)
				}
			}
		}

	}

	def private addAttributes(JsonObject jsonBaseObject, EObject object) {
		val attributes = object.eClass.EAllAttributes
		val jsonAttributes = new JsonObject
		if(attributes.size > 0) {
			for (attribute : attributes.filter[!ignoredAttributes.contains(name)]) {
				val name = attribute.name
				if(attribute.many) {
					val values = object.eGet(attribute, true) as List<Object>
					if(values.size > 0) {
						val jsonPrimitiveArray = new JsonArray
						for (value : values) {
							jsonPrimitiveArray.add(value.toJsonPrimitive)
						}
						jsonAttributes.add(name, jsonPrimitiveArray)
					}
				} else {
					val value = object.eGet(attribute, true)
					if(value != null) {
						jsonAttributes.add(name, value.toJsonPrimitive)
					}
				}
			}
			if(jsonAttributes.entrySet.size > 0) {
				jsonBaseObject.add(ATTRIBUTES, jsonAttributes)
			}
		}
	}

	def private addReferences(JsonObject jsonBaseObject, EObject eObject) {
		val references = eObject.eClass.EAllReferences
		val jsonReferences = new JsonObject
		if(references.size > 0) {
			for (EReference reference : references) {
				val name = reference.name
				if(reference.many) {
					val List<Object> values = eObject.eGet(reference, true) as List<Object>
					if(values.size > 0) {
						val jsonReferencesArray = new JsonArray
						for (value : values) {
							val jsonRefObject = value.toJsonObject as JsonObject

							// should we add attributes or not?
							jsonRefObject.addAttributes(value as EObject)
							jsonRefObject.addMessagesAndMeta(value as EObject)
							jsonReferencesArray.add(jsonRefObject)
						}
						jsonReferences.add(name, jsonReferencesArray)
					}
				} else {
					val value = eObject.eGet(reference, true)
					if(value != null) {
						val jsonRefObject = value.toJsonObject as JsonObject
						jsonRefObject.addAttributes(value as EObject)
						jsonRefObject.addMessagesAndMeta(value as EObject)
						jsonReferences.add(name, jsonRefObject)
					}
				}
			}
			if(jsonReferences.entrySet.size > 0) {
				jsonBaseObject.add(REFERENCES, jsonReferences)
			}
		}
	}

	def private addMeta(JsonObject jsonBaseObject, EObject object) {
		val attributes = object.eClass.EAllAttributes.filter[!ignoredAttributes.contains(it.name)]
		val references = object.eClass.EAllReferences

		val jsonTypeMeta = new JsonObject

		if(attributes.size > 0) {
			val jsonAttributes = new JsonArray
			jsonTypeMeta.add(ATTRIBUTES, jsonAttributes)
			for (attribute : attributes) {
				val jsonAttribute = new JsonObject
				jsonAttribute.addFeatureMeta(attribute)
				jsonAttributes.add(jsonAttribute)
			}
		}

		if(references.size > 0) {
			val jsonReferences = new JsonArray
			jsonTypeMeta.add(REFERENCES, jsonReferences)
			for (reference : references) {
				val jsonReference = new JsonObject
				jsonReference.addFeatureMeta(reference)
				jsonReferences.add(jsonReference)
			}
		}
		jsonBaseObject.add(PARAM_META, jsonTypeMeta)
	}

	def private addFeatureMeta(JsonObject jsonBaseObject, EStructuralFeature feature) {

		if(feature instanceof EAttribute) {
			jsonBaseObject.add(FEATURE, new JsonPrimitive(ATTRIBUTES + "." + feature.name))
			jsonBaseObject.addType(feature.EAttributeType)
			if(feature.EAttributeType instanceof EEnum) {
				val enum = feature.EAttributeType as EEnum
				val jsonLiterals = new JsonArray
				for (literal : enum.ELiterals) {
					jsonLiterals.add(new JsonPrimitive(literal.name))
					jsonBaseObject.add(ENUM_LITERALS, jsonLiterals)
				}
			}
			jsonBaseObject.addProperty(INSTANCE_CLASS_NAME, feature.EAttributeType.instanceClassName)
			feature.EAttributeType.EAnnotations.forEach [
				it.details.filter[it.key.toString != "name" && it.key.toString != "baseType"].forEach [
					try {
						jsonBaseObject.addProperty(it.key, Integer.parseInt(it.value))
					} catch(Exception e) {
						jsonBaseObject.addProperty(it.key, it.value)
						logger.debug("Not an int '{}'", it.value)
					}
				]
			]
		}
		if(feature instanceof EReference) {
			jsonBaseObject.add(FEATURE, new JsonPrimitive(REFERENCES + "." + feature.name))
			jsonBaseObject.addType(feature.EReferenceType)
			jsonBaseObject.add(CONTAINMENT, new JsonPrimitive(feature.isContainment))
		}
		jsonBaseObject.addProperty(DERIVED, feature.isDerived)
		jsonBaseObject.addProperty(MANY, feature.isMany)
		jsonBaseObject.addProperty(REQUIRED, feature.required)
		jsonBaseObject.addProperty(LOWER_BOUND, feature.lowerBound)
		jsonBaseObject.addProperty(UPPER_BOUND, feature.upperBound)
	}

	def private addMessagesAndMeta(JsonObject jsonBaseObject, EObject object) {

		// validation requested?
		if(jsonConverterConfig.validate) {
			val diags = object.validate
			if(diags.size > 0) {
				if(!diagnostics.containsKey(object)) {
					diagnostics.put(object, diags)
				}
			}
		}

		// meta requested?
		if(jsonConverterConfig.meta) {
			jsonBaseObject.addMeta(object)
		}
	}

	def private addType(JsonObject jsonBaseObject, EClassifier classifier) {
		jsonBaseObject.addProperty(TYPE, classifier.type)
	}

	def private dispatch toJsonObject(Object object) {
		logger.error("NO DISPATCH MEHTOD for toJsonObject({}) ", object.class.name)
		new JsonPrimitive(object.toString)
	}

	def private dispatch toJsonObject(EObject object) {
		object.toJsonBase
	}

	def private dispatch getUrl(CDOResourceNode object) {
		ALIAS_NODE + object.path + object.timestampParam
	}

	def private dispatch getUrl(EObject object) {
		var id = ""
		if(object instanceof CDOObject) {
			id = object.cdoID.toURIFragment.replace("L", "")
		} else {

			// Legacy models do not inherit from CDOObject
			id = EcoreUtil.getURI(object).fragment.replace("L", "")
		}
		ALIAS_OBJECT + "/" + object.eClass.EPackage.nsPrefix + "." + object.eClass.name + "/" + id + object.timestampParam

	}
	
	def private getTimestampParam(EObject object) {
		if (object instanceof CDOObject) {
			if (object.view.timeStamp > 0) {
				return "?" + PARAM_TIMESTAMP + "=" + object.view.timeStamp
			}
		}
		return ""
	}

	def private getOid(EObject object) {
		val uri = EcoreUtil.getURI(object)
		return Long.parseLong(uri.fragment.replace("L", ""))
	}

	def private setAttributes(JsonElement element, EObject eObject) {
		if(element.jsonObject) {

			// should always be the case if it is a valid json
			val jsonObject = element.asJsonObject
			jsonObject.entrySet.forEach [
				val jsonName = it.key
				val jsonElement = it.value
				logger.debug("Found attribute with name '{}'", jsonName)
				val eAttribute = eObject.eClass.EAllAttributes.filter[it.name == jsonName].head
				if(eAttribute != null) {
					logger.debug("Found matching eAttribute with name '{}'", jsonName)
					if(jsonElement.isAttributeSettable(eAttribute)) {
						logger.debug("Match - json attribute is settable to eAttribute for '{}'", jsonName)
						if(eAttribute.many) {
							val eArray = newArrayList
							if(jsonElement.jsonNull) {
								logger.debug("JsonElement '{}' is null", jsonName)
							} else {
								jsonElement.asJsonArray.forEach [
									val eType = it.asJsonPrimitive.safeToEType(eAttribute)
									if(eType != null) {
										eArray.add(eType)
									}
								]
							}
							eObject.safeSetAttributeArray(eAttribute, eArray)
						} else {
							if(jsonElement.jsonNull) {
								logger.debug("JsonElement '{}' is null", jsonName)
								eObject.eUnset(eAttribute)
							} else {
								val eType = jsonElement.asJsonPrimitive.safeToEType(eAttribute)
								if(eType != null) {
									eObject.eSet(eAttribute, eType)
								}
							}
						}
					} else {
						logger.debug("MISSmatch - json attribute is NOT settable to eAttribute for '{}'", jsonName)
					}
				} else {
					logger.debug("NOT found matching eAttribute with name '{}'", jsonName)
				}
			]
		}
	}

	def private setReferences(JsonElement element, EObject eObject) {
		if(element.jsonObject) {

			// should always be the case if it is a valid json
			val jsonObject = element.asJsonObject
			jsonObject.entrySet.forEach [
				val jsonName = it.key
				val jsonElement = it.value
				logger.debug("Found reference with name '{}'", jsonName)
				val eReference = eObject.eClass.EAllReferences.filter[it.name == jsonName].head
				if(eReference != null) {
					logger.debug("Found matching eReference with name '{}'", jsonName)
					if(jsonElement.isReferenceSettable(eReference)) {
						logger.debug("Match - json reference is settable to eReference for '{}'", jsonName)
						if(eReference.many) {
							val eArray = newArrayList
							if(jsonElement.jsonNull) {
								logger.debug("JsonElement '{}' is null", jsonName)
							} else {
								jsonElement.asJsonArray.forEach [
									val jsonRefObject = it.asJsonObject
									val id = jsonRefObject.safeResolveId
									if(id.value.jsonNull) {
										logger.debug("JsonElement '{}' is null", id.key)
									} else {
										logger.debug("Object '{}' requested", id)
										val referencedObject = eObject.view.safeRequestObject(id.value.safeAsLong)

										logger.debug("ReferencedObject '{}'", referencedObject)
										eArray.add(referencedObject)
									}
								]
							}
							eObject.safeSetReferenceArray(eReference, eArray)
						} else {
							if(jsonElement.jsonNull) {
								logger.debug("JsonElement '{}' is null", jsonName)
								eObject.eUnset(eReference)
							} else {
								val jsonRefObject = jsonElement.asJsonObject
								val id = jsonRefObject.safeResolveId

								if(id.value.jsonNull) {
									logger.debug("JsonElement '{}' is null", id.key)
									eObject.eUnset(eReference)
								} else {
									logger.debug("Object '{}' requested", id)
									val referencedObject = eObject.view.safeRequestObject(id.value.safeAsLong)

									logger.debug("ReferencedObject '{}'", referencedObject)
									eObject.safeSetReference(eReference, referencedObject)
								}
							}
						}
					} else {
						logger.debug("MISSmatch - json reference is NOT settable to eReference for '{}'", jsonName)
					}
				} else {
					logger.debug("NOT found matching eReference with name '{}'", jsonName)
				}
			]
		}
	}

	def private safeToEType(JsonPrimitive jsonPrimitive, EAttribute eAttribute) {
		logger.debug("eAttribute '{}' has data type '{}', try to set json value '{}'", eAttribute.name, eAttribute.EAttributeType.name, jsonPrimitive)
		try {
			switch eAttribute.EAttributeType.instanceClass {
				case typeof(String): return jsonPrimitive.asString
				case typeof(boolean): return jsonPrimitive.asBoolean
				case typeof(Boolean): return jsonPrimitive.asBoolean
				case typeof(int): return jsonPrimitive.asInt
				case typeof(Integer): return jsonPrimitive.asInt
				case typeof(long): return jsonPrimitive.asLong
				case typeof(Long): return jsonPrimitive.asLong
				case typeof(short): return jsonPrimitive.asShort
				case typeof(Short): return jsonPrimitive.asShort
				case typeof(double): return jsonPrimitive.asDouble
				case typeof(Double): return jsonPrimitive.asDouble
				case typeof(float): return jsonPrimitive.asFloat
				case typeof(Float): return jsonPrimitive.asFloat
				case typeof(byte): return jsonPrimitive.asByte
				case typeof(Byte): return jsonPrimitive.asByte
				case typeof(char): return jsonPrimitive.asCharacter
				case typeof(Character): return jsonPrimitive.asCharacter
				case typeof(Date): return dateFormat.parse(jsonPrimitive.asString)
				case typeof(BigDecimal): return jsonPrimitive.asBigDecimal
				case typeof(BigInteger): return jsonPrimitive.asBigInteger
				case typeof(byte[]): return Base64.decodeBase64(jsonPrimitive.asString)
			}

			if(eAttribute.EAttributeType instanceof EEnum) {
				logger.debug("'{}' is an EEnum", eAttribute.EAttributeType.name)
				val enum = eAttribute.EAttributeType as EEnum
				val literal = enum.getEEnumLiteral(jsonPrimitive.asString)
				if(literal != null) {
					return literal.instance
				}
				return null
			}
		} catch(Exception e) {
			throw new FlatlandException(SC_BAD_REQUEST, "Json primitive '{}' could not be converted to '{}' for attribute '{}", jsonPrimitive.asString, eAttribute.EAttributeType.name, eAttribute.name)
		}

		logger.error("NO CONVERSION WAS POSSIBLE of eAttribute '{}' to data type {}", eAttribute.name, eAttribute.EAttributeType.name)
		return null
	}

	def private dispatch toJsonPrimitive(Object object) {
		logger.error("NO DISPATCH MEHTOD for getJsonPrimitive({}) ", object.class.name)
		new JsonPrimitive(object.toString)
	}

	def private dispatch toJsonPrimitive(byte[] bytes) {
		new JsonPrimitive(Base64.encodeBase64String(bytes))
	}

	def private dispatch toJsonPrimitive(Number object) {
		new JsonPrimitive(object)
	}

	def private dispatch toJsonPrimitive(Character object) {
		new JsonPrimitive(object.toString)
	}

	def private dispatch toJsonPrimitive(Date object) {
		new JsonPrimitive(dateFormat.format(object))
	}

	def private dispatch toJsonPrimitive(URI object) {
		new JsonPrimitive(object.toString)
	}

	def private dispatch toJsonPrimitive(String object) {
		new JsonPrimitive(object)
	}

	def private dispatch toJsonPrimitive(Enumerator object) {
		new JsonPrimitive(object.name)
	}

	def private dispatch toJsonPrimitive(Boolean object) {
		new JsonPrimitive(object)
	}

	def private getDiagnosticsAsJsonArray(Map<EObject, List<Diagnostic>> localDiagnostics) {
		if(localDiagnostics.size > 0) {
			val messageArray = new JsonArray
			localDiagnostics.keySet.forEach [
				val origin = new JsonObject
				origin.add(ORIGIN, new JsonPrimitive(it.url))
				val diagsArray = new JsonArray
				origin.add(DIAGNOSTIC, diagsArray)
				localDiagnostics.get(it).forEach [
					val diag = new JsonObject
					diag.addProperty(MESSAGE, it.message)
					val feature = it.data.get(1) as EStructuralFeature
					if(feature instanceof EAttribute) {
						diag.addProperty(FEATURE, (ATTRIBUTES + "." + feature.name))
					} else {
						diag.addProperty(FEATURE, (REFERENCES + "." + feature.name))
					}
					diagsArray.add(diag)
					if(it.children.size > 0) {
						val detailsArray = new JsonArray
						it.children.forEach [
							detailsArray.add(new JsonPrimitive(it.message))
						]
						diag.add(DETAILS, detailsArray)
					}
				]
				messageArray.add(origin)
			]
			return messageArray
		}
		return null
	}

	def private getRevisionDeltasAsJsonArray(Map<EObject, List<CDOFeatureDelta>> localRevisionDelta) {
		if(localRevisionDelta.size > 0) {
			val messageArray = new JsonArray
			localRevisionDelta.keySet.forEach [
				val origin = new JsonObject
				origin.add(ORIGIN, new JsonPrimitive(it.url))
				val deltasArray = new JsonArray
				origin.add(REVISION_DELTA, deltasArray)
				val object = it
				localRevisionDelta.get(object).forEach[val delta = new JsonObject delta.addProperty(MESSAGE, "Changed feature '" + it.feature.name + "' of '" + ITEM_DELEGATOR.getText(object) + "' to '" + object.eGet(it.feature) + "'")
					if(it.feature instanceof EAttribute) {
						delta.addProperty(FEATURE, (ATTRIBUTES + "." + feature.name))
					} else {
						delta.addProperty(FEATURE, (REFERENCES + "." + feature.name))
					} deltasArray.add(delta)]
				messageArray.add(origin)
			]
			return messageArray
		}
	}

	def getView(EObject eObject) {
		(eObject as CDOObject).cdoView
	}

	def newObjectWithStatus() {

		val objectWithStatus = new JsonObject
		if(diagnostics.size == 0) {
			objectWithStatus.addProperty(STATUS, MessageStatus.OK.name)
		} else {
			objectWithStatus.addProperty(STATUS, MessageStatus.INVALID.name)
		}

		val jsonBaseObject = new JsonObject
		jsonBaseObject.add(STATUS, objectWithStatus)
		if(diagnostics.size > 0) {
			objectWithStatus.add(DIAGNOSTICS, diagnostics.diagnosticsAsJsonArray)
		}
		if(revisionDeltas.size > 0) {
			objectWithStatus.add(REVISION_DELTAS, revisionDeltas.revisionDeltasAsJsonArray)
		}
		return jsonBaseObject
	}

	// methods which could throw an Exception
	def safeResolveId(JsonObject jsonObject) {
		val id = jsonObject.entrySet.filter[it.key == ID].head
		if(id == null || id.value.isJsonNull) {
			throw new FlatlandException(SC_BAD_REQUEST, "Attribute '{}' missing or null", ID)
		}
		return id
	}

	def safeResolvePut(JsonObject jsonObject) {
		val put = jsonObject.entrySet.filter[it.key == PUT].head
		if(put == null || put.value.isJsonNull) {
			throw new FlatlandException(SC_BAD_REQUEST, "Attribute '{}' missing or null", PUT)
		}
		return put
	}

	def safeResolveType(JsonObject jsonObject) {
		val type = jsonObject.entrySet.filter[it.key == TYPE].head
		if(type == null || type.value.isJsonNull) {
			throw new FlatlandException(SC_BAD_REQUEST, "Attribute '{}' missing or null", TYPE)
		}
		return type
	}

	def safeAsLong(JsonElement element) {
		try {
			return element.asLong
		} catch(Exception e) {
			throw new FlatlandException(SC_BAD_REQUEST, "Attribute '{}={}' must be a long", ID, element.asString)
		}

	}

	def safeSetReference(EObject container, EReference eReference, EObject refObject) {
		try {
			container.eSet(eReference, refObject)
		} catch(Exception e) {
			throw new FlatlandException(SC_BAD_REQUEST, container, "Object '{}' has wrong type for reference '{}'", refObject, eReference.name)
		}

	}

	def safeSetReferenceArray(EObject container, EReference eReference, List<EObject> refArray) {
		if(eReference.upperBound > 0 && refArray.size > eReference.upperBound) {
			throw new FlatlandException(SC_BAD_REQUEST, container, "Try to add '{}' elements to array '{}' having upper limit of '{}'", refArray.size, eReference.name, eReference.upperBound)
		}
		try {
			container.eSet(eReference, refArray)
		} catch(Exception e) {
			throw new FlatlandException(SC_BAD_REQUEST, container, "Reference list contains object with wrong type for reference '{}'", eReference.name)
		}
	}

	def safeSetAttributeArray(EObject container, EAttribute eAttribute, List<Object> attArray) {
		if(eAttribute.upperBound > 0 && attArray.size > eAttribute.upperBound) {
			throw new FlatlandException(SC_BAD_REQUEST, container, "Try to add '{}' elements to array '{}' having upper limit of '{}'", attArray.size, eAttribute.name, eAttribute.upperBound)
		}
		container.eSet(eAttribute, attArray)
	}
}
