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

import com.google.common.base.Splitter
import com.google.gson.JsonElement
import javax.servlet.http.HttpServletResponse
import org.eclipse.emf.cdo.view.CDOView
import org.eclipse.emf.ecore.EAttribute
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EClassifier
import org.eclipse.emf.ecore.EReference
import org.slf4j.LoggerFactory

class EMF {

	val logger = LoggerFactory.getLogger(this.class)

	def getType(EClassifier classifier) {
		classifier.EPackage.nsPrefix + "." + classifier.name
	}

	def isAttributeSettable(JsonElement element, EAttribute feature) {
		if (feature.derived) {
			logger.debug("EAttribute '{}' is derived", feature.name)
			return false
		}

		if ((element.jsonNull || element.jsonPrimitive) && !feature.many) {
			logger.debug("EAttribute '{}' is primitive or null", feature.name)
			return true
		}

		if ((element.jsonNull || element.jsonArray) && feature.many) {
			logger.debug("EAttribute '{}' is array or null", feature.name)
			return true
		}
		return false
	}

	def isReferenceSettable(JsonElement element, EReference feature) {
		if (feature.containment) {
			logger.debug("EReference '{}' is containment", feature.name)
			return false
		}

		if (feature.derived) {
			logger.debug("EReference '{}' is derived", feature.name)
			return false
		}

		if ((element.jsonNull || element.jsonObject) && !feature.many) {
			logger.debug("EReference '{}' is object or null", feature.name)
			return true
		}

		if ((element.jsonNull || element.jsonArray) && feature.many) {
			logger.debug("EReference '{}' is array or null", feature.name)
			return true
		}
		return false
	}

	def isContainmentSettable(EReference feature) {
		if (feature.containment) {
			logger.debug("EReference '{}' is containment", feature.name)
			return true
		}
	}
	
	def safePackagePrefix(String type) {
		val segments = Splitter.on(".").split(type)
		if (segments.size != 2) {
			throw new FlatlandException('''Not a valid type '�type�' ''', HttpServletResponse.SC_BAD_REQUEST)
		}
		segments.get(0)
	}
	
	def safeEType(String type) {
		val segments = Splitter.on(".").split(type)
		if (segments.size != 2) {
			throw new FlatlandException('''Not a valid type '�type�' ''', HttpServletResponse.SC_BAD_REQUEST)
		}
		segments.get(1)
	}

	def safeCreateType(CDOView view, String type) {
		val ePackage = view.ePackage(type.safePackagePrefix)
		val eClass = view.eClass(type)
		if (eClass == null) {
			throw new FlatlandException('''Could not resolve eClass for '�type�' ''', HttpServletResponse.SC_BAD_REQUEST)
		}
		logger.debug("Resolved EClass '{}'", eClass)
		val newObject = ePackage.EFactoryInstance.create(eClass)
		logger.debug("Created new object '{}'", newObject)
		return newObject
	}

	def ePackage(CDOView view, String nsPrefix) {
		val packageRegistry = view.session.packageRegistry
		val packageInfo = packageRegistry.packageInfos.filter[it.EPackage.nsPrefix == nsPrefix].head
		if (packageInfo == null) {
			throw new FlatlandException('''Invalid package prefix '�nsPrefix�' ''', HttpServletResponse.SC_BAD_REQUEST)
		}
		return packageInfo.EPackage
	}

	def private eClass(CDOView view, String type) {
		val eType = type.safeEType
		val ePackage = view.ePackage(type.safePackagePrefix)
		if (ePackage != null) {
			logger.debug("Resolved EPackage '{}'", ePackage)
			return ePackage.EClassifiers.filter[it.name == eType].head as EClass
		}
		return null
	}
}