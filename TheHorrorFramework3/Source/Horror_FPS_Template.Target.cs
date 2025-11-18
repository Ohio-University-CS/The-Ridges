using UnrealBuildTool;
using System.Collections.Generic;

public class Horror_FPS_TemplateTarget : TargetRules
{
    public Horror_FPS_TemplateTarget(TargetInfo Target) : base(Target)
    {
        Type = TargetType.Game;
        DefaultBuildSettings = BuildSettingsVersion.V5;
        IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_6;
        ExtraModuleNames.Add("Horror_FPS_Template");
    }
}
