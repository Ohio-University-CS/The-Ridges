#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "FlashTrigger.generated.h"

UCLASS()
class YOURPROJECT_API AFlashTrigger : public AActor
{
    GENERATED_BODY()

public:
    AFlashTrigger();

protected:
    virtual void BeginPlay() override;

    // Overlap event
    UFUNCTION()
    void OnBoxOverlap(
        UPrimitiveComponent* OverlappedComp,
        AActor* OtherActor,
        UPrimitiveComponent* OtherComp,
        int32 OtherBodyIndex,
        bool bFromSweep,
        const FHitResult& SweepResult
    );

    // Called after the delay to hide the actor again
    void HideScareActor();

public:

    // Trigger box component
    UPROPERTY(VisibleAnywhere)
    class UBoxComponent* TriggerBox;

    // Actor to flash (set in editor)
    UPROPERTY(EditAnywhere, BlueprintReadWrite)
    AActor* ActorToFlash;

    // Flash duration
    UPROPERTY(EditAnywhere, BlueprintReadWrite)
    float FlashDuration = 0.1f;
};
