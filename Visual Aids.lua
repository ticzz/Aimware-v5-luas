--[[
	Created by: yu0r
		( https://aimware.net/forum/thread-86012.html )
	Edited by: zack
]]

local SetValue, random = gui.SetValue, math.random

local A = {
	"clr_chams_ct_invis", "clr_chams_ct_vis",
	"clr_chams_ghost_client", "clr_chams_ghost_server",
	"clr_chams_hands_primary", "clr_chams_hands_secondary",
	"clr_chams_historyticks",
	"clr_chams_other_invis", "clr_chams_other_vis",
	"clr_chams_t_invis", "clr_chams_t_vis",
	"clr_chams_weapon_primary", "clr_chams_weapon_secondary",
	"clr_esp_bar_ammo1", "clr_esp_bar_ammo2",
	"clr_esp_bar_armor1", "clr_esp_bar_armor2",
	"clr_esp_bar_health1", "clr_esp_bar_health2",
	"clr_esp_bar_lbytimer1", "clr_esp_bar_lbytimer2",
	"clr_esp_box_ct_invis", "clr_esp_box_ct_vis",
	"clr_esp_box_other_invis", "clr_esp_box_other_vis",
	"clr_esp_box_t_invis", "clr_esp_box_t_vis",
	"clr_esp_crosshair", "clr_esp_crosshair_recoil",
	"clr_esp_outofview",
	"clr_gui_button_clicked", "clr_gui_button_hover", "clr_gui_button_idle", "clr_gui_button_outline",
	"clr_gui_checkbox_off", "clr_gui_checkbox_off_hover", "clr_gui_checkbox_on", "clr_gui_checkbox_on_hover",
	"clr_gui_combobox_drop1", "clr_gui_combobox_drop2", "clr_gui_combobox_drop3",
	"clr_gui_controls1", "clr_gui_controls2", "clr_gui_controls3",
	"clr_gui_groupbox_background", "clr_gui_groupbox_outline", "clr_gui_groupbox_scroll",
	"clr_gui_hover",
	"clr_gui_listbox_active", "clr_gui_listbox_background", "clr_gui_listbox_outline", "clr_gui_listbox_select",
	"clr_gui_slider_bar1", "clr_gui_slider_bar2", "clr_gui_slider_bar3", "clr_gui_slider_button",
	"clr_gui_tablist1", "clr_gui_tablist2", "clr_gui_tablist3", "clr_gui_tablist4",
	"clr_gui_text1", "clr_gui_text2",
	"clr_gui_window_background",
	"clr_gui_window_footer", "clr_gui_window_footer_text",
	"clr_gui_window_header", "clr_gui_window_header_tab1", "clr_gui_window_header_tab2",
	"clr_gui_window_logo1", "clr_gui_window_logo2",
	"clr_misc_hitmarker"
}

local B = {
	"esp_enemy_box",
	"esp_team_box",
	"esp_other_box",
	"esp_weapon_box",
	"esp_self_box",
	"vis_chams_hands",
	"vis_skybox"
}

local C = {
	'esp_enemy_chams',
	'esp_team_chams',
	'esp_other_chams',
	'esp_weapon_chams',
	'esp_self_chams'
}

local a = 255
callbacks.Register("Draw", function()
	for i=1, #A do
		local r, g, b = random(255), random(255), random(255)
		SetValue(A[i], r, g, b, a)
		SetValue(B[i], random(1, 6))
		SetValue(C[i], random(1, 7))
	end

	SetValue("esp_crosshair_recoil", random(1,2))
	SetValue("vis_bullet_tracer", 1)
	SetValue("vis_chams_weapon", random(1,17))
end)
