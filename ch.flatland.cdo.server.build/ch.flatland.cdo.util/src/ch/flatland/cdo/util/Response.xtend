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

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import org.slf4j.LoggerFactory

class Response {
	val static logger = LoggerFactory.getLogger(Response)
	val static PARAM_JSONP_CALLBACK = "callback"
	
	def static writeResponse(HttpServletResponse resp, HttpServletRequest req, String jsonString) {
		logger.debug("Json '{}'", jsonString)

		// write response
		if (req.getParameter(PARAM_JSONP_CALLBACK) != null && req.getParameter(PARAM_JSONP_CALLBACK).length > 0) {
			resp.contentType = Json.JSONP_CONTENTTYPE_UTF8
			resp.writer.append('''�req.getParameter(PARAM_JSONP_CALLBACK)�(�jsonString�)''')
		} else {
			resp.contentType = Json.JSON_CONTENTTYPE_UTF8
			resp.writer.append(jsonString)
		}
	}
}
