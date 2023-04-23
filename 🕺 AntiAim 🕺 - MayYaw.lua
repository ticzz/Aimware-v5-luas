local ScriptName=GetScriptName()
local Version="1.7";
local LastVersion= string.gsub(http.Get("https://raw.githubusercontent.com/MrMayow1337/MayYawLua/main/Version.txt"), "\n", "")
if LastVersion~=Version then
	local LastScript=http.Get("https://raw.githubusercontent.com/MrMayow1337/MayYawLua/main/MayYaw%20.lua")
	file.Delete(ScriptName)
	file.Open(ScriptName,"w")
	file.Write(ScriptName,LastScript)
end
------------------[All ffi:
ffi.cdef [[
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);

    typedef struct {
        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } color_struct_t;

    typedef void (*console_color_print)(const color_struct_t&, const char*, ...);

    typedef void* (__thiscall* get_client_entity_t)(void*, int);
]]
local ffi_log = ffi.cast("console_color_print", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("tier0.dll"), "?ConColorMsg@@YAXABVColor@@PBDZZ"))
local SetClantag= ffi.cast('int(__fastcall*)(const char*, const char*)', mem.FindPattern('engine.dll', '53 56 57 8B DA 8B F9 FF 15'))
------------------All ffi]
-----------------[Functions:
--Encoding,Decoding function
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function enc(data) --Encoding
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
local function dec(data) --Decoding
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end
local function CustomGui(guiObject,x,y,wight,hight) --Custom Gui function
	if guiObject==nil then return end
	if x then guiObject:SetPosX(x) end
	if y then guiObject:SetPosY(y) end 
	if wight then guiObject:SetWidth(wight) end
	if hight then guiObject:SetHeight(hight) end
end
local function GradientRect(x,y,hight,wight,vert,r,g,b,a) --Render GradientRect function
    highty=hight
    hight=a/hight
    xx=x
    if vert==false then
        if hight > 0 then
            for i=a, 0, -hight do
                draw.Color(r,g,b,i)
                draw.FilledRect(x,y,x+2,wight)
                x=x+1
            end
        elseif hight < 0 then
            for i=0, a, -hight do
                draw.Color(r,g,b,i)
                draw.FilledRect(x,y,x+2,wight)
                x=x+1
            end
        end
     elseif vert==true then
        if wight > 0 then
             for i=a, 0, -wight do
                 draw.Color(r,g,b,i)
                 draw.FilledRect(xx,y,highty,y+2)
                y=y+1
             end
        elseif wight < 0 then
            for i=0, a, -wight do
                draw.Color(r,g,b,i)
                draw.FilledRect(xx,y,highty,y+2)
                y=y+1
            end
        end
    end
end
function client.color_log(r, g, b, msg, ...) --Color Log function
    for k, v in pairs({...}) do
        msg = tostring(msg .. v)
    end
    local clr = ffi.new("color_struct_t")
       clr.r, clr.g, clr.b, clr.a = r, g, b, 255
    ffi_log(clr, msg)
end
local function HitGroup(HitGroup) --HitGroup handler function
    if HitGroup == nil then
        return;
    elseif HitGroup == 0 then
        return "body";
    elseif HitGroup == 1 then
        return "head";
    elseif HitGroup == 2 then
        return "chest";
    elseif HitGroup== 3 then
        return "stomach";
    elseif HitGroup == 4 then
        return "left arm";
    elseif HitGroup == 5 then
        return "right arm";
    elseif HitGroup == 6 then
        return "left leg";
    elseif HitGroupP == 7 then
        return "right leg";
    elseif HitGroup == 10 then
        return "body";
    end
end
local function GetActiveGun() --Active gun handler function
    local lp=entities.GetLocalPlayer()
    local lpaw=lp:GetWeaponID()
    if lpaw==2 or lpaw==3 or lpaw==4 or lpaw==30 or lpaw==32 or lpaw==36 or lpaw==61 or lpaw==63 then
        wclass="pistol"
    elseif lpaw==9 then
        wclass="sniper"
    elseif lpaw==40 then
        wclass="scout"
    elseif lpaw==1 then
        wclass="hpistol"
    elseif lpaw==17 or lpaw== 19 or lpaw== 23 or lpaw== 24 or lpaw== 26 or lpaw== 33 or lpaw== 34 then
        wclass="smg"
    elseif lpaw==7 or lpaw==8 or lpaw== 10 or lpaw== 13 or lpaw== 16 or lpaw== 39 or lpaw== 61 then
        wclass="rifle"
    elseif lpaw== 25 or lpaw== 27 or lpaw== 29 or lpaw== 35 then
        wclass="shotgun"
    elseif lpaw == 38 or lpaw== 11 then
        wclass="asniper"
    elseif lpaw == 28 or lpaw== 14 then
        wclass="lmg"
    else
        wclass="other"
    end
    return wclass
end
function GetLuaCfg() -- Get all lua cfg
    ConfigList={}
    file.Enumerate(function(file)
        if string.match(file, "%.dat") then
            table.insert(ConfigList, file:sub(15,-5))
        end
    end)
    table.insert(ConfigList, "MayYaw(Default)")
    return ConfigList
end
------------------Functions]
GetLuaCfg()
local Aimwaremenu=gui.Reference("MENU")
local MayYaw = gui.Tab(gui.Reference("Settings"), "mayyaw", "MayYaw");
local MainYaw=gui.Groupbox(MayYaw, "Enable MayYaw", 5, 10, 175, 0)
local EnableYaw=gui.Checkbox(MainYaw, "Enableyaw", "Enable", false)
local ComboboxMenuMode=gui.Combobox(MainYaw, "ComboxMenuMode", "Tab Selection","General","Anti-Aim","Visuals","Misc","Config")
local GroupboxMain=gui.Groupbox(MayYaw, "Press 'Enable'", 190, 10, 410, 0)
local GroupboxAntiAim=gui.Groupbox(MayYaw, "MayYaw Anti-Aim", 190, 10, 410, 0)
local GroupboxVisuals=gui.Groupbox(MayYaw, "MayYaw Visuals", 190, 10, 200, 0)
local GroupboxVisualsValue=gui.Groupbox(MayYaw, "MayYaw Visuals Value", 400, 10, 225, 0)
local GroupboxConfigs=gui.Groupbox(MayYaw, "MayYaw Configs", 190, 10, 230, 0)
local GroupboxCodesActions=gui.Groupbox(MayYaw, "MayYaw Actions with Codes", 425, 240, 200, 0)
local EditBoxCodes=gui.Editbox(GroupboxCodesActions, "EditBoxCodes", "Config Code" )
local GroupboxConfigsActions=gui.Groupbox(MayYaw, "MayYaw Actions with Configs", 425, 10, 200, 0)
local EditBoxConfig=gui.Editbox( GroupboxConfigsActions, "EditBoxConfig", "Config Name" )
local ListboxConfig=gui.Listbox( GroupboxConfigs, "ListboxConfig", 310, unpack(ConfigList))
local EnableIndicators=gui.Checkbox(GroupboxVisuals, "EnableIndocators", "Indicators", false)
local EnableKeybinds=gui.Checkbox(GroupboxVisuals, "EnableKeybinds", "Keybinds", false)
local EnableDesyncInvertIndicator=gui.Checkbox(GroupboxVisuals, "EnableDesyncInvertIndicator", "Desync Indicator", false)
local EnableWatermark=gui.Checkbox(GroupboxVisuals,"EnableWatermark","Watermark",false)
local EnableNightMode=gui.Checkbox( GroupboxVisuals, "EnableNightMode", "Night Mode", false )
local EnableAcpectRatio=gui.Checkbox( GroupboxVisuals, "EnableAcpectRation", "Aspect Ratio", false )
local ComboboxKeybindsStyles=gui.Combobox(GroupboxVisualsValue, "ComboboxKeybindsStyles", "Keybinds Styles","Default","Sense")
local ComboboxWatermarkStyles=gui.Combobox(GroupboxVisualsValue, "ComboboxWatermarkStyles", "Watermark Styles","Default","Sense")
local AspectRatioDefValSlider=gui.Slider(GroupboxVisualsValue,"AspectRatioVal","Aspect Ratio Value",0,0,200)
local NightModeValSlider=gui.Slider(GroupboxVisualsValue, "NightModeValSlider", "Night Mode Value", 100, 1, 100);
local GroupboxGeneral=gui.Groupbox(MayYaw, "MayYaw General", 190, 10, 200, 0)
local GroupboxGeneralValue=gui.Groupbox(MayYaw, "MayYaw General Value", 400, 10, 225, 0)
local EnableCustomDoubleTapMode=gui.Checkbox(GroupboxGeneral,"EnableCustomDoubleTapMode","Custom Double fire",false)
local EnableJumpScoutFix=gui.Checkbox(GroupboxGeneral,"EnableJumpScoutFix","Jump Scout Fix",false)
local EnableNoScopeHitChance=gui.Checkbox(GroupboxGeneral,"EnableNoScopeHitChance","NoScope Hit Chance",false)
local EnableDoubleFireDamageHpdiv2=gui.Checkbox(GroupboxGeneral,"DoubleFireDamageHpdiv2","DT dmg Enemy HP/2",false)
local ComboboxCustomDoubleFireMode=gui.Combobox(GroupboxGeneralValue,"ComboboxCustomDoubleFireMode","Double fire mode","Adaptive","Faster(Inaccuracy)","Standart","Slow")
local NoScopeHitChanceSlider=gui.Slider(GroupboxGeneralValue,"NoScopeHitChanceSlider", "NoScope Hit Chance Value", 0, 0, 100)
local EnableIdealTick=gui.Checkbox(GroupboxGeneral, "EnableIdealTick", "IdealTick", false )
local GroupboxMisc=gui.Groupbox(MayYaw, "MayYaw Misc", 190, 10, 230, 0)
local GroupboxAutoBuy=gui.Groupbox(MayYaw, "AutoBuy", 190, 250, 230, 0)
local ComboboxAutoBuyPrimaryWeapon=gui.Combobox(GroupboxAutoBuy, "ComboxAutoBuyPrimaryWeapon", "Primary Weapon","None","Auto","Ssg08","AWP")
local ComboboxAutoBuySecondaryWeapon=gui.Combobox(GroupboxAutoBuy, "ComboxAutoBuySecondaryWeapon", "Secondary Weapon","None","Deagle R8","Dual","Tec9/Five Seven")
local ComboboxAutoBuyArmor=gui.Combobox(GroupboxAutoBuy, "ComboxAutoBuyArmor", "Armor","None","Kevlar","Kevlar + Helmet")
local GrenadeMultibox=gui.Multibox(GroupboxAutoBuy,"Grenade")
local EnableBuyGrenade=gui.Checkbox(GrenadeMultibox, "EnableBuyGrenade", "Grenade", false)
local EnableBuyMolotov=gui.Checkbox(GrenadeMultibox, "EnableBuyMolotov", "Molotov", false)
local EnableBuySmoke=gui.Checkbox(GrenadeMultibox, "EnableBuySmoke", "Smoke", false)
local EnableDmg=gui.Checkbox(GroupboxMisc,"EnableDmg","DamageOverride",false)
local EnableEngineRadar=gui.Checkbox(GroupboxMisc,"EnableEngineRadar","EngineRadar",false)
local EnableAutoBuy=gui.Checkbox(GroupboxMisc,"EnableAutoBuy","AutoBuy",false)
local EnableHitLog=gui.Checkbox(GroupboxMisc,"EnableHitLog","Advanced Damage Log",false)
local EnableClantag=gui.Checkbox(GroupboxMisc,"EnableClantag","Clantag",false)
local GroupboxDMG=gui.Groupbox(MayYaw, "Damage Override", 430, 10, 200, 0)
local AwpDMGOverrideSlider=gui.Slider(GroupboxDMG, "awpdmgoverrideslider", "Awp Override Min Damage", 0, 1, 130 )
local AutoDMGOverrideSlider=gui.Slider(GroupboxDMG, "autodmgoverrideslider", "Auto Override Min Damage", 0, 1, 130 )
local Ssg08DMGOverrideSlider=gui.Slider(GroupboxDMG, "ssg08dmgoverrideslider", "Scout Override Min Damage", 0, 1, 130 )
local HeavyPistolDMGOverrideSlider=gui.Slider(GroupboxDMG, "heavypistoldmgoverrideslider", "Heavy Pistol Override Min Damage", 0, 1, 130 )
local PistolDMGOverrideSlider=gui.Slider(GroupboxDMG, "pistoldmgoverrideslider", "Pistol Override Min Damage", 0, 1, 130 )
local ComboboxDMGmode=gui.Combobox(GroupboxDMG, "ComboboxDMGmode", "Mode","Hold","Toggle")
local DMGKey=gui.Keybox(GroupboxDMG,"DMGKey","Key", 0 )
local EnableMayYawAA=gui.Checkbox(GroupboxAntiAim,"EbableMayYawAA","MayYawAA",false)
local EnableLagitAAonUse=gui.Checkbox(GroupboxAntiAim,"EnableLagitAAonUse","Legit AA on Use",false)
local GroupboxEnableMayYawAA=gui.Groupbox(MayYaw, "MayYaw AA",  190, 135, 410, 0)
local ComboboxAAPlayerState=gui.Combobox( GroupboxEnableMayYawAA, "ComboboxAAPlayerState", "Player State","Global","Standing","SlowMotion","Moving","Air")
local ComboxAtTargetPriotity=gui.Combobox( GroupboxEnableMayYawAA, "ComboxAtTargetPriotity", "At Tagret Priority", "FOV", "Distance" )
local EnableStandingAA=gui.Checkbox( GroupboxEnableMayYawAA, "EnableStandingAA", "Enable Standing Anti-Aim",false)
local EnableSlowMotionAA=gui.Checkbox( GroupboxEnableMayYawAA, "EnableSlowMotionAA", "Enable SlowMotion Anti-Aim",false)
local EnableMovingAA=gui.Checkbox( GroupboxEnableMayYawAA, "EnableMovingAA", "Enable Moving Anti-Aim",false)
local EnableAirAA=gui.Checkbox( GroupboxEnableMayYawAA, "EnableAirAA", "Enable Air Anti-Aim",false)
local GlobalRotationSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "GlobalRotationSliderCustom", "Rotation Offset", 0, -58, 58 )
local GlobalLBYSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "GlobalLBYSliderCustom", "LBY Offset", 0, -180, 180 )
local GlobalBaseYawSliderCustom=gui.Slider(GroupboxEnableMayYawAA,"GlobalBaseYawSliderCustom","Base Yaw Offset",0,-180,180)
local StandingRotationSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "StandingRotationSliderCustom", "Rotation Offset", 0, -58, 58 )
local StandingLBYSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "StandingLBYSliderCustom", "LBY Offset", 0, -180, 180 )
local StandingBaseYawSliderCustom=gui.Slider(GroupboxEnableMayYawAA,"StandingBaseYawSliderCustom","Base Yaw Offset",0,-180,180)
local SlowMotionRotationSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "SlowMotionRotationSliderCustom", "Rotation Offset", 0, -58, 58 )
local SlowMotionLBYSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "SlowMotionLBYSliderCustom", "LBY Offset", 0, -180, 180 )
local SlowMotionBaseYawSliderCustom=gui.Slider(GroupboxEnableMayYawAA,"SlowMotionBaseYawSliderCustom","Base Yaw Offset",0,-180,180)
local MovingRotationSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "MovingRotationSliderCustom", "Rotation Offset", 0, -58, 58 )
local MovingLBYSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "MovingLBYSliderCustom", "LBY Offset", 0, -180, 180 )
local MovingBaseYawSliderCustom=gui.Slider(GroupboxEnableMayYawAA,"MovingBaseYawSliderCustom","Base Yaw Offset",0,-180,180)
local AirRotationSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "AirRotationSliderCustom", "Rotation Offset", 0, -58, 58 )
local AirLBYSliderCustom=gui.Slider(GroupboxEnableMayYawAA, "AirLBYSliderCustom", "LBY Offset", 0, -180, 180 )
local AirBaseYawSliderCustom=gui.Slider(GroupboxEnableMayYawAA,"AirBaseYawSliderCustom","Base Yaw Offset",0,-180,180)
local EnableJitterGlobal=gui.Checkbox( GroupboxEnableMayYawAA, "EnableJitterGlobal", "Jitter Global", false )
local EnableJitterStanding=gui.Checkbox( GroupboxEnableMayYawAA, "EnableJitterStanding", "Jitter Standing", false )
local EnableJitterSlowMotion=gui.Checkbox( GroupboxEnableMayYawAA, "EnableJitterSlowMotion", "Jitter SlowMotion", false )
local EnableJitterMoving=gui.Checkbox( GroupboxEnableMayYawAA, "EnableJitterMoving", "Jitter Moving", false )
local EnableJitterAir=gui.Checkbox( GroupboxEnableMayYawAA, "EnableJitterAir", "Jitter Air", false )
local SliderJitterOffsetGlobal=gui.Slider( GroupboxEnableMayYawAA, "SliderJitterOffsetGlobal", "Jitter Global Offset",0, 0, 180 )
local SliderJitterOffsetStanding=gui.Slider( GroupboxEnableMayYawAA, "SliderJitterOffsetStanding", "Jitter Standing Offset",0, 0, 180 )
local SliderJitterOffsetSlowMotion=gui.Slider( GroupboxEnableMayYawAA, "SliderJitterOffsetSlowMotion", "Jitter SlowMotion Offset",0, 0, 180 )
local SliderJitterOffsetMoving=gui.Slider( GroupboxEnableMayYawAA, "SliderJitterOffsetMoving", "Jitter Moving Offset",0, 0, 180 )
local SliderJitterOffsetAir=gui.Slider( GroupboxEnableMayYawAA, "SliderJitterOffsetAir", "Jitter Air Offset",0, 0, 180 )
local ComobboxAutoDirectionModeGlobal=gui.Combobox( GroupboxEnableMayYawAA, "ComobboxAutoDirectionModeGlobal", "Auto Direction Global mode", "Advanced At Target","Default At Target")
local ComobboxAutoDirectionModeStanding=gui.Combobox( GroupboxEnableMayYawAA, "ComobboxAutoDirectionModeStanding", "Auto Direction Standing mode", "Advanced At Target","Default At Target")
local ComobboxAutoDirectionModeSlowMotion=gui.Combobox( GroupboxEnableMayYawAA, "ComobboxAutoDirectionModeSlowMotion", "Auto Direction SlowMotion mode", "Advanced At Target","Default At Target")
local ComobboxAutoDirectionModeMoving=gui.Combobox( GroupboxEnableMayYawAA, "ComobboxAutoDirectionModeMoving", "Auto Direction Moving mode", "Advanced At Target","Default At Target")
local ComobboxAutoDirectionModeAir=gui.Combobox( GroupboxEnableMayYawAA, "ComobboxAutoDirectionModeAir", "Auto Direction Air mode", "Advanced At Target","Default At Target")
local EnableLowDelta=gui.Checkbox(GroupboxEnableMayYawAA, "EnableLowDelta", "LowDelta",false)
local LowDeltaSliderValue=gui.Slider(GroupboxEnableMayYawAA, "LowDeltaSliderValue", "Low Delta Value", 0, 1, 60 )
local EnbaleAutoSwitchDesync=gui.Checkbox(GroupboxEnableMayYawAA,"EnbaleAutoSwitchDesync","Auto Desync Switch",false)
local ComboboxAutoDesyncInvertMode=gui.Combobox(GroupboxEnableMayYawAA, "ComboboxAutoDesyncInvertMode", "Desync Switch Mode","FOV","Distance","Local Player Velocity")
local DesyncSwitchKey=gui.Keybox(GroupboxEnableMayYawAA,"DesyncSwitchKey","Desync Switch Key", 0 )
local DescriptionGroupbox=gui.Groupbox(MayYaw, "MayYaw Description", 5, 160, 175, 0)
local Descriptionmaintext=gui.Text(DescriptionGroupbox,"MayYaw lua for aimware")
local Descriptionversiontext=gui.Text(DescriptionGroupbox,"Version: "..Version)
local Descriptionavtortext=gui.Text(DescriptionGroupbox,"Created by Maybe")
local DescriptionDiscordtext=gui.Text(DescriptionGroupbox,"Discord: MrMaybe#2990")
local LastUpdGroupboxNotLatUpd=gui.Groupbox(MayYaw, "Last Update", 5, 335, 175, 0)
local LastUpdGroupbox=gui.Groupbox(MayYaw, "Last Update", 5, 327, 175, 0)
local LastUpddatetext=gui.Text(LastUpdGroupbox,"05.08.2021")
local LastUpdlog2text=gui.Text(LastUpdGroupbox,"[+] IdealTick")
local LastUpdlog3text=gui.Text(LastUpdGroupbox,"[+] Player AA State")
local LastUpdlog4text=gui.Text(LastUpdGroupbox,"[+] Jitter")
local LastUpdlog5text=gui.Text(LastUpdGroupbox,"[+] 2 AutoDir mode")
local LastUpdlog7text=gui.Text(LastUpdGroupbox,"[=] Code System")
local LastUpdlog8text=gui.Text(LastUpdGroupbox,"[=] Reworked MayYawAA")
local LastUpdlog9text=gui.Text(LastUpdGroupbox,"[=] Cfg tab design")
local LastUpdlog10text=gui.Text(LastUpdGroupbox,"[=] AutoBuy Design")
local UpdateText=gui.Text(LastUpdGroupboxNotLatUpd,"PLEASE RELOAD SCRIPT".."\n\n New version: "..LastVersion.."\n\n Your Version:"..Version)
local WatermarkColor=gui.ColorPicker(EnableWatermark,"Colorwatermark","Watermark Color", 56,56, 165, 255 )
local KeybindsColor=gui.ColorPicker(EnableKeybinds,"KeybindsColor","Keybinds Color", 56,56, 165, 255 )
local MainLogColor=gui.ColorPicker(EnableHitLog,"MainLogColor","Main Log Color", 94,152,217, 255 )
local PrefixLogColor=gui.ColorPicker(EnableHitLog,"PrefixLogColor","Prefix Log Color", 0,243,26, 255 )
local DesyncInvertActiveColor=gui.ColorPicker(EnableDesyncInvertIndicator,"DesyncInvertActiveColor","Active Arrow Color", 0,255, 0, 255 )
local maxticks=gui.Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks')
---------------------------
local GuiElementsList={ 
						"mayyaw.Enableyaw","mayyaw.EnableCustomDoubleTapMode","mayyaw.EnableJumpScoutFix","mayyaw.EnableNoScopeHitChance",
						"mayyaw.DoubleFireDamageHpdiv2","mayyaw.ComboboxCustomDoubleFireMode","mayyaw.NoScopeHitChanceSlider","mayyaw.EbableMayYawAA",
						"mayyaw.EnableLagitAAonUse","mayyaw.ComboboxAAPlayerState","mayyaw.GlobalRotationSliderCustom","mayyaw.GlobalLBYSliderCustom",
						"mayyaw.GlobalBaseYawSliderCustom","mayyaw.EnableStandingAA","mayyaw.StandingRotationSliderCustom",
                        "mayyaw.StandingLBYSliderCustom","mayyaw.StandingBaseYawSliderCustom","mayyaw.EnableSlowMotionAA","mayyaw.SlowMotionRotationSliderCustom",
						"mayyaw.SlowMotionLBYSliderCustom","mayyaw.SlowMotionBaseYawSliderCustom","mayyaw.EnableMovingAA",
						"mayyaw.MovingRotationSliderCustom","mayyaw.MovingLBYSliderCustom","mayyaw.MovingBaseYawSliderCustom","mayyaw.EnableAirAA",
						"mayyaw.AirRotationSliderCustom","mayyaw.AirLBYSliderCustom","mayyaw.AirBaseYawSliderCustom",
						"mayyaw.ComboxAtTargetPriotity","mayyaw.ComobboxAutoDirectionModeGlobal","mayyaw.ComobboxAutoDirectionModeStanding",
						"mayyaw.ComobboxAutoDirectionModeSlowMotion","mayyaw.ComobboxAutoDirectionModeMoving","mayyaw.ComobboxAutoDirectionModeAir",
						"mayyaw.EnableJitterGlobal","mayyaw.SliderJitterOffsetGlobal","mayyaw.EnableJitterStanding","mayyaw.SliderJitterOffsetStanding",
						"mayyaw.EnableJitterSlowMotion","mayyaw.SliderJitterOffsetSlowMotion","mayyaw.EnableJitterMoving","mayyaw.SliderJitterOffsetMoving",
						"mayyaw.EnableJitterAir","mayyaw.SliderJitterOffsetAir","mayyaw.EnableLowDelta","mayyaw.LowDeltaSliderValue","mayyaw.EnbaleAutoSwitchDesync",
						"mayyaw.ComboboxAutoDesyncInvertMode","mayyaw.DesyncSwitchKey","mayyaw.EnableIndocators","mayyaw.EnableKeybinds","mayyaw.EnableDesyncInvertIndicator",
						"mayyaw.EnableWatermark","mayyaw.EnableNightMode","mayyaw.EnableAcpectRation","mayyaw.ComboboxKeybindsStyles","mayyaw.ComboboxWatermarkStyles",
						"mayyaw.AspectRatioVal","mayyaw.NightModeValSlider","mayyaw.EnableDmg","mayyaw.EnableEngineRadar","mayyaw.EnableAutoBuy",
						"mayyaw.EnableHitLog","mayyaw.EnableClantag","mayyaw.awpdmgoverrideslider","mayyaw.autodmgoverrideslider","mayyaw.ssg08dmgoverrideslider",
						"mayyaw.heavypistoldmgoverrideslider","mayyaw.pistoldmgoverrideslider","mayyaw.ComboboxDMGmode","mayyaw.DMGKey","mayyaw.ComboxAutoBuyPrimaryWeapon",
						"mayyaw.ComboxAutoBuySecondaryWeapon","mayyaw.ComboxAutoBuyArmor","mayyaw.EnableBuyGrenade","mayyaw.EnableBuyMolotov","mayyaw.EnableBuySmoke"
					  }
local GuiElementsColorList={KeybindsColor,WatermarkColor,MainLogColor,PrefixLogColor,DesyncInvertActiveColor}
local DefaultMayYawConfig="MSwxLDEsMSwxLDAsMTIsMSwwLDEsLTU4LDEwOCwwLDEsLTU4LDAsMCwxLC01OCwzOCwwLDEsLTM3LDc1LDAsMSwtMjMsNjEsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDEsOCwxLDExLDEsMTEsMSwxNywwLDAsNzAsMCwxLDEsMSwxLDAsMSwxLDAsODgsMSwxLDEsMSwwLDgsMiw1LDkyLDEsMCw4NiwyLDMsMiwxLDEsMSwxNDIsMTY1LDIyOSwyNTUsMTQyLDE2NSwyMjksMjU1LDE1NiwyNTUsMjU1LDI1NSwwLDI1NSwzNiwyNTUsMTQyLDE2NSwyMjksMjU1"
local CreateConfigButton=gui.Button( GroupboxConfigsActions, "Create", function()
	local ConfigName=EditBoxConfig:GetValue()
	if ConfigName == nil or ConfigName == "" or ConfigName == "MayYaw(Default)"then
		return
	end
	file.Write("MayYawConfigs/"..ConfigName..".dat","")
	GetLuaCfg()
    ListboxConfig:SetOptions(unpack(ConfigList))
	EditBoxConfig:SetValue("")
end)
local DeleteConfigButton=gui.Button( GroupboxConfigsActions, "Delete",function()
	GetLuaCfg()
	file.Delete("MayYawConfigs/"..ConfigList[ListboxConfig:GetValue()+1]..".dat")
	GetLuaCfg()
	ListboxConfig:SetOptions(unpack(ConfigList))
end)
local SaveConfigButton=gui.Button( GroupboxConfigsActions, "Save", function()
	local kbr,kbg,kbb,kba=KeybindsColor:GetValue()
	local wtr,wtg,wtb,wta=WatermarkColor:GetValue()
	local mlr,mlg,mlb,mla=MainLogColor:GetValue()
	local plr,plg,plb,pla=PrefixLogColor:GetValue()
	local iir,iig,iib,iia=DesyncInvertActiveColor:GetValue()
	local GuiElementsColorValueList={{kbr,kbg,kbb,kba},{wtr,wtg,wtb,wta},{mlr,mlg,mlb,mla},{plr,plg,plb,pla},{iir,iig,iib,iia}}
	GetLuaCfg()
    local ConfigName=ConfigList[ListboxConfig:GetValue()+1]
	file.Write("MayYawConfigs/"..ConfigName..".dat","")
    fileConfig = file.Open("MayYawConfigs/"..ConfigName..".dat", "a");
	for i = 1, table.maxn(GuiElementsList) do
		local Value=gui.GetValue(GuiElementsList[i])
		if Value == true then
			Value=1
		elseif Value == false then
			Value=0
		end
		fileConfig:Write(tostring(Value..","))
    end
	for j=1, table.maxn(GuiElementsColorValueList) do
		for g=1, table.maxn(GuiElementsColorValueList[j]) do
			if j == table.maxn(GuiElementsColorValueList) and g==table.maxn(GuiElementsColorValueList[j]) then
				fileConfig:Write(tostring(GuiElementsColorValueList[j][g]))
			else
				fileConfig:Write(tostring(GuiElementsColorValueList[j][g]..","))
			end
		end
	end
end) 
local LoadConfigButton=gui.Button( GroupboxConfigsActions, "Load",function()
	local Data={}
    GetLuaCfg()
    local ConfigName=ConfigList[ListboxConfig:GetValue()+1]
	if ListboxConfig:GetValue()+1 == table.maxn(ConfigList) then
		ConfigData=dec(DefaultMayYawConfig)
	else
		ConfigData=file.Read("MayYawConfigs/"..ConfigName..".dat","r")
	end
	for h in string.gmatch(ConfigData, '([^,]+)') do
		table.insert(Data,h)
	end
	for i = 1, table.maxn(GuiElementsList) do
		gui.SetValue(GuiElementsList[i],Data[i])
    end
	local Maxngui=table.maxn(GuiElementsList)
	for i = 1, table.maxn(GuiElementsColorList) do
		if i > 1 then 
			Schet=Schet+1
		else
			Schet=0
		end
		local kl1=Data[Maxngui+1+Schet*4]
		local kl2=Data[Maxngui+2+Schet*4]
		local kl3=Data[Maxngui+3+Schet*4]
		local a=Data[Maxngui+4+Schet*4]
		GuiElementsColorList[i]:SetValue(kl1,kl2,kl3,a)
    end
end)

local RefreshConfigsButton=gui.Button(GroupboxConfigsActions,"Refresh",function()
    GetLuaCfg()
    ListboxConfig:SetOptions(unpack(ConfigList))
end)
local ResetConfigButton=gui.Button(GroupboxConfigsActions,"Reset",function()
	for i = 1, table.maxn(GuiElementsList) do
		if i ~= 1 then
			gui.SetValue(GuiElementsList[i],nil)
		end
	end
	for i = 1, table.maxn(GuiElementsColorList) do
		GuiElementsColorList[i]:SetValue(nil,nil,nil,nil)
	end
end)
local ImportCofigByCode=gui.Button(GroupboxCodesActions,"Import",function()
	local Data={}
	local Code=dec(EditBoxCodes:GetValue())
	for h in string.gmatch(Code, '([^,]+)') do
		table.insert(Data,h)
	end
	for i = 1, table.maxn(GuiElementsList) do
		gui.SetValue(GuiElementsList[i],Data[i])
    end
	local Maxngui=table.maxn(GuiElementsList)
	for i = 1, table.maxn(GuiElementsColorList) do
		if i > 1 then 
			Schet=Schet+1
		else
			Schet=0
		end
		local kl1=Data[Maxngui+1+Schet*4]
		local kl2=Data[Maxngui+2+Schet*4]
		local kl3=Data[Maxngui+3+Schet*4]
		local a=Data[Maxngui+4+Schet*4]
		GuiElementsColorList[i]:SetValue(kl1,kl2,kl3,a)
    end
	EditBoxCodes:SetValue("")
end)
local ExportCofigByCode=gui.Button(GroupboxCodesActions,"Export",function()
	local ExportConfig={}
	local kbr,kbg,kbb,kba=KeybindsColor:GetValue()
	local wtr,wtg,wtb,wta=WatermarkColor:GetValue()
	local mlr,mlg,mlb,mla=MainLogColor:GetValue()
	local plr,plg,plb,pla=PrefixLogColor:GetValue()
	local iir,iig,iib,iia=DesyncInvertActiveColor:GetValue()
	local GuiElementsColorValueList={{kbr,kbg,kbb,kba},{wtr,wtg,wtb,wta},{mlr,mlg,mlb,mla},{plr,plg,plb,pla},{iir,iig,iib,iia}}
	GetLuaCfg()
	for i = 1, table.maxn(GuiElementsList) do
		local Value=gui.GetValue(GuiElementsList[i])
		if Value == true then
			Value=1
		elseif Value == false then
			Value=0
		end
		table.insert(ExportConfig,Value..",")
    end
	for j=1, table.maxn(GuiElementsColorValueList) do
		for g=1, table.maxn(GuiElementsColorValueList[j]) do
			if j == table.maxn(GuiElementsColorValueList) and g==table.maxn(GuiElementsColorValueList[j]) then
				table.insert(ExportConfig,GuiElementsColorValueList[j][g])
			else
				table.insert(ExportConfig,GuiElementsColorValueList[j][g]..",")
			end
		end
	end
	print(enc(table.concat(ExportConfig)))
end)
--------------------------
--[Gui Corections
CustomGui(CreateConfigButton,nil,55,80,25)
CustomGui(DeleteConfigButton,90,55,80,25)
CustomGui(LoadConfigButton,nil,95,80,25)
CustomGui(SaveConfigButton,90,95,80,25)
CustomGui(RefreshConfigsButton,nil,135,80,25)
CustomGui(ResetConfigButton,90,135,80,25)
CustomGui(ImportCofigByCode,nil,55,80,25)
CustomGui(ExportCofigByCode,90,55,80,25)
CustomGui(ComboboxDMGmode,nil,nil,80,nil)
CustomGui(DMGKey,90,240,nil,nil)
CustomGui(ComboboxAutoBuyPrimaryWeapon,nil,nil,95,nil)
CustomGui(ComboboxAutoBuySecondaryWeapon,105,0,95,nil)
CustomGui(ComboboxAutoBuyArmor,nil,nil,95,nil)
CustomGui(GrenadeMultibox,105,56,95,nil)
CustomGui(ComboboxAAPlayerState,nil,nil,150,nil)
CustomGui(ComboboxAutoDesyncInvertMode,nil,nil,150,nil)
CustomGui(DesyncSwitchKey,nil,nil,200,nil)
CustomGui(ComboxAtTargetPriotity,220,0,150,nil)
CustomGui(ComobboxAutoDirectionModeGlobal,nil,nil,150,nil)
CustomGui(ComobboxAutoDirectionModeStanding,nil,nil,150,nil)
CustomGui(ComobboxAutoDirectionModeSlowMotion,nil,nil,150,nil)
CustomGui(ComobboxAutoDirectionModeMoving,nil,nil,150,nil)
CustomGui(ComobboxAutoDirectionModeAir,nil,nil,150,nil)
--Gui Corections]
--Default Presets
local DefScopeAutoValue = gui.GetValue("rbot.hitscan.accuracy.asniper.hitchance")
local DefDmgAutoValue = gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
local AspectRatioDefVal = 0
local NightModeDefVal = 100
local HitScore = 0
local DesyncSide = "Left"
local max = 100000000
local mindist = max
local LocalPlayerSpread=0
local Font1 = draw.CreateFont("Arial Black", 15)
local Font2 = draw.CreateFont("Verdana", 13)
local Font3 = draw.CreateFont("Verdana", 12)
local Font4 = draw.CreateFont("Verdana", 15)
local defhcscout=gui.GetValue("rbot.hitscan.accuracy.scout.hitchance")
local defRotation=gui.GetValue("rbot.antiaim.base")
local awpdefdmg=gui.GetValue("rbot.hitscan.accuracy.sniper.mindamage")
local autodefdmg=gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
local ssgdefdmg=gui.GetValue("rbot.hitscan.accuracy.scout.mindamage")
local heavydefdmg=gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
local pistoldefdmg=gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
local toggle=1
local DesyncSwitchToggle=-1
local AutoPeekToggle=-1
local x1=100; local y1=100; local wight=230;local hight=200
local OverrideScoutHC=false
--Version
if LastVersion~=Version then
	LastUpdGroupboxNotLatUpd:SetInvisible(false)
	LastUpdGroupbox:SetInvisible(true)
else
	LastUpdGroupboxNotLatUpd:SetInvisible(true)
	LastUpdGroupbox:SetInvisible(false)
end
--Function for gui elements
function GuiElements()
	if EnableYaw:GetValue() then
		ComboboxMenuMode:SetDisabled(false)
	else
		ComboboxMenuMode:SetDisabled(true)
	end
	if EnableYaw:GetValue() and ComboboxMenuMode:GetValue()==0 then
		if EnableNoScopeHitChance:GetValue() then
			NoScopeHitChanceSlider:SetDisabled(false)
		else
			NoScopeHitChanceSlider:SetDisabled(true)
		end
		if EnableCustomDoubleTapMode:GetValue() then
			ComboboxCustomDoubleFireMode:SetDisabled(false)
		else
			ComboboxCustomDoubleFireMode:SetDisabled(true)
		end
		GroupboxGeneral:SetInvisible(false)
		GroupboxGeneralValue:SetInvisible(false)
	else
		GroupboxGeneral:SetInvisible(true)
		GroupboxGeneralValue:SetInvisible(true)
	end
	if EnableYaw:GetValue() and ComboboxMenuMode:GetValue()==1 then
		if EnableMayYawAA:GetValue() then
			if EnableLowDelta:GetValue() then
				LowDeltaSliderValue:SetInvisible(false)
			else
				LowDeltaSliderValue:SetInvisible(true)
			end
			if ComobboxAutoDirectionModeGlobal:GetValue() == 0 then
                GlobalBaseYawSliderCustom:SetDisabled(true)
            else
                GlobalBaseYawSliderCustom:SetDisabled(false)
            end
            if ComobboxAutoDirectionModeStanding:GetValue() == 0 then
                StandingBaseYawSliderCustom:SetDisabled(true)
            else
                StandingBaseYawSliderCustom:SetDisabled(false)
            end
            if ComobboxAutoDirectionModeSlowMotion:GetValue() == 0 then
                SlowMotionBaseYawSliderCustom:SetDisabled(true)
            else
                SlowMotionBaseYawSliderCustom:SetDisabled(false)
            end
            if ComobboxAutoDirectionModeMoving:GetValue() == 0 then
                MovingBaseYawSliderCustom:SetDisabled(true)
            else
                MovingBaseYawSliderCustom:SetDisabled(false)
            end
            if ComobboxAutoDirectionModeAir:GetValue() == 0 then
                AirBaseYawSliderCustom:SetDisabled(true)
            else
                AirBaseYawSliderCustom:SetDisabled(false)
            end
			if EnbaleAutoSwitchDesync:GetValue() then
				ComboboxAutoDesyncInvertMode:SetInvisible(false)
				DesyncSwitchKey:SetDisabled(true)
			else
				DesyncSwitchKey:SetDisabled(false)
				ComboboxAutoDesyncInvertMode:SetInvisible(true)
			end
		end
		EnableMayYawAA:SetDisabled(false)
		if EnableMayYawAA:GetValue() then --Gui AA State [Global]
            if ComboboxAAPlayerState:GetValue() == 0 then
				SliderJitterOffsetGlobal:SetInvisible(false)
				SliderJitterOffsetStanding:SetInvisible(true)
				SliderJitterOffsetSlowMotion:SetInvisible(true)
				SliderJitterOffsetMoving:SetInvisible(true)
				SliderJitterOffsetAir:SetInvisible(true)
				EnableJitterGlobal:SetInvisible(false)
				EnableJitterStanding:SetInvisible(true)
				EnableJitterSlowMotion:SetInvisible(true)
				EnableJitterMoving:SetInvisible(true)
				EnableJitterAir:SetInvisible(true)
                ComobboxAutoDirectionModeGlobal:SetInvisible(false)
                ComobboxAutoDirectionModeStanding:SetInvisible(true)
                ComobboxAutoDirectionModeSlowMotion:SetInvisible(true)
                ComobboxAutoDirectionModeMoving:SetInvisible(true)
                ComobboxAutoDirectionModeAir:SetInvisible(true)
                EnableStandingAA:SetInvisible(true)
                EnableSlowMotionAA:SetInvisible(true)
                EnableMovingAA:SetInvisible(true)
                EnableAirAA:SetInvisible(true)
                GlobalRotationSliderCustom:SetInvisible(false)
                GlobalLBYSliderCustom:SetInvisible(false)
                GlobalBaseYawSliderCustom:SetInvisible(false)
                StandingRotationSliderCustom:SetInvisible(true)
                StandingLBYSliderCustom:SetInvisible(true)
                StandingBaseYawSliderCustom:SetInvisible(true)
                SlowMotionRotationSliderCustom:SetInvisible(true)
                SlowMotionLBYSliderCustom:SetInvisible(true)
                SlowMotionBaseYawSliderCustom:SetInvisible(true)
                MovingRotationSliderCustom:SetInvisible(true)
                MovingLBYSliderCustom:SetInvisible(true)
                MovingBaseYawSliderCustom:SetInvisible(true)
                AirRotationSliderCustom:SetInvisible(true)
                AirLBYSliderCustom:SetInvisible(true)
                AirBaseYawSliderCustom:SetInvisible(true)
            elseif ComboboxAAPlayerState:GetValue() == 1 then  --Gui AA State [Standing]
				SliderJitterOffsetGlobal:SetInvisible(true)
				SliderJitterOffsetStanding:SetInvisible(false)
				SliderJitterOffsetSlowMotion:SetInvisible(true)
				SliderJitterOffsetMoving:SetInvisible(true)
				SliderJitterOffsetAir:SetInvisible(true)
				EnableJitterGlobal:SetInvisible(true)
				EnableJitterStanding:SetInvisible(false)
				EnableJitterSlowMotion:SetInvisible(true)
				EnableJitterMoving:SetInvisible(true)
				EnableJitterAir:SetInvisible(true)
                ComobboxAutoDirectionModeGlobal:SetInvisible(true)
                ComobboxAutoDirectionModeStanding:SetInvisible(false)
                ComobboxAutoDirectionModeSlowMotion:SetInvisible(true)
                ComobboxAutoDirectionModeMoving:SetInvisible(true)
                ComobboxAutoDirectionModeAir:SetInvisible(true)
                EnableStandingAA:SetInvisible(false)
                EnableSlowMotionAA:SetInvisible(true)
                EnableMovingAA:SetInvisible(true)
                EnableAirAA:SetInvisible(true)
                GlobalRotationSliderCustom:SetInvisible(true)
                GlobalLBYSliderCustom:SetInvisible(true)
                GlobalBaseYawSliderCustom:SetInvisible(true)
                StandingRotationSliderCustom:SetInvisible(false)
                StandingLBYSliderCustom:SetInvisible(false)
                StandingBaseYawSliderCustom:SetInvisible(false)
                SlowMotionRotationSliderCustom:SetInvisible(true)
                SlowMotionLBYSliderCustom:SetInvisible(true)
                SlowMotionBaseYawSliderCustom:SetInvisible(true)
                MovingRotationSliderCustom:SetInvisible(true)
                MovingLBYSliderCustom:SetInvisible(true)
                MovingBaseYawSliderCustom:SetInvisible(true)
                AirRotationSliderCustom:SetInvisible(true)
                AirLBYSliderCustom:SetInvisible(true)
                AirBaseYawSliderCustom:SetInvisible(true)
            elseif ComboboxAAPlayerState:GetValue() == 2 then --Gui AA State [SlowMotion]
				SliderJitterOffsetGlobal:SetInvisible(true)
				SliderJitterOffsetStanding:SetInvisible(true)
				SliderJitterOffsetSlowMotion:SetInvisible(false)
				SliderJitterOffsetMoving:SetInvisible(true)
				SliderJitterOffsetAir:SetInvisible(true)
				EnableJitterGlobal:SetInvisible(true)
				EnableJitterStanding:SetInvisible(true)
				EnableJitterSlowMotion:SetInvisible(false)
				EnableJitterMoving:SetInvisible(true)
				EnableJitterAir:SetInvisible(true)
                ComobboxAutoDirectionModeGlobal:SetInvisible(true)
                ComobboxAutoDirectionModeStanding:SetInvisible(true)
                ComobboxAutoDirectionModeSlowMotion:SetInvisible(false)
                ComobboxAutoDirectionModeMoving:SetInvisible(true)
                ComobboxAutoDirectionModeAir:SetInvisible(true)
                EnableStandingAA:SetInvisible(true)
                EnableSlowMotionAA:SetInvisible(false)
                EnableMovingAA:SetInvisible(true)
                EnableAirAA:SetInvisible(true)
                GlobalRotationSliderCustom:SetInvisible(true)
                GlobalLBYSliderCustom:SetInvisible(true)
                GlobalBaseYawSliderCustom:SetInvisible(true)
                StandingRotationSliderCustom:SetInvisible(true)
                StandingLBYSliderCustom:SetInvisible(true)
                StandingBaseYawSliderCustom:SetInvisible(true)
                SlowMotionRotationSliderCustom:SetInvisible(false)
                SlowMotionLBYSliderCustom:SetInvisible(false)
                SlowMotionBaseYawSliderCustom:SetInvisible(false)
                MovingRotationSliderCustom:SetInvisible(true)
                MovingLBYSliderCustom:SetInvisible(true)
                MovingBaseYawSliderCustom:SetInvisible(true)
                AirRotationSliderCustom:SetInvisible(true)
                AirLBYSliderCustom:SetInvisible(true)
                AirBaseYawSliderCustom:SetInvisible(true)
            elseif ComboboxAAPlayerState:GetValue() == 3 then --Gui AA State [Moving]
				SliderJitterOffsetGlobal:SetInvisible(true)
				SliderJitterOffsetStanding:SetInvisible(true)
				SliderJitterOffsetSlowMotion:SetInvisible(true)
				SliderJitterOffsetMoving:SetInvisible(false)
				SliderJitterOffsetAir:SetInvisible(true)
				EnableJitterGlobal:SetInvisible(true)
				EnableJitterStanding:SetInvisible(true)
				EnableJitterSlowMotion:SetInvisible(true)
				EnableJitterMoving:SetInvisible(false)
				EnableJitterAir:SetInvisible(true)
                ComobboxAutoDirectionModeGlobal:SetInvisible(true)
                ComobboxAutoDirectionModeStanding:SetInvisible(true)
                ComobboxAutoDirectionModeSlowMotion:SetInvisible(true)
                ComobboxAutoDirectionModeMoving:SetInvisible(false)
                ComobboxAutoDirectionModeAir:SetInvisible(true)
                EnableStandingAA:SetInvisible(true)
                EnableSlowMotionAA:SetInvisible(true)
                EnableMovingAA:SetInvisible(false)
                EnableAirAA:SetInvisible(true)
                GlobalRotationSliderCustom:SetInvisible(true)
                GlobalLBYSliderCustom:SetInvisible(true)
                GlobalBaseYawSliderCustom:SetInvisible(true)
                StandingRotationSliderCustom:SetInvisible(true)
                StandingLBYSliderCustom:SetInvisible(true)
                StandingBaseYawSliderCustom:SetInvisible(true)
                SlowMotionRotationSliderCustom:SetInvisible(true)
                SlowMotionLBYSliderCustom:SetInvisible(true)
                SlowMotionBaseYawSliderCustom:SetInvisible(true)
                MovingRotationSliderCustom:SetInvisible(false)
                MovingLBYSliderCustom:SetInvisible(false)
                MovingBaseYawSliderCustom:SetInvisible(false)
                AirRotationSliderCustom:SetInvisible(true)
                AirLBYSliderCustom:SetInvisible(true)
                AirBaseYawSliderCustom:SetInvisible(true)
            elseif ComboboxAAPlayerState:GetValue() == 4 then --Gui AA State [Air]
				SliderJitterOffsetGlobal:SetInvisible(true)
				SliderJitterOffsetStanding:SetInvisible(true)
				SliderJitterOffsetSlowMotion:SetInvisible(true)
				SliderJitterOffsetMoving:SetInvisible(true)
				SliderJitterOffsetAir:SetInvisible(false)
				EnableJitterGlobal:SetInvisible(true)
				EnableJitterStanding:SetInvisible(true)
				EnableJitterSlowMotion:SetInvisible(true)
				EnableJitterMoving:SetInvisible(true)
				EnableJitterAir:SetInvisible(false)
                ComobboxAutoDirectionModeGlobal:SetInvisible(true)
                ComobboxAutoDirectionModeStanding:SetInvisible(true)
                ComobboxAutoDirectionModeSlowMotion:SetInvisible(true)
                ComobboxAutoDirectionModeMoving:SetInvisible(true)
                ComobboxAutoDirectionModeAir:SetInvisible(false)
                EnableStandingAA:SetInvisible(true)
                EnableSlowMotionAA:SetInvisible(true)
                EnableMovingAA:SetInvisible(true)
                EnableAirAA:SetInvisible(false)
                GlobalRotationSliderCustom:SetInvisible(true)
                GlobalLBYSliderCustom:SetInvisible(true)
                GlobalBaseYawSliderCustom:SetInvisible(true)
                StandingRotationSliderCustom:SetInvisible(true)
                StandingLBYSliderCustom:SetInvisible(true)
                StandingBaseYawSliderCustom:SetInvisible(true)
                SlowMotionRotationSliderCustom:SetInvisible(true)
                SlowMotionLBYSliderCustom:SetInvisible(true)
                SlowMotionBaseYawSliderCustom:SetInvisible(true)
                MovingRotationSliderCustom:SetInvisible(true)
                MovingLBYSliderCustom:SetInvisible(true)
                MovingBaseYawSliderCustom:SetInvisible(true)
                AirRotationSliderCustom:SetInvisible(false)
                AirLBYSliderCustom:SetInvisible(false)
                AirBaseYawSliderCustom:SetInvisible(false)
            end
			GroupboxEnableMayYawAA:SetInvisible(false)
		else
            GroupboxEnableMayYawAA:SetInvisible(true)
		end
		GroupboxAntiAim:SetInvisible(false)
	else
        GroupboxEnableMayYawAA:SetInvisible(true)
		GroupboxAntiAim:SetInvisible(true)
	end
	if EnableYaw:GetValue() and ComboboxMenuMode:GetValue()==2 then
		GroupboxVisuals:SetInvisible(false)
		GroupboxVisualsValue:SetInvisible(false)
		if EnableNightMode:GetValue() then
			NightModeValSlider:SetDisabled(false)
		else
			NightModeValSlider:SetDisabled(true)
		end
		if EnableAcpectRatio:GetValue() then
			AspectRatioDefValSlider:SetDisabled(false)
		else
			AspectRatioDefValSlider:SetDisabled(true)
		end
		if EnableKeybinds:GetValue() then
			ComboboxKeybindsStyles:SetDisabled(false)
		else
			ComboboxKeybindsStyles:SetDisabled(true)
		end
		if EnableWatermark:GetValue() then
			ComboboxWatermarkStyles:SetDisabled(false)
		else
			ComboboxWatermarkStyles:SetDisabled(true)
		end
		
	else
		GroupboxVisualsValue:SetInvisible(true)
		GroupboxVisuals:SetInvisible(true)
	end
	if EnableYaw:GetValue() and ComboboxMenuMode:GetValue()==3 then
		if EnableHitLog:GetValue() then
			PrefixLogColor:SetInvisible(false)
			MainLogColor:SetInvisible(false)
		else
			PrefixLogColor:SetInvisible(true)
			MainLogColor:SetInvisible(true)
		end
		if EnableAutoBuy:GetValue() then
			GroupboxAutoBuy:SetInvisible(false)
		else
			GroupboxAutoBuy:SetInvisible(true)
		end
		if EnableDmg:GetValue() then
			GroupboxDMG:SetInvisible(false)
		else
			GroupboxDMG:SetInvisible(true)
		end
		GroupboxMisc:SetInvisible(false)
	else
		PrefixLogColor:SetInvisible(true)
		MainLogColor:SetInvisible(true)
		GroupboxDMG:SetInvisible(true)
		GroupboxMisc:SetInvisible(true)
		GroupboxAutoBuy:SetInvisible(true)
	end
    if EnableYaw:GetValue() and ComboboxMenuMode:GetValue()==4 then
	local ConfigList={}
    file.Enumerate(function(file)
    	if string.match(file, "%.dat") then
        	table.insert(ConfigList, file:sub(15,-5))
    	end
    end)
	   if ListboxConfig:GetValue() == table.maxn(ConfigList) then
		SaveConfigButton:SetDisabled(true)
		DeleteConfigButton:SetDisabled(true)
	   else
		SaveConfigButton:SetDisabled(false)
		DeleteConfigButton:SetDisabled(false)
	   end
       GroupboxConfigsActions:SetInvisible(false)
       GroupboxConfigs:SetInvisible(false)
	   GroupboxCodesActions:SetInvisible(false)
    else
       GroupboxConfigsActions:SetInvisible(true)
       GroupboxConfigs:SetInvisible(true)
	   GroupboxCodesActions:SetInvisible(true)
    end
	if EnableYaw:GetValue()==false then
		GroupboxMain:SetInvisible(false)
	else
		GroupboxMain:SetInvisible(true)
	end
end
--function Usmd for Velocity
callbacks.Register("CreateMove", function(ucmd)
vel=ucmd.sidemove
end);
--function for Check is DmgOverride active
function GetPlayerState()
    local SlowKey=gui.GetValue("rbot.accuracy.movement.slowkey")
    local LocalPlayer=entities.GetLocalPlayer()
    local VelocityX = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" )
	local VelocityY = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" )
	local LocalPlayerVelocity=math.ceil(math.sqrt(VelocityX^2 + VelocityY^2))
    if bit.band( LocalPlayer:GetPropInt( "m_fFlags" ), 1 ) == 1 and LocalPlayerVelocity < 4 then
        PlayerState="Standing"
    end
    if bit.band( LocalPlayer:GetPropInt( "m_fFlags" ), 1 ) == 1 and LocalPlayerVelocity > 4 and SlowKey~=0 and input.IsButtonDown( SlowKey ) ==false then
        PlayerState="Moving"
    end
    if bit.band( LocalPlayer:GetPropInt( "m_fFlags" ), 1 ) == 1 and SlowKey~=0 and input.IsButtonDown( SlowKey ) then
        PlayerState="SlowMotion"
    end
    if bit.band( LocalPlayer:GetPropInt( "m_fFlags" ), 1 ) == 0 then
        PlayerState="Air"
    end
    return PlayerState
end
function isDmgEnable()
	local dmgovkey=gui.GetValue("mayyaw.DMGKey")
	if EnableYaw:GetValue() and EnableDmg:GetValue() and dmgovkey~=0 then
		if ComboboxDMGmode:GetValue() == 0 then
			if input.IsButtonDown(dmgovkey) then
				return true
			else
				return false
			end
		elseif ComboboxDMGmode:GetValue() == 1 then
			if toggle == 1 then
				return false
			elseif toggle == -1 then
				return true
			end
		end
	end
end
--function for Check is DT enable in active weapon
function IsDtEnable()
	local lp=entities.GetLocalPlayer()
	if lp~=nil and lp:IsAlive() then
		local AwpDtEnable=gui.GetValue("rbot.hitscan.accuracy.sniper.doublefire")
		local Ssg08DtEnable=gui.GetValue("rbot.hitscan.accuracy.scout.doublefire")
		local PistolDtEnable=gui.GetValue("rbot.hitscan.accuracy.pistol.doublefire")
		local AutoDtEnable=gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire")
		local HeavypistolDtEnable=gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire")
		local SmgDtEnable=gui.GetValue("rbot.hitscan.accuracy.smg.doublefire")
		local RifleDtEnable=gui.GetValue("rbot.hitscan.accuracy.rifle.doublefire")
		local ShotgunDtEnable=gui.GetValue("rbot.hitscan.accuracy.shotgun.doublefire")
		local Lightmgenable=gui.GetValue("rbot.hitscan.accuracy.lmg.doublefire")
		local lpaw=lp:GetWeaponID()
		wclass=GetActiveGun()
		if wclass=="pistol" and (PistolDtEnable==1 or PistolDtEnable==2)  then
			dtguion=true
		elseif wclass=="hpistol" and (HeavypistolDtEnable==1 or HeavypistolDtEnable==2) then
			dtguion=true
		elseif wclass=="smg" and (SmgDtEnable==1 or SmgDtEnable==2) then
			dtguion=true
		elseif wclass=="sniper" and (AwpDtEnable==1 or AwpDtEnable==2) then
			dtguion=true
		elseif wclass=="scout" and (Ssg08DtEnable==1 or Ssg08DtEnable==2) then
			dtguion=true
		elseif wclass=="rifle" and (RifleDtEnable==1 or RifleDtEnable==2) then
			dtguion=true
		elseif wclass=="shotgun" and (ShotgunDtEnable==1 or ShotgunDtEnable==2) then
			dtguion=true
		elseif wclass=="asniper" and (AutoDtEnable==1 or AutoDtEnable==2) then
			dtguion=true
		elseif wclass=="lmg" and (Lightmgenable==1 or Lightmgenable==2) then
			dtguion=true
		else
			dtguion=false
		end
		return(dtguion)
	end
end
--function Keybinds
function Keybinds()

	xmouse,ymouse=input.GetMousePos()
	if not input.IsButtonDown(1) then
		xmousebefore,ymousebefore=input.GetMousePos()
		drag=false
	end
	if xmouse>x1 and ymouse > y1 and xmouse < wight and ymouse < hight and input.IsButtonDown(1) then
		if drag == false then
			xcor=xmousebefore-x1
			ycor=ymousebefore-y1
		end
		drag=true
		xmouseafter,ymouseafter=input.GetMousePos()
		x1=xmouseafter-xcor
		y1=ymouseafter-ycor
		wight=x1+130
		hight=y1+100
	end
	draw.SetFont(Font3)
	local FdKey=gui.GetValue("rbot.antiaim.extra.fakecrouchkey")
	local DtEnable=IsDtEnable()
	local HsEnable=gui.GetValue("rbot.antiaim.condition.shiftonshot")
	local SlowEnable=gui.GetValue("rbot.accuracy.movement.slowkey")
	local SpeedburstEnable=gui.GetValue("misc.speedburst.enable")
	local SpeedburstKey=gui.GetValue("misc.speedburst.key")
	local EnableAutoPeek=gui.GetValue("rbot.accuracy.movement.autopeek")
	local AutoPeekKey=gui.GetValue("rbot.accuracy.movement.autopeekkey")
	if ComboboxKeybindsStyles:GetValue()==0 then
		draw.Color(1,1,1,120)
	elseif ComboboxKeybindsStyles:GetValue()==1 then
		draw.Color(1,1,1,90)
	end
	draw.FilledRect(x1,y1,wight,y1+20)
	local rk,gk,bk,ak=KeybindsColor:GetValue()
	draw.Color(rk,gk,bk,ak)
	draw.FilledRect(x1,y1,wight,y1+2)
	draw.Color(1,1,1,255)
	draw.Text(x1+46,y1+6,"keybinds")
	draw.Color(255,255,255,255)
	draw.TextShadow(x1+45,y1+6,"keybinds")
	if DtEnable == true then
		draw.Color(1,1,1,255)
		draw.Text(x1+6,y1+27,"Double Tap  	  [toggled]")
		draw.Color(255,255,255,255)
		draw.TextShadow(x1+5,y1+27,"Double Tap  	  [toggled]")
		dtots=15
	else
		dtots=0
	end
	if HsEnable then
		draw.Color(1,1,1,255)
		draw.Text(x1+6,y1+27+dtots,"Hide shots   	  [toggled]")
		draw.Color(255,255,255,255)
		draw.TextShadow(x1+5,y1+27+dtots,"Hide shots   	  [toggled]")
		hsots=15
	else
		hsots=0
	end
	if FdKey~=0 and input.IsButtonDown(FdKey) then
		draw.Color(1,1,1,255)
		draw.Text(x1+6,y1+27+dtots+hsots,"Fake duck   	   [holding]")
		draw.Color(255,255,255,255)
		draw.Text(x1+5,y1+27+dtots+hsots,"Fake duck   	   [holding]")
		fdost=15
	else
		fdost=0
	end
	if SlowEnable~=0 and input.IsButtonDown(SlowEnable) then
		draw.Color(1,1,1,255)
		draw.Text(x1+6,y1+27+dtots+hsots+fdost,"Slow walk   	    [holding]")
		draw.Color(255,255,255,255)
		draw.Text(x1+5,y1+27+dtots+hsots+fdost,"Slow walk   	    [holding]")
		slowost=15
	else
		slowost=0
	end
	if isDmgEnable() then
		local weapon=GetActiveGun()
		draw.Color(1,1,1,255)
		if weapon~="other" then
			draw.Text(x1+6,y1+27+dtots+hsots+fdost+slowost,"Dmg Override  ["..gui.GetValue("rbot.hitscan.accuracy."..weapon..".mindamage").."]")
		end
		draw.Color(255,255,255,255)
		if weapon~="other" then
			draw.Text(x1+5,y1+27+dtots+hsots+fdost+slowost,"Dmg Override  ["..gui.GetValue("rbot.hitscan.accuracy."..weapon..".mindamage").."]")
		end
		dmgost=15
	else
		dmgost=0
	end
	if SpeedburstEnable==true and SpeedburstKey~=0 and input.IsButtonDown(SpeedburstKey) then
		draw.Color(1,1,1,255)
		draw.Text(x1+6,y1+27+dtots+hsots+fdost+slowost+dmgost,"Speed burst   	[holding]")
		draw.Color(255,255,255,255)
		draw.Text(x1+5,y1+27+dtots+hsots+fdost+slowost+dmgost,"Speed burst   	[holding]")
		speedost=15
	else
		speedost=0
	end
	if AutoPeekKey~=0 and EnableAutoPeek==true then
		if gui.GetValue("rbot.accuracy.movement.autopeektype")==0 then
			AutoPeekToggle=-1
			if input.IsButtonDown(AutoPeekKey) then
				draw.Color(1,1,1,255)
				draw.Text(x1+6,y1+27+dtots+hsots+fdost+slowost+dmgost+speedost,"Auto Peek   	   [holding]")
				draw.Color(255,255,255,255)
				draw.Text(x1+5,y1+27+dtots+hsots+fdost+slowost+dmgost+speedost,"Auto Peek   	   [holding]")
			end
		elseif gui.GetValue("rbot.accuracy.movement.autopeektype")==1 then
			if input.IsButtonPressed(AutoPeekKey) then
				AutoPeekToggle=AutoPeekToggle*-1
			end
			if AutoPeekToggle == 1 then
				draw.Color(1,1,1,255)
				draw.Text(x1+5,y1+27+dtots+hsots+fdost+slowost+dmgost+speedost,"Auto Peek   	   [toggled]")
				draw.Color(255,255,255,255)
				draw.Text(x1+4,y1+27+dtots+hsots+fdost+slowost+dmgost+speedost,"Auto Peek   	   [toggled]")
			end
		end
	else
		AutoPeekToggle=-1
	end
end
--function Indicators
function Indicators()
	local fdkey=gui.GetValue("rbot.antiaim.extra.fakecrouchkey")
	local hsenable=gui.GetValue("rbot.antiaim.condition.shiftonshot")
	local WightScreen,HightScreen=draw.GetScreenSize()
	local VelocityX = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" )
	local VelocityY = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" )
	local LocalPlayerVelocity=math.sqrt(VelocityX^2 + VelocityY^2)
	GradientRect(WightScreen/2,HightScreen/2+35,30-LocalPlayerVelocity/35,HightScreen/2+38,false,255,255,255,255)
	GradientRect(WightScreen/2-30+LocalPlayerVelocity/35,HightScreen/2+35,-30+LocalPlayerVelocity/35,HightScreen/2+38,false,255,255,255,255)
	draw.Color(255,255,255,255)
	draw.SetFont(Font1) draw.Text(WightScreen/2-29,HightScreen/2+20,"MAY YAW")
	local dtguion=IsDtEnable()
	if fdkey~=0 then
		if dtguion and hsenable==false and input.IsButtonDown(fdkey)==false then
			draw.Color(65, 180, 80,255)
			dta=12
			dtx=0
			draw.Text(WightScreen/2-8-dtx,HightScreen/2+53,"DT")
		elseif dtguion and hsenable==true and input.IsButtonDown(fdkey)==false then
			draw.Color(218, 218, 80,255)
			dtx=20
			dta=12
			draw.Text(WightScreen/2-8-dtx,HightScreen/2+53,"DT (slow)")
		elseif dtguion and input.IsButtonDown(fdkey) then
			draw.Color(255,0,00,255)
			dta=12
			dtx=55
			draw.Text(WightScreen/2-8-dtx,HightScreen/2+53,"DESEBELD(fakeduck)")
		else
			dta=0
			dtx=0
		end
	end
	if fdkey==0 then
		if dtguion and hsenable==false then
			draw.Color(65, 180, 80,255)
			dta=12
			dtx=0
			draw.Text(WightScreen/2-8-dtx,HightScreen/2+53,"DT")
		elseif dtguion and hsenable==true then
			draw.Color(218, 218, 80,255)
			dtx=20
			dta=12
			draw.Text(WightScreen/2-8-dtx,HightScreen/2+53,"DT (slow)")
		end
		 
	end
	if fdkey~=0 and input.IsButtonDown(fdkey)==true and dtguion==false then
		draw.Color(65,180,80,255)
		draw.Text(WightScreen/2-8,HightScreen/2+53,"FD")
		dta=12
	end
	if hsenable then
		draw.Color(65, 180, 80,255)
		draw.Text(WightScreen/2-8,HightScreen/2+53+dta,"HS")
		hsa=10
	else
		hsa=0
	end
		slowkey = gui.GetValue("rbot.accuracy.movement.slowkey")
	if slowkey~=0 and input.IsButtonDown(slowkey) and EnableMayYawAA:GetValue() and EnableLowDelta:GetValue() then
		draw.Color(255,255,255,255)
		draw.Text(WightScreen/2-35,HightScreen/2+41,"LOW DELTA")
	else
		draw.Color(174,34,235,255)
		draw.Text(WightScreen/2-30,HightScreen/2+41,"OPPOSITE")
	end
	if isDmgEnable() then
		draw.Color(255, 216, 0,255)
		draw.Text(WightScreen/2-12,HightScreen/2+53+dta+hsa,"dmg")
	end
end
--function Damage Override
function DmgOverride()
	if EnableYaw:GetValue() and EnableDmg:GetValue() then
		local dmgovkey=gui.GetValue("mayyaw.DMGKey")
		if dmgovkey~=0 then
			if ComboboxDMGmode:GetValue() ==0 then
				if input.IsButtonPressed(dmgovkey) then
					awpdefdmg=gui.GetValue("rbot.hitscan.accuracy.sniper.mindamage")
					autodefdmg=gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
					ssgdefdmg=gui.GetValue("rbot.hitscan.accuracy.scout.mindamage")
					heavydefdmg=gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
				end
				if input.IsButtonDown(dmgovkey) then
					gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage",gui.GetValue("mayyaw.awpdmgoverrideslider"))
					gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage",gui.GetValue("mayyaw.autodmgoverrideslider"))
					gui.SetValue("rbot.hitscan.accuracy.scout.mindamage",gui.GetValue("mayyaw.ssg08dmgoverrideslider"))
					gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage",gui.GetValue("mayyaw.heavypistoldmgoverrideslider"))
					gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage",gui.GetValue("mayyaw.pistoldmgoverrideslider"))
				elseif input.IsButtonReleased( dmgovkey ) then
					gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage",awpdefdmg)
					gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage",autodefdmg)
					gui.SetValue("rbot.hitscan.accuracy.scout.mindamage",ssgdefdmg)
					gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage",heavydefdmg)
					gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage",pistoldefdmg)
				end
			elseif ComboboxDMGmode:GetValue() == 1 then
				if input.IsButtonPressed(dmgovkey) then
					toggle=toggle*-1
				end
				if toggle==-1 and input.IsButtonPressed(dmgovkey) then
					awpdefdmg=gui.GetValue("rbot.hitscan.accuracy.sniper.mindamage")
					autodefdmg=gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
					ssgdefdmg=gui.GetValue("rbot.hitscan.accuracy.scout.mindamage")
					heavydefdmg=gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
				end 
				if toggle==-1 and input.IsButtonPressed(dmgovkey) then
					gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage",gui.GetValue("mayyaw.awpdmgoverrideslider"))
					gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage",gui.GetValue("mayyaw.autodmgoverrideslider"))
					gui.SetValue("rbot.hitscan.accuracy.scout.mindamage",gui.GetValue("mayyaw.ssg08dmgoverrideslider"))
					gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage",gui.GetValue("mayyaw.heavypistoldmgoverrideslider"))
					gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage",gui.GetValue("mayyaw.pistoldmgoverrideslider"))
				elseif toggle==1 and input.IsButtonPressed(dmgovkey) then
					gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage",awpdefdmg)
					gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage",autodefdmg)
					gui.SetValue("rbot.hitscan.accuracy.scout.mindamage",ssgdefdmg)
					gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage",heavydefdmg)
					gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage",pistoldefdmg)
				end
			end
		end
	end
end
--function for getting desync angle
function DesyncDelta()
	local LocalPlayer=entities.GetLocalPlayer()
	local lby = math.min(58, math.max(-58, (LocalPlayer:GetProp("m_flLowerBodyYawTarget") - LocalPlayer:GetProp("m_angEyeAngles").y + 180) % 360 - 180))
	local rot = nil
	if gui.GetValue("rbot.master") then
		rot = gui.GetValue("rbot.antiaim.base.rotation")
	else
		if lby > 0 then
				rot = -58
		else
				rot = 58
		end
	end
	delta = math.abs(lby - rot)
	if gui.GetValue("rbot.antiaim.condition.use") and input.IsButtonDown(69) then
		delta=0
	end
	return math.abs(delta)
end
--function Watermark
function Watermark()
	local WightScreen,HightScreen=draw.GetScreenSize()
	local LocalPlayer=entities.GetLocalPlayer()
	local UserName=cheat.GetUserName()
	if LocalPlayer ~= nil then
		pr=entities.GetPlayerResources()
		delay = pr:GetPropInt("m_iPing", entities.GetLocalPlayer():GetIndex())
	else
		delay="None "
	end
	server=engine.GetServerIP()
	if server == nil then
		serverip="Menu"
		serverdelay="None "
	elseif server=="loopback" then
		serverip="Local"
		serverdelay="None "
	else
		serverip=server
		serverdelay=delay
	end
	textot=16
	draw.SetFont(Font2)
	local text=("MayYaw | " ..UserName .. " | ".. delay .."ms | " ..serverip.." | "..os.date("%H"..":%M"..":%S"))
	local textlen=draw.GetTextSize(text)
	local rw,gw,bw,aw=WatermarkColor:GetValue()
	if ComboboxWatermarkStyles:GetValue()==0 then
		draw.Color(1,1,1,120)
		draw.FilledRect(WightScreen-textlen-2*textot,10,WightScreen-textot,32)
		GradientRect((WightScreen-textlen-2*textot)+(textlen+textot)/2,10,(textot+textlen)/2,13,false,rw,gw,bw,aw)
		GradientRect((WightScreen-textlen-2*textot),10,-(textot+textlen)/2,13,false,rw,gw,bw,aw)
		GradientRect((WightScreen-textlen-2*textot)+(textlen+textot)/2,30,(textot+textlen)/2,33,false,rw,gw,bw,aw)
		GradientRect((WightScreen-textlen-2*textot),30,-(textot+textlen)/2,33,false,rw,gw,bw,aw)
	elseif ComboboxWatermarkStyles:GetValue()==1 then
		draw.Color(1,1,1,70)
		draw.FilledRect(WightScreen-textlen-2*textot,10,WightScreen-textot,32)
		draw.Color(rw,gw,bw,aw)
		draw.FilledRect((WightScreen-textlen-2*textot),10,(WightScreen-textlen-2*textot+textot+textlen),12)
	end
	draw.Color(255,255,255,255)
	draw.Text(WightScreen-textlen-textot*1.5,16,text)

	if LocalPlayer~=nil then
		
		if math.ceil(DesyncDelta()) < 70 then
			Desyncdelta=math.ceil(DesyncDelta())
		end
		if Desyncdelta >= 100 then
			deltaO100=5
		else
			deltaO100=0
		end
		if gui.GetValue("rbot.hitscan.accuracy.pistol.doublefire")~=0 or gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire")~=0 or gui.GetValue("rbot.hitscan.accuracy.smg.doublefire")~=0 or gui.GetValue("rbot.hitscan.accuracy.rifle.doublefire")~=0 or gui.GetValue("rbot.hitscan.accuracy.shotgun.doublefire")~=0 or gui.GetValue("rbot.hitscan.accuracy.scout.doublefire")~=0 or gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire")~=0  or gui.GetValue("rbot.hitscan.accuracy.sniper.doublefire")~=0 or gui.GetValue("rbot.hitscan.accuracy.lmg.doublefire")~=0 then
			DTon=true
		else
			DTon=false
		end
		if DTon or gui.GetValue("rbot.antiaim.condition.shiftonshot") or gui.GetValue("misc.speedburst.enable") or gui.GetValue("misc.fakelag.enable")==false then
			DisFLValCor=60
			FL="1 | SHIFTING"
		else
			DisFLValCor=0
			FL=gui.GetValue("misc.fakelag.factor")
		end
		if LocalPlayer:IsAlive() then
			local textfl=("FL : "..FL)
			local textfllen=draw.GetTextSize(textfl)
			if ComboboxWatermarkStyles:GetValue()==0 then
				draw.Color(1,1,1,120)
				draw.FilledRect(WightScreen-76-DisFLValCor,38,WightScreen-textot,59)
				draw.FilledRect(WightScreen-176-DisFLValCor,38,WightScreen-85+deltaO100-DisFLValCor,59)
				draw.Color(rw,gw,bw,aw)
				GradientRect((WightScreen-76-DisFLValCor)+(WightScreen-textot-WightScreen+76+DisFLValCor)/2-2,38,(WightScreen-textot-WightScreen+76+DisFLValCor)/2,41,false,rw,gw,bw,aw)
				GradientRect(WightScreen-77-DisFLValCor,38,-(WightScreen-textot-WightScreen+76+DisFLValCor)/2,41,false,rw,gw,bw,aw)
				GradientRect((WightScreen-176-DisFLValCor)+(WightScreen-85+deltaO100-DisFLValCor-WightScreen+176+DisFLValCor)/2,38,(WightScreen-85+deltaO100-DisFLValCor-WightScreen+176+DisFLValCor)/2,41,false,rw,gw,bw,aw)
				GradientRect(WightScreen-176-DisFLValCor,38,-(WightScreen-85+deltaO100-DisFLValCor-WightScreen+176+DisFLValCor)/2,41,false,rw,gw,bw,aw)
			elseif ComboboxWatermarkStyles:GetValue()==1 then
				draw.Color(1,1,1,90)
				draw.FilledRect(WightScreen-69-DisFLValCor,38,WightScreen-textot,59)
				draw.FilledRect(WightScreen-155-DisFLValCor,38,WightScreen-80+deltaO100-DisFLValCor,59)
				GradientRect(WightScreen-157-DisFLValCor,37,WightScreen-155-DisFLValCor,-25,true,rw,gw,bw,aw)
				GradientRect(WightScreen-157-DisFLValCor,48,WightScreen-155-DisFLValCor,25,true,rw,gw,bw,aw)
				GradientRect((WightScreen-71-DisFLValCor)+(WightScreen-textot-WightScreen+71+DisFLValCor)/2-2,58,(WightScreen-textot-WightScreen+71+DisFLValCor)/2,59,false,rw,gw,bw,aw)
				GradientRect(WightScreen-71-DisFLValCor,58,-(WightScreen-textot-WightScreen+71+DisFLValCor)/2,59,false,rw,gw,bw,aw)
			end
			if ComboboxWatermarkStyles:GetValue()==0 then
				draw.Color(255,255,255,255)
				draw.Text(WightScreen-68-DisFLValCor,45,textfl)
				draw.SetFont(Font2)
				draw.Text(WightScreen-154-DisFLValCor,45,"FAKE ("..Desyncdelta.."°)")
				local x=WightScreen-165-DisFLValCor;local r=6;local y=50; local y1=0; local t=2
				for i = 0, 360 / 100 * delta do
					angle = i * math.pi / 180
					draw.Color(210, 210, 210, 255)
					ptx, pty = x + r * math.cos(angle), y + y1 + r * math.sin(angle)
					ptx_, pty_ = x + (r-t) * math.cos(angle), y + y1 + (r-t) * math.sin(angle)
					draw.Line(ptx, pty, ptx_, pty_)
				end
				for i = 360 / 100 * delta + 1, 360 do
					angle = i * math.pi / 180
					draw.Color(45, 45, 45, 45)
					ptx, pty = x + r * math.cos(angle), y + y1 + r * math.sin(angle)
					ptx_, pty_ = x + (r-t) * math.cos(angle), y + y1 + (r-t) * math.sin(angle)
					draw.Line(ptx, pty, ptx_, pty_)
				end
			elseif ComboboxWatermarkStyles:GetValue()==1 then
				draw.Color(255,255,255,255)
				draw.Text(WightScreen-63-DisFLValCor,43,textfl)
				draw.SetFont(Font2)
				draw.Text(WightScreen-149-DisFLValCor,43,"FAKE ("..Desyncdelta.."°)")
			end
		end
	end
end
--function JumpScoutFix
function JumpScoutFix()
	if EnableYaw:GetValue() and EnableJumpScoutFix:GetValue() then
		local lp=entities.GetLocalPlayer()
		if lp ~=nil then
			if lp:IsAlive() then
				playervelocity = math.sqrt(lp:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + lp:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)
				if lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_ssg08" then
					if bit.band( lp:GetPropInt( "m_fFlags" ), 1 ) == 0 and OverrideScoutHC==false and lp:GetPropEntity("m_hActiveWeapon"):GetWeaponInaccuracy()< 0.04 then
						defhcscout=gui.GetValue( "rbot.hitscan.accuracy.scout.hitchance" )
						gui.SetValue("rbot.hitscan.accuracy.scout.hitchance", 5)
						
						OverrideScoutHC=true
					elseif bit.band( lp:GetPropInt( "m_fFlags" ), 1 ) == 1 and OverrideScoutHC == true then
						
						gui.SetValue("rbot.hitscan.accuracy.scout.hitchance", defhcscout)
						OverrideScoutHC=false
					end
					
					if playervelocity > 5 then
						gui.SetValue("misc.strafe.enable", true)
					else
						gui.SetValue("misc.strafe.enable",false)
					end
				else
					gui.SetValue("misc.strafe.enable",true)
				end
			else
				gui.SetValue("misc.strafe.enable",true)
			end
		else
			if OverrideScoutHC== true then
				gui.SetValue("rbot.hitscan.accuracy.scout.hitchance", defhcscout)
				OverrideScoutHC=false
			end
		end
	end
end
--function Engine Radar
function EngineRadar()
	if EnableYaw:GetValue() and EnableEngineRadar:GetValue() then
		for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
			Player:SetProp("m_bSpotted", 1);
		end
	else
		for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
			Player:SetProp("m_bSpotted", 0);
		end
	end
end
--function for getting Low delta for desync
function Delta()
	if input.IsButtonDown(SlowEnable) then
		delta=28
	else
		delta=0
	end
	return delta
end
--function MayYawAA
function MayYawAA()
	local SlowEnable=gui.GetValue("rbot.accuracy.movement.slowkey")
	local DesyncSwitchKeyValue=gui.GetValue("mayyaw.DesyncSwitchKey")
	local LocalPlayer=entities.GetLocalPlayer()

    if GetPlayerState() == "Standing" then
        if EnableStandingAA:GetValue() then
            if ComobboxAutoDirectionModeStanding:GetValue() == 0 then
				if EnableJitterStanding:GetValue() then
					local JitterOffset = SliderJitterOffsetStanding:GetValue()/2
                	AdvancedAtTarget(true,JitterOffset)
				else
					AdvancedAtTarget(false,nil)
				end
                EnableAdvancedAtTarget=true
            elseif ComobboxAutoDirectionModeStanding:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
                EnableAdvancedAtTarget=false
            end
            RotationOffsetCustom=StandingRotationSliderCustom:GetValue()
            LbyOffsetCustom=StandingLBYSliderCustom:GetValue()
            BaseYawOffsetCustom=StandingBaseYawSliderCustom:GetValue()
        else
            if ComobboxAutoDirectionModeGlobal:GetValue() == 0 then
                EnableAdvancedAtTarget=true
				if EnableJitterGlobal:GetValue() then
					local JitterOffset=SliderJitterOffsetGlobal:GetValue()/2
                	AdvancedAtTarget(true,JitterOffset)
				else
					AdvancedAtTarget(false,nil)
				end
            elseif ComobboxAutoDirectionModeGlobal:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
                EnableAdvancedAtTarget=false
            end
            RotationOffsetCustom=GlobalRotationSliderCustom:GetValue()
            LbyOffsetCustom=GlobalLBYSliderCustom:GetValue()
            BaseYawOffsetCustom=GlobalBaseYawSliderCustom:GetValue()
        end
    elseif GetPlayerState() == "SlowMotion" then
        if EnableSlowMotionAA:GetValue() then
            if ComobboxAutoDirectionModeSlowMotion:GetValue() == 0 then
				if EnableJitterSlowMotion:GetValue() then
					local JitterOffset=SliderJitterOffsetSlowMotion:GetValue()/2
                	AdvancedAtTarget(true,JitterOffset)
				else
					AdvancedAtTarget(false,nil)
				end
                EnableAdvancedAtTarget=true
            elseif ComobboxAutoDirectionModeSlowMotion:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
                EnableAdvancedAtTarget=false
            end
            RotationOffsetCustom=SlowMotionRotationSliderCustom:GetValue()
            LbyOffsetCustom=SlowMotionLBYSliderCustom:GetValue()
            BaseYawOffsetCustom=SlowMotionBaseYawSliderCustom:GetValue()
        else
            if ComobboxAutoDirectionModeGlobal:GetValue() == 0 then
                EnableAdvancedAtTarget=true
				if EnableJitterGlobal:GetValue() then
					local JitterOffset=SliderJitterOffsetGlobal:GetValue()/2
                	AdvancedAtTarget(true,JitterOffset)
				else
					AdvancedAtTarget(false,nil)
				end
            elseif ComobboxAutoDirectionModeGlobal:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
                EnableAdvancedAtTarget=false
            end
            RotationOffsetCustom=GlobalRotationSliderCustom:GetValue()
            LbyOffsetCustom=GlobalLBYSliderCustom:GetValue()
            BaseYawOffsetCustom=GlobalBaseYawSliderCustom:GetValue()
        end
    elseif GetPlayerState() == "Moving" then
        if EnableMovingAA:GetValue() then
            if ComobboxAutoDirectionModeMoving:GetValue() == 0 then
                EnableAdvancedAtTarget=true
				if EnableJitterMoving:GetValue() then
					local JitterOffset=SliderJitterOffsetMoving:GetValue()/2
                	AdvancedAtTarget(true,JitterOffset)
				else
					AdvancedAtTarget(false,nil)
				end
            elseif ComobboxAutoDirectionModeMoving:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
                EnableAdvancedAtTarget=false
            end
            RotationOffsetCustom=MovingRotationSliderCustom:GetValue()
            LbyOffsetCustom=MovingLBYSliderCustom:GetValue()
            BaseYawOffsetCustom=MovingBaseYawSliderCustom:GetValue()
        else
            if ComobboxAutoDirectionModeGlobal:GetValue() == 0 then
                EnableAdvancedAtTarget=true
                if EnableJitterGlobal:GetValue() then
					local JitterOffset=SliderJitterOffsetGlobal:GetValue()/2
                	AdvancedAtTarget(true,JitterOffset)
				else
					AdvancedAtTarget(false,nil)
				end
            elseif ComobboxAutoDirectionModeGlobal:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
                EnableAdvancedAtTarget=false
            end
            RotationOffsetCustom=GlobalRotationSliderCustom:GetValue()
            LbyOffsetCustom=GlobalLBYSliderCustom:GetValue()
            BaseYawOffsetCustom=GlobalBaseYawSliderCustom:GetValue()
        end
    elseif GetPlayerState() == "Air" then
        if EnableAirAA:GetValue() then
            if ComobboxAutoDirectionModeAir:GetValue() == 0 then
                EnableAdvancedAtTarget=true
				if EnableJitterAir:GetValue() then
					local JitterOffset=SliderJitterOffsetAir:GetValue()/2
                	AdvancedAtTarget(true,JitterOffset)
				else
					AdvancedAtTarget(false,nil)
				end
            elseif ComobboxAutoDirectionModeAir:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
                EnableAdvancedAtTarget=false
            end
            RotationOffsetCustom=AirRotationSliderCustom:GetValue()
            LbyOffsetCustom=AirLBYSliderCustom:GetValue()
            BaseYawOffsetCustom=AirBaseYawSliderCustom:GetValue()
        else
            if ComobboxAutoDirectionModeGlobal:GetValue() == 0 then
                EnableAdvancedAtTarget=true
                if EnableJitterGlobal:GetValue() then
					local JitterOffset=SliderJitterOffsetGlobal:GetValue()/2
                	AdvancedAtTarget(true,JitterOffset)
				else
					AdvancedAtTarget(false,nil)
				end
            elseif ComobboxAutoDirectionModeStanding:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
                EnableAdvancedAtTarget=false
            end
            RotationOffsetCustom=GlobalRotationSliderCustom:GetValue()
            LbyOffsetCustom=GlobalLBYSliderCustom:GetValue()
            BaseYawOffsetCustom=GlobalBaseYawSliderCustom:GetValue()
        end  
    end
    if EnableLowDelta:GetValue() and input.IsButtonDown(SlowEnable) then
		if RotationOffsetCustom<0 then
			RotationOffset=-gui.GetValue("mayyaw.LowDeltaSliderValue")
		end
		if RotationOffsetCustom>0 then
			RotationOffset=gui.GetValue("mayyaw.LowDeltaSliderValue")
		end
		if LbyOffsetCustom > 0 then
			LbyOffset=(gui.GetValue("mayyaw.LowDeltaSliderValue")+11)
		end
		if LbyOffsetCustom < 0 then
			LbyOffset=-(gui.GetValue("mayyaw.LowDeltaSliderValue")+11)
		end
	else
		RotationOffset=RotationOffsetCustom
		LbyOffset=LbyOffsetCustom
	end
	if EnbaleAutoSwitchDesync:GetValue() then
		if ComboboxAutoDesyncInvertMode:GetValue() == 0 then
			mode="FOV"
		elseif ComboboxAutoDesyncInvertMode:GetValue() == 1 then
			mode="Distance"
		elseif ComboboxAutoDesyncInvertMode:GetValue() == 2 then
			mode="Local Player Velocity"
		end
		local DesyncSide=DesyncSideFunc(mode)
		if DesyncSide=="Right" then
			if EnableAdvancedAtTarget==false then
				BaseYawOffset=BaseYawOffsetCustom
			end
			RotationOffset=-math.abs(RotationOffset)
			LbyOffset=math.abs(LbyOffset)
		elseif DesyncSide=="Left" then
			if EnableAdvancedAtTarget==false then
				BaseYawOffset=-BaseYawOffsetCustom
			end
			RotationOffset=math.abs(RotationOffset)
			LbyOffset=-math.abs(LbyOffset)
		else
			gui.SetValue("rbot.antiaim.base",177)
		end
	elseif EnbaleAutoSwitchDesync:GetValue()==false then
		if EnableAdvancedAtTarget==false then
			BaseYawOffset=BaseYawOffsetCustom
		end
		if DesyncSwitchKeyValue~=0 then
			if input.IsButtonPressed(DesyncSwitchKeyValue) then
				DesyncSwitchToggle=DesyncSwitchToggle*-1
			end
			if DesyncSwitchToggle==1 then
				LbyOffset=LbyOffset*-1
				if EnableAdvancedAtTarget==false then
					BaseYawOffset=BaseYawOffset*-1
				end
				RotationOffset=RotationOffset*-1
			elseif DesyncSwitchToggle==-1 then
				LbyOffset=LbyOffset*1
				if EnableAdvancedAtTarget==false then
					BaseYawOffset=BaseYawOffset*1
				end
				RotationOffset=RotationOffset*1
			end
		end
	end
	gui.SetValue("rbot.antiaim.base.rotation",RotationOffset)
	gui.SetValue("rbot.antiaim.base.lby",LbyOffset)
	
	if EnableAdvancedAtTarget==false then
		if GetPlayerState() == "Standing" then
			if EnableStandingAA:GetValue() then
				if ComobboxAutoDirectionModeStanding:GetValue() == 1 then
					if EnableJitterStanding:GetValue() then
						local JitterOffset=SliderJitterOffsetStanding:GetValue()
						local BaseYaw=BaseYawOffset
						Jitter(BaseYaw,JitterOffset)
						Jitteroff=true
					else
						Jitteroff=false
					end
				end
			else
				if EnableJitterGlobal:GetValue() then
					local JitterOffset=SliderJitterOffsetGlobal:GetValue()
					local BaseYaw=BaseYawOffset
					Jitter(BaseYaw,JitterOffset)
					Jitteroff=true
				else
					Jitteroff=false
				end
			end
		elseif GetPlayerState() == "SlowMotion" then
			if EnableSlowMotionAA:GetValue() then
				if ComobboxAutoDirectionModeSlowMotion:GetValue() == 1 then
					if EnableJitterSlowMotion:GetValue() then
						local JitterOffset=SliderJitterOffsetSlowMotion:GetValue()
						local BaseYaw=BaseYawOffset
						Jitter(BaseYaw,JitterOffset)
						Jitteroff=true
					else
						Jitteroff=false
					end
				end
			else
				if EnableJitterGlobal:GetValue() then
					local JitterOffset=SliderJitterOffsetGlobal:GetValue()
					local BaseYaw=BaseYawOffset
					Jitter(BaseYaw,JitterOffset)
					Jitteroff=true
				else
					Jitteroff=false
				end	
			end
		elseif GetPlayerState() == "Moving" then
			if EnableMovingAA:GetValue() then
				if ComobboxAutoDirectionModeMoving:GetValue() == 1 then
					if EnableJitterMoving:GetValue() then
						local JitterOffset=SliderJitterOffsetMoving:GetValue()
						local BaseYaw=BaseYawOffset
						Jitter(BaseYaw,JitterOffset)
						Jitteroff=true
					else
						Jitteroff=false
					end
				end
			else
				if EnableJitterGlobal:GetValue() then
					local JitterOffset=SliderJitterOffsetGlobal:GetValue()
					local BaseYaw=BaseYawOffset
					Jitter(BaseYaw,JitterOffset)
					Jitteroff=true
				else
					Jitteroff=false
				end
			end
		elseif GetPlayerState() == "Air" then
			if EnableAirAA:GetValue() then
				if ComobboxAutoDirectionModeAir:GetValue() == 1 then
					if EnableJitterAir:GetValue() then
						local JitterOffset=SliderJitterOffsetAir:GetValue()
						local BaseYaw=BaseYawOffset
						Jitter(BaseYaw,JitterOffset)
						Jitteroff=true
					else
						Jitteroff=false
					end
				end
			else
				if EnableJitterGlobal:GetValue() then
					local JitterOffset=SliderJitterOffsetGlobal:GetValue()
					local BaseYaw=BaseYawOffset
					Jitter(BaseYaw,JitterOffset)
					Jitteroff=true
				else
					Jitteroff=false
				end
			end
		end
		if Jitteroff ~= true then
			gui.SetValue("rbot.antiaim.base",BaseYawOffset)
		end
	end
end
function Jitter(BaseYaw,JitterOffset)
	BaseYaw=math.ceil(BaseYaw)
	JitterOffset=math.ceil(JitterOffset/2)
	RightJitter=BaseYaw
	LeftJitter=BaseYaw
	if BaseYaw >= 0 then -- Left side
		if BaseYaw + JitterOffset > 180 then
			RightJitter=-180+(JitterOffset-(180-BaseYaw))
		elseif BaseYaw + JitterOffset < 180 then
			RightJitter=BaseYaw+JitterOffset
		end
		LeftJitter=BaseYaw-JitterOffset
	elseif BaseYaw < 0 then --Right side
		if BaseYaw - JitterOffset < -180 then
			LeftJitter=180-(JitterOffset-(180-math.abs(BaseYaw)))
		elseif BaseYaw - JitterOffset > -180 then
			LeftJitter=BaseYaw-JitterOffset
		end
		RightJitter=BaseYaw+JitterOffset
	end
	if globals.TickCount() % 2 == 0 then
		gui.SetValue("rbot.antiaim.base", LeftJitter);
	end
	if globals.TickCount() % 4 == 0 then
		gui.SetValue("rbot.antiaim.base", RightJitter);
	end
end
--function LegitAA
function LegitAAonUse()
	if input.IsButtonDown(69) then
		gui.SetValue("rbot.antiaim.advanced.pitch",0)
		gui.SetValue("rbot.antiaim.base",0)
		gui.SetValue("rbot.antiaim.condition.use",0)
	else
		gui.SetValue("rbot.antiaim.advanced.pitch",1)
		gui.SetValue("rbot.antiaim.condition.use",1)
	end
end
--function Desync Indicator
function DesyncInvertIndicator()
	local WightScreen,HightScreen=draw.GetScreenSize()
	if gui.GetValue("rbot.antiaim.base.lby") > 0 then
		DesyncSide="Right"
	end
	if gui.GetValue("rbot.antiaim.base.lby") < 0 then
		DesyncSide="Left"
	end
	if gui.GetValue("rbot.antiaim.base.lby")==0 and gui.GetValue("rbot.antiaim.base.rotation")<0 then
		DesyncSide="Right"
	end
	if gui.GetValue("rbot.antiaim.base.lby")==0 and gui.GetValue("rbot.antiaim.base.rotation")>0 then
		DesyncSide="Left"
	end
	if gui.GetValue("rbot.antiaim.base.lby")>=-180 and gui.GetValue("rbot.antiaim.base.rotation")==-58 then
		DesyncSide="Right"
	end
	if gui.GetValue("rbot.antiaim.base.lby")<=180 and gui.GetValue("rbot.antiaim.base.rotation")==58 then
		DesyncSide="Left"
	end
	if gui.GetValue("rbot.antiaim.base.lby")==0 and gui.GetValue("rbot.antiaim.base.rotation")==0 then
		DesyncSide="Neutral"
	end
	if gui.GetValue("rbot.antiaim.condition.use") and input.IsButtonDown(69) then
		DesyncSide="Neutral"
	end
	if DesyncSide=="Right" and input.IsButtonDown(69)==false then
		Lr,Lg,Lb,Lw=1,1,1,70
		Rr,Rg,Rb,Rw=DesyncInvertActiveColor:GetValue()
	elseif DesyncSide=="Left" and input.IsButtonDown(69)==false then
		Lr,Lg,Lb,Lw=DesyncInvertActiveColor:GetValue()
		Rr,Rg,Rb,Rw=1,1,1,70
	elseif DesyncSide=="Right" and EnableLagitAAonUse:GetValue()==true and input.IsButtonDown(69)==true then
		Lr,Lg,Lb,Lw=DesyncInvertActiveColor:GetValue()
		Rr,Rg,Rb,Rw=1,1,1,70
	elseif DesyncSide=="Left" and EnableLagitAAonUse:GetValue()==true and input.IsButtonDown(69)==true then
		Lr,Lg,Lb,Lw=1,1,1,70
		Rr,Rg,Rb,Rw=DesyncInvertActiveColor:GetValue()
	else
		Lr,Lg,Lb,Lw=1,1,1,70
		Rr,Rg,Rb,Rw=1,1,1,70
	end
	draw.Color(1,1,1,70)
	draw.Triangle(WightScreen/2-40, HightScreen/2+9, WightScreen/2-40, HightScreen/2-9, WightScreen/2-55, HightScreen/2 )
	draw.Triangle(WightScreen/2+40, HightScreen/2+9, WightScreen/2+40, HightScreen/2-9, WightScreen/2+55, HightScreen/2 )
	draw.Color(Lr,Lg,Lb,Lw)
	draw.FilledRect(WightScreen/2-35, HightScreen/2+9, WightScreen/2-37, HightScreen/2-9)
	draw.Color(Rr,Rg,Rb,Rw)
	draw.FilledRect(WightScreen/2+35, HightScreen/2+9, WightScreen/2+37, HightScreen/2-9)
end
--function for calling other functions)
function Main()
	local LocalPlayer=entities.GetLocalPlayer()
	if EnableYaw:GetValue() and EnableIndicators:GetValue() and LocalPlayer ~=nil and LocalPlayer:IsAlive() then
		Indicators()
	end
	if EnableYaw:GetValue() and EnableDmg:GetValue() then
		DmgOverride()
	end
	if EnableYaw:GetValue() and EnableWatermark:GetValue() then
		Watermark()
	end
	if EnableYaw:GetValue() and EnableKeybinds:GetValue() and LocalPlayer~=nil then
		Keybinds()
	end
	if EnableYaw:GetValue() and EnableDesyncInvertIndicator:GetValue() and LocalPlayer~=nil then
		if LocalPlayer:IsAlive() then
			DesyncInvertIndicator()
		end
	end
	if EnableYaw:GetValue() and EnableMayYawAA:GetValue() and LocalPlayer~=nil then
		if LocalPlayer:IsAlive() then
			MayYawAA()
		end
	end
	if EnableYaw:GetValue() and EnableLagitAAonUse:GetValue() and LocalPlayer~=nil then
		if LocalPlayer:IsAlive() then
			LegitAAonUse()
		end
	end
	if EnableYaw:GetValue() and LocalPlayer~=nil then
		AspectRatio()
		NightMode()
	end
	if EnableYaw:GetValue() then
		DoubleFireMode()
	end
	if EnableYaw:GetValue() and EnableNoScopeHitChance:GetValue() and LocalPlayer~=nil then
		NoScopeHitChance()
	end
	if EnableYaw:GetValue() then
		DtDmgHpDiv2()
	end
	if EnableYaw:GetValue() and EnableIdealTick:GetValue() and LocalPlayer~=nil and LocalPlayer:IsAlive() then
		IdealTick()
	end
end
function AutoBuy(event)
	if event:GetName() == "round_prestart" then
		if EnableYaw:GetValue() then
			if EnableAutoBuy:GetValue() then
				if ComboboxAutoBuyPrimaryWeapon:GetValue()==1 then
					PrimaryWeapon="buy scar20;"
				elseif ComboboxAutoBuyPrimaryWeapon:GetValue()==2 then
					PrimaryWeapon="buy ssg08;"
				elseif ComboboxAutoBuyPrimaryWeapon:GetValue()==3 then
					PrimaryWeapon="buy awp;"
				else
					PrimaryWeapon=""
				end
				if ComboboxAutoBuySecondaryWeapon:GetValue()==1 then
					SecondaryWeapon="buy deagle;"
				elseif ComboboxAutoBuySecondaryWeapon:GetValue()==2 then
					SecondaryWeapon="buy elite;"
				elseif ComboboxAutoBuySecondaryWeapon:GetValue()==3 then
					SecondaryWeapon="buy tec9;"
				else
					SecondaryWeapon=""
				end
				if ComboboxAutoBuyArmor:GetValue()==0 then
					Armor=""
				elseif ComboboxAutoBuyArmor:GetValue()==1 then
					Armor="buy vest;"
				else
					Armor="buy vesthelm;"
				end
				if EnableBuyGrenade:GetValue() then
					Granade=" buy hegrenade;"
				else
					Granade=""
				end
				if EnableBuyMolotov:GetValue() then
					Molotov=" buy incgrenade; buy molotov;"
				else
					Molotov=""
				end
				if EnableBuySmoke:GetValue() then
					Smoke=" buy smokegrenade;"
				else
					Smoke=""
				end
				client.Command(PrimaryWeapon..SecondaryWeapon..Armor..Granade..Molotov..Smoke.." buy taser", true)
			end
		end
	end
end
function DesyncSideFunc(mode)
	local WightScreen,HightScreen=draw.GetScreenSize()
	local localplayer=entities.GetLocalPlayer()
	local players = entities.FindByClass( "CCSPlayer" );
	if localplayer~=nil and table.maxn(players)>1 then
		local localpos=localplayer:GetAbsOrigin()
		local x1=localpos.x
		local y1=localpos.y
		local z1=localpos.z
		for i = 1, #players do
			player=players[i]
			entpos=player:GetAbsOrigin()
			if player:IsAlive() then
				if player:GetIndex() ~=localplayer:GetIndex() and player:GetTeamNumber()~=localplayer:GetTeamNumber() and player:GetTeamNumber()~=1 then
					local x2=entpos.x
					local y2=entpos.y
					local z2=entpos.z
					--At Dist mode
					if mode == "Distance" then
						dist=vector.Distance( { x1, y1, z1 }, { x2, y2, z2 } )
						if dist<mindist then
							mindist=dist
							playerDesync=player
						end
					end
					--FOV Based
					if mode == "FOV" then
						local enemyx,enemyy=client.WorldToScreen(player:GetAbsOrigin()+Vector3(0,0,50))
						if enemyx~=nil and enemyy~=nil then
							local dist=math.sqrt((math.abs(WightScreen/2-enemyx))^2+(math.abs(HightScreen/2-enemyy))^2)
							if dist<mindist then
								mindist=dist
								playerDesync=player
							end
						end
					end
					if mode=="Local Player Velocity" then
						if vel == 450 then
							DesyncSide="Right"
						end
						if vel == -450 then
							DesyncSide="Left"
						end
						return DesyncSide
					end
				end
			end
		end
		mindist=1000000
		if playerDesync~=nil and ComboboxAutoDesyncInvertMode:GetValue()~=1 and playerDesync~=nil then
			local EnemyPosX=playerDesync:GetAbsOrigin().x
			local EnemyPosY=playerDesync:GetAbsOrigin().y
			local LocalPosX=localpos.x
			local LocalPosY=localpos.y
			if LocalPosX > 0 and LocalPosY > 0 then
				LocalChet=1
			elseif LocalPosX < 0 and LocalPosY > 0 then
				LocalPChet=2
			elseif LocalPosX < 0 and LocalPosY < 0 then
				LocalPChet=3
			elseif LocalPosX > 0 and LocalPosY < 0 then
				LocalPChet=4
			end
			local ViewAngle=engine.GetViewAngles().y
			if EnemyPosX > LocalPosX and EnemyPosY > LocalPosY then
				if ViewAngle > 0 and ViewAngle < 45 then
					DesyncSide="Left"
				end
				if ViewAngle > 45 and ViewAngle < 90 then
					DesyncSide="Right"
				end
			end
			if EnemyPosX < LocalPosX and EnemyPosY > LocalPosY then
				if ViewAngle > 90 and ViewAngle < 135 then
					DesyncSide="Left"
				end
				if ViewAngle > 135 and ViewAngle < 180 then
					DesyncSide="Right"
				end
			end
			if EnemyPosX < LocalPosX and EnemyPosY < LocalPosY then
				if ViewAngle > -180 and ViewAngle < -135 then
					DesyncSide="Left"
				end
				if ViewAngle > -135 and ViewAngle < -90 then
					DesyncSide="Right"
				end
			end
			if EnemyPosX > LocalPosX and EnemyPosY < LocalPosY then
				if ViewAngle > -90 and ViewAngle < -45 then
					DesyncSide="Left"
				end
				if ViewAngle > -45 and ViewAngle < 0 then
					DesyncSide="Right"
				end
			end
			return DesyncSide
		end
	end
end
local animation={"M","M","Ma","Ma","May","May","MayY","MayY","MayYa","MayYa","MayYaw","MayYaw","MayYaw","MayYa","MayYa","MayY","MayY","May","May","Ma","Ma","M","M","",""}
function Clantag()
	if EnableClantag:GetValue() and EnableYaw:GetValue() then
		local CurTime = math.floor(globals.CurTime() * 2.3);
    	if OldTime ~= CurTime then
    	    SetClantag(animation[CurTime % #animation+1], animation[CurTime % #animation+1]);
    	end
    	OldTime = CurTime;
		clantagset = 1;
	else
		if clantagset == 1 then
            clantagset = 0;
            SetClantag("", "");
        end
	end
end
function DamageLog(event)
	local LocalPlayer = entities.GetLocalPlayer();
	if EnableYaw:GetValue() and EnableHitLog:GetValue() and LocalPlayer~=nil and LocalPlayer:IsAlive() then
		if event:GetName()=="player_death" or event:GetName()=="round_start" then
			local UserD=entities.GetByUserID(event:GetInt('userid'))
			if LocalPlayer:GetIndex()==UserD:GetIndex() then
				HitScore=1
			end
		end
		if event:GetName()~="weapon_fire" and event:GetName()~="player_hurt" then
			return
		end
		local user = entities.GetByUserID(event:GetInt('userid'));
		if (LocalPlayer == nil or user == nil) then
			return
		end
		if event:GetName()=="player_hurt" then
			local attacker = entities.GetByUserID(event:GetInt('attacker'));
			local remainingHealth = event:GetInt('health');
			local damageDone = event:GetInt('dmg_health');
			if attacker == nil then
				return
			end
			if (LocalPlayer:GetIndex() == attacker:GetIndex()) then
				local safty=math.floor(100-LocalPlayer:GetWeaponInaccuracy()*500)
				if safty >= 60 then
					safty="true"
				elseif safty < 60 then
					safty="false"
				elseif safty==nil then
					safty="false"
				end
				if gui.GetValue("rbot.antiaim.condition.shiftonshot") and IsDtEnable() then
					Exploits=2
				elseif gui.GetValue("rbot.antiaim.condition.shiftonshot") or IsDtEnable() then
					Exploits=1
				else
					Exploits=0
				end
				local maxticksValue=gui.Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks'):GetValue()
				local simtime = globals.TickCount() % maxticksValue 
				local log=("["..HitScore.."] ".."Hit "..user:GetName().." in the "..HitGroup(event:GetInt('hitgroup')).." for "..damageDone.." damage ("..remainingHealth.." remaining)".." safty="..safty.." ("..simtime..":"..Exploits..")".."\n")
				HitScore=HitScore+1
				local r1,g1,b1,a1=MainLogColor:GetValue()
				local r2,g2,b2,a2=PrefixLogColor:GetValue()
				client.color_log(r2,g2,b2,"[MayYaw]")
				client.color_log(r1,g1,b1, log .. "\n")
			end
		end
	end
end
function AspectRatio()
	local NewAsp=AspectRatioDefValSlider:GetValue()
	if not EnableAcpectRatio:GetValue() then
		if SetAspectRatioZero==false then
			client.SetConVar( "r_aspectratio", 0, true)
			SetAspectRatioZero=true
		end
		SetAspectRatioIfAgain=false
		return
	else
		if SetAspectRatioIfAgain==false then
			client.SetConVar( "r_aspectratio",AspectRatioDefValSlider:GetValue()/100, true)
			SetAspectRatioIfAgain=true
		end
	end
	if NewAsp~=AspectRatioDefVal then
		client.SetConVar( "r_aspectratio", NewAsp/100, true)
		AspectRatioDefVal=NewAsp
	end
	SetAspectRatioZero=false
end
function AdvancedAtTarget(JitterEnbale,JitterOffset)
	local WightScreen,HightScreen=draw.GetScreenSize()
	gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
	gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
	local LocalPlayer=entities.GetLocalPlayer()
	local localpos=LocalPlayer:GetAbsOrigin()
	local LocalPosX=localpos.x
	local LocalPosY=localpos.y
	local LocalPosZ=localpos.z
	local players = entities.FindByClass( "CCSPlayer" );
	for i = 1, #players do
		local player=players[i]
		if player:GetIndex()~=LocalPlayer:GetIndex() and player:GetTeamNumber()~=LocalPlayer:GetTeamNumber() and player:IsAlive() then
			local EnemyPos=player:GetAbsOrigin()
			local EnemyPosX=EnemyPos.x
			local EnemyPosY=EnemyPos.y
			local EnemyPosZ=EnemyPos.z
			if ComboxAtTargetPriotity:GetValue()==1 then
				if LocalPosX~=nil and LocalPosY~=nil and LocalPosZ~=nil and EnemyPosX~=nil and EnemyPosY~=nil and EnemyPosZ~=nil then
					dist=vector.Distance( { LocalPosX, LocalPosY, LocalPosZ }, { EnemyPosX, EnemyPosY, EnemyPosZ } )
				end
				if dist<mindist then
					mindist=dist
					playerDesync=player
				end
			elseif ComboxAtTargetPriotity:GetValue()==0 then
				local enemyx,enemyy=client.WorldToScreen(player:GetAbsOrigin())
				if enemyx~=nil and enemyy~=nil then
					dist=math.sqrt((math.abs(WightScreen/2-enemyx))^2+(math.abs(HightScreen/2-enemyy))^2)
					if dist<mindist then
						mindist=dist
						playerDesync=player
					end
				end
			end
		end
	end
	mindist=1000000
	if playerDesync~=nil then
		local ViewAngle=engine.GetViewAngles().y
		local PlayerPosXYZ=playerDesync:GetAbsOrigin()
		if PlayerPosXYZ~=nil then
			local EnemyPlayerPosX=math.abs(PlayerPosXYZ.x)
			local EnemyPlayerPosY=math.abs(PlayerPosXYZ.y)
			local LocalPlayerPosX=math.abs(LocalPosX)
			local LocalPlayerPosY=math.abs(LocalPosY)
			local DistX=math.max(EnemyPlayerPosX,LocalPlayerPosX)-math.min(EnemyPlayerPosX,LocalPlayerPosX)
			local DistY=math.max(EnemyPlayerPosY,LocalPlayerPosY)-math.min(EnemyPlayerPosY,LocalPlayerPosY)
			if PlayerPosXYZ.x > LocalPosX and PlayerPosXYZ.y > LocalPosY then
				Ugol=math.atan(DistY/DistX)*57,3
				Ugol=-(Ugol-ViewAngle)
			end
			if PlayerPosXYZ.x < LocalPosX and PlayerPosXYZ.y > LocalPosY then
				Ugol=math.atan(DistY/DistX)*57,3
				Ugol=(Ugol+ViewAngle)-180
			end			
			if PlayerPosXYZ.x < LocalPosX and PlayerPosXYZ.y < LocalPosY then
				Ugol=math.atan(DistY/DistX)*57,3
				Ugol=180-(Ugol-ViewAngle)
			end
			if PlayerPosXYZ.x > LocalPosX and PlayerPosXYZ.y < LocalPosY then
				Ugol=math.atan(DistY/DistX)*57,3
				Ugol=(Ugol+ViewAngle)
				
			end
			if Ugol < 0 then
				Resault=-180-Ugol
			elseif Ugol > 0  then
				Resault=180-Ugol
			end
			if JitterEnbale == false then
				gui.SetValue("rbot.antiaim.base",Resault)
				return
			end
			local BaseYaw=Resault
			if BaseYaw >= 0 then -- Left side
				if BaseYaw + JitterOffset > 180 then
					RightJitter=-180+(JitterOffset-(180-BaseYaw))
				elseif BaseYaw + JitterOffset < 180 then
					RightJitter=BaseYaw+JitterOffset
				end
				LeftJitter=BaseYaw-JitterOffset
			elseif BaseYaw < 0 then --Right side
				if BaseYaw - JitterOffset < -180 then
					LeftJitter=180-(JitterOffset-(180-math.abs(BaseYaw)))
				elseif BaseYaw - JitterOffset > -180 then
					LeftJitter=BaseYaw-JitterOffset
				end
				RightJitter=BaseYaw+JitterOffset
 			end
			if globals.TickCount() % 2 == 0 then
				gui.SetValue("rbot.antiaim.base", LeftJitter);
			end
			if globals.TickCount() % 4 == 0 then
				gui.SetValue("rbot.antiaim.base", RightJitter);
			end
		end
	end
end
function NightMode()
	local Night = entities.FindByClass("CEnvTonemapController")[1];
	if EnableNightMode:GetValue() then
		if NightModeAgain==false then
			Night:SetProp("m_bUseCustomAutoExposureMin", 1);
			Night:SetProp("m_bUseCustomAutoExposureMax", 1);
			Night:SetProp("m_flCustomAutoExposureMin", NightModeValSlider:GetValue()/100);
			Night:SetProp("m_flCustomAutoExposureMax", NightModeValSlider:GetValue()/100);
			NightModeAgain=true
		end
		local NewNightModeVal=NightModeValSlider:GetValue()
		if NewNightModeVal~=NightModeDefVal then
			NightModeDefVal=NewNightModeVal
			Night:SetProp("m_bUseCustomAutoExposureMin", 1);
			Night:SetProp("m_bUseCustomAutoExposureMax", 1);
			Night:SetProp("m_flCustomAutoExposureMin", NewNightModeVal/100);
			Night:SetProp("m_flCustomAutoExposureMax", NewNightModeVal/100);
		end
	else
		NightModeAgain=false
		if Night:GetProp("m_bUseCustomAutoExposureMin") ~=0  and Night:GetProp("m_bUseCustomAutoExposureMax")~=0 then 
			Night:SetProp("m_bUseCustomAutoExposureMin", 0);
			Night:SetProp("m_bUseCustomAutoExposureMax", 0);
		end
	end
end
function NoScopeHitChance()
	local LocalPlayer=entities.GetLocalPlayer()
	local IsScoped=LocalPlayer:GetPropBool("m_bIsScoped")
	local SliderValue=gui.GetValue("mayyaw.NoScopeHitChanceSlider")
	local gun=GetActiveGun()
	if gun ~= "asniper" then
		return
	end
	if Aimwaremenu:IsActive() then
		if gui.GetValue("rbot.hitscan.accuracy.asniper.hitchance")==SliderValue then
			gui.SetValue("rbot.hitscan.accuracy.asniper.hitchance",DefScopeAutoValue)
		end
		DefScopeAutoValue=gui.GetValue("rbot.hitscan.accuracy.asniper.hitchance")
		return
	end
	if not IsScoped then
		if SliderValue ~= gui.GetValue("rbot.hitscan.accuracy.asniper.hitchance") then
			gui.SetValue("rbot.hitscan.accuracy.asniper.hitchance",SliderValue )
		end
	else
		gui.SetValue("rbot.hitscan.accuracy.asniper.hitchance",DefScopeAutoValue)
	end
end
function DoubleFireMode()
	local maxserverticks = client.GetConVar('sv_maxusrcmdprocessticks')
	if not EnableCustomDoubleTapMode:GetValue() then
		if SetDefTicks==false then
			maxticks:SetValue(maxserverticks)
			SetDefTicks=true
		end
		return
	end
	local LocalPlayer=entities.GetLocalPlayer()
	local PlayerResources=entities.GetPlayerResources()
	if EnableCustomDoubleTapMode:GetValue() then
		if ComboboxCustomDoubleFireMode:GetValue() == 0 and LocalPlayer~=nil then
			local ping= PlayerResources:GetPropInt("m_iPing", entities.GetLocalPlayer():GetIndex())
			if ping <=5 then
				AdaptiveValue=maxserverticks+1
			elseif ping <=20 then
				AdaptiveValue=maxserverticks
			elseif ping <=50 then
				AdaptiveValue=maxserverticks-1
			elseif ping <=70 then
				AdaptiveValue=maxserverticks-2
			elseif ping > 70 then
				AdaptiveValue=maxserverticks-3
			end
			maxticks:SetValue(AdaptiveValue)
		end
		if ComboboxCustomDoubleFireMode:GetValue() == 1 then
			maxticks:SetValue(19)
		end
		if ComboboxCustomDoubleFireMode:GetValue() == 2 then
			maxticks:SetValue(16)
		end
		if ComboboxCustomDoubleFireMode:GetValue() == 3 then
			maxticks:SetValue(14)
		end
	end
	SetDefTicks=false
end
function DtDmgHpDiv2()
	LocalPlayer=entities.GetLocalPlayer()
	if not EnableDoubleFireDamageHpdiv2:GetValue() or LocalPlayer==nil or not LocalPlayer:IsAlive() or GetActiveGun()~="asniper" or IsDtEnable()==false  then
		if SetDefDmg==false then
			gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage",DefDmgAutoValue)
			SetDefDmg=true
		end
		return
	end
	if RagebotTarget==nil then 
		return
	end
	local EnemyHp=RagebotTarget:GetHealth()
	if EnemyHp == nil then
		return
	end
	local Dmg=math.ceil(EnemyHp/2)
	if Aimwaremenu:IsActive() then
		if SetDmgIfMenuOpen==false then
			gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage",DefDmgAutoValue)
			SetDmgIfMenuOpen=true
		end
		DefDmgAutoValue=gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
		return
	end
	if Dmg ~= 0 then
		gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage",Dmg)
	end
	SetDmgIfMenuOpen=false
	SetDefDmg=false
end
function IdealTick()
	local AutoPeekKey=gui.GetValue("rbot.accuracy.movement.autopeekkey")
	if gui.GetValue( "rbot.accuracy.movement.autopeek" ) == false then
		AutoPeekToggle=-1
		return
	end
	if gui.GetValue("rbot.accuracy.movement.autopeektype")==0 and AutoPeekKey~=0 then
		AutoPeekToggle=-1
		if input.IsButtonDown(AutoPeekKey) then
			if DefValueAutoPeekhold == true then
				DefEhableFakeLag=gui.GetValue("misc.fakelag.enable")
				DefValueFakelag=gui.GetValue("misc.fakelag.factor")
				DefEnableFakeLatency=gui.GetValue("misc.fakelatency.enable")
				DefValueFakeLatency=gui.GetValue("misc.fakelatency.amount")
				DefScarDT=gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire")
				DefAwpDT=gui.GetValue("rbot.hitscan.accuracy.sniper.doublefire")
				DefScotDT=gui.GetValue("rbot.hitscan.accuracy.scout.doublefire")
				DefHPistolDT=gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire")
				DefValueAutoPeekhold=false
			end
			gui.SetValue("misc.fakelag.enable",false)
			gui.SetValue("misc.fakelag.factor",1)
			gui.SetValue("misc.fakelatency.enable",true)
			gui.SetValue("misc.fakelatency.amount",120)
			gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire",2)
			gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire",2)
			gui.SetValue("rbot.hitscan.accuracy.scout.doublefire",2)
			gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire",2)
		end
		if input.IsButtonReleased(AutoPeekKey) then
			gui.SetValue("misc.fakelag.enable",DefEhableFakeLag)
			gui.SetValue("misc.fakelag.factor",DefValueFakelag)
			gui.SetValue("misc.fakelatency.enable",DefEnableFakeLatency)
			gui.SetValue("misc.fakelatency.amount",DefValueFakeLatency)
			gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire",DefScarDT)
			gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire",DefAwpDT)
			gui.SetValue("rbot.hitscan.accuracy.scout.doublefire",DefScotDT)
			gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire",DefHPistolDT)
			DefValueAutoPeekhold=true
		end
	elseif gui.GetValue("rbot.accuracy.movement.autopeektype")==1 and AutoPeekKey~=0 then
		if Aimwaremenu:IsActive() then
			return
		end
		if EnableKeybinds:GetValue() == false then
			if input.IsButtonPressed( AutoPeekKey ) then
				AutoPeekToggle=AutoPeekToggle*-1
			end
			KeyBindsToggleOnes=false
		else
			if KeyBindsToggleOnes==false then
				AutoPeekToggle=-1
				KeyBindsToggleOnes=true
			end
		end
		if AutoPeekToggle == 1 then
			if DefValueAutoPeekToggle==false then
				DefEhableFakeLag=gui.GetValue("misc.fakelag.enable")
				DefValueFakelag=gui.GetValue("misc.fakelag.factor")
				DefEnableFakeLatency=gui.GetValue("misc.fakelatency.enable")
				DefValueFakeLatency=gui.GetValue("misc.fakelatency.amount")
				DefScarDT=gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire")
				DefAwpDT=gui.GetValue("rbot.hitscan.accuracy.sniper.doublefire")
				DefScotDT=gui.GetValue("rbot.hitscan.accuracy.scout.doublefire")
				DefHPistolDT=gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire")
				DefValueAutoPeekToggle=true
				SetDefValueAutoPeekToggle=false
			end
			gui.SetValue("misc.fakelag.enable",false)
			gui.SetValue("misc.fakelag.factor",1)
			gui.SetValue("misc.fakelatency.enable",true)
			gui.SetValue("misc.fakelatency.amount",120)
			gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire",2)
			gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire",2)
			gui.SetValue("rbot.hitscan.accuracy.scout.doublefire",2)
			gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire",2)
		elseif AutoPeekToggle ==-1 then
			if SetDefValueAutoPeekToggle ==false then
				gui.SetValue("misc.fakelag.enable",DefEhableFakeLag)
				gui.SetValue("misc.fakelag.factor",DefValueFakelag)
				gui.SetValue("misc.fakelatency.enable",DefEnableFakeLatency)
				gui.SetValue("misc.fakelatency.amount",DefValueFakeLatency)
				gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire",DefScarDT)
				gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire",DefAwpDT)
				gui.SetValue("rbot.hitscan.accuracy.scout.doublefire",DefScotDT)
				gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire",DefHPistolDT)
				SetDefValueAutoPeekToggle=true
			end
			DefValueAutoPeekToggle=false
		end
	end
end
callbacks.Register("AimbotTarget", function(enemy)
	if enemy:GetIndex() ~=nil then
		if entities.GetByIndex(enemy:GetIndex()):IsAlive() then
			RagebotTarget=entities.GetByIndex(enemy:GetIndex())
		end
	end
end)
client.AllowListener("round_prestart");
callbacks.Register("CreateMove",JumpScoutFix)
callbacks.Register("Draw",Main)
callbacks.Register("Draw",Clantag)
callbacks.Register( "FireGameEvent",DamageLog)
callbacks.Register( "FireGameEvent", AutoBuy)
callbacks.Register("Draw",GuiElements)
callbacks.Register("Draw",EngineRadar)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

