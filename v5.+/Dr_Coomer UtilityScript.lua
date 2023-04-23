local Font = draw.CreateFont("Bahnschrift", 20, 100)
local Ref = gui.Reference("VISUALS");
local Visuals = gui.Tab(Ref, "visuals", "aimware.pro");

local Ref2 = gui.Reference("RAGEBOT");
local Rbot = gui.Tab(Ref2, "ragebot", "aimware.pro");

local Ref3 = gui.Reference("MISC")
local Misc = gui.Tab(Ref3, "misc", "aimware.pro")


local ecb_watermark = gui.Checkbox(Visuals, "ecb_watermark", "Watermark", true);
local gap = gui.Text(Visuals, " ");

local Saturation = gui.Slider(Visuals, "Saturation", "Saturation", 1, 0, 1, 0.01);
local Value = gui.Slider(Visuals, "Value", "Value", 255, 0, 255, 1);
local Speed = gui.Slider(Visuals, "Speed", "Speed", 1, 0.01, 2, 0.01);


local gap1 = gui.Text(Visuals, " ");
local gap2 = gui.Text(Visuals, " ");


local Arms = gui.Checkbox(Visuals, "Arms", "Arms", false);
local OccludedArms = gui.Checkbox(Visuals, "OccludedArms", "Occluded Arms", false);
local AlphaArms = gui.Slider(Visuals, "ArmsAlpha", "Arms Alpha", 255, 0, 255, 1);

local gap3 = gui.Text(Visuals, " ");

local Weapon = gui.Checkbox(Visuals, "Weapon", "Weapon", false);
local OccludedWeapon = gui.Checkbox(Visuals, "OccludedWeapon", "Occluded Weapon", false);
local AlphaWeapon = gui.Slider(Visuals, "WeaponAlpha", "Weapon Alpha", 255, 0, 255, 1);

local gap4 = gui.Text(Visuals, " ");

local LocalPlayerModel = gui.Checkbox(Visuals, "LocalPlayerModel", "Local Player Model", false);
local OccludedLocal = gui.Checkbox(Visuals, "OccludedLocalModel", "Occluded Local Model", false);
local AlphaLocal = gui.Slider(Visuals, "LocalModelAlpha", "Local Model Alpha", 255, 0, 255, 1);

local gap4 = gui.Text(Visuals, " ");

local LocalPlayerGlow = gui.Checkbox(Visuals, "LocalPlayerGlow", "Local Player Glow", false);
local AlphaLocalGlow = gui.Slider(Visuals, "LocalAlphaGlow", "Local Alpha Glow", 255, 0, 255, 1);

local gap6 = gui.Text(Visuals, " ");

local LocalAttachmentsPlayer = gui.Checkbox(Visuals, "LocalAttachmentsPlayer", "Local Attachments Player", false);
local OccludedLocalAttachments = gui.Checkbox(Visuals, "OccludedLocalAttachments", "Occluded LocalAttac hments", false);
local AlphaLocalAttachments = gui.Slider(Visuals, "LocalAttachmentsAlpha", "Local Attachments Alpha", 255, 0, 255, 1);

local gap7 = gui.Text(Visuals, " ");
local gap8 = gui.Text(Visuals, " ");

local Ghost = gui.Checkbox(Visuals, "Ghost", "Ghost", false);
local OccludedGhost = gui.Checkbox(Visuals, "OccludedGhost", "Occluded Ghost", false);
local AlphaGhost = gui.Slider(Visuals, "GhostAlpha", "Ghost Alpha", 255, 0, 255, 1);

local gap9 = gui.Text(Visuals, " ");
local gap10 = gui.Text(Visuals, " ");

local LocalBulletTracer = gui.Checkbox(Visuals, "LocalBulletTracer", "Bullet Tracers", false)
local AlphaLocalTracer = gui.Slider(Visuals, "AlphaLocalTracer", "Bullet Tracer Alpha", 255, 0 ,255, 1)

-----------------------------------------[Rage Bot Start]-----------------------------------------

local DesyncJitter = gui.Checkbox(Rbot, "DesyncJitter", "Desync Jitter", false);
local DesyncJitterRange = gui.Slider(Rbot, "DesyncJitterRange", "DesyncJitterRange", 58, 0, 58, 2);
local YawJitter = gui.Checkbox(Rbot, "YawJitter", "Yaw Jitter", false);
local YawJitterRange = gui.Slider(Rbot, "Yaw", "Yaw", 165, 0, 180, 1)
YawJitterRange:SetValue(165);

local gap11 = gui.Text(Rbot, " ");
local gap12 = gui.Text(Rbot, " ");

local SlideWalkSpam = gui.Checkbox(Rbot, "SlideWalkSpam", "Slide Walk Spam", false)

local gap13 = gui.Text(Rbot, " ");
local gap14 = gui.Text(Rbot, " ");

local DT = gui.Checkbox(Rbot, "DoubleTap", "Double Tap", false)
local KnifeTeleport = gui.Checkbox(Rbot, "KnifeTeleport", "Teleport with knife", false)

local HS = gui.Checkbox(Rbot, "HideShots", "Hide Shots", false)



-----------------------------------------[Misc Start]-----------------------------------------

local AimwareSpam = gui.Checkbox(Misc, "AimwareSpam", "Chat Spam", false)

-----------------------------------------[End of GUI]-----------------------------------------


callbacks.Register("Draw", "AntiAims", function()

    if DesyncJitter:GetValue() then
        gui.SetValue("rbot.antiaim.base.rotation", DesyncJitterRange:GetValue() * math.random(-1, 1))
    end

    if YawJitter:GetValue() then
        local CenterJitter = math.floor(math.random(-1, 1))

        if CenterJitter == 0 then
            CenterJitter = -1
        end

        gui.SetValue("rbot.antiaim.base", YawJitterRange:GetValue() * CenterJitter)
    end

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
    end

end)

callbacks.Register("Draw", "Exploits", function()

    --pasted from Bleeding.lua

    local exploit_state;

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

callbacks.Register("Draw", "AimwareSpam", function()
    if AimwareSpam:GetValue() then
        local AimwareChatSpamRandomizer = math.random(0, 190)

        gui.SetValue("misc.chatspam", AimwareChatSpamRandomizer)
    end
end)

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

    if Weapon:GetValue() then
        gui.SetValue("esp.chams.localweapon.visible.clr", r, g, b, AlphaWeapon:GetValue())
            if OccludedWeapon:GetValue() then
                gui.SetValue("esp.chams.localweapon.occluded.clr", r, g, b, AlphaWeapon:GetValue())
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

callbacks.Register("Draw", "Watermark", function()
    --* Watermark
local LocalPlayerCheck1 = entities.GetLocalPlayer();

--Bs dynamic ish watermark. Also yes, bad variable name.
local x1 = 1770 --Default: 1770

if not ecb_watermark:GetValue() then return end

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

callbacks.Register("Draw", "Indicators", function()
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

    local LocalPlayer = entities.GetLocalPlayer();

    local MapName = engine.GetMapName();
    
    local mindmg = gui.GetValue("rbot.hitscan.accuracy.shared.mindamage")

if LocalPlayer ~= nil then
    local weaponID = LocalPlayer:GetWeaponID();
    local weaponType = LocalPlayer:GetWeaponType();


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
    if waepon == 17 then
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

--[[ All Knifes ]]--
    if weaponType == 0 then
        mindmg = ""
    end

    draw.Text(965, 565, mindmg)
end
end)