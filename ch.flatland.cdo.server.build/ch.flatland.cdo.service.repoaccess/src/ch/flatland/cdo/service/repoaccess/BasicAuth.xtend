package ch.flatland.cdo.service.repoaccess

import javax.servlet.http.HttpServletRequest
import org.apache.commons.codec.binary.Base64
import ch.flatland.cdo.util.FlatlandException

class BasicAuth {
	def static getUserId(HttpServletRequest request) throws FlatlandException {
		val userNameIndex = request.userNameAndPassword.indexOf(":")
		val userName = request.userNameAndPassword.substring(0, userNameIndex)
		return userName
	}
	
	def static getSessionId(HttpServletRequest request) {
		return request.session.id
	}
	
	def static getSessionKey(HttpServletRequest request) {
		return request.sessionId + "-" + request.userId
	}

	def static getPassword(HttpServletRequest request) throws FlatlandException {
		val userNameIndex = request.userNameAndPassword.indexOf(":")
		val password = request.userNameAndPassword.substring(userNameIndex + 1)
		return password
	}

	def private static getUserNameAndPassword(HttpServletRequest request) throws FlatlandException {
		val authHeader = request.getHeader("Authorization");
		if (authHeader == null) {
			throw new FlatlandException("request.getHeader(\"Authorization\") == null, should not happen")
		}
		val usernameAndPassword = new String(Base64.decodeBase64(authHeader.substring(6).getBytes()))
		return usernameAndPassword
	}
}