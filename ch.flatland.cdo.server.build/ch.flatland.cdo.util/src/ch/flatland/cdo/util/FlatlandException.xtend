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
import java.util.List
import java.util.Map
import org.eclipse.emf.ecore.EObject

class FlatlandException extends Exception {

	val public static STATUS_NOK = "NOK"
	var int httpStatus
	var String message
	var Map<EObject, List<FLDiagnostic>> fLDiagnostics

	new(int httpStatus, Map<EObject, List<FLDiagnostic>> fLDiagnostics, String format, Object... arguments) {
		this.fLDiagnostics = fLDiagnostics
		this.message = init(format, arguments)
		this.httpStatus = httpStatus	
	}

	new(int httpStatus, String format, Object... arguments) {
		this.message = init(format, arguments)
		this.httpStatus = httpStatus	
	}
	
	new(int httpStatus, Map<EObject, List<FLDiagnostic>> fLDiagnostics, String message) {
		this.fLDiagnostics = fLDiagnostics
		this.message = message
		this.httpStatus = httpStatus	
	}
	
	new(int httpStatus, String message) {
		this.message = message
		this.httpStatus = httpStatus	
	}
	
	new(String message) {
		this.message = message
	}
	
	def getHttpStatus() {
		httpStatus
	}
	
	override getMessage() {
		message
	}
	
	def private init(String format, Object... arguments) {
		val segments = Splitter.on("{}").split(format)
		val builder = new StringBuilder
		var index = 0
		for (s : segments) {
			builder.append(s)
			if (arguments.size > index) {
				builder.append(arguments.get(index).toString)
			}	
			index++
		}
		return builder.toString
	}
}
