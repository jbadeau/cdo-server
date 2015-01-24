/**
 */
package ch.flatland.cdo.model.base.impl;

import ch.flatland.cdo.model.base.BaseFactory;
import ch.flatland.cdo.model.base.BasePackage;
import ch.flatland.cdo.model.base.FLComponent;
import ch.flatland.cdo.model.base.FLElement;
import ch.flatland.cdo.model.base.FLPackage;
import ch.flatland.cdo.model.base.FLProperty;
import ch.flatland.cdo.model.base.FLTrace;
import ch.flatland.cdo.model.base.FLTraceType;

import ch.flatland.cdo.model.base.util.BaseValidator;
import org.eclipse.emf.ecore.EAttribute;
import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EDataType;
import org.eclipse.emf.ecore.EEnum;
import org.eclipse.emf.ecore.EOperation;
import org.eclipse.emf.ecore.EPackage;
import org.eclipse.emf.ecore.EReference;
import org.eclipse.emf.ecore.EValidator;
import org.eclipse.emf.ecore.EcorePackage;

import org.eclipse.emf.ecore.impl.EPackageImpl;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model <b>Package</b>.
 * <!-- end-user-doc -->
 * @generated
 */
public class BasePackageImpl extends EPackageImpl implements BasePackage {
	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private EClass flElementEClass = null;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private EClass flComponentEClass = null;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private EClass flPackageEClass = null;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private EClass flTraceEClass = null;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private EClass flPropertyEClass = null;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private EEnum flTraceTypeEEnum = null;

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private EDataType flIdentifierEDataType = null;

	/**
	 * Creates an instance of the model <b>Package</b>, registered with
	 * {@link org.eclipse.emf.ecore.EPackage.Registry EPackage.Registry} by the package
	 * package URI value.
	 * <p>Note: the correct way to create the package is via the static
	 * factory method {@link #init init()}, which also performs
	 * initialization of the package, or returns the registered package,
	 * if one already exists.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see org.eclipse.emf.ecore.EPackage.Registry
	 * @see ch.flatland.cdo.model.base.BasePackage#eNS_URI
	 * @see #init()
	 * @generated
	 */
	private BasePackageImpl() {
		super(eNS_URI, BaseFactory.eINSTANCE);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private static boolean isInited = false;

	/**
	 * Creates, registers, and initializes the <b>Package</b> for this model, and for any others upon which it depends.
	 * 
	 * <p>This method is used to initialize {@link BasePackage#eINSTANCE} when that field is accessed.
	 * Clients should not invoke it directly. Instead, they should simply access that field to obtain the package.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @see #eNS_URI
	 * @see #createPackageContents()
	 * @see #initializePackageContents()
	 * @generated
	 */
	public static BasePackage init() {
		if (isInited) return (BasePackage)EPackage.Registry.INSTANCE.getEPackage(BasePackage.eNS_URI);

		// Obtain or create and register package
		BasePackageImpl theBasePackage = (BasePackageImpl)(EPackage.Registry.INSTANCE.get(eNS_URI) instanceof BasePackageImpl ? EPackage.Registry.INSTANCE.get(eNS_URI) : new BasePackageImpl());

		isInited = true;

		// Initialize simple dependencies
		EcorePackage.eINSTANCE.eClass();

		// Create package meta-data objects
		theBasePackage.createPackageContents();

		// Initialize created meta-data
		theBasePackage.initializePackageContents();

		// Register package validator
		EValidator.Registry.INSTANCE.put
			(theBasePackage, 
			 new EValidator.Descriptor() {
				 public EValidator getEValidator() {
					 return BaseValidator.INSTANCE;
				 }
			 });

		// Mark meta-data to indicate it can't be changed
		theBasePackage.freeze();

  
		// Update the registry and return the package
		EPackage.Registry.INSTANCE.put(BasePackage.eNS_URI, theBasePackage);
		return theBasePackage;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EClass getFLElement() {
		return flElementEClass;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EAttribute getFLElement_Name() {
		return (EAttribute)flElementEClass.getEStructuralFeatures().get(0);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EAttribute getFLElement_Description() {
		return (EAttribute)flElementEClass.getEStructuralFeatures().get(1);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_Traces() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(2);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_Properties() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(3);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToOwn() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(4);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToUse() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(5);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToRealize() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(6);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToSpecify() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(7);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToImplement() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(8);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToElaborate() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(9);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToDerive() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(10);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToValidate() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(11);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToTest() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(12);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToRelate() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(13);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToffect() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(14);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToSatisfy() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(15);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToVerify() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(16);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToRefine() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(17);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLElement_TraceToTrack() {
		return (EReference)flElementEClass.getEStructuralFeatures().get(18);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EOperation getFLElement__ToFilterByType__EList_FLTraceType() {
		return flElementEClass.getEOperations().get(0);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EClass getFLComponent() {
		return flComponentEClass;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EAttribute getFLComponent_ComponentId() {
		return (EAttribute)flComponentEClass.getEStructuralFeatures().get(0);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLComponent_Children() {
		return (EReference)flComponentEClass.getEStructuralFeatures().get(1);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EClass getFLPackage() {
		return flPackageEClass;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLPackage_Elements() {
		return (EReference)flPackageEClass.getEStructuralFeatures().get(0);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLPackage_SubPackages() {
		return (EReference)flPackageEClass.getEStructuralFeatures().get(1);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLPackage_Contents() {
		return (EReference)flPackageEClass.getEStructuralFeatures().get(2);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EClass getFLTrace() {
		return flTraceEClass;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EAttribute getFLTrace_TraceType() {
		return (EAttribute)flTraceEClass.getEStructuralFeatures().get(0);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EReference getFLTrace_Target() {
		return (EReference)flTraceEClass.getEStructuralFeatures().get(1);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EClass getFLProperty() {
		return flPropertyEClass;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EAttribute getFLProperty_Name() {
		return (EAttribute)flPropertyEClass.getEStructuralFeatures().get(0);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EAttribute getFLProperty_Value() {
		return (EAttribute)flPropertyEClass.getEStructuralFeatures().get(1);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EEnum getFLTraceType() {
		return flTraceTypeEEnum;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public EDataType getFLIdentifier() {
		return flIdentifierEDataType;
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public BaseFactory getBaseFactory() {
		return (BaseFactory)getEFactoryInstance();
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private boolean isCreated = false;

	/**
	 * Creates the meta-model objects for the package.  This method is
	 * guarded to have no affect on any invocation but its first.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void createPackageContents() {
		if (isCreated) return;
		isCreated = true;

		// Create classes and their features
		flElementEClass = createEClass(FL_ELEMENT);
		createEAttribute(flElementEClass, FL_ELEMENT__NAME);
		createEAttribute(flElementEClass, FL_ELEMENT__DESCRIPTION);
		createEReference(flElementEClass, FL_ELEMENT__TRACES);
		createEReference(flElementEClass, FL_ELEMENT__PROPERTIES);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_OWN);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_USE);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_REALIZE);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_SPECIFY);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_IMPLEMENT);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_ELABORATE);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_DERIVE);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_VALIDATE);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_TEST);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_RELATE);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TOFFECT);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_SATISFY);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_VERIFY);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_REFINE);
		createEReference(flElementEClass, FL_ELEMENT__TRACE_TO_TRACK);
		createEOperation(flElementEClass, FL_ELEMENT___TO_FILTER_BY_TYPE__ELIST_FLTRACETYPE);

		flComponentEClass = createEClass(FL_COMPONENT);
		createEAttribute(flComponentEClass, FL_COMPONENT__COMPONENT_ID);
		createEReference(flComponentEClass, FL_COMPONENT__CHILDREN);

		flPackageEClass = createEClass(FL_PACKAGE);
		createEReference(flPackageEClass, FL_PACKAGE__ELEMENTS);
		createEReference(flPackageEClass, FL_PACKAGE__SUB_PACKAGES);
		createEReference(flPackageEClass, FL_PACKAGE__CONTENTS);

		flTraceEClass = createEClass(FL_TRACE);
		createEAttribute(flTraceEClass, FL_TRACE__TRACE_TYPE);
		createEReference(flTraceEClass, FL_TRACE__TARGET);

		flPropertyEClass = createEClass(FL_PROPERTY);
		createEAttribute(flPropertyEClass, FL_PROPERTY__NAME);
		createEAttribute(flPropertyEClass, FL_PROPERTY__VALUE);

		// Create enums
		flTraceTypeEEnum = createEEnum(FL_TRACE_TYPE);

		// Create data types
		flIdentifierEDataType = createEDataType(FL_IDENTIFIER);
	}

	/**
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	private boolean isInitialized = false;

	/**
	 * Complete the initialization of the package and its meta-model.  This
	 * method is guarded to have no affect on any invocation but its first.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void initializePackageContents() {
		if (isInitialized) return;
		isInitialized = true;

		// Initialize package
		setName(eNAME);
		setNsPrefix(eNS_PREFIX);
		setNsURI(eNS_URI);

		// Obtain other dependent packages
		EcorePackage theEcorePackage = (EcorePackage)EPackage.Registry.INSTANCE.getEPackage(EcorePackage.eNS_URI);

		// Create type parameters

		// Set bounds for type parameters

		// Add supertypes to classes
		flComponentEClass.getESuperTypes().add(this.getFLElement());
		flPackageEClass.getESuperTypes().add(this.getFLElement());

		// Initialize classes, features, and operations; add parameters
		initEClass(flElementEClass, FLElement.class, "FLElement", IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
		initEAttribute(getFLElement_Name(), theEcorePackage.getEString(), "name", null, 1, 1, FLElement.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, !IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
		initEAttribute(getFLElement_Description(), theEcorePackage.getEString(), "description", null, 0, 1, FLElement.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, !IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_Traces(), this.getFLTrace(), null, "traces", null, 0, -1, FLElement.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_COMPOSITE, !IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_Properties(), this.getFLProperty(), null, "properties", null, 0, -1, FLElement.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_COMPOSITE, !IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToOwn(), this.getFLElement(), null, "traceToOwn", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToUse(), this.getFLElement(), null, "traceToUse", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToRealize(), this.getFLElement(), null, "traceToRealize", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToSpecify(), this.getFLElement(), null, "traceToSpecify", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToImplement(), this.getFLElement(), null, "traceToImplement", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToElaborate(), this.getFLElement(), null, "traceToElaborate", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToDerive(), this.getFLElement(), null, "traceToDerive", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToValidate(), this.getFLElement(), null, "traceToValidate", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToTest(), this.getFLElement(), null, "traceToTest", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToRelate(), this.getFLElement(), null, "traceToRelate", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToffect(), this.getFLElement(), null, "traceToffect", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToSatisfy(), this.getFLElement(), null, "traceToSatisfy", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToVerify(), this.getFLElement(), null, "traceToVerify", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToRefine(), this.getFLElement(), null, "traceToRefine", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLElement_TraceToTrack(), this.getFLElement(), null, "traceToTrack", null, 0, -1, FLElement.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);

		EOperation op = initEOperation(getFLElement__ToFilterByType__EList_FLTraceType(), this.getFLElement(), "toFilterByType", 0, -1, !IS_UNIQUE, IS_ORDERED);
		addEParameter(op, this.getFLTrace(), "traces", 0, -1, !IS_UNIQUE, IS_ORDERED);
		addEParameter(op, this.getFLTraceType(), "traceType", 0, 1, !IS_UNIQUE, IS_ORDERED);

		initEClass(flComponentEClass, FLComponent.class, "FLComponent", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
		initEAttribute(getFLComponent_ComponentId(), this.getFLIdentifier(), "componentId", null, 0, 1, FLComponent.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, !IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
		initEReference(getFLComponent_Children(), this.getFLComponent(), null, "children", null, 0, -1, FLComponent.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

		initEClass(flPackageEClass, FLPackage.class, "FLPackage", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
		initEReference(getFLPackage_Elements(), this.getFLElement(), null, "elements", null, 0, -1, FLPackage.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, IS_COMPOSITE, !IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
		initEReference(getFLPackage_SubPackages(), this.getFLPackage(), null, "subPackages", null, 0, -1, FLPackage.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);
		initEReference(getFLPackage_Contents(), this.getFLElement(), null, "contents", null, 0, -1, FLPackage.class, IS_TRANSIENT, IS_VOLATILE, !IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, IS_DERIVED, IS_ORDERED);

		initEClass(flTraceEClass, FLTrace.class, "FLTrace", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
		initEAttribute(getFLTrace_TraceType(), this.getFLTraceType(), "traceType", null, 1, 1, FLTrace.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, !IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
		initEReference(getFLTrace_Target(), this.getFLElement(), null, "target", null, 1, 1, FLTrace.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_COMPOSITE, IS_RESOLVE_PROXIES, !IS_UNSETTABLE, IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

		initEClass(flPropertyEClass, FLProperty.class, "FLProperty", !IS_ABSTRACT, !IS_INTERFACE, IS_GENERATED_INSTANCE_CLASS);
		initEAttribute(getFLProperty_Name(), this.getFLIdentifier(), "name", null, 1, 1, FLProperty.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, !IS_UNIQUE, !IS_DERIVED, IS_ORDERED);
		initEAttribute(getFLProperty_Value(), theEcorePackage.getEString(), "value", null, 1, 1, FLProperty.class, !IS_TRANSIENT, !IS_VOLATILE, IS_CHANGEABLE, !IS_UNSETTABLE, !IS_ID, !IS_UNIQUE, !IS_DERIVED, IS_ORDERED);

		// Initialize enums and add enum literals
		initEEnum(flTraceTypeEEnum, FLTraceType.class, "FLTraceType");
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.OWN);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.USE);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.REALIZE);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.SPECIFY);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.IMPLEMENT);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.ELABORATE);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.DERIVE);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.VALIDATE);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.TEST);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.RELATE);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.AFFECT);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.SATISFY);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.VERIFY);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.REFINE);
		addEEnumLiteral(flTraceTypeEEnum, FLTraceType.TRACK);

		// Initialize data types
		initEDataType(flIdentifierEDataType, String.class, "FLIdentifier", IS_SERIALIZABLE, !IS_GENERATED_INSTANCE_CLASS);

		// Create resource
		createResource(eNS_URI);

		// Create annotations
		// http:///org/eclipse/emf/ecore/util/ExtendedMetaData
		createExtendedMetaDataAnnotations();
	}

	/**
	 * Initializes the annotations for <b>http:///org/eclipse/emf/ecore/util/ExtendedMetaData</b>.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	protected void createExtendedMetaDataAnnotations() {
		String source = "http:///org/eclipse/emf/ecore/util/ExtendedMetaData";	
		addAnnotation
		  (flIdentifierEDataType, 
		   source, 
		   new String[] {
			 "name", "FLIdentifier",
			 "pattern", "[a-zA-Z0-9_\\-\\.]*"
		   });
	}

} //BasePackageImpl
