package ch.flatland.cdo.server.product

import org.eclipse.emf.cdo.server.CDOServerUtil
import org.eclipse.emf.cdo.server.IRepository
import org.eclipse.emf.cdo.spi.server.InternalRepository
import org.eclipse.net4j.util.container.IPluginContainer
import org.eclipse.net4j.util.lifecycle.LifecycleUtil
import ch.flatland.cdo.server.ServerUtil

class Repository {

	private new() {
		// hide constructor
	}

	var static transient InternalRepository REPOSITORY
	var static transient SecurityManager SECURITY_MANAGER

	def static void start() {
		App.info("Start repository")

		// repository store
		val repositoryProps = newHashMap(
			IRepository.Props.SUPPORTING_AUDITS -> ServerUtil.SUPPORTING_AUDITS.toString,
			IRepository.Props.SUPPORTING_BRANCHES -> ServerUtil.SUPPORTING_BRANCHES.toString,
			IRepository.Props.ENSURE_REFERENTIAL_INTEGRITY -> ServerUtil.ENSURE_REFERENTIAL_INTEGRITY.toString,
			IRepository.Props.ALLOW_INTERRUPT_RUNNING_QUERIES -> "true",
			IRepository.Props.ID_GENERATION_LOCATION -> "STORE",
			IRepository.Props.SERIALIZE_COMMITS -> "false",
			IRepository.Props.OPTIMISTIC_LOCKING_TIMEOUT -> "10000",
			IRepository.Props.OVERRIDE_UUID -> ServerUtil.REPOSITORY_NAME
		)

		REPOSITORY = CDOServerUtil.createRepository(ServerUtil.REPOSITORY_NAME, StoreFactory.createStore, repositoryProps) as InternalRepository

		CDOServerUtil.addRepository(IPluginContainer.INSTANCE, REPOSITORY);

		SECURITY_MANAGER = SecurityManagerFactory.createSecurityManager
		SECURITY_MANAGER.addCommitHandler(CommitHandlerFactory.createAnnotationCommitHandler)
		//SECURITY_MANAGER.addCommitHandler(CommitHandlerFactory.createHomeCommitHandler)
		SECURITY_MANAGER.repository = REPOSITORY
		SECURITY_MANAGER.activate
	}

	def static stop() {
		App.info("Stop repository")
		SECURITY_MANAGER.deactivate
		if (REPOSITORY != null) {
			LifecycleUtil.deactivate(REPOSITORY)
		}	
	}
}