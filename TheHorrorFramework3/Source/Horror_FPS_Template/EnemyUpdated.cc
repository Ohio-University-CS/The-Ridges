#include "MyAIController.h"
#include "Perception/AIPerceptionComponent.h"
#include "Perception/AISense_Sight.h"
#include "Kismet/GameplayStatics.h"
#include "GameFramework/Character.h"
#include "AIController.h"

AMyAIController::AMyAIController()
{
    // Create and configure perception system
    AIPerception = CreateDefaultSubobject<UAIPerceptionComponent>(TEXT("AIPerception"));
    SetPerceptionComponent(*AIPerception);

    // Bind perception update delegate
    AIPerception->OnTargetPerceptionUpdated.AddDynamic(this, &AMyAIController::OnTargetPerceptionUpdated);
}

void AMyAIController::BeginPlay()
{
    Super::BeginPlay();

    // Stop movement at start
    StopMovement();

    // Play idle startup sound if assigned
    if (IdleStartSound)
    {
        UGameplayStatics::PlaySound2D(GetWorld(), IdleStartSound);
    }
}

void AMyAIController::OnTargetPerceptionUpdated(AActor* Actor, FAIStimulus Stimulus)
{
    // Play chase sound
    if (ChaseSound)
    {
        UGameplayStatics::PlaySound2D(GetWorld(), ChaseSound);
    }

    // Try to cast to player
    ACharacter* PlayerCharacter = Cast<ACharacter>(Actor);
    if (!PlayerCharacter)
    {
        StopMovement();
        return;
    }

    // Only react if successfully sensed
    if (Stimulus.WasSuccessfullySensed())
    {
        MoveToActor(PlayerCharacter, 50.0f);  // same as AcceptanceRadius = 50
    }
    else
    {
        StopMovement();
    }
}
