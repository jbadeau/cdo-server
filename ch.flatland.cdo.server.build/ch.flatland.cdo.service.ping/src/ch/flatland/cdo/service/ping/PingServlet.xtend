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
package ch.flatland.cdo.service.ping

import ch.flatland.cdo.service.ping.model.PingBean
import ch.flatland.cdo.util.AbstractServlet
import ch.flatland.cdo.util.JsonConverter
import java.io.IOException
import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

import static extension ch.flatland.cdo.util.Response.*

class PingServlet extends AbstractServlet {

	public val static SERVLET_CONTEXT = "/ping"
	
	val static extension JsonConverter = new JsonConverter
	val static PING = new PingBean("Flatland CDO Server", "1.0.0").toJson

	override protected doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logRequest(req)		
		resp.writeResponse(req, PING)
	}
}
