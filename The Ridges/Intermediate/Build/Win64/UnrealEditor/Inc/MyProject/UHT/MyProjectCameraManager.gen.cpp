// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/GeneratedCppIncludes.h"
#include "MyProjectCameraManager.h"

PRAGMA_DISABLE_DEPRECATION_WARNINGS

void EmptyLinkFunctionForGeneratedCodeMyProjectCameraManager() {}

// ********** Begin Cross Module References ********************************************************
ENGINE_API UClass* Z_Construct_UClass_APlayerCameraManager();
MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectCameraManager();
MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectCameraManager_NoRegister();
UPackage* Z_Construct_UPackage__Script_MyProject();
// ********** End Cross Module References **********************************************************

// ********** Begin Class AMyProjectCameraManager **************************************************
void AMyProjectCameraManager::StaticRegisterNativesAMyProjectCameraManager()
{
}
FClassRegistrationInfo Z_Registration_Info_UClass_AMyProjectCameraManager;
UClass* AMyProjectCameraManager::GetPrivateStaticClass()
{
	using TClass = AMyProjectCameraManager;
	if (!Z_Registration_Info_UClass_AMyProjectCameraManager.InnerSingleton)
	{
		GetPrivateStaticClassBody(
			StaticPackage(),
			TEXT("MyProjectCameraManager"),
			Z_Registration_Info_UClass_AMyProjectCameraManager.InnerSingleton,
			StaticRegisterNativesAMyProjectCameraManager,
			sizeof(TClass),
			alignof(TClass),
			TClass::StaticClassFlags,
			TClass::StaticClassCastFlags(),
			TClass::StaticConfigName(),
			(UClass::ClassConstructorType)InternalConstructor<TClass>,
			(UClass::ClassVTableHelperCtorCallerType)InternalVTableHelperCtorCaller<TClass>,
			UOBJECT_CPPCLASS_STATICFUNCTIONS_FORCLASS(TClass),
			&TClass::Super::StaticClass,
			&TClass::WithinClass::StaticClass
		);
	}
	return Z_Registration_Info_UClass_AMyProjectCameraManager.InnerSingleton;
}
UClass* Z_Construct_UClass_AMyProjectCameraManager_NoRegister()
{
	return AMyProjectCameraManager::GetPrivateStaticClass();
}
struct Z_Construct_UClass_AMyProjectCameraManager_Statics
{
#if WITH_METADATA
	static constexpr UECodeGen_Private::FMetaDataPairParam Class_MetaDataParams[] = {
#if !UE_BUILD_SHIPPING
		{ "Comment", "/**\n *  Basic First Person camera manager.\n *  Limits min/max look pitch.\n */" },
#endif
		{ "IncludePath", "MyProjectCameraManager.h" },
		{ "ModuleRelativePath", "MyProjectCameraManager.h" },
#if !UE_BUILD_SHIPPING
		{ "ToolTip", "Basic First Person camera manager.\nLimits min/max look pitch." },
#endif
	};
#endif // WITH_METADATA
	static UObject* (*const DependentSingletons[])();
	static constexpr FCppClassTypeInfoStatic StaticCppClassTypeInfo = {
		TCppClassTypeTraits<AMyProjectCameraManager>::IsAbstract,
	};
	static const UECodeGen_Private::FClassParams ClassParams;
};
UObject* (*const Z_Construct_UClass_AMyProjectCameraManager_Statics::DependentSingletons[])() = {
	(UObject* (*)())Z_Construct_UClass_APlayerCameraManager,
	(UObject* (*)())Z_Construct_UPackage__Script_MyProject,
};
static_assert(UE_ARRAY_COUNT(Z_Construct_UClass_AMyProjectCameraManager_Statics::DependentSingletons) < 16);
const UECodeGen_Private::FClassParams Z_Construct_UClass_AMyProjectCameraManager_Statics::ClassParams = {
	&AMyProjectCameraManager::StaticClass,
	"Engine",
	&StaticCppClassTypeInfo,
	DependentSingletons,
	nullptr,
	nullptr,
	nullptr,
	UE_ARRAY_COUNT(DependentSingletons),
	0,
	0,
	0,
	0x008003ACu,
	METADATA_PARAMS(UE_ARRAY_COUNT(Z_Construct_UClass_AMyProjectCameraManager_Statics::Class_MetaDataParams), Z_Construct_UClass_AMyProjectCameraManager_Statics::Class_MetaDataParams)
};
UClass* Z_Construct_UClass_AMyProjectCameraManager()
{
	if (!Z_Registration_Info_UClass_AMyProjectCameraManager.OuterSingleton)
	{
		UECodeGen_Private::ConstructUClass(Z_Registration_Info_UClass_AMyProjectCameraManager.OuterSingleton, Z_Construct_UClass_AMyProjectCameraManager_Statics::ClassParams);
	}
	return Z_Registration_Info_UClass_AMyProjectCameraManager.OuterSingleton;
}
DEFINE_VTABLE_PTR_HELPER_CTOR(AMyProjectCameraManager);
AMyProjectCameraManager::~AMyProjectCameraManager() {}
// ********** End Class AMyProjectCameraManager ****************************************************

// ********** Begin Registration *******************************************************************
struct Z_CompiledInDeferFile_FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h__Script_MyProject_Statics
{
	static constexpr FClassRegisterCompiledInInfo ClassInfo[] = {
		{ Z_Construct_UClass_AMyProjectCameraManager, AMyProjectCameraManager::StaticClass, TEXT("AMyProjectCameraManager"), &Z_Registration_Info_UClass_AMyProjectCameraManager, CONSTRUCT_RELOAD_VERSION_INFO(FClassReloadVersionInfo, sizeof(AMyProjectCameraManager), 528022315U) },
	};
};
static FRegisterCompiledInInfo Z_CompiledInDeferFile_FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h__Script_MyProject_3291233822(TEXT("/Script/MyProject"),
	Z_CompiledInDeferFile_FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h__Script_MyProject_Statics::ClassInfo, UE_ARRAY_COUNT(Z_CompiledInDeferFile_FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h__Script_MyProject_Statics::ClassInfo),
	nullptr, 0,
	nullptr, 0);
// ********** End Registration *********************************************************************

PRAGMA_ENABLE_DEPRECATION_WARNINGS
