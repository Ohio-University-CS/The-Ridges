// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

// IWYU pragma: private, include "MyProjectCameraManager.h"

#ifdef MYPROJECT_MyProjectCameraManager_generated_h
#error "MyProjectCameraManager.generated.h already included, missing '#pragma once' in MyProjectCameraManager.h"
#endif
#define MYPROJECT_MyProjectCameraManager_generated_h

#include "UObject/ObjectMacros.h"
#include "UObject/ScriptMacros.h"

PRAGMA_DISABLE_DEPRECATION_WARNINGS

// ********** Begin Class AMyProjectCameraManager **************************************************
MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectCameraManager_NoRegister();

#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h_16_INCLASS_NO_PURE_DECLS \
private: \
	static void StaticRegisterNativesAMyProjectCameraManager(); \
	friend struct Z_Construct_UClass_AMyProjectCameraManager_Statics; \
	static UClass* GetPrivateStaticClass(); \
	friend MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectCameraManager_NoRegister(); \
public: \
	DECLARE_CLASS2(AMyProjectCameraManager, APlayerCameraManager, COMPILED_IN_FLAGS(0 | CLASS_Transient | CLASS_Config), CASTCLASS_None, TEXT("/Script/MyProject"), Z_Construct_UClass_AMyProjectCameraManager_NoRegister) \
	DECLARE_SERIALIZER(AMyProjectCameraManager)


#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h_16_ENHANCED_CONSTRUCTORS \
	/** Deleted move- and copy-constructors, should never be used */ \
	AMyProjectCameraManager(AMyProjectCameraManager&&) = delete; \
	AMyProjectCameraManager(const AMyProjectCameraManager&) = delete; \
	DECLARE_VTABLE_PTR_HELPER_CTOR(NO_API, AMyProjectCameraManager); \
	DEFINE_VTABLE_PTR_HELPER_CTOR_CALLER(AMyProjectCameraManager); \
	DEFINE_DEFAULT_CONSTRUCTOR_CALL(AMyProjectCameraManager) \
	NO_API virtual ~AMyProjectCameraManager();


#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h_13_PROLOG
#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h_16_GENERATED_BODY \
PRAGMA_DISABLE_DEPRECATION_WARNINGS \
public: \
	FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h_16_INCLASS_NO_PURE_DECLS \
	FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h_16_ENHANCED_CONSTRUCTORS \
private: \
PRAGMA_ENABLE_DEPRECATION_WARNINGS


class AMyProjectCameraManager;

// ********** End Class AMyProjectCameraManager ****************************************************

#undef CURRENT_FILE_ID
#define CURRENT_FILE_ID FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCameraManager_h

PRAGMA_ENABLE_DEPRECATION_WARNINGS
