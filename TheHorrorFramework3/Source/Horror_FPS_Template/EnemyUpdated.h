#pragma once

#include "CoreMinimal.h"
#include "AIController.h"
#include "Perception/AIPerceptionTypes.h"
#include "MyAIController.generated.h"

UCLASS()
class YOURPROJECT_API AMyAIController : public AAIController
{
    GENERATED_BODY()

public:
    AMyAIController();

protected:
    virtual void BeginPlay() override;

    // Perception Updated Callback
    UFUNCTION()
    void OnTargetPerceptionUpdated(AActor* Actor, FAIStimulus Stimulus);

protected:
    UPROPERTY(VisibleAnywhere, BlueprintReadOnly)
    class UAIPerceptionComponent* AIPerception;

    UPROPERTY(EditAnywhere)
    USoundBase* ChaseSound;

    UPROPERTY(EditAnywhere)
    USoundBase* IdleStartSound;
};
