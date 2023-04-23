local client_console_cmd = client.Command
local ui_new_button = gui.Button

local function fuckcrosshair()
client_console_cmd("cl_crosshair_drawoutline 0")
client_console_cmd("cl_crosshair_dynamic_maxdist_splitratio 0.35")
client_console_cmd("cl_crosshair_dynamic_splitalpha_innermod 1")
client_console_cmd("cl_crosshair_dynamic_splitalpha_outermod 0.5")
client_console_cmd("cl_crosshair_dynamic_splitdist 7")
client_console_cmd("cl_crosshair_friendly_warning 1")
client_console_cmd("cl_crosshair_outlinethickness 0.500000")
client_console_cmd("cl_crosshair_sniper_show_normal_inaccuracy 0")
client_console_cmd("cl_crosshair_sniper_width 1")
client_console_cmd("cl_crosshair_t 0")
client_console_cmd("cl_crosshairalpha 255.000000")
client_console_cmd("cl_crosshaircolor 5")
client_console_cmd("cl_crosshaircolor_b 0.000000")
client_console_cmd("cl_crosshaircolor_g 0.000000")
client_console_cmd("cl_crosshaircolor_r 0.000000")
client_console_cmd("cl_crosshairdot 1")
client_console_cmd("cl_crosshairgap -5.000000")
client_console_cmd("cl_crosshairgap_useweaponvalue 0")
client_console_cmd("cl_crosshairsize 1000000")
client_console_cmd("cl_crosshairstyle 4")
client_console_cmd("cl_crosshairthickness 100000")
client_console_cmd("cl_crosshairusealpha 1")
client_console_cmd("cl_fixedcrosshairgap -10")
client_console_cmd("play commander/train_bodydamageheadshot_04.wav, true")
end

local function normalcrosshair()
client_console_cmd("cl_crosshair_drawoutline 1")
client_console_cmd("cl_crosshair_dynamic_maxdist_splitratio 0.35")
client_console_cmd("cl_crosshair_dynamic_splitalpha_innermod 1")
client_console_cmd("cl_crosshair_dynamic_splitalpha_outermod 0.5")
client_console_cmd("cl_crosshair_dynamic_splitdist 7")
client_console_cmd("cl_crosshair_friendly_warning 0")
client_console_cmd("cl_crosshair_outlinethickness 0")
client_console_cmd("cl_crosshair_sniper_show_normal_inaccuracy 0")
client_console_cmd("cl_crosshair_sniper_width 2")
client_console_cmd("cl_crosshair_t 0")
client_console_cmd("cl_crosshairalpha 255")
client_console_cmd("cl_crosshaircolor 5")
client_console_cmd("cl_crosshaircolor_b 0")
client_console_cmd("cl_crosshaircolor_g 255")
client_console_cmd("cl_crosshaircolor_r 125")
client_console_cmd("cl_crosshairdot 0")
client_console_cmd("cl_crosshairgap -1")
client_console_cmd("cl_crosshairgap_useweaponvalue 0")
client_console_cmd("cl_crosshairsize 3")
client_console_cmd("cl_crosshairstyle 4")
client_console_cmd("cl_crosshairthickness 0.5")
client_console_cmd("cl_crosshairusealpha 0")
client_console_cmd("cl_fixedcrosshairgap 3")
client_console_cmd("play commander/train_bodydamageheadshot_04.wav, true")
end



local fuckcrosshairbutton = gui.Button(gui.Reference("Misc", "General", "Bypass"), "Fuck crosshair", fuckcrosshair)


local normalcrosshairbutton = gui.Button(gui.Reference("Misc", "General", "Bypass"), "Normal crosshair", normalcrosshair)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

