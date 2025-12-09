#include "FlashTrigger.h"
#include "Components/BoxComponent.h"
#include "Components/PrimitiveComponent.h"
#include "Kismet/GameplayStatics.h"
#include "TimerManager.h"

AFlashTrigger::AFlashTrigger()
{
    PrimaryActorTick.bCanEverTick = false;

    // Create trigger box
    TriggerBox = CreateDefaultSubobject<UBoxComponent>(TEXT("TriggerBox"));
    RootComponent = TriggerBox;

    TriggerBox->SetCollisionEnabled(ECollisionEnabled::QueryOnly);
    TriggerBox->SetCollisionObjectType(ECC_WorldStatic);
    TriggerBox->SetCollisionResponseToAllChannels(ECR_Ignore);
    TriggerBox->SetCollisionResponseToChannel(ECC_Pawn, ECR_Overlap);

    // Bind overlap event
    TriggerBox->OnComponentBeginOverlap.AddDynamic(this, &AFlashTrigger::OnBoxOverlap);
}

void AFlashTrigger::BeginPlay()
{
    Super::BeginPlay();

    // Ensure the scare actor starts invisible
    if (ActorToFlash)
    {
        if (UPrimitiveComponent* RootComp = Cast<UPrimitiveComponent>(ActorToFlash->GetRootComponent()))
        {
            RootComp->SetVisibility(false, true);
        }
    }
}

void AFlashTrigger::OnBoxOverlap(UPrimitiveComponent* OverlappedComp, AActor* OtherActor,
    UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult)
{
    if (!ActorToFlash) return;

    // Get root component of the scare actor
    if (UPrimitiveComponent* RootComp = Cast<UPrimitiveComponent>(ActorToFlash->GetRootComponent()))
    {
        // Make visible
        RootComp->SetVisibility(true, true);

        // Set timer to hide after delay
        GetWorld()->GetTimerManager().SetTimer(
            FTimerHandle(),
            this,
            &AFlashTrigger::HideScareActor,
            FlashDuration,
            false
        );
    }
}

void AFlashTrigger::HideScareActor()
{
    if (!ActorToFlash) return;

    if (UPrimitiveComponent* RootComp = Cast<UPrimitiveComponent>(ActorToFlash->GetRootComponent()))
    {
        RootComp->SetVisibility(false, true);
    }
}
