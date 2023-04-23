local Font = draw.CreateFont("Bahnschrift", 20, 100)

local VisualsRef = gui.Reference("VISUALS");
local Visuals = gui.Tab(VisualsRef, "visuals", "aimware.pro");

local RbotRef = gui.Reference("RAGEBOT");
local Rbot = gui.Tab(RbotRef, "ragebot", "aimware.pro");

local MiscRef = gui.Reference("MISC")
local Misc = gui.Tab(MiscRef, "misc", "aimware.pro")



local MiscVisaulsGroup = gui.Groupbox(Visuals, "Miscellaneous", 455, 16, 160, 20)

local watermark = gui.Checkbox(MiscVisaulsGroup, "watermark", "Watermark", true);

local RemoveArmsInScope = gui.Checkbox(MiscVisaulsGroup, "RemoveArmsInScope", "Remove Arms in scope", false)

local ForceCrosshair = gui.Checkbox(MiscVisaulsGroup, "ForceCrosshair", "Force Crosshair", false)



local IndicatorGroup = gui.Groupbox(Visuals, "Indicators", 305, 16, 148, 20)

local MinimumDamageIndicators = gui.Checkbox(IndicatorGroup, "MinDmgIndicators", "Min-Damage", false)

local RainbowCustomizationGroup = gui.Groupbox(Visuals, "Rainbow Settings", 16, 16, 287.5, 50);
local RainbowRainbowifyGroup = gui.Groupbox(Visuals, "Rainbow Models", 16, 225, 287.5, 50);

local Saturation = gui.Slider(RainbowCustomizationGroup, "Saturation", "Saturation", 1, 0, 1, 0.01);
local Value = gui.Slider(RainbowCustomizationGroup, "Value", "Value", 255, 0, 255, 1);
local Speed = gui.Slider(RainbowCustomizationGroup, "Speed", "Speed", 1, 0.01, 2, 0.01);

local Arms = gui.Checkbox(RainbowRainbowifyGroup, "Arms", "Arms", false);
local OccludedArms = gui.Checkbox(RainbowRainbowifyGroup, "OccludedArms", "Occluded Arms", false);
local AlphaArms = gui.Slider(RainbowRainbowifyGroup, "ArmsAlpha", "Arms Alpha", 255, 0, 255, 1);

local gap3 = gui.Text(RainbowRainbowifyGroup, " ");

local WeaponVM = gui.Checkbox(RainbowRainbowifyGroup, "WeaponVM", "Weapon Viewmodel", false);
local OccludedWeaponVM = gui.Checkbox(RainbowRainbowifyGroup, "OccludedWeaponVM", "Occluded Weapon VM", false);
local AlphaWeaponVM = gui.Slider(RainbowRainbowifyGroup, "WeaponVMAlpha", "Weapon VM Alpha", 255, 0, 255, 1);

local gap4 = gui.Text(RainbowRainbowifyGroup, " ");

local LocalPlayerModel = gui.Checkbox(RainbowRainbowifyGroup, "LocalPlayerModel", "Local Player Model", false);
local OccludedLocal = gui.Checkbox(RainbowRainbowifyGroup, "OccludedLocalModel", "Occluded Local Model", false);
local AlphaLocal = gui.Slider(RainbowRainbowifyGroup, "LocalModelAlpha", "Local Model Alpha", 255, 0, 255, 1);

local gap4 = gui.Text(RainbowRainbowifyGroup, " ");

local LocalPlayerGlow = gui.Checkbox(RainbowRainbowifyGroup, "LocalPlayerGlow", "Local Player Glow", false);
local AlphaLocalGlow = gui.Slider(RainbowRainbowifyGroup, "LocalAlphaGlow", "Local Alpha Glow", 255, 0, 255, 1);

local gap6 = gui.Text(RainbowRainbowifyGroup, " ");

local LocalAttachmentsPlayer = gui.Checkbox(RainbowRainbowifyGroup, "LocalAttachmentsPlayer", "Local Attachments Player", false);
local OccludedLocalAttachments = gui.Checkbox(RainbowRainbowifyGroup, "OccludedLocalAttachments", "Occluded LocalAttac hments", false);
local AlphaLocalAttachments = gui.Slider(RainbowRainbowifyGroup, "LocalAttachmentsAlpha", "Local Attachments Alpha", 255, 0, 255, 1);

local gap7 = gui.Text(RainbowRainbowifyGroup, " ");

local Ghost = gui.Checkbox(RainbowRainbowifyGroup, "Ghost", "Ghost", false);
local OccludedGhost = gui.Checkbox(RainbowRainbowifyGroup, "OccludedGhost", "Occluded Ghost", false);
local AlphaGhost = gui.Slider(RainbowRainbowifyGroup, "GhostAlpha", "Ghost Alpha", 255, 0, 255, 1);

local gap10 = gui.Text(RainbowRainbowifyGroup, " ");

local LocalBulletTracer = gui.Checkbox(RainbowRainbowifyGroup, "LocalBulletTracer", "Bullet Tracers", false)
local AlphaLocalTracer = gui.Slider(RainbowRainbowifyGroup, "AlphaLocalTracer", "Bullet Tracer Alpha", 255, 0 ,255, 1)

-----------------------------------------[Rage Bot Start]-----------------------------------------

local AntiAimMainGroup = gui.Groupbox(Rbot, "Anti-Aim Customization", 16, 16, 599, 50)

local DesyncJitter = gui.Checkbox(AntiAimMainGroup, "DesyncJitter", "Desync Jitter", false);
local InconDesyncJitter = gui.Checkbox(AntiAimMainGroup, "InconDesyncJitter", "Inconsistent Desync Jitter", false);
local DesyncJitterRange = gui.Slider(AntiAimMainGroup, "DesyncJitterRange", "Desync Jitter Range", 58, 30, 58, 2);
DesyncJitterRange:SetValue(58);
DesyncJitterRange:SetDescription("30ᵒ is the minimum due to aimware being aimware")

local gap11 = gui.Text(AntiAimMainGroup, " "); 

local YawJitter = gui.Checkbox(AntiAimMainGroup, "YawJitter", "Yaw Jitter", false);
local YawJitterRange = gui.Slider(AntiAimMainGroup, "YawJitterRange", "Yaw Jitter Range", 165, 0, 180, 1);
YawJitterRange:SetValue(165);

local gap11 = gui.Text(Rbot, " ");
local gap12 = gui.Text(Rbot, " ");

local SlideWalkSpam = gui.Checkbox(Rbot, "SlideWalkSpam", "Slide Walk Spam", false);

local gap13 = gui.Text(Rbot, " ");
local gap14 = gui.Text(Rbot, " ");

local DT = gui.Checkbox(Rbot, "DoubleTap", "Double Tap", false);
local KnifeTeleport = gui.Checkbox(Rbot, "KnifeTeleport", "Teleport with knife", false);

local HS = gui.Checkbox(Rbot, "HideShots", "Hide Shots", false);



-----------------------------------------[Misc Start]-----------------------------------------

local AimwareSpam = gui.Checkbox(Misc, "AimwareSpam", "Chat Spam", false)

-----------------------------------------[End of GUI]-----------------------------------------

--[[ Rainbow visuals ]]--
local function RAINBOW(sat, val)
    local time = globals.CurTime()*3.14159*Speed:GetValue();
    
    local changing_value = math.floor(val*0.5)*sat
    local constant_value = (val-changing_value)
    
    return unpack({
        math.floor(math.sin(time) * changing_value + constant_value),
        math.floor(math.sin(time+2.1) * changing_value + constant_value),
        math.floor(math.sin(time+4.2) * changing_value + constant_value)
    })
end

callbacks.Register("Draw", "Rainbow", function()
    --* Rainbow Colors
    local r, g, b = RAINBOW(Saturation:GetValue(), Value:GetValue())

    if Arms:GetValue() then
        gui.SetValue("esp.chams.localarms.visible.clr", r, g, b, AlphaArms:GetValue())
            if OccludedArms:GetValue() then
                gui.SetValue("esp.chams.localarms.visible.clr", r, g, b, AlphaArms:GetValue())
            end
    end

    if WeaponVM:GetValue() then
        gui.SetValue("esp.chams.localweapon.visible.clr", r, g, b, AlphaWeaponVM:GetValue())
            if OccludedWeaponVM:GetValue() then
                gui.SetValue("esp.chams.localweapon.occluded.clr", r, g, b, AlphaWeaponVM:GetValue())
            end
    end


    if LocalPlayerModel:GetValue() then
        gui.SetValue("esp.chams.local.visible.clr", r, g, b, AlphaLocalModel:GetValue())
            if OccludedLocal:GetValue() then
                gui.SetValue("esp.chams.local.occluded.clr", r, g, b, AlphaLocalModel:GetValue())
            end
    end

    if LocalPlayerGlow:GetValue() then
        gui.SetValue("esp.chams.local.Overlay.Glow.clr", r, g, b, AlphaLocalGlow:GetValue())
    end

    if LocalAttachmentsPlayer:GetValue() then
        gui.SetValue("esp.chams.localattachments.visible.clr", r, g, b, AlphaLocalAttachments:GetValue())
            if OccludedLocalAttachments:GetValue() then
                gui.SetValue("esp.chams.localattachments.occluded.clr", r, g, b, AlphaLocalAttachments:GetValue())
            end
    end 

    if Ghost:GetValue() then
        gui.SetValue("esp.chams.ghost.visible.clr", r, g, b, AlphaGhost:GetValue())
            if OccludedGhost:GetValue() then
                gui.SetValue("esp.chams.ghost.occluded.clr", r, g, b, AlphaGhost:GetValue())
            end
    end 

    if LocalBulletTracer:GetValue() then
        gui.SetValue("esp.world.bullettracerfilter.local.clr", r, g, b, AlphaLocalTracer:GetValue())
    end

end)

--[[ Anti-Aim ]]--
callbacks.Register("Draw", "AntiAims", function()

--[[ Desync Jitter ]]--
    if DesyncJitter:GetValue() then
        local NormalJitter = math.random(-1, 2);
        local InconsistentJitter = math.random(-1, 1);


            if NormalJitter == 0 then
                NormalJitter = -1
            end

            if NormalJitter == 2 then
                NormalJitter = 1
            end

            if InconDesyncJitter:GetValue() then
                NormalJitter = InconsistentJitter
            end

        gui.SetValue("rbot.antiaim.base.rotation", DesyncJitterRange:GetValue() * NormalJitter)
    end

    --[[ Yaw Jitter ]]--
    if YawJitter:GetValue() then
        local CenterJitter = math.floor(math.random(-1, 1))

        if CenterJitter == 0 then
            CenterJitter = -1
        end

        gui.SetValue("rbot.antiaim.base", YawJitterRange:GetValue() * CenterJitter)
    end

    --[[ Leg Fucker/Slide Walk Spam/What ever you wanna call it ]]--
    if SlideWalkSpam:GetValue() then
        local LegFucker = math.random(-3, 1)

        if LegFucker == -1 then
            LegFucker = 0
        end

        if LegFucker == -2 then
            LegFucker = 0
        end

        if LegFucker == -3 then
            LegFucker = 0
        end

        gui.SetValue("misc.slidewalk", LegFucker)

    else
        gui.SetValue("misc.slidewalk", false)
    end

end)

--[[ Exploits ]]--
callbacks.Register("Draw", "Exploits", function()

    --pasted from Bleeding.lua

    local exploit_state;
    local exploit_knife;

    if DT:GetValue() then

        exploit_state = "Defensive Warp Fire"
        exploit_knife = "Defensive Fire"
    elseif HS:GetValue() and not DT:GetValue() then

        exploit_state = "Shift Fire"
        exploit_knife = "Shift Fire"
    else

        exploit_state = "Off"
        exploit_knife = "Off"
    end

    if KnifeTeleport:GetValue() == true then
        exploit_knife = exploit_state
    end

    --better ways of doing this. I cba to do it any other way.
    --actually added this myself since the one from Bleeding was outdated.
    gui.SetValue("rbot.accuracy.attack.asniper.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.scout.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.pistol.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.hpistol.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.zeus.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.smg.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.rifle.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.shotgun.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.sniper.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.lmg.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack.knife.fire", exploit_knife)
    gui.SetValue("rbot.accuracy.attack.shared.fire", exploit_state)
end)

--[[ Better default chatspam ]]--
callbacks.Register("Draw", "AimwareSpam", function()
    if AimwareSpam:GetValue() then
        local AimwareChatSpamRandomizer = math.random(0, 140)

        gui.SetValue("misc.chatspam", AimwareChatSpamRandomizer)

    else
        gui.SetValue("misc.chatspam", false)
    end
end)

--[[ Watermark ]]--
callbacks.Register("Draw", "Watermark", function()
    --* Watermark
local LocalPlayerCheck1 = entities.GetLocalPlayer();

--Bs dynamic ish watermark. Also yes, bad variable name.
local x1 = 1770 --Default: 1770

if not watermark:GetValue() then return end

if LocalPlayerCheck1 then

    draw.SetFont(Font);

    draw.Color(255, 138, 130, 255);
    draw.FilledRect(1915, 5, x1 - 7, 38); --Default: 1763

    draw.Color(255, 255, 255, 255);
    draw.Text(1800, 15, " | aimware.pro");

    draw.Color(255, 255, 255, 255);
    draw.Text(x1, 15, "test");

else

    draw.SetFont(Font);

    draw.Color(255, 138, 130, 255);
    draw.FilledRect(1915, 5, 1810, 38);

    draw.Color(255, 255, 255, 255);
    draw.Text(1815, 15, "aimware.pro");

end

end)

--[[ Remove viewmodel while scoped ]]--
callbacks.Register("Draw", "RemoveViewmodelScope", function()
    local Get_LocalPlayer_Scope = entities.GetLocalPlayer()

    local Active_Weapon 
    if Get_LocalPlayer_Scope then
        Active_Weapon = Get_LocalPlayer_Scope:GetPropEntity("m_hActiveWeapon")
    end
    local Zoom_Level
    local Is_Scoped

    if Get_LocalPlayer_Scope then
        Is_Scoped = Get_LocalPlayer_Scope:GetProp("m_bIsScoped")
    end

    if RemoveArmsInScope:GetValue() then
        if Get_LocalPlayer_Scope then
            if Is_Scoped == 65536 then
                client.SetConVar("viewmodel_offset_y", 1, true)
            elseif Is_Scoped == 65792 then
                client.SetConVar("viewmodel_offset_y", 1, true)
            else
                if Is_Scoped ~= 0 then
                Zoom_Level = Active_Weapon:GetProp("m_zoomLevel")
                    if Zoom_Level == 1 then
                        client.SetConVar("viewmodel_offset_y", -50, true)
                    elseif Zoom_Level == 2 then
                        client.SetConVar("viewmodel_offset_y", -50, true)
                    else
                        client.SetConVar("viewmodel_offset_y", 1, true)
                    end
                else
                    client.SetConVar("viewmodel_offset_y", 1, true)
                end
            end
        else
            client.SetConVar("viewmodel_offset_y", 1, true)
        end
    else
        client.SetConVar("viewmodel_offset_y", 1, true)
    end

end)

--[[ Force Crosshair ]]--
callbacks.Register("Draw", "ForceCrosshair", function()
    local Get_LocalPlayer_Xhair = entities.GetLocalPlayer()
    local Active_Weapon
    local weaponType_Xhair


    if Get_LocalPlayer_Xhair then
        Is_Scoped_Xhair = Get_LocalPlayer_Xhair:GetProp("m_bIsScoped")
        Active_Weapon_Xhair = Get_LocalPlayer_Xhair:GetPropEntity("m_hActiveWeapon")
        weaponType_Xhair = Get_LocalPlayer_Xhair:GetWeaponType();
    end

    local Zoom_Level_Xhair
    if weaponType_Xhair == 0 or 9 or 7 then
        Zoom_Level_Xhair = ""
    else
        Zoom_Level_Xhair = Active_Weapon_Xhair:GetProp("m_zoomLevel")
    end
    

    if ForceCrosshair:GetValue() then
        if Is_Scoped_Xhair == 65536 then
            client.SetConVar('weapon_debug_spread_show', 3, true)
        elseif Is_Scoped_Xhair == 65792 then
            client.SetConVar('weapon_debug_spread_show', 3, true)
        elseif Is_Scoped_Xhair == 257 then
            client.SetConVar('weapon_debug_spread_show', 0, true)
        elseif Is_Scoped_Xhair == 1 then
            client.SetConVar('weapon_debug_spread_show', 0, true)
        else
            client.SetConVar('weapon_debug_spread_show', 3, true)
        end
    else
        client.SetConVar('weapon_debug_spread_show', 0, true)
    end

end)

--[[ Visualizes minimum damage ]]--
callbacks.Register("Draw", "MinDmgIndicators", function()
    --weaponID's
    -- 508 = knife
    -- 1 = Deagle
    -- 2 = duel barretas
    -- 3 = Five-Seven
    -- 4 = Glock
    -- 7 = AK47
    -- 9 = AWP
    -- 11 = G3SG1
    -- 13 = Galil
    -- 14 = M249
    -- 17 = MAC-10
    -- 19 = P90
    -- 23 = MP5-SD
    -- 24 = UMP
    -- 25 = XM1014
    -- 26 = PP-Bizon
    -- 28 = Negev
    -- 29 = SawOff
    -- 30 = Tec9
    -- 31 = Zues
    -- 34 = MP9
    -- 35 = Nova
    -- 36 = p250
    -- 38 = Scar20
    -- 39 = 
    -- 40 = scout/ssg08
    -- 42 = CT knife
    -- 61 = USPS
    -- 64 = R8
    -- WeaponType 0 is knifes and zues
    -- 

    --If you come to me saying this is a bad way to do this, I am aware, and it works as intended so I don't care.

    local Get_LocalPlayer_Weapon = entities.GetLocalPlayer();
    
    local mindmg = gui.GetValue("rbot.hitscan.accuracy.shared.mindamage")

if MinimumDamageIndicators:GetValue() then
    if Get_LocalPlayer_Weapon ~= nil then
        local weaponID = Get_LocalPlayer_Weapon:GetWeaponID();
        local weaponType = Get_LocalPlayer_Weapon:GetWeaponType();

    --[[ Non-Guns ]]--
        if weaponType == 0 or 9 or 7 then
            mindmg = ""
        end

    --[[ Zues ]]--
        if weaponID == 31 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.zeus.mindamage")
        end

    --[[ Light Pistols ]]--
        if weaponID == 2 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
        end
        if weaponID == 3 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
        end
        if weaponID == 36 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
        end
        if weaponID == 61 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
        end
        if weaponID == 30 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
        end
        if weaponID == 4 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
        end

    --[[ Heavy Pistols ]]--
        if weaponID == 1 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
        end
        if weaponID == 64 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
        end

    --[[ Rifles ]]--
        if weaponID == 7 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.rifle.mindamage")
        end
        if weaponID == 13 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.rifle.mindamage")
        end
        if weaponID == 39 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.rifle.mindamage")
        end

    --[[ SMGs ]]--
        if weaponID == 34 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.smg.mindamage")
        end
        if weaponID == 23 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.smg.mindamage")
        end
        if weaponID == 24 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.smg.mindamage")
        end
        if weaponID == 19 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.smg.mindamage")
        end
        if weaponID == 26 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.smg.mindamage")
        end
        if weaponID == 17 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.smg.mindamage")
        end

    --[[ Shotguns ]]--
        if weaponID == 35 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.shotgun.mindamage")
        end
        if weaponID == 25 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.shotgun.mindamage")
        end
        if weaponID == 29 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.shotgun.mindamage")
        end

    --[[ LMG ]]--
        if weaponID == 14 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.lmg.mindamage")
        end
        if weaponID == 28 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.lmg.mindamage")
        end


    --[[ Auto Snipers ]]--
        if weaponID == 11 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
        end
        if weaponID == 38 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
        end

    --[[ Scout ]]--
        if weaponID == 40 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.scout.mindamage")
        end

    --[[ AWP ]]--
        if weaponID == 9 then
            mindmg = gui.GetValue("rbot.hitscan.accuracy.sniper.mindamage")
        end

        draw.Text(965, 565, mindmg)
    end
end
end)