--Inspired by zack´s [https://aimware.net/forum/user-36169.html] 'always esp on dead.lua' [https://aimware.net/forum/thread/86414]

--Mainly usage is for Legit Gameplay

--Turns Visuals on when dead 		(to get infos for teammates (but Legit player shouldnt know too much ;P ))
--Turns Visuals off when alive 		(exept the Visuals for Chams of visible Enemys will stay on)
--If alive but need/want some extra infos for easier clutches just tap your wallhackkey from time to time :D (onHold key)

-- DeadESP (This version only works with the default Chams provided by Aimware.net atm)

local x,y = 0,0

local visual_refs = gui.Reference("VISUALS");
local deadesp_tab = gui.Tab(visual_refs, "deadesp.tab", "DeadESP")
local deadesp_group = gui.Groupbox(deadesp_tab, "DeadESP")
local deadesp_wallhack_key = gui.Keybox(deadesp_group, "wallhackkey", "DeadESP Holdkey", false); -- Box to set a hold-key to enable enemy.occluded chams aka Wallhack
deadesp_wallhack_key:SetDescription("Turn on Chams thru Wallz while alive");
local deadesp_chams_on_tggl = gui.Combobox(deadesp_group, 'deadespontgglchams_combobox', 'DeadESP Chams on hold', 'Off', 'Flat', 'Color', 'Metallic', 'Glow' ) -- Box to change WallhackChams Mode onthefly
deadesp_chams_on_tggl:SetDescription("Chams used for Wallhack on hold")
local deadesp_chams_while_spec = gui.Combobox(deadesp_group, 'deadesp_chams_while_spec_combobox', 'DeadESP Chams while Spectating', 'Off', 'Flat', 'Color', 'Metallic', 'Glow' ) -- Change Wallhack ChamsMode onthefly
deadesp_chams_while_spec:SetDescription("Chams used for Wallhack when spectator")
local wh_chams_indicators_clr = gui.ColorPicker(deadesp_group, "wh.chams.ind.color", "WH Chams Indicators Color", 180,0,0,255)
local xposi = gui.Slider(deadesp_group, "xposi", "X Position", 15, 0, x)
xposi:SetDescription("Sets X Screenposition for the Indicator")
local yposi = gui.Slider(deadesp_group, "yposi", "Y Position", y/2, 0, y)
yposi:SetDescription("Sets Y Screenposition for the Indicator")
gui.Text(deadesp_group, "Created by ticzz | aka KriZz87")
gui.Text(deadesp_group, "https://github.com/ticzz/Aimware-v5-luas/blob/master/DeadESP.lua" )
player = entities.GetLocalPlayer()
setFont = draw.SetFont
color = draw.Color
text = draw.TextShadow
font = draw.CreateFont("Tahoma", 15, 700)



local function DeadESP() 

local x,y = draw.GetScreenSize()
local player = entities.GetLocalPlayer()
setFont(font)


if player == nil or NULL then
return

else 
if player:IsAlive() == true and (deadesp_wallhack_key:GetValue() ~= nil or false) and input.IsButtonDown(deadesp_wallhack_key:GetValue()) then -------------- Alive, holding down the wh-key
gui.SetValue("esp.chams.enemy.occluded", deadesp_chams_on_tggl:GetValue())
color(wh_chams_indicators_clr:GetValue())
text(xposi:GetValue(),yposi:GetValue(), "WallhackChams onPress ON")



elseif player:IsAlive() == true and not input.IsButtonDown(deadesp_wallhack_key:GetValue()) then ---------------------------------------------------------------- Alive, no onHoldkey active
            
gui.SetValue("esp.overlay.enemy.name", false)
gui.SetValue("esp.chams.enemy.occluded", false)
gui.SetValue("esp.chams.enemy.visible", "2")
gui.SetValue("esp.chams.enemy.overlay", false)
gui.SetValue("esp.chams.enemyattachments.occluded", false)
gui.SetValue("esp.chams.enemyattachments.visible", false)
gui.SetValue("esp.chams.enemyattachments.overlay", false)
gui.SetValue("esp.chams.friendlyattachments.occluded", false)
gui.SetValue("esp.chams.friendlyattachments.visible", false)
gui.SetValue("esp.chams.friendlyattachments.overlay", false)
gui.SetValue("esp.overlay.enemy.scoped", false)
gui.SetValue("esp.overlay.enemy.reloading", false)
gui.SetValue("esp.overlay.enemy.health.healthnum", false)
gui.SetValue("esp.overlay.enemy.health.healthbar", false)
gui.SetValue("esp.overlay.enemy.weapon", false)
gui.SetValue("esp.overlay.enemy.box", false)
gui.SetValue("esp.overlay.enemy.hasdefuser", false)
gui.SetValue("esp.overlay.enemy.hasc4", false)
gui.SetValue("esp.overlay.weapon.ammo", false)
gui.SetValue("esp.overlay.enemy.barrel", false)
gui.SetValue("esp.overlay.enemy.armor", false)


elseif player:IsAlive() == false then --------------------------------------------------------------------------------------------------------------------------- simply dead and spectating someone

gui.SetValue("esp.overlay.enemy.name", true)
gui.SetValue("esp.chams.enemy.occluded", deadesp_chams_while_spec:GetValue())
gui.SetValue("esp.chams.enemy.visible", "2")
gui.SetValue("esp.chams.enemy.overlay", "1")
gui.SetValue("esp.chams.enemyattachments.occluded", false)
gui.SetValue("esp.chams.enemyattachments.visible", false)
gui.SetValue("esp.chams.enemyattachments.overlay", false)
gui.SetValue("esp.chams.friendlyattachments.occluded", false)
gui.SetValue("esp.chams.friendlyattachments.visible", false)
gui.SetValue("esp.chams.friendlyattachments.overlay", false)
gui.SetValue("esp.overlay.enemy.scoped", false)
gui.SetValue("esp.overlay.enemy.reloading", false)
gui.SetValue("esp.overlay.enemy.health.healthnum", false)
gui.SetValue("esp.overlay.enemy.health.healthbar", true)
gui.SetValue("esp.overlay.enemy.weapon", "1")
gui.SetValue("esp.overlay.enemy.box", false)
gui.SetValue("esp.overlay.enemy.hasdefuser", true)
gui.SetValue("esp.overlay.enemy.hasc4", true)
gui.SetValue("esp.overlay.enemy.barrel", false)
gui.SetValue("esp.overlay.enemy.armor", "1")


end 
end
end



callbacks.Register( "Draw", DeadESP );