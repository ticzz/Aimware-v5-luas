print(GetScriptName() .. " succesfully loaded")

--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#

local vis_tab_radar = gui.Reference('VISUALS')
local vis_main_tab = gui.Tab(vis_tab_radar, "lua_tab_radar", "EngineRadar")
local EngineRadarchk = gui.Checkbox ( vis_main_tab, "lua_engine_radar", "Enable EngineRadar", false );


local function engine_radar_draw()

if EngineRadarchk:GetValue() then        

for index, Player in pairs(entities.FindByClass("CCSPlayer")) do

Player:SetProp("m_bSpotted", 1);

else

Player:SetProp("m_bSpotted", 0);

end
end
end

callbacks.Register("Draw", "engine_radar_draw", engine_radar_draw);