using UnrealBuildTool;

public class Horror_FPS_Template : ModuleRules
{
    public Horror_FPS_Template(ReadOnlyTargetRules Target) : base(Target)
    {
        PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;

        PublicDependencyModuleNames.AddRange(new string[]
        {
            "Core",
            "CoreUObject",
            "Engine",
            "InputCore",
            "AIModule",
            "GameplayTasks"
        });

        PrivateDependencyModuleNames.AddRange(new string[] { });
    }
}
