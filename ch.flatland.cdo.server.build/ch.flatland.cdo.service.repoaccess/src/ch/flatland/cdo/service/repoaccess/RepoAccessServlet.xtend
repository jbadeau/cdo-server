package ch.flatland.cdo.service.repoaccess

import java.io.IOException
import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import org.eclipse.emf.cdo.common.id.CDOIDUtil

import static extension ch.flatland.cdo.util.Json.*
import ch.flatland.cdo.util.FlatlandException

class RepoAccessServlet extends AbstractAccessServlet {

	val static PARAM_OID = paramOid
	val static PARAM_META = paramMeta
	val static PARAM_JSONP_CALLBACK = "callback"
	val static SERVLET_CONTEXT = "/repo"

	override protected doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (RepoAccessPlugin.getDefault.debugging) {
			logRequest(req)
		}
		val serverBaseUrl = req.requestURL.substring(0, req.requestURL.indexOf(SERVLET_CONTEXT)) + SERVLET_CONTEXT
		var String requestedObjectAsJson = null

		try {

			var processed = false

			// processes meta info
			if (req.getParameter(PARAM_META) != null && req.getParameter(PARAM_META).length > 0) {
				requestedObjectAsJson = resolveEClassifier(req.getParameter(PARAM_META)).toJson(serverBaseUrl)
				processed = true
			}

			// processes oid
			if (req.getParameter(PARAM_OID) != null && req.getParameter(PARAM_OID).length > 0) {
				requestedObjectAsJson = view.getObject(CDOIDUtil.createLong(Long.parseLong(req.getParameter(PARAM_OID)))).
					toJson(serverBaseUrl)
				processed = true
			}

			// processes path
			if (!processed) {
				requestedObjectAsJson = view.getResourceNode(req.pathInfo).toJson(serverBaseUrl)
			}

		} catch (Exception e) {
			requestedObjectAsJson = e.toJson(serverBaseUrl)
			e.printStackTrace
		} finally {

			// write response
			if (req.getParameter(PARAM_JSONP_CALLBACK) != null && req.getParameter(PARAM_JSONP_CALLBACK).length > 0) {
				resp.contentType = jsonpContentTypeUTF8
				resp.writer.append('''�req.getParameter(PARAM_JSONP_CALLBACK)�(�requestedObjectAsJson�)''')
			} else {
				resp.contentType = jsonContentTypeUTF8
				resp.writer.append(requestedObjectAsJson)
			}
		}
	}

	def private resolveEClassifier(String uri) throws FlatlandException {
		val segments = uri.split('/').iterator
		val classifierName = segments.last
		val packageUri = uri.replace("/" + classifierName, "")

		if (RepoAccessPlugin.getDefault.debugging) {
			println(
				'''
					>>>
					   resolveEClassifier(�uri�) �this.class.name�
					   classifierName = �classifierName�
					   packageUri = �packageUri�
					<<<
				''')
		}

		val package = view.session.packageRegistry.getEPackage(packageUri)

		if (package != null) {
			for (classifier : package.EClassifiers) {
				if (classifier.name == classifierName) {
					return classifier
				}
			}
		}

		throw new FlatlandException("Could not resolve meta info for " + uri)
	}
}
