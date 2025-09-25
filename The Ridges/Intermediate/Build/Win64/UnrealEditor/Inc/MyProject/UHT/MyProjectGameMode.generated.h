// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

// IWYU pragma: private, include "MyProjectGameMode.h"

#ifdef MYPROJECT_MyProjectGameMode_generated_h
#error "MyProjectGameMode.generated.h already included, missing '#pragma once' in MyProjectGameMode.h"
#endif
#define MYPROJECT_MyProjectGameMode_generated_h

#include "UObject/ObjectMacros.h"
#include "UObject/ScriptMacros.h"

PRAGMA_DISABLE_DEPRECATION_WARNINGS

// ********** Begin Class AMyProjectGameMode *******************************************************
MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectGameMode_NoRegister();

#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h_15_INCLASS_NO_PURE_DECLS \
private: \
	static void StaticRegisterNativesAMyProjectGameMode(); \
	friend struct Z_Construct_UClass_AMyProjectGameMode_Statics; \
	static UClass* GetPrivateStaticClass(); \
	friend MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectGameMode_NoRegister(); \
public: \
	DECLARE_CLASS2(AMyProjectGameMode, AGameModeBase, COMPILED_IN_FLAGS(CLASS_Abstract | CLASS_Transient | CLASS_Config), CASTCLASS_None, TEXT("/Script/MyProject"), Z_Construct_UClass_AMyProjectGameMode_NoRegister) \
	DECLARE_SERIALIZER(AMyProjectGameMode)


#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h_15_ENHANCED_CONSTRUCTORS \
	/** Deleted move- and copy-constructors, should never be used */ \
	AMyProjectGameMode(AMyProjectGameMode&&) = delete; \
	AMyProjectGameMode(const AMyProjectGameMode&) = delete; \
	DECLARE_VTABLE_PTR_HELPER_CTOR(NO_API, AMyProjectGameMode); \
	DEFINE_VTABLE_PTR_HELPER_CTOR_CALLER(AMyProjectGameMode); \
	DEFINE_ABSTRACT_DEFAULT_CONSTRUCTOR_CALL(AMyProjectGameMode) \
	NO_API virtual ~AMyProjectGameMode();


#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h_12_PROLOG
#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h_15_GENERATED_BODY \
PRAGMA_DISABLE_DEPRECATION_WARNINGS \
public: \
	FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h_15_INCLASS_NO_PURE_DECLS \
	FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h_15_ENHANCED_CONSTRUCTORS \
private: \
PRAGMA_ENABLE_DEPRECATION_WARNINGS


class AMyProjectGameMode;

// ********** End Class AMyProjectGameMode *********************************************************

#undef CURRENT_FILE_ID
#define CURRENT_FILE_ID FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectGameMode_h

PRAGMA_ENABLE_DEPRECATION_WARNINGS
