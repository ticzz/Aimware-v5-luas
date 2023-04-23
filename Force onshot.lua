local force_onshot
do
  local _with_0 = gui.Checkbox(gui.Reference("Ragebot", "Aimbot", "Automation"), "onshot", "Force onshot", false)
  _with_0:SetDescription("Binding recommended.")
  force_onshot = _with_0
end
local onshotable = { }
local changes = false
local ApplyOnshots
ApplyOnshots = function()
  local lp = entities.GetLocalPlayer()
  if force_onshot:GetValue() then
    changes = true
    local _list_0 = entities.FindByClass("CCSPlayer")
    for _index_0 = 1, #_list_0 do
      local player = _list_0[_index_0]
      if player:GetProp("m_iPendingTeamNum") ~= lp:GetProp("m_iPendingTeamNum") then
        if onshotable[player:GetIndex()] then
          local has_onshot = onshotable[player:GetIndex()] > globals.CurTime()
          if has_onshot then
            player:SetProp("m_iTeamNum", player:GetProp("m_iPendingTeamNum"))
          else
            player:SetProp("m_iTeamNum", lp:GetProp("m_iTeamNum"))
          end
        else
          player:SetProp("m_iTeamNum", lp:GetProp("m_iTeamNum"))
        end
      end
    end
  elseif changes then
    changes = false
    local _list_0 = entities.FindByClass("CCSPlayer")
    for _index_0 = 1, #_list_0 do
      local player = _list_0[_index_0]
      player:SetProp("m_iTeamNum", player:GetProp("m_iPendingTeamNum"))
    end
  end
end
callbacks.Register("CreateMove", function(usercmd)
  ApplyOnshots()
  
end)
client.AllowListener("weapon_fire")
callbacks.Register("FireGameEvent", function(event)
  if event:GetName() ~= "weapon_fire" then
    return 
  end
  local index = client.GetPlayerIndexByUserID(event:GetInt("userid"))
  onshotable[index] = globals.CurTime() + 0.2
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

