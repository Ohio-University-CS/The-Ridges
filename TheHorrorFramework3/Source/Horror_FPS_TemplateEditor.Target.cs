using UnrealBuildTool;
using System.Collections.Generic;

public class Horror_FPS_TemplateEditorTarget : TargetRules
{
    public Horror_FPS_TemplateEditorTarget(TargetInfo Target) : base(Target)
    {
        Type = TargetType.Editor;
        DefaultBuildSettings = BuildSettingsVersion.V5;
        IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_3;
        ExtraModuleNames.Add("Horror_FPS_Template");
    }
}

