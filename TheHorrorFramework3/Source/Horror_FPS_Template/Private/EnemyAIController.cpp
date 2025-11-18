#include "EnemyAIController.h"
#include "Kismet/GameplayStatics.h"
#include "GameFramework/Character.h"
#include "Engine/World.h"
#include "UObject/ConstructorHelpers.h"

AEnemyAIController::AEnemyAIController()
{
    PrimaryActorTick.bCanEverTick = false;

    // Load Behavior Tree
    static ConstructorHelpers::FObjectFinder<UBehaviorTree> BTObject(
        TEXT("/Game/AI/BT_Enemy.BT_Enemy")
    );
    if (BTObject.Succeeded())
    {
        BehaviorTreeAsset = BTObject.Object;
    }

    // Load Blackboard Data
    // If your asset is named differently, fix this path
    static ConstructorHelpers::FObjectFinder<UBlackboardData> BBObject(
        TEXT("/Game/AI/BB_Enemy.BB_Enemy")
    );
    if (BBObject.Succeeded())
    {
        BlackboardAsset = BBObject.Object;
    }

    // We let UseBlackboard() actually create the BlackboardComp instance
    BlackboardComp = nullptr;
}

void AEnemyAIController::BeginPlay()
{
    Super::BeginPlay();

    if (BlackboardAsset == nullptr)
    {
        UE_LOG(LogTemp, Warning, TEXT("EnemyAIController: BlackboardAsset is NULL"));
        return;
    }

    // Initialize blackboard and store the component in BlackboardComp
    if (!UseBlackboard(BlackboardAsset, BlackboardComp))
    {
        UE_LOG(LogTemp, Warning, TEXT("EnemyAIController: UseBlackboard failed"));
        return;
    }

    // Run the behavior tree
    if (BehaviorTreeAsset)
    {
        RunBehaviorTree(BehaviorTreeAsset);
    }
    else
    {
        UE_LOG(LogTemp, Warning, TEXT("EnemyAIController: BehaviorTreeAsset is NULL"));
    }

    // Set the PlayerTarget key so MoveTo has a valid target
    APawn* PlayerPawn = UGameplayStatics::GetPlayerPawn(GetWorld(), 0);
    if (PlayerPawn && BlackboardComp)
    {
        BlackboardComp->SetValueAsObject(TEXT("PlayerTarget"), PlayerPawn);
    }
}
