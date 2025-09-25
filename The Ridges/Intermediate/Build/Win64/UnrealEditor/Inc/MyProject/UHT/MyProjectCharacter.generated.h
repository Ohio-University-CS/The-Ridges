// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

// IWYU pragma: private, include "MyProjectCharacter.h"

#ifdef MYPROJECT_MyProjectCharacter_generated_h
#error "MyProjectCharacter.generated.h already included, missing '#pragma once' in MyProjectCharacter.h"
#endif
#define MYPROJECT_MyProjectCharacter_generated_h

#include "UObject/ObjectMacros.h"
#include "UObject/ScriptMacros.h"

PRAGMA_DISABLE_DEPRECATION_WARNINGS

// ********** Begin Class AMyProjectCharacter ******************************************************
#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h_24_RPC_WRAPPERS_NO_PURE_DECLS \
	DECLARE_FUNCTION(execDoJumpEnd); \
	DECLARE_FUNCTION(execDoJumpStart); \
	DECLARE_FUNCTION(execDoMove); \
	DECLARE_FUNCTION(execDoAim);


MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectCharacter_NoRegister();

#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h_24_INCLASS_NO_PURE_DECLS \
private: \
	static void StaticRegisterNativesAMyProjectCharacter(); \
	friend struct Z_Construct_UClass_AMyProjectCharacter_Statics; \
	static UClass* GetPrivateStaticClass(); \
	friend MYPROJECT_API UClass* Z_Construct_UClass_AMyProjectCharacter_NoRegister(); \
public: \
	DECLARE_CLASS2(AMyProjectCharacter, ACharacter, COMPILED_IN_FLAGS(CLASS_Abstract | CLASS_Config), CASTCLASS_None, TEXT("/Script/MyProject"), Z_Construct_UClass_AMyProjectCharacter_NoRegister) \
	DECLARE_SERIALIZER(AMyProjectCharacter)


#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h_24_ENHANCED_CONSTRUCTORS \
	/** Deleted move- and copy-constructors, should never be used */ \
	AMyProjectCharacter(AMyProjectCharacter&&) = delete; \
	AMyProjectCharacter(const AMyProjectCharacter&) = delete; \
	DECLARE_VTABLE_PTR_HELPER_CTOR(NO_API, AMyProjectCharacter); \
	DEFINE_VTABLE_PTR_HELPER_CTOR_CALLER(AMyProjectCharacter); \
	DEFINE_ABSTRACT_DEFAULT_CONSTRUCTOR_CALL(AMyProjectCharacter) \
	NO_API virtual ~AMyProjectCharacter();


#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h_21_PROLOG
#define FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h_24_GENERATED_BODY \
PRAGMA_DISABLE_DEPRECATION_WARNINGS \
public: \
	FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h_24_RPC_WRAPPERS_NO_PURE_DECLS \
	FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h_24_INCLASS_NO_PURE_DECLS \
	FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h_24_ENHANCED_CONSTRUCTORS \
private: \
PRAGMA_ENABLE_DEPRECATION_WARNINGS


class AMyProjectCharacter;

// ********** End Class AMyProjectCharacter ********************************************************

#undef CURRENT_FILE_ID
#define CURRENT_FILE_ID FID_Users_anime_OneDrive_Documents_Unreal_Projects_MyProject_Source_MyProject_MyProjectCharacter_h

PRAGMA_ENABLE_DEPRECATION_WARNINGS
