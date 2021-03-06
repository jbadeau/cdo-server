/**
 */
package ch.flatland.cdo.model.config.impl;

import ch.flatland.cdo.model.config.Authenticator;
import ch.flatland.cdo.model.config.AuthenticatorType;
import ch.flatland.cdo.model.config.ConfigPackage;

import org.eclipse.emf.common.notify.Notification;

import org.eclipse.emf.ecore.EClass;

import org.eclipse.emf.ecore.impl.ENotificationImpl;
import org.eclipse.emf.ecore.impl.MinimalEObjectImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model object '<em><b>Authenticator</b></em>'.
 * <!-- end-user-doc -->
 * <p>
 * The following features are implemented:
 * <ul>
 *   <li>{@link ch.flatland.cdo.model.config.impl.AuthenticatorImpl#getAuthenticatorType <em>Authenticator Type</em>}</li>
 *   <li>{@link ch.flatland.cdo.model.config.impl.AuthenticatorImpl#getConnectionUrl <em>Connection Url</em>}</li>
 *   <li>{@link ch.flatland.cdo.model.config.impl.AuthenticatorImpl#getDomainBase <em>Domain Base</em>}</li>
 *   <li>{@link ch.flatland.cdo.model.config.impl.AuthenticatorImpl#getUserIdField <em>User Id Field</em>}</li>
 *   <li>{@link ch.flatland.cdo.model.config.impl.AuthenticatorImpl#getReadOnlyPassword <em>Read Only Password</em>}</li>
 *   <li>{@link ch.flatland.cdo.model.config.impl.AuthenticatorImpl#getAdminPassword <em>Admin Password</em>}</li>
 *   <li>{@link ch.flatland.cdo.model.config.impl.AuthenticatorImpl#isCheckSSL <em>Check SSL</em>}</li>
 * </ul>
 * </p>
 *
 * @generated
 */
public class AuthenticatorImpl extends MinimalEObjectImpl.Container implements Authenticator {
	/**
	 * The default value of the '{@link #getAuthenticatorType() <em>Authenticator Type</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getAuthenticatorType()
	 * @generated
	 * @ordered
	 */
	protected static final AuthenticatorType AUTHENTICATOR_TYPE_EDEFAULT = AuthenticatorType.CDO;

	/**
	 * The cached value of the '{@link #getAuthenticatorType() <em>Authenticator Type</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getAuthenticatorType()
	 * @generated
	 * @ordered
	 */
	protected AuthenticatorType authenticatorType = AUTHENTICATOR_TYPE_EDEFAULT;

	/**
	 * The default value of the '{@link #getConnectionUrl() <em>Connection Url</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getConnectionUrl()
	 * @generated
	 * @ordered
	 */
	protected static final String CONNECTION_URL_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getConnectionUrl() <em>Connection Url</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getConnectionUrl()
	 * @generated
	 * @ordered
	 */
	protected String connectionUrl = CONNECTION_URL_EDEFAULT;

	/**
	 * The default value of the '{@link #getDomainBase() <em>Domain Base</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getDomainBase()
	 * @generated
	 * @ordered
	 */
	protected static final String DOMAIN_BASE_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getDomainBase() <em>Domain Base</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getDomainBase()
	 * @generated
	 * @ordered
	 */
	protected String domainBase = DOMAIN_BASE_EDEFAULT;

	/**
	 * The default value of the '{@link #getUserIdField() <em>User Id Field</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getUserIdField()
	 * @generated
	 * @ordered
	 */
	protected static final String USER_ID_FIELD_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getUserIdField() <em>User Id Field</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getUserIdField()
	 * @generated
	 * @ordered
	 */
	protected String userIdField = USER_ID_FIELD_EDEFAULT;

	/**
	 * The default value of the '{@link #getReadOnlyPassword() <em>Read Only Password</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getReadOnlyPassword()
	 * @generated
	 * @ordered
	 */
	protected static final String READ_ONLY_PASSWORD_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getReadOnlyPassword() <em>Read Only Password</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getReadOnlyPassword()
	 * @generated
	 * @ordered
	 */
	protected String readOnlyPassword = READ_ONLY_PASSWORD_EDEFAULT;

	/**
	 * The default value of the '{@link #getAdminPassword() <em>Admin Password</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getAdminPassword()
	 * @generated
	 * @ordered
	 */
	protected static final String ADMIN_PASSWORD_EDEFAULT = null;

	/**
	 * The cached value of the '{@link #getAdminPassword() <em>Admin Password</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #getAdminPassword()
	 * @generated
	 * @ordered
	 */
	protected String adminPassword = ADMIN_PASSWORD_EDEFAULT;

	/**
	 * The default value of the '{@link #isCheckSSL() <em>Check SSL</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #isCheckSSL()
	 * @generated
	 * @ordered
	 */
	protected static final boolean CHECK_SSL_EDEFAULT = false;

	/**
	 * The cached value of the '{@link #isCheckSSL() <em>Check SSL</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #isCheckSSL()
	 * @generated
	 * @ordered
	 */
	protected boolean checkSSL = CHECK_SSL_EDEFAULT;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected AuthenticatorImpl() {
		super();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	protected EClass eStaticClass() {
		return ConfigPackage.Literals.AUTHENTICATOR;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public AuthenticatorType getAuthenticatorType() {
		return authenticatorType;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setAuthenticatorType(AuthenticatorType newAuthenticatorType) {
		AuthenticatorType oldAuthenticatorType = authenticatorType;
		authenticatorType = newAuthenticatorType == null ? AUTHENTICATOR_TYPE_EDEFAULT : newAuthenticatorType;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, ConfigPackage.AUTHENTICATOR__AUTHENTICATOR_TYPE, oldAuthenticatorType, authenticatorType));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getConnectionUrl() {
		return connectionUrl;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setConnectionUrl(String newConnectionUrl) {
		String oldConnectionUrl = connectionUrl;
		connectionUrl = newConnectionUrl;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, ConfigPackage.AUTHENTICATOR__CONNECTION_URL, oldConnectionUrl, connectionUrl));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getDomainBase() {
		return domainBase;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setDomainBase(String newDomainBase) {
		String oldDomainBase = domainBase;
		domainBase = newDomainBase;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, ConfigPackage.AUTHENTICATOR__DOMAIN_BASE, oldDomainBase, domainBase));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getUserIdField() {
		return userIdField;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setUserIdField(String newUserIdField) {
		String oldUserIdField = userIdField;
		userIdField = newUserIdField;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, ConfigPackage.AUTHENTICATOR__USER_ID_FIELD, oldUserIdField, userIdField));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getReadOnlyPassword() {
		return readOnlyPassword;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setReadOnlyPassword(String newReadOnlyPassword) {
		String oldReadOnlyPassword = readOnlyPassword;
		readOnlyPassword = newReadOnlyPassword;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, ConfigPackage.AUTHENTICATOR__READ_ONLY_PASSWORD, oldReadOnlyPassword, readOnlyPassword));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public String getAdminPassword() {
		return adminPassword;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setAdminPassword(String newAdminPassword) {
		String oldAdminPassword = adminPassword;
		adminPassword = newAdminPassword;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, ConfigPackage.AUTHENTICATOR__ADMIN_PASSWORD, oldAdminPassword, adminPassword));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public boolean isCheckSSL() {
		return checkSSL;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void setCheckSSL(boolean newCheckSSL) {
		boolean oldCheckSSL = checkSSL;
		checkSSL = newCheckSSL;
		if (eNotificationRequired())
			eNotify(new ENotificationImpl(this, Notification.SET, ConfigPackage.AUTHENTICATOR__CHECK_SSL, oldCheckSSL, checkSSL));
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public Object eGet(int featureID, boolean resolve, boolean coreType) {
		switch (featureID) {
			case ConfigPackage.AUTHENTICATOR__AUTHENTICATOR_TYPE:
				return getAuthenticatorType();
			case ConfigPackage.AUTHENTICATOR__CONNECTION_URL:
				return getConnectionUrl();
			case ConfigPackage.AUTHENTICATOR__DOMAIN_BASE:
				return getDomainBase();
			case ConfigPackage.AUTHENTICATOR__USER_ID_FIELD:
				return getUserIdField();
			case ConfigPackage.AUTHENTICATOR__READ_ONLY_PASSWORD:
				return getReadOnlyPassword();
			case ConfigPackage.AUTHENTICATOR__ADMIN_PASSWORD:
				return getAdminPassword();
			case ConfigPackage.AUTHENTICATOR__CHECK_SSL:
				return isCheckSSL();
		}
		return super.eGet(featureID, resolve, coreType);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eSet(int featureID, Object newValue) {
		switch (featureID) {
			case ConfigPackage.AUTHENTICATOR__AUTHENTICATOR_TYPE:
				setAuthenticatorType((AuthenticatorType)newValue);
				return;
			case ConfigPackage.AUTHENTICATOR__CONNECTION_URL:
				setConnectionUrl((String)newValue);
				return;
			case ConfigPackage.AUTHENTICATOR__DOMAIN_BASE:
				setDomainBase((String)newValue);
				return;
			case ConfigPackage.AUTHENTICATOR__USER_ID_FIELD:
				setUserIdField((String)newValue);
				return;
			case ConfigPackage.AUTHENTICATOR__READ_ONLY_PASSWORD:
				setReadOnlyPassword((String)newValue);
				return;
			case ConfigPackage.AUTHENTICATOR__ADMIN_PASSWORD:
				setAdminPassword((String)newValue);
				return;
			case ConfigPackage.AUTHENTICATOR__CHECK_SSL:
				setCheckSSL((Boolean)newValue);
				return;
		}
		super.eSet(featureID, newValue);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public void eUnset(int featureID) {
		switch (featureID) {
			case ConfigPackage.AUTHENTICATOR__AUTHENTICATOR_TYPE:
				setAuthenticatorType(AUTHENTICATOR_TYPE_EDEFAULT);
				return;
			case ConfigPackage.AUTHENTICATOR__CONNECTION_URL:
				setConnectionUrl(CONNECTION_URL_EDEFAULT);
				return;
			case ConfigPackage.AUTHENTICATOR__DOMAIN_BASE:
				setDomainBase(DOMAIN_BASE_EDEFAULT);
				return;
			case ConfigPackage.AUTHENTICATOR__USER_ID_FIELD:
				setUserIdField(USER_ID_FIELD_EDEFAULT);
				return;
			case ConfigPackage.AUTHENTICATOR__READ_ONLY_PASSWORD:
				setReadOnlyPassword(READ_ONLY_PASSWORD_EDEFAULT);
				return;
			case ConfigPackage.AUTHENTICATOR__ADMIN_PASSWORD:
				setAdminPassword(ADMIN_PASSWORD_EDEFAULT);
				return;
			case ConfigPackage.AUTHENTICATOR__CHECK_SSL:
				setCheckSSL(CHECK_SSL_EDEFAULT);
				return;
		}
		super.eUnset(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public boolean eIsSet(int featureID) {
		switch (featureID) {
			case ConfigPackage.AUTHENTICATOR__AUTHENTICATOR_TYPE:
				return authenticatorType != AUTHENTICATOR_TYPE_EDEFAULT;
			case ConfigPackage.AUTHENTICATOR__CONNECTION_URL:
				return CONNECTION_URL_EDEFAULT == null ? connectionUrl != null : !CONNECTION_URL_EDEFAULT.equals(connectionUrl);
			case ConfigPackage.AUTHENTICATOR__DOMAIN_BASE:
				return DOMAIN_BASE_EDEFAULT == null ? domainBase != null : !DOMAIN_BASE_EDEFAULT.equals(domainBase);
			case ConfigPackage.AUTHENTICATOR__USER_ID_FIELD:
				return USER_ID_FIELD_EDEFAULT == null ? userIdField != null : !USER_ID_FIELD_EDEFAULT.equals(userIdField);
			case ConfigPackage.AUTHENTICATOR__READ_ONLY_PASSWORD:
				return READ_ONLY_PASSWORD_EDEFAULT == null ? readOnlyPassword != null : !READ_ONLY_PASSWORD_EDEFAULT.equals(readOnlyPassword);
			case ConfigPackage.AUTHENTICATOR__ADMIN_PASSWORD:
				return ADMIN_PASSWORD_EDEFAULT == null ? adminPassword != null : !ADMIN_PASSWORD_EDEFAULT.equals(adminPassword);
			case ConfigPackage.AUTHENTICATOR__CHECK_SSL:
				return checkSSL != CHECK_SSL_EDEFAULT;
		}
		return super.eIsSet(featureID);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	@Override
	public String toString() {
		if (eIsProxy()) return super.toString();

		StringBuffer result = new StringBuffer(super.toString());
		result.append(" (authenticatorType: ");
		result.append(authenticatorType);
		result.append(", connectionUrl: ");
		result.append(connectionUrl);
		result.append(", domainBase: ");
		result.append(domainBase);
		result.append(", userIdField: ");
		result.append(userIdField);
		result.append(", readOnlyPassword: ");
		result.append(readOnlyPassword);
		result.append(", adminPassword: ");
		result.append(adminPassword);
		result.append(", checkSSL: ");
		result.append(checkSSL);
		result.append(')');
		return result.toString();
	}

} //AuthenticatorImpl
