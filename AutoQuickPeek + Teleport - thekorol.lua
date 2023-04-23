-- global variables
local peek_abs_origin = {}
local is_peeking = false
local has_shot = false

-- gui
local gui_TAB = gui.Tab(gui.Reference("Ragebot"), "Quickpeek", "Quick peek")
local gui_GB = gui.Groupbox(gui_TAB, "Quickpeek + Teleport", 15, 15,297,0)
local gui_checkbox = gui.Checkbox(gui_GB, "quickpeek.enable", "Enable Auto Peek", false);
local gui_key = gui.Keybox(gui_GB, "quickpeek.key", "Auto Peek Bind", "A");
local gui_color = gui.ColorPicker(gui_GB, "quickpeek.clr", "Fill Color", 255, 255, 255, 255);

local function render(pos, radius)
	local center = {client.WorldToScreen(Vector3(pos.x, pos.y, pos.z)) }
	for degrees = 1, 20, 1 do
        
        local cur_point = nil;
        local old_point = nil;

        if pos.z == nil then
            cur_point = {pos.x + math.sin(math.rad(degrees * 18)) * radius, pos.y + math.cos(math.rad(degrees * 18)) * radius};    
            old_point = {pos.x + math.sin(math.rad(degrees * 18 - 18)) * radius, pos.y + math.cos(math.rad(degrees * 18 - 18)) * radius};
        else
            cur_point = {client.WorldToScreen(Vector3(pos.x + math.sin(math.rad(degrees * 18)) * radius, pos.y + math.cos(math.rad(degrees * 18)) * radius, pos.z))};
            old_point = {client.WorldToScreen(Vector3(pos.x + math.sin(math.rad(degrees * 18 - 18)) * radius, pos.y + math.cos(math.rad(degrees * 18 - 18)) * radius, pos.z))};
        end
                    
        if cur_point[1] ~= nil and cur_point[2] ~= nil and old_point[1] ~= nil and old_point[2] ~= nil and center[1] ~= nil and center [2] ~= nil then        
            draw.Color(gui_color:GetValue())
            draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], center[1], center[2])
        end 
    end
end

callbacks.Register( "Draw", function()
 
 local m_local = entities.GetLocalPlayer()

 if input.IsButtonDown(gui_key:GetValue()) then 
 gui.SetValue("misc.speedburst.enable", true)
 gui.SetValue("misc.speedburst.indicator", true)
 else
 gui.SetValue("misc.speedburst.enable", false)
 gui.SetValue("misc.speedburst.indicator", false)
 end

 if input.IsButtonDown(gui_key:GetValue()) and not is_peeking then
 peek_abs_origin = m_local:GetAbsOrigin()
 is_peeking = true 
 end
 
 if is_peeking and input.IsButtonDown(gui_key:GetValue()) then
 render(peek_abs_origin, 12)
 else 
 if is_peeking then
 peek_abs_origin = m_local:GetAbsOrigin()
 end
 end
end)

callbacks.Register("CreateMove", function(cmd)
 
 local m_local = entities.GetLocalPlayer()

 if has_shot and input.IsButtonDown(gui_key:GetValue()) then
 local local_angle = {engine.GetViewAngles().x, engine.GetViewAngles().y, engine.GetViewAngles().z }
 local world_forward = {vector.Subtract( {peek_abs_origin.x, peek_abs_origin.y, peek_abs_origin.z},  {m_local:GetAbsOrigin().x, m_local:GetAbsOrigin().y, m_local:GetAbsOrigin().z} )}
 
 cmd.forwardmove = ( ( (math.sin(math.rad(local_angle[2]) ) * world_forward[2]) + (math.cos(math.rad(local_angle[2]) ) * world_forward[1]) ) * 200 )
 cmd.sidemove = ( ( (math.cos(math.rad(local_angle[2]) ) * -world_forward[2]) + (math.sin(math.rad(local_angle[2]) ) * world_forward[1]) ) * 200 )

 if vector.Length(world_forward) < 10 then
 has_shot = false
 end
 end
end)

client.AllowListener( "player_hurt" );

callbacks.Register( "FireGameEvent", function(Event)

  local lp_index = entities.GetLocalPlayer():GetIndex()
  local attacker = entities.GetByUserID(Event:GetInt("attacker"));
  
  if attacker:GetIndex() == lp_index then	
  if input.IsButtonDown(81) then return end
  has_shot = true
  cheat.RequestSpeedBurst()
  end

end)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

