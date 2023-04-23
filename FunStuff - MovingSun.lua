local LUA_menu_MISC = gui.Reference("SETTINGS", "MISCELLANEOUS")
gui.Text(LUA_menu_MISC, "	")
local LUA_sun_mover = gui.Groupbox(LUA_menu_MISC, "~ Sun Position Manipulator ~")
local sunmove_enable = gui.Checkbox(LUA_sun_mover, "Lua_sun_enable", "Lua_sun_enable", 0)
local LUA_sun_slider_x = gui.Slider(LUA_sun_mover, "LUA_sun_slider_x", "Sun Controll X", 0, -180, 180)
local LUA_sun_slider_y = gui.Slider(LUA_sun_mover, "LUA_sun_slider_y", "Sun Controll Y", 0, -180, 180)
local LUA_sun_slider_z = gui.Slider(LUA_sun_mover, "LUA_sun_slider_z", "Sun Controll Z", 0, -180, 180)
local sun
local controll_x
local controll_y
local controll_z
local function sun_stuff()
if (sunmove_enable:GetValue() == true) then

  sun = entities.FindByClass("CCascadeLight")[1]
   if sun ~= nil then
      controll_x = gui.GetValue("LUA_sun_slider_x")
      controll_y = gui.GetValue("LUA_sun_slider_y")
      controll_z = gui.GetValue("LUA_sun_slider_z")
      sun:SetPropVector({controll_x,controll_y,controll_z},"m_envLightShadowDirection")
end

else
return
end
end

callbacks.Register("Draw", sun_stuff)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

