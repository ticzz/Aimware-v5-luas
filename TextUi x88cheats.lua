--FEEL FREE TO EDIT, IMPROVE - signed by w1ldac3--
--Dragon's Text-UI--
--Rework by w1ldac3--
--Fixed by Dragon on June 9th, 2020--

local ref = gui.Reference("Visuals")
local x88_tab = gui.Tab(ref, "x88_tab", "x88Cheats")

--GUI--
local x88_group = gui.Groupbox(x88_tab,"x88Settings",15,15, 295,400)
local x88_st = gui.Groupbox(x88_tab,"UI Settings",320,15, 295,400)
local x88_styles = gui.Groupbox(x88_tab,"Styles",15,237, 295,400)
local x88_offsets = gui.Groupbox(x88_tab,"Offsets",320,290, 295, 400 )
local x88_othr = gui.Groupbox(x88_tab,"Extra", 15,610,295,400)
local x88_info = gui.Groupbox(x88_tab,"Information", 320,735,295,400)
local ToggleMenu = gui.Checkbox(x88_group,"x88_enable", "Menu", false)
local ToggleWel = gui.Checkbox(x88_group,"x88_welcome", "Welcome!", false)
local ToggleAdvanced = gui.Checkbox(x88_st,"x88_advanced", "Advanced Mode", false)
local ToggleWM = gui.Checkbox(x88_group,"x88_watermark", "Premium Watermark", false)
local ToggleKD = gui.Checkbox(x88_st,"x88_kd","K/D", false)
local ToggleESP = gui.Checkbox(x88_st,"x88_esp","Visual Features", false)
local ToggleMisc = gui.Checkbox(x88_st,"x88_misc", "Misc Features", false)
local clr_menu = gui.ColorPicker(ToggleMenu,"x88_menu_clr", "Menu", 255,255,255,255)
local clr_wel = gui.ColorPicker(ToggleWel,"x88_wel_clr", "Welcome Message", 252,211,3,255)
local clr_wm = gui.ColorPicker(ToggleWM,"x88_wm_clr", "Watermark", 192,108,129,255)
local clr_func_off = gui.ColorPicker(x88_styles,"x88_func_clr_off", "Functions OFF", 255,255,255,255)
local clr_func_on = gui.ColorPicker(x88_styles,"x88_func_clr_on", "Functions ON", 67,144,219,255)
gui.Text(x88_styles, "SEIZURE WARNING!")
local epilepsy_menu = gui.Checkbox(x88_styles, "x88_rainbow_menu", "Rainbow Menu", false)
local epilepsy_wel = gui.Checkbox(x88_styles, "x88_rainbow_wel", "Rainbow Welcome Message", false)
local epilepsy_wm = gui.Checkbox(x88_styles, "x88_rainbow_wm", "Rainbow Watermark", false)
local epilepsy_func = gui.Checkbox(x88_styles, "x88_rainbow_func", "Rainbow Functions (v1.3)", false)
local welcome_offset_x = gui.Slider(x88_offsets, "x88_welcome_offset_x", "Welcome! Offset X", 270, 0, 700)
local welcome_offset_y = gui.Slider(x88_offsets, "x88_welcome_offset_y", "Welcome! Offset Y", 5, 0, 700)
local menu_offset_x = gui.Slider(x88_offsets, "x88_menu_offset_x", "Menu Offset X", 270, 0, 700)
local menu_offset_y = gui.Slider(x88_offsets, "x88_menu_offset_y", "Menu Offset Y", 50, 0, 700)
local wmark_offset_x = gui.Slider(x88_offsets, "x88_wmark_offset_x", "Watermark Offset X", 5, 0, 700)
local wmark_offset_y = gui.Slider(x88_offsets, "x88_wmark_offset_y", "Watermark Offset Y", 35, 0, 700)
local kd_offset_x = gui.Slider(x88_offsets, "x88_kd_offset_x", "KD Offset X", 500, 0, 700)
local kd_offset_y = gui.Slider(x88_offsets, "x88_kd_offset_y", "KD Offset Y", 5, 0, 700)
--Text in GUI--
gui.Text(x88_info, "Originally by I_Am_The_Dragon (UID: 220920)")
gui.Text(x88_info, "Reworked by w1ldac3 (UID: 217577)")
gui.Text(x88_info, "S/o to Squidoodle (UID: 305824) for helping a lot   with parts of code.")
gui.Text(x88_info, "w1ldac3 quit CS:GO (afaik) so I (Dragon) decided to fix it.")
gui.Text(x88_info, "Fixed by I_Am_The_Dragon on June 9th, 2020.")
gui.Text(x88_info, "Huge respect to all who contributed to this project  and thank you so much. - Dragon :)")
-- End - Text in GUI--
--Descriptions--
ToggleMenu:SetDescription("Shows x88cheats menu.")
ToggleWel:SetDescription("Show welcome message.")
ToggleKD:SetDescription("Shows Kills and Deaths counter.")
ToggleESP:SetDescription("Shows Visual features in menu.")
ToggleMisc:SetDescription("Shows Misc features in menu.")
ToggleWM:SetDescription("Shows premium x88 software watermark.")
ToggleAdvanced:SetDescription("Shows type of Auto-Strafe, Fake-Lag and Fake-Ping.")
epilepsy_menu:SetDescription("Draws menu in animated rainbow color.")
epilepsy_wel:SetDescription("Draws welcome msg. in animated rainbow color.")
epilepsy_wm:SetDescription("Draws watermark in animated rainbow color.")
epilepsy_func:SetDescription("Draws *OFF/ON* in animated rainbow color.")
--End - Descriptions--
--End - GUI--

local font = draw.CreateFont("Tahoma", 14, 700, {0x200})
local username = ""

local function overlay()
--RGB--
local speed = 3
    local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
    local a = 255
--END of RGB--
local x, y = 0, 0
x = x + wmark_offset_x:GetValue()
y = y + wmark_offset_y:GetValue()
	if gui.GetValue("esp.master") then
	if ToggleWM:GetValue() then
	draw.SetFont(font)
	if epilepsy_wm:GetValue()
	then
	draw.Color(r,g,b,a)
	else
    draw.Color(clr_wm:GetValue())
	end
    draw.TextShadow(x,y,"x88Cheats")
	end
	end
end

local function username()
    username = client.GetConVar( "name" )
end

local function welcome()
    --RGB--
local speed = 3
    local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
    local a = 255
--END of RGB--
local x, y = 0, 0
x = x + welcome_offset_x:GetValue()
y = y + welcome_offset_y:GetValue()
	if gui.GetValue("esp.master") then
    if ToggleWel:GetValue() then
		draw.SetFont(font)
	    if epilepsy_wel:GetValue()
	    then
	    draw.Color(r,g,b,a)
	    else
        draw.Color(clr_wel:GetValue())
	    end
        --Hello MasterLooser15!--
        draw.TextShadow(x,y,"Hello ")
        draw.TextShadow(x+35,y,username .. " :)")
    	--MADE by w1ldac3--
    	draw.TextShadow(x,y+15,"Made by w1ldac3")
    	--Credits to Dragon--
    	draw.TextShadow(x+115,y+15,"Credits to Dragon")
end
end
end
local function textui()
--RGB--
local speed = 3
    local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
    local a = 255
--END of RGB--
local x, y = 0, 0
x = x + menu_offset_x:GetValue()
y = y + menu_offset_y:GetValue()
	if gui.GetValue("esp.master") then
	if ToggleMenu:GetValue() then
	if entities.GetLocalPlayer() then
		draw.SetFont(font)
		--MENU Draws--
		if epilepsy_menu:GetValue() then
		draw.Color(r,g,b,a)
		else
		if epilepsy_menu:GetValue() then
		draw.Color(r,g,b,a)
		else
		draw.Color(clr_menu:GetValue())
		end		end
		draw.TextShadow(x,y+15,"Aimbot:")
		draw.TextShadow(x,y,"OBS mode:") 

--Aimbot Functions--
if gui.GetValue("lbot.master") then
	draw.Color(25,193,33,255)
	draw.TextShadow(x+150,y+15,"Legit")
	elseif gui.GetValue("rbot.master") then
	draw.Color(255,0,0,255)
	draw.TextShadow(x+150,y+15,"Rage")
	else
	draw.Color(clr_func_off:GetValue())
	draw.TextShadow(x+150,y+15,"OFF")
end

--LegitBot Menu--
if gui.GetValue("lbot.master") then
	if epilepsy_menu:GetValue() then
		draw.Color(r,g,b,a)
		else
		draw.Color(clr_menu:GetValue())
		end	draw.TextShadow(x,y+30,"LegitBot:")
	draw.TextShadow(x,y+45,"Backtrack:")
	draw.TextShadow(x,y+60,"Triggerbot:")
	draw.TextShadow(x,y+75,"AutoTrigger:")
	draw.TextShadow(x,y+90,"Resolver:")
	draw.TextShadow(x,y+105,"LegitAA:")

--Functions--		
	if gui.GetValue("lbot.aim.enable") then
		draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+30,"ON")
		else
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+150,y+30,"OFF")
    end
    if gui.GetValue("lbot.extra.backtrack") == 0 then
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+150,y+45,"OFF")
		elseif gui.GetValue("lbot.extra.backtrack") <= 100 then
		draw.Color(25,193,33,255)
		draw.TextShadow(x+150,y+45,"Legit")
		elseif gui.GetValue("lbot.extra.backtrack") <= 150 then
		draw.Color(255,255,0,255)
		draw.TextShadow(x+150,y+45,"Medium")
		elseif gui.GetValue("lbot.extra.backtrack") <= 200 then
		draw.Color(255,165,0,255)
		draw.TextShadow(x+150,y+45,"High")
		elseif gui.GetValue("lbot.extra.backtrack") <= 400 then
		draw.Color(255,0,0,255)
		draw.TextShadow(x+150,y+45,"MAX")
	end
    
    if gui.GetValue("lbot.trg.enable") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow( x+150,y+60, "ON")
        else
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow( x+150,y+60, "OFF")
	end
	if gui.GetValue("lbot.trg.autofire") then
		draw.Color(255,0,0,255)
		draw.TextShadow(x+150,y+75,"ON")
		else
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+150,y+75,"OFF")
	end
	if gui.GetValue("lbot.posadj.resolver") then
		draw.Color(clr_func_on:GetValue())
		draw.TextShadow(x+150,y+90,"ON")
		else
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+150,y+90,"OFF")
	end
	if string.match(tostring(gui.GetValue("lbot.antiaim.type")),"Off") then
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+150,y+105,"OFF")
		elseif string.match(tostring(gui.GetValue("lbot.antiaim.type")),"Minimum") then	
		draw.Color(25,193,33,255)
		draw.TextShadow(x+150,y+105,"Min")
		elseif string.match(tostring(gui.GetValue("lbot.antiaim.type")),"Maximum") then
	
		draw.Color(255,0,0,255)
		draw.TextShadow(x+150,y+105,"Max")
	end
end
--End of LBOT menu--
--Visuals Functions--
if ToggleESP:GetValue() then
	if epilepsy_menu:GetValue() then
		draw.Color(r,g,b,a)
		else
		draw.Color(clr_menu:GetValue())
        end	
local offyspecial = 15
if ToggleMisc:GetValue() then
    offyspecial = offyspecial + 90
end

    draw.TextShadow(x+205,y+offyspecial+15,"BOX ESP:")
	draw.TextShadow(x+205,y+offyspecial+30,"Box Precision:")
	draw.TextShadow(x+205,y+offyspecial+45,"Chams:")
	draw.TextShadow(x+205,y+offyspecial+60,"Chams XQZ:")
	draw.TextShadow(x+205,y+offyspecial+75,"BTChams:")
	draw.TextShadow(x+205,y+offyspecial+90,"BTChams XQZ:")
	draw.TextShadow(x+205,y+offyspecial+105,"Glow:")
	draw.TextShadow(x+205,y+offyspecial+120,"Player Indicators:")
	draw.TextShadow(x+205,y+offyspecial+135,"Bullet Tracers:")
if gui.GetValue("esp.overlay.enemy.box") == 0 then
	draw.Color(clr_func_off:GetValue())
	draw.TextShadow(x+355,y+offyspecial+15, "OFF")
	elseif gui.GetValue("esp.overlay.enemy.box") == 1 then
	draw.Color(clr_func_on:GetValue())
	draw.TextShadow(x+355,y+offyspecial+15, "Outlined")
	elseif gui.GetValue("esp.overlay.enemy.box") == 2 then
	draw.Color(clr_func_on:GetValue())
	draw.TextShadow(x+355,y+offyspecial+15, "Normal")
end
if gui.GetValue("esp.overlay.enemy.precision") then
	draw.Color(clr_func_on:GetValue())	
	draw.TextShadow( x+355, y+offyspecial+30, "ON")	
	else
	draw.Color(clr_func_off:GetValue())
	draw.TextShadow( x+355, y+offyspecial+30, "OFF")
end
if gui.GetValue("esp.chams.enemy.visible") == 0 then
    draw.Color(clr_func_off:GetValue())
    draw.TextShadow(x+355,y+offyspecial+45, "OFF" )
	elseif gui.GetValue("esp.chams.enemy.visible") == 1 then
	draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+45,  "Flat" )
    elseif gui.GetValue("esp.chams.enemy.visible") == 2 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+45,  "Color" )
    elseif gui.GetValue("esp.chams.enemy.visible") == 3 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+45,  "Metallic" )
    elseif gui.GetValue("esp.chams.enemy.visible") == 4 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+45,  "Glow" )
    elseif gui.GetValue("esp.chams.enemy.visible") == 5 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+45,  "Textured" )
    elseif gui.GetValue("esp.chams.enemy.visible") == 6 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+45,  "Invisible" )
end
if gui.GetValue("esp.chams.enemy.occluded") == 0 then
    draw.Color(clr_func_off:GetValue())
    draw.TextShadow(x+355,y+offyspecial+60, "OFF" )
    elseif gui.GetValue("esp.chams.enemy.occluded") == 1 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+60,  "Flat" )
    elseif gui.GetValue("esp.chams.enemy.occluded") == 2 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+60,  "Color" )
    elseif gui.GetValue("esp.chams.enemy.occluded") == 3 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+60,  "Metallic" )
    elseif gui.GetValue("esp.chams.enemy.occluded") == 4 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+60,  "Glow" )
end
if gui.GetValue("esp.chams.backtrack.visible") == 0 then
    draw.Color(clr_func_off:GetValue())
    draw.TextShadow(x+355,y+offyspecial+75, "OFF" )
    elseif gui.GetValue("esp.chams.backtrack.visible") == 1 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+75,  "Flat" )
    elseif gui.GetValue("esp.chams.backtrack.visible") == 2 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+75,  "Color" )
    elseif gui.GetValue("esp.chams.backtrack.visible") == 3 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+75,  "Metallic" )
    elseif gui.GetValue("esp.chams.backtrack.visible") == 4 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+75,  "Glow" )
    elseif gui.GetValue("esp.chams.backtrack.visible") == 5 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+75,  "Textured" )
    elseif gui.GetValue("esp.chams.backtrack.visible") == 6 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+75,  "Invisible" )
end

if gui.GetValue("esp.chams.backtrack.occluded") == 0 then
    draw.Color(clr_func_off:GetValue())
    draw.TextShadow(x+355,y+offyspecial+90, "OFF" )
    elseif gui.GetValue("esp.chams.backtrack.occluded") == 1 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+90,  "Flat" )
    elseif gui.GetValue("esp.chams.backtrack.occluded") == 2 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+90,  "Color" )
    elseif gui.GetValue("esp.chams.backtrack.occluded") == 3 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+90,  "Metallic" )
    elseif gui.GetValue("esp.chams.backtrack.occluded") == 4 then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+90,  "Glow" )
end
if gui.GetValue("esp.chams.enemy.glow") == 0 then
	draw.Color(clr_func_off:GetValue())
	draw.TextShadow(x+355,y+offyspecial+105,"OFF")
	elseif gui.GetValue("esp.chams.enemy.glow") == 1 then
	draw.Color(clr_func_on:GetValue())
	draw.TextShadow(x+355,y+offyspecial+105,"Team")
	elseif gui.GetValue("esp.chams.enemy.glow") == 2 then
	draw.Color(0,255,0,255)
	draw.TextShadow(x+355,y+offyspecial+105,"Health")
end
if gui.GetValue("esp.local.outofview") then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+offyspecial+120, "ON")
    else
    draw.Color(clr_func_off:GetValue())
    draw.TextShadow(x+355,y+offyspecial+120, "OFF")
end
if gui.GetValue("esp.world.bullettracer") == 0 then
	draw.Color(clr_func_off:GetValue())
	draw.TextShadow(x+355,y+offyspecial+135, "OFF")
	elseif gui.GetValue("esp.world.bullettracer") == 1 then
	draw.Color(clr_func_on:GetValue())
	draw.TextShadow(x+355,y+offyspecial+135, "Latest")
	elseif gui.GetValue("esp.world.bullettracer") == 2 then
	draw.Color(clr_func_on:GetValue())
	draw.TextShadow(x+355,y+offyspecial+135, "All")
end
end
--End of Visuals--
--Misc Functions--
if ToggleMisc:GetValue() then
	if epilepsy_menu:GetValue() then
		draw.Color(r,g,b,a)
		else
		draw.Color(clr_menu:GetValue())
        end	
    draw.TextShadow(x+205,y+15,"Auto-Strafe:")
	draw.TextShadow(x+205,y+30,"Bunny-Hop:")
	draw.TextShadow(x+205,y+45,"FakeLag:")
	draw.TextShadow(x+205,y+60,"Fake PING:")
	draw.TextShadow(x+205,y+75,"Hitsound:")
	draw.TextShadow(x+205,y+90,"Hitmarker:")
	draw.TextShadow(x+205,y+105,"Clantag:")
if gui.GetValue("misc.strafe.enable") then
    draw.Color(clr_func_on:GetValue())
    draw.TextShadow(x+355,y+15, "ON" )
	else
    draw.Color(clr_func_off:GetValue())
    draw.TextShadow(x+355,y+15, "OFF")
        
end
if ToggleAdvanced:GetValue() then
if gui.GetValue("misc.strafe.enable") then
	draw.Color(clr_func_off:GetValue())
	draw.TextShadow(x+380,y+15, "|")
    if string.match(tostring(gui.GetValue("misc.strafe.mode")), "Silent") then
    draw.Color(255,0,0,255)
	draw.TextShadow(x+390,y+15, " SILENT")
	elseif string.match(tostring(gui.GetValue("misc.strafe.mode")), "Normal") then
    draw.Color(255,255,0,255)
	draw.TextShadow(x+390,y+15, " NORMAL")
	elseif string.match(tostring(gui.GetValue("misc.strafe.mode")), "Sideways") then
    draw.Color(255,255,0,255)
	draw.TextShadow(x+390,y+15, " SIDEWAYS")
	elseif string.match(tostring(gui.GetValue("misc.strafe.mode")), "W-Only") then
    draw.Color(255,255,0,255)
	draw.TextShadow(x+390,y+15, " W")
	elseif string.match(tostring(gui.GetValue("misc.strafe.mode")), "Mouse") then
    draw.Color(25,193,33,255)
	draw.TextShadow(x+390,y+15, " MOUSE")

end
end
end
	if string.match(tostring(gui.GetValue("misc.autojump")), "Off") then
    draw.Color(clr_func_off:GetValue())
    draw.TextShadow(x+355,y+30, 'OFF')
    elseif string.match(tostring(gui.GetValue("misc.autojump")), "Perfect") then
    draw.Color(255,255,0,255)
    draw.TextShadow(x+355,y+30, 'Perfect')
    elseif string.match(tostring(gui.GetValue("misc.autojump")), "Legit") then
    draw.Color(25,193,33,255)
	draw.TextShadow(x+355,y+30, 'Legit')
end   
    if gui.GetValue("misc.fakelag.enable") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+355,y+45, "ON")
        else
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+355,y+45, "OFF")
end
if ToggleAdvanced:GetValue() then
if gui.GetValue("misc.fakelag.enable") then
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+380,y+45, "|")
		if gui.GetValue("misc.fakelag.type") == 0 then 
		draw.Color(25,193,33,255)
		draw.TextShadow(x+390,y+45, " NORMAL")
		elseif gui.GetValue("misc.fakelag.type") == 1 then
		draw.Color(255,0,0,255)
		draw.TextShadow(x+390,y+45, " ADAPTIVE")
		elseif gui.GetValue("misc.fakelag.type") == 2 then
		draw.Color(255,165,0,255)
		draw.TextShadow(x+390,y+45, " RANDOM")
		elseif gui.GetValue("misc.fakelag.type") == 3 then
		draw.Color(255,165,0,255)
		draw.TextShadow(x+390,y+45, " SWITCH")
end
if gui.GetValue("misc.fakelag.peek") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+455,y+45, "+ ON PEEK")
end
end    
    end
        if gui.GetValue("misc.fakelatency.enable") then
		draw.Color(clr_func_on:GetValue())
		draw.TextShadow(x+355,y+60, "ON")
        else
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+355,y+60, "OFF")	
end
if ToggleAdvanced:GetValue() then		
if gui.GetValue("misc.fakelatency.enable") then
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+380,y+60, "|")
		if gui.GetValue("misc.fakelatency.amount") == 0 then
        draw.Color(255,255,255)
        draw.TextShadow(x+390,y+60, "  0")
        elseif gui.GetValue("misc.fakelatency.amount") <= 100 then
        draw.Color( 25, 193, 33, 255 )
        draw.TextShadow(x+390,y+60, "  LOW")
		elseif gui.GetValue("misc.fakelatency.amount") <= 350 then
        draw.Color( 255, 255, 0, 255 )
        draw.TextShadow(x+390,y+60, "  MEDIUM")
		elseif gui.GetValue("misc.fakelatency.amount") <= 700 then
        draw.Color( 255, 165, 0, 255 )
        draw.TextShadow(x+390,y+60, "  HIGH")
		elseif gui.GetValue("misc.fakelatency.amount") <= 1000 then
        draw.Color( 255, 0, 0, 255 )
        draw.TextShadow(x+390,y+60, "  MAX")

    end
end
end
        if gui.GetValue("esp.world.hiteffects.sound") then
		draw.Color(25,193,33,255)
		draw.TextShadow(x+355,y+75, 'ON')
		else
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+355,y+75, 'OFF')
end   
        if gui.GetValue("esp.world.hiteffects.marker") then
		draw.Color(25,193,33,255)
		draw.TextShadow(x+355,y+90, 'ON')
		else
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+355,y+90, 'OFF')
end  
        if gui.GetValue("misc.clantag") then
        draw.Color(255,0,0)
        draw.TextShadow(x+355,y+105, "ON")
        else
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+355,y+105, "OFF")
    end
end
--End of Misc-- 
--RageBot Menu-- 
        if gui.GetValue("rbot.master") then
--UI--
if epilepsy_menu:GetValue() then
		draw.Color(r,g,b,a)
		else
		draw.Color(clr_menu:GetValue())
		end draw.TextShadow(x,y+30,"RageBot:")
draw.TextShadow(x,y+45, "Silent Aim:") 
draw.TextShadow(x,y+60, "Resolver:")       
draw.TextShadow(x,y+75, "Backtrack:")   
draw.TextShadow(x,y+90, "Rapid-Fire:") --Double-Tap 
draw.TextShadow(x,y+105, "AA Pitch:")
draw.TextShadow(x,y+120,"AA Yaw:")
draw.TextShadow(x,y+135,"KnifeBot:")
--Functions--
		if gui.GetValue("rbot.aim.enable") then
		draw.Color(255,0,0,255)
		draw.TextShadow(x+150,y+30,"ON")
		else
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+150,y+30,"OFF")
	end
        if gui.GetValue("rbot.aim.target.silentaim") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+45, "ON")
        else
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+150,y+45, "OFF")
    end
        if gui.GetValue("rbot.accuracy.posadj.resolver") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+60, "ON")
        else
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+150,y+60, "OFF")
    end
        if gui.GetValue("rbot.accuracy.posadj.backtrack") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+75, "ON" )
        else
        draw.Color (clr_func_off:GetValue())
        draw.TextShadow(x+150,y+75, "OFF")
    end
        if gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") == 0 then
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+150,y+90, "OFF")
        elseif gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") == 1 then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+90, "SHIFT")
        elseif gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") == 2 then
        draw.Color(clr_func_on:GetValue())
		draw.TextShadow(x+150,y+90, "RAPID")
		elseif gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") == 3 then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+145,y+90, "RAPID FC")
    end
        if gui.GetValue("rbot.antiaim.advanced.pitch") == 0 then
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+150,y+105, "OFF")
        elseif gui.GetValue("rbot.antiaim.advanced.pitch") == 1 then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+105, "89`")
        elseif gui.GetValue("rbot.antiaim.advanced.pitch") == 2 then
        draw.Color(255,0,0,255)
        draw.TextShadow(x+150,y+105, "180`")
end
		if string.match(tostring(gui.GetValue("rbot.antiaim.base")), "Off") then
		draw.Color(clr_func_off:GetValue())
		draw.TextShadow(x+150,y+120,"OFF")
		elseif string.match(tostring(gui.GetValue("rbot.antiaim.base")), "Backward") then
		draw.Color(clr_func_on:GetValue())
		draw.TextShadow(x+150,y+120,"Back")
		elseif string.match(tostring(gui.GetValue("rbot.antiaim.base")), "Spinbot") then
		draw.Color(clr_func_on:GetValue())
		draw.TextShadow(x+150,y+120,"Spin")
		elseif string.match(tostring(gui.GetValue("rbot.antiaim.base")), "Desync") then
		draw.Color(clr_func_on:GetValue())
		draw.TextShadow(x+150,y+120,"Sync")
		elseif string.match(tostring(gui.GetValue("rbot.antiaim.base")), "Desync Jitter") then
		draw.Color(clr_func_on:GetValue())
		draw.TextShadow(x+150,y+120,"JitterSync")
--IDK why Desync Jitter is not drawing JitterSync :(--
--Prob bc it just found match string Desync and then draws only SYNC--

end
		if string.match(tostring(gui.GetValue("rbot.aim.extra.knife")), "Off") then
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+150,y+135,"OFF")
        elseif string.match(tostring(gui.GetValue("rbot.aim.extra.knife")), "Default Knifebot") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+135,"Default")
        elseif string.match(tostring(gui.GetValue("rbot.aim.extra.knife")), "Only Backstab") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+135,"TF2 Spy")
        elseif string.match(tostring(gui.GetValue("rbot.aim.extra.knife")), "Quick Stab") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y+135,"Quick")
end
end
--End of Ragebot Menu--
		if gui.GetValue("esp.other.antiobs") then
        draw.Color(clr_func_on:GetValue())
        draw.TextShadow(x+150,y,"ON")
        else
        draw.Color(clr_func_off:GetValue())
        draw.TextShadow(x+150,y,"OFF")
    end
end
end
end
end
--End of Menu--
--Functions of Kills\Deaths--
local function getKdr(ply)
    local e = entities.GetPlayerResources()
    local index = ply:GetIndex()

    return e:GetPropInt('m_iKills', client.GetLocalPlayerIndex()) / e:GetPropInt('m_iDeaths', client.GetLocalPlayerIndex())
end
function kills_deaths()
local x, y = 0, 0
menu_x = x + menu_offset_x:GetValue()
menu_y = y + menu_offset_y:GetValue()
x = x + kd_offset_x:GetValue()
y = y + kd_offset_y:GetValue()
if gui.GetValue("esp.master") then
if ToggleKD:GetValue() then
if entities.GetLocalPlayer() then
	draw.SetFont(font)
	--Kills&Deaths--
	draw.Color(255,100,0,255)
	draw.TextShadow(x,y,"Kills:")
	draw.Color(255,50,50,255)
	draw.TextShadow(x,y+15,"Deaths:")
	--kills
    draw.Color(255, 255, 255, 255)
    draw.TextShadow(x+35, y, entities.GetPlayerResources():GetPropInt('m_iKills', client.GetLocalPlayerIndex()
))
    --deaths
    draw.Color(255, 255, 255, 255)
    draw.TextShadow(x+50, y+15, entities.GetPlayerResources():GetPropInt('m_iDeaths', client.GetLocalPlayerIndex()))
end
end
end
end
--End--
--Viemodel FOV Changer--
 visuals_menu = gui.Reference("Visuals", "x88Misc")
 custom_viewmodel_editor = gui.Checkbox(x88_othr, "x88_viewmodel_editor", "Custom Viewmodel Editor", 0 );
 xO = client.GetConVar("viewmodel_OFFset_x"); 
 yO = client.GetConVar("viewmodel_OFFset_y"); 
 zO = client.GetConVar("viewmodel_OFFset_z");
 fO = client.GetConVar("viewmodel_fov");
 xS = gui.Slider(x88_othr, "vm_x", "X", xO, -20, 20);
 yS = gui.Slider(x88_othr, "vm_y", "Y", yO, -100, 100);
 zS = gui.Slider(x88_othr, "vm_z", "Z", zO, -20, 20);
 vfov = gui.Slider(x88_othr, "vfov", "Viewmodel FOV", fO, 0, 120);
 
local function Visuals_Viewmodel()

   if custom_viewmodel_editor:GetValue() then 
client.SetConVar("viewmodel_OFFset_x", xS:GetValue(), true);
client.SetConVar("viewmodel_OFFset_y", yS:GetValue(), true);
client.SetConVar("viewmodel_OFFset_z", zS:GetValue(), true);
client.SetConVar("viewmodel_fov", vfov:GetValue(), true);
   end
   end
local function Visuals_Disable_Post_Processing()
       if visuals_disable_post_processing:GetValue() then 
           client.SetConVar( "mat_postprocess_enable", 0, true );
   else
       client.SetConVar( "mat_postprocess_enable", 1, true );
       end
   end
--End of Viewmodel changer--
--SimpleSpeclist by Cheeseot
local specshit = gui.Reference( "Visuals", "x88Cheats", "Extra")
local BetterSpecBox = gui.Checkbox( specshit, "betterspec", "Simple spectator list", false )
BetterSpecBox:SetDescription("Position based on default spectator window.")

function betterspec()
local sorting = 0
local specpos1, specpos2 = gui.GetValue("spectators")
	if BetterSpecBox:GetValue() then
	gui.SetValue("misc.showspec", 0)
	local lp = entities.GetLocalPlayer()
		if lp ~= nil then
			for i, v in ipairs(entities.FindByClass("CCSPlayer")) do
			local player = v
				if player ~= lp and not player:IsAlive() then
				local name = player:GetName()
					if player:GetPropEntity("m_hObserverTarget") ~= nil then
					local playerindex = player:GetIndex()
					local botcheck = client.GetPlayerInfo(playerindex)
						if not botcheck["IsGOTV"] then
						local target = player:GetPropEntity("m_hObserverTarget");
							if target:IsPlayer() then
							local targetindex = target:GetIndex()
							local myindex = client.GetLocalPlayerIndex()
								if lp:IsAlive() then
									if targetindex == myindex then
									draw.SetFont(font)
									draw.Color(255,255,255,255)
									draw.Text( specpos1, specpos2 + (sorting * 16), name )
									draw.TextShadow( specpos1, specpos2 + (sorting * 16), name )
									sorting = sorting + 1
									end
								end	
								if not lp:IsAlive() then
									if lp:GetPropEntity("m_hObserverTarget") ~= nil then
									local myspec = lp:GetPropEntity("m_hObserverTarget")
									local myspecindex = myspec:GetIndex()
									if targetindex == myspecindex then
									draw.SetFont(font)
									draw.Color(255,255,255,255)
									draw.Text( specpos1, specpos2 + (sorting * 16), name )
									draw.TextShadow( specpos1, specpos2 + (sorting * 16), name )
									sorting = sorting + 1
									end
								end
								end
							end
						end
					end
				end
			end
		end
	end
end	
callbacks.Register ("Draw", "betterspec", betterspec)
--SimpleSpeclist by Cheeseot
--Recoil Crosshair by Cheeseot
local PunchCheckbox = gui.Checkbox(x88_othr, "recoilcrosshair", "Recoil Crosshair", 0 );
local recoilcolor = gui.ColorPicker(PunchCheckbox, "recoilcolor", "Recoil Crosshair Color", 255,255,255,255)
local IdleCheckbox = gui.Checkbox(x88_othr, "_recoilidle", "Crosshair only while recoil", 0 );

PunchCheckbox:SetDescription("Shows a nice little crosshair with recoil.")
IdleCheckbox:SetDescription("Shows recoil crosshair only while recoil presented.")

local function punch()

local rifle = 0;
local me = entities.GetLocalPlayer();
if me ~= nil and not gui.GetValue("rbot.master") then
    if me:IsAlive() then
    local scoped = me:GetProp("m_bIsScoped");
    if scoped == 256 then scoped = 0 end
    if scoped == 257 then scoped = 1 end
    local my_weapon = me:GetPropEntity("m_hActiveWeapon");
    if my_weapon ~=nil then
        local weapon_name = my_weapon:GetClass();
        local canDraw = 0;
        local snipercrosshair = 0;
        weapon_name = string.gsub(weapon_name, "CWeapon", "");
        if weapon_name == "Aug" or weapon_name == "SG556" then
            rifle = 1;
            else
            rifle = 0;
            end

        if scoped == 0 or (scoped == 1 and rifle == 1) then
            canDraw = 1;
            else
            canDraw = 0;
            end

        if weapon_name == "Taser" or weapon_name == "CKnife" then
            canDraw = 0;
            end

        if weapon_name == "AWP" or weapon_name == "SCAR20" or weapon_name == "G3SG1"  or weapon_name == "SSG08" then
            snipercrosshair = 1;
            end

    --Recoil Crosshair by Cheeseot

        if PunchCheckbox:GetValue() and canDraw == 1 then
            local punchAngleVec = me:GetPropVector("localdata", "m_Local", "m_aimPunchAngle");
            local punchAngleX, punchAngleY = punchAngleVec.x, punchAngleVec.y
            local w, h = draw.GetScreenSize();
            local x = w / 2;
            local y = h / 2;
            local fov = 90 --gui.GetValue("vis_view_fov");      polak pls add this back

            if fov == 0 then
                fov = 90;
                end
            if scoped == 1 and rifle == 1 then
                fov = 45;
                end
            
            local dx = w / fov;
            local dy = h / fov;
			
			local px = 0
			local py = 0
			
            if gui.GetValue("esp.other.norecoil") then
				px = x - (dx * punchAngleY)*1.2;
				py = y + (dy * punchAngleX)*2;
            else
				px = x - (dx * punchAngleY)*0.6;
				py = y + (dy * punchAngleX);
			end
            
            if px > x-0.5 and px < x then px = x end
            if px < x+0.5 and px > x then px = x end
            if py > y-0.5 and py < y then py = y end
            if py < y+0.5 and py > y then py = y end

			if IdleCheckbox:GetValue() then
            if px == x and py == y and snipercrosshair ~=1 then return; end
			end
				
            draw.Color(recoilcolor:GetValue());
            draw.FilledRect(px-3, py-1, px+3, py+1);
            draw.FilledRect(px-1, py-3, px+1, py+3);
            end
        end
    end
    end
end
callbacks.Register("Draw", "punch", punch);
--Recoil Crosshair by Cheeseot
--Callbacks\Listeners--
client.AllowListener( "player_death" )
client.AllowListener( "client_disconnect" )
client.AllowListener( "begin_new_match" )
callbacks.Register( "FireGameEvent", "KillDeathCount", KillDeathCount)
callbacks.Register("Draw", "Custom Viewmodel Editor", Visuals_Viewmodel)
callbacks.Register("Draw", "username", username)
callbacks.Register("Draw", "guitoggles", guitoggles)
callbacks.Register("Draw", "kills_deaths", kills_deaths)
callbacks.Register( "Draw", "overlay", overlay )
callbacks.Register( "Draw", "welcome", welcome )
callbacks.Register( "Draw", "textui", textui )