--Fog ESP v3 updated ;
--------by giperfast ;
--------yarindayan12 ;
--------------------------
local misc_automation_main_ref = gui.Reference("Visuals", "World");
local bloom_group = gui.Groupbox(misc_automation_main_ref, "FogEsp", 328, 218, 296)
local Checkbox = gui.Checkbox(bloom_group,"Checkbox", "Enable", true );
local FogColor = gui.ColorPicker(Checkbox, "FogColor", 255, 255, 255, 255);
local bloom_value = gui.Slider( bloom_group, "Value", "AmbientMin", 1, 1, 100);
local bloom = gui.Slider( bloom_group, "Value", "BloomScale", 1, 1, 100);
local fogstart = gui.Slider( bloom_group, "Fogstart", "FogStart", 100, 1, 1000);
local fogend = gui.Slider( bloom_group, "FogEnd", "FogEnd", 1000, 1, 1000);
local maxdensity = gui.Slider( bloom_group, "MaxDensity", "MaxDensity", 1, 1, 100);
local ZoomScale = gui.Slider( bloom_group, "ZoomScale", "ZoomScale", 1, 1, 100);


callbacks.Register("Draw", "fog", function()
    CheckboxValue = Checkbox:GetValue() and 0 or 1
    if(CheckboxValue == 0) then
        r,g,b = FogColor:GetValue();
        local CEnvTonemapController = entities.FindByClass("CEnvTonemapController")[1];
        local CFogController = entities.FindByClass("CFogController")[1];

        if(CFogController) then
            CFogController:SetProp("m_fog.enable", 1, true);
            CFogController:SetProp("m_fog.start", fogstart:GetValue());
            CFogController:SetProp("m_fog.end", fogend:GetValue());
            CFogController:SetProp("m_fog.maxdensity", maxdensity:GetValue()/100);
            CFogController:SetProp("m_fog.ZoomFogScale", ZoomScale:GetValue()/100);
        end
        if(CEnvTonemapController) then
            CEnvTonemapController:SetProp("m_flCustomBloomScale", bloom:GetValue()/50);
            client.SetConVar("r_modelAmbientMin", bloom_value:GetValue()/1, true);
            client.SetConVar("fog_override", 1, true);
            client.SetConVar("fog_enableskybox", 1, true);
            client.SetConVar("fog_startskybox", fogstart:GetValue(), true);
            client.SetConVar("fog_endskybox", fogend:GetValue(), true);
            client.SetConVar("fog_maxdensityskybox", maxdensity:GetValue()/100, true );
        end
            local fcolor = r.." "..g.." "..b;
            client.SetConVar("fog_color",fcolor, true);
            client.SetConVar("fog_colorskybox",fcolor, true);
        end
        if(CheckboxValue == 1) then
                local CEnvTonemapController = entities.FindByClass("CEnvTonemapController")[1];
                local CFogController = entities.FindByClass("CFogController")[1];
            if(CFogController) then
                CFogController:SetProp("m_fog.enable", 0, true);
                CFogController:SetProp("m_fog.start", 0, true);
                CFogController:SetProp("m_fog.end", 0, true);
                CFogController:SetProp("m_fog.maxdensity",0, true);
                CFogController:SetProp("m_fog.ZoomFogScale",0, true);
            end
            if(CEnvTonemapController) then
                CEnvTonemapController:SetProp("m_flCustomBloomScale", 0, true);
                client.SetConVar("r_modelAmbientMin", 0, true);
                client.SetConVar("fog_override", 0, true);
                client.SetConVar("fog_enableskybox", 0, true);
                client.SetConVar("fog_startskybox",  0, true);
                client.SetConVar("fog_endskybox",  0, true);
                client.SetConVar("fog_maxdensityskybox",  0, true);
        end
    end
end)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

