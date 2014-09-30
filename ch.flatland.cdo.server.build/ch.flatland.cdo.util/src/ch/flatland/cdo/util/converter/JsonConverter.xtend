package ch.flatland.cdo.util.converter

import ch.flatland.cdo.util.Json
import ch.flatland.cdo.util.JsonConverterConfig
import com.google.gson.Gson
import com.google.gson.JsonArray
import com.google.gson.JsonObject
import com.google.gson.JsonPrimitive
import java.util.List
import org.eclipse.emf.cdo.CDOObject
import org.eclipse.emf.common.util.Enumerator
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EAttribute
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EClassifier
import org.eclipse.emf.ecore.EEnum
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.edit.EMFEditPlugin
import org.eclipse.emf.edit.provider.AdapterFactoryItemDelegator
import org.eclipse.emf.edit.provider.ComposedAdapterFactory

class JsonConverter {
	static val gson = new Gson
	static val ITEM_DELEGATOR = new AdapterFactoryItemDelegator(
		new ComposedAdapterFactory(EMFEditPlugin.getComposedAdapterFactoryDescriptorRegistry))

	static val TYPE = "type"
	static val TYPE_META = "typeMeta"
	static val LABEL = "label"
	static val LOWER_BOUND = "lowerBound"
	static val UPPER_BOUND = "upperBound"
	static val OID = Json.PARAM_OID
	static val META_TYPE = Json.PARAM_META_TYPE
	static val URL = "url"
	static val NAME = "name"
	static val CONTAINER = "container"
	static val ATTRIBUTES = "attributes"
	static val REFERENCES = "references"
	static val CONTAINMENT = "containment"

	static val ignoredAttributes = newArrayList("resourceSet", "modified", "loaded", "trackingModification", "errors",
		"warnings", "timeStamp")

	def dispatch String toJson(Object object, JsonConverterConfig jsonConverterConfig) {
		gson.toJson(object)
	}

	def dispatch String toJson(EClass object, JsonConverterConfig jsonConverterConfig) {
		val attributes = object.EAllAttributes.filter[!ignoredAttributes.contains(it.name)]
		val references = object.EAllReferences

		val jsonTypeMeta = new JsonObject
		jsonTypeMeta.addTypeMeta(object, jsonConverterConfig)

		if (attributes.size > 0) {
			val jsonAttributes = new JsonArray
			jsonTypeMeta.add(ATTRIBUTES, jsonAttributes)
			for (attribute : attributes) {
				val a = attribute as EAttribute
				val jsonAttribute = new JsonObject
				jsonAttribute.addProperty(NAME, a.name)

				if (a.EAttributeType.eClass.name == "EEnum") {
					val enum = a.EAttributeType as EEnum
					val jsonLiterals = new JsonArray
					for (literal : enum.ELiterals) {
						jsonLiterals.add(new JsonPrimitive(literal.name))
						jsonAttribute.add(TYPE, jsonLiterals)
					}
				} else {
					jsonAttribute.addProperty(TYPE, a.EAttributeType.name)
				}
				jsonAttribute.addProperty(LOWER_BOUND, a.lowerBound)
				jsonAttribute.addProperty(UPPER_BOUND, a.upperBound)
				jsonAttributes.add(jsonAttribute)
			}
		}

		if (references.size > 0) {
			val jsonReferences = new JsonArray
			jsonTypeMeta.add(REFERENCES, jsonReferences)
			for (reference : references) {
				val r = reference as EReference
				val jsonReference = new JsonObject
				jsonReference.addProperty(NAME, r.name)
				jsonReference.addTypeMeta(r.EReferenceType, jsonConverterConfig)
				jsonReference.addProperty(LOWER_BOUND, r.lowerBound)
				jsonReference.addProperty(UPPER_BOUND, r.upperBound)
				jsonReference.addProperty(CONTAINMENT, r.containment)
				jsonReferences.add(jsonReference)
			}
		}
		jsonTypeMeta.toString
	}

	def dispatch String toJson(CDOObject object, JsonConverterConfig jsonConverterConfig) {
		val jsonBaseObject = object.toJsonBase(jsonConverterConfig)

		jsonBaseObject.addAttributes(object, jsonConverterConfig)
		jsonBaseObject.addReferences(object, jsonConverterConfig)
		jsonBaseObject.toString
	}

	def dispatch String toJson(Throwable object, JsonConverterConfig jsonConverterConfig) {
		val jsonBaseObject = new JsonObject
		jsonBaseObject.addProperty(TYPE, "ch.flatland.Exception")
		jsonBaseObject.addProperty(LABEL, object.class.simpleName)
		if (object.message != null) {
			jsonBaseObject.addProperty("message", object.message)
		}
		jsonBaseObject.toString
	}

	// helpers
	def private toJsonBase(CDOObject object, JsonConverterConfig jsonConverterConfig) {
		val jsonBaseObject = toJsonBase(object as EObject, jsonConverterConfig)
		jsonBaseObject.addProperty(OID, Long.parseLong(object.cdoID.toURIFragment.replace("L", "")))
		jsonBaseObject.addProperty(URL,
			jsonConverterConfig.serverBaseUrl + "?" + OID + "=" + object.cdoID.toURIFragment.replace("L", ""))

		var CDOObject container = null
		if (object.eContainer != null) {
			container = object.eContainer as CDOObject
		} else {
			container = object.cdoResource
		}
		jsonBaseObject.addProperty(CONTAINER,
			jsonConverterConfig.serverBaseUrl + "?" + OID + "=" + container.cdoID.toURIFragment.replace("L", ""))

		return jsonBaseObject
	}

	def private toJsonBase(EObject object, JsonConverterConfig jsonConverterConfig) {
		val jsonBaseObject = new JsonObject

		jsonBaseObject.addTypeMeta(object.eClass, jsonConverterConfig)
		jsonBaseObject.addProperty(LABEL, ITEM_DELEGATOR.getText(object))
		return jsonBaseObject
	}

	def private addAttributes(JsonObject jsonBaseObject, CDOObject object, JsonConverterConfig jsonConverterConfig) {
		val attributes = object.eClass.EAllAttributes
		val jsonAttributes = new JsonObject
		if (attributes.size > 0) {
			for (attribute : attributes.filter[!ignoredAttributes.contains(name)]) {
				val name = attribute.name

				if (attribute.many) {
					val values = object.eGet(attribute, true) as List<Object>
					if (values.size > 0) {
						val jsonPrimitiveArray = new JsonArray
						for (value : values) {
							jsonPrimitiveArray.add(value.jsonPrimitive)
						}
						jsonAttributes.add(name, jsonPrimitiveArray)
					}
				} else {
					val value = object.eGet(attribute, true)
					if (value != null) {
						jsonAttributes.add(name, value.jsonPrimitive)
					}
				}

			}
			if (jsonAttributes.entrySet.size > 0) {
				jsonBaseObject.add(ATTRIBUTES, jsonAttributes)
			}
		}
	}

	def private addReferences(JsonObject jsonBaseObject, CDOObject cdoObject, JsonConverterConfig jsonConverterConfig) {
		val references = cdoObject.eClass.EAllReferences
		val jsonReferences = new JsonObject
		if (references.size > 0) {
			for (EReference reference : references) {
				val name = reference.name
				if (reference.many) {
					val List<Object> values = cdoObject.eGet(reference, true) as List<Object>
					if (values.size > 0) {
						val jsonReferencesArray = new JsonArray
						for (value : values) {
							jsonReferencesArray.add(value.getJsonObject(jsonConverterConfig))
						}
						jsonReferences.add(name, jsonReferencesArray)
					}
				} else {
					val value = cdoObject.eGet(reference, true)
					if (value != null) {
						jsonReferences.add(name, value.getJsonObject(jsonConverterConfig))
					}
				}
			}
			if (jsonReferences.entrySet.size > 0) {
				jsonBaseObject.add(REFERENCES, jsonReferences)
			}
		}
	}

	def private addTypeMeta(JsonObject jsonBaseObject, EClassifier classifier, JsonConverterConfig jsonConverterConfig) {
		jsonBaseObject.addProperty(TYPE, classifier.EPackage.nsPrefix + "." + classifier.name)
		if (jsonConverterConfig.meta) {
			jsonBaseObject.addProperty(TYPE_META,
				jsonConverterConfig.serverBaseUrl + "?" + JsonConverter.META_TYPE + "=" + classifier.EPackage.nsURI +
					"/" + classifier.name)
		}
	}

	def private dispatch getJsonPrimitive(Object object) {
		System.err.println("getJsonPrimitive(Object object) " + object.class.name + " returns " + object.toString)
		new JsonPrimitive(object.toString)
	}

	def private dispatch getJsonPrimitive(Number object) {
		new JsonPrimitive(object.toString)
	}

	def private dispatch getJsonPrimitive(URI object) {
		new JsonPrimitive(object.toString)
	}

	def private dispatch getJsonPrimitive(String object) {
		new JsonPrimitive(object)
	}

	def private dispatch getJsonPrimitive(Enumerator object) {
		new JsonPrimitive(object.name)
	}

	def private dispatch getJsonPrimitive(Boolean object) {
		new JsonPrimitive(object)
	}

	def private dispatch getJsonObject(Object object, JsonConverterConfig jsonConverterConfig) {
		System.err.println(
			"getJsonObject(Object object, String serverUrl) " + object.class.name + " returns " + object.toString)
		new JsonPrimitive(object.toString)
	}

	def private dispatch getJsonObject(CDOObject object, JsonConverterConfig jsonConverterConfig) {
		object.toJsonBase(jsonConverterConfig)
	}

	def private dispatch getJsonObject(EObject object, JsonConverterConfig jsonConverterConfig) {
		object.toJsonBase(jsonConverterConfig)
	}
}
