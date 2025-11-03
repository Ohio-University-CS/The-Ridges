#include "MyAIController.h"
#include "BehaviorTree/BlackboardComponent.h"
#include "BehaviorTree/BehaviorTree.h"
#include "BehaviorTree/BehaviorTreeComponent.h"
#include "UObject/ConstructorHelpers.h"
#include "Kismet/GameplayStatics.h"
#include "GameFramework/Character.h"
#include "GameFramework/Actor.h"
#include "Engine/World.h"

AMyAIController::AMyAIController()
{
    PrimaryActorTick.bCanEverTick = true;

    static ConstructorHelpers::FObjectFinder<UBehaviorTree> BTObject(TEXT("/Game/AI/BT_Ai_Enemy.BT_Ai_Enemy"));
    static ConstructorHelpers::FObjectFinder<UBlackboardData> BBObject(TEXT("/Game/AI/BD_Ai_Enemy.BD_Ai_Enemy"));

    if (BTObject.Succeeded())
        BehaviorTree = BTObject.Object;

    if (BBObject.Succeeded())
        BlackboardAsset = BBObject.Object;
}

void AMyAIController::BeginPlay()
{
    Super::BeginPlay();          

    if (UseBlackboard(BlackboardAsset, Blackboard))
        RunBehaviorTree(BehaviorTree);             //simple start game function
}

void AMyAIController::Tick(float DeltaTime)
{
    Super::Tick(DeltaTime);

    APawn* PlayerPawn = UGameplayStatics::GetPlayerPawn(GetWorld(), 0);
    if (!PlayerPawn || !Blackboard) return;

    float Distance = FVector::Dist(PlayerPawn->GetActorLocation(), GetPawn()->GetActorLocation());
    bool bCanSeePlayer = Blackboard->GetValueAsBool(TEXT("bCanSeePlayer"));

    if (bCanSeePlayer || Distance <= 5000.0f)          //if it can see you OR it is closer than 5000 units
    {
        if (Distance > 200.0f)    //if further than 200 units, move closer
        {
            MoveToTarget();         //calls unreal function
        }
        else
        {
            StopMovement();
            AttackTarget();           //customm animation
        }
    }
}

void AMyAIController::MoveToTarget()
{
    APawn* PlayerPawn = UGameplayStatics::GetPlayerPawn(GetWorld(), 0);
    if (PlayerPawn)
        MoveToActor(PlayerPawn, 150.0f); 
}

void AMyAIController::AttackTarget()
{
    UE_LOG(LogTemp, Warning, TEXT("Enemy attacking player"));
}

