// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/GeneratedCppIncludes.h"
#include "MyProjectGameMode.h"

PRAGMA_DISABLE_DEPRECATION_WARNINGS

void EmptyLinkFunctionForGeneratedCodeMyProjectGameMode() {}

// ********** Begin Cross Module References ********************************************************
ENGINE_API UClass* Z_Construct_UClass_AGameModeBase();
MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectGameMode();
MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectGameMode_NoRegister();
UPackage* Z_Construct_UPackage__Script_MyProject();
// ********** End Cross Module References **********************************************************

// ********** Begin Class AMyProjectGameMode *******************************************************
void AMyProjectGameMode::StaticRegisterNativesAMyProjectGameMode()
{
}
FClassRegistrationInfo Z_Registration_Info_UClass_AMyProjectGameMode;
UClass* AMyProjectGameMode::GetPrivateStaticClass()
{
	using TClass = AMyProjectGameMode;
	if (!Z_Registration_Info_UClass_AMyProjectGameMode.InnerSingleton)
	{
		GetPrivateStaticClassBody(
			StaticPackage(),
			TEXT("MyProjectGameMode"),
			Z_Registration_Info_UClass_AMyProjectGameMode.InnerSingleton,
			StaticRegisterNativesAMyProjectGameMode,
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
	return Z_Registration_Info_UClass_AMyProjectGameMode.InnerSingleton;
}
UClass* Z_Construct_UClass_AMyProjectGameMode_NoRegister()
{
	return AMyProjectGameMode::GetPrivateStaticClass();
}
struct Z_Construct_UClass_AMyProjectGameMode_Statics
{
#if WITH_METADATA
	static constexpr UECodeGen_Private::FMetaDataPairParam Class_MetaDataParams[] = {
#if !UE_BUILD_SHIPPING
		{ "Comment", "/**\n *  Simple GameMode for a first person game\n */" },
#endif
		{ "HideCategories", "Info Rendering MovementReplication Replication Actor Input Movement Collision Rendering HLOD WorldPartition DataLayers Transformation" },
		{ "IncludePath", "MyProjectGameMode.h" },
		{ "ModuleRelativePath", "MyProjectGameMode.h" },
		{ "ShowCategories", "Input|MouseInput Input|TouchInput" },
#if !UE_BUILD_SHIPPING
		{ "ToolTip", "Simple GameMode for a first person game" },
#endif
	};
#endif // WITH_METADATA
	static UObject* (*const DependentSingletons[])();
	static constexpr FCppClassTypeInfoStatic StaticCppClassTypeInfo = {
		TCppClassTypeTraits<AMyProjectGameMode>::IsAbstract,
	};
	static const UECodeGen_Private::FClassParams ClassParams;
};
UObject* (*const Z_Construct_UClass_AMyProjectGameMode_Statics::DependentSingletons[])() = {
	(UObject* (*)())Z_Construct_UClass_AGameModeBase,
	(UObject* (*)())Z_Construct_UPackage__Script_MyProject,
};
static_assert(UE_ARRAY_COUNT(Z_Construct_UClass_AMyProjectGameMode_Statics::DependentSingletons) < 16);
const UECodeGen_Private::FClassParams Z_Construct_UClass_AMyProjectGameMode_Statics::ClassParams = {
	&AMyProjectGameMode::StaticClass,
	"Game",
	&StaticCppClassTypeInfo,
	DependentSingletons,
	nullptr,
	nullptr,
	nullptr,
	UE_ARRAY_COUNT(DependentSingletons),
	0,
	0,
	0,
	0x008003ADu,
	METADATA_PARAMS(UE_ARRAY_COUNT(Z_Construct_UClass_AMyProjectGameMode_Statics::Class_MetaDataParams), Z_Construct_UClass_AMyProjectGameMode_Statics::Class_MetaDataParams)
};
UClass* Z_Construct_UClass_AMyProjectGameMode()
{
	if (!Z_Registration_Info_UClass_AMyProjectGameMode.OuterSingleton)
	{
		UECodeGen_Private::ConstructUClass(Z_Registration_Info_UClass_AMyProjectGameMode.OuterSingleton, Z_Construct_UClass_AMyProjectGameMode_Statics::ClassParams);
	}
	return Z_Registration_Info_UClass_AMyProjectGameMode.OuterSingleton;
}
DEFINE_VTABLE_PTR_HELPER_CTOR(AMyProjectGameMode);
AMyProjectGameMode::~AMyProjectGameMode() {}
// ********** End Class AMyProjectGameMode *********************************************************

// ********** Begin Registration *******************************************************************
struct Z_CompiledInDeferFile_FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h__Script_MyProject_Statics
{
	static constexpr FClassRegisterCompiledInInfo ClassInfo[] = {
		{ Z_Construct_UClass_AMyProjectGameMode, AMyProjectGameMode::StaticClass, TEXT("AMyProjectGameMode"), &Z_Registration_Info_UClass_AMyProjectGameMode, CONSTRUCT_RELOAD_VERSION_INFO(FClassReloadVersionInfo, sizeof(AMyProjectGameMode), 3026348713U) },
	};
};
static FRegisterCompiledInInfo Z_CompiledInDeferFile_FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h__Script_MyProject_172135157(TEXT("/Script/MyProject"),
	Z_CompiledInDeferFile_FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h__Script_MyProject_Statics::ClassInfo, UE_ARRAY_COUNT(Z_CompiledInDeferFile_FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h__Script_MyProject_Statics::ClassInfo),
	nullptr, 0,
	nullptr, 0);
// ********** End Registration *********************************************************************

PRAGMA_ENABLE_DEPRECATION_WARNINGS
