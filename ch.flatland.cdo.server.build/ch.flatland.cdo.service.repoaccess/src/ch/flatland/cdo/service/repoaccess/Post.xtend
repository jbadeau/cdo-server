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
package ch.flatland.cdo.service.repoaccess

import ch.flatland.cdo.util.EMF
import ch.flatland.cdo.util.FlatlandException
import ch.flatland.cdo.util.Json
import ch.flatland.cdo.util.Request
import ch.flatland.cdo.util.Response
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import org.eclipse.emf.cdo.common.id.CDOIDUtil
import org.eclipse.emf.cdo.common.security.CDOPermission
import org.slf4j.LoggerFactory

class Post {

	val logger = LoggerFactory.getLogger(this.class)

	val extension Request = new Request
	val extension Response = new Response
	val extension EMF = new EMF

	def void run(HttpServletRequest req, HttpServletResponse resp) {
		val body = req.readBody
		logger.debug("Run for '{}' with body '{}'", req.userId, body)

		val extension JsonConverter = req.createJsonConverter(RepoAccessServlet.SERVLET_CONTEXT)

		val view = SessionFactory.getCDOSession(req).openTransaction
		var String jsonString = null

		try {
			if (body.length == 0) {
				throw new FlatlandException("Request body must not be empty")
			}

			val jsonObject = body.fromJson
			val id = jsonObject.resolveId

			if (id == null) {
				throw new FlatlandException("Attribute '" + Json.PARAM_ID + "' not found in json object!")
			}

			logger.debug("Object '{}' requested", id)

			val requestedObject = view.getObject(CDOIDUtil.createLong(id.value.asLong))

			logger.debug("Object '{}' loaded type of {}", id, requestedObject.eClass.type)

			if (requestedObject.cdoPermission != CDOPermission.WRITE) {
				throw new FlatlandException("No permission to edit object '" + id + "'")
			}

			jsonObject.toEObject = requestedObject
			
			view.commit

			// now transform manipulated object to json for the reponse			
			jsonString = requestedObject.toJson

		} catch (Exception e) {
			jsonString = e.toJson
			logger.error("Could not processing request", e)
		} finally {
			if (!view.closed) {
				view.close
			}
		}
		resp.writeResponse(req, jsonString)
	}

}
