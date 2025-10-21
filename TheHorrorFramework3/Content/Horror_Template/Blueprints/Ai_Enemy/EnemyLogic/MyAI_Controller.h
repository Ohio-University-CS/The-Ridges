// Header file for custom AI Controller class in Unreal Engine
#pragma once
#include "CoreMinimal.h"      //Unreal core engine types
#include "AIController.h"     //Unreals built in AI classes
#include "MyAIController.generated.h"    //required for UCLASS macro

UCLASS()
class HORRORTEMPLATE_API AMyAIController : public AAIController
{
    GENERATED_BODY()      //enables macros for reflection system

public:
    AMyAIController();       // Constructor 

protected:
    virtual void BeginPlay() override;     // Called when the game starts or when spawned

public:
    virtual void Tick(float DeltaTime) override;       
    // Called every frame (always running after BeginPlay())

private:
    void MoveToTarget();           // Function to move AI towards a target
    void AttackTarget();         // Function to perform an attack on the target
};