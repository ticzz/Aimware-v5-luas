local movement_ref = gui.Reference("MISC", "Movement", "Other")

local sync_movement = gui.Checkbox(movement_ref, "sync_movement_0.", "Enable synced movement when on player's head", false)

local sync_movement_indicator = gui.Checkbox(movement_ref, "sync_movement_indicator.", "Enable synced movement indicator", false)

local s_w, s_h = draw.GetScreenSize()
local sync_movement_indicator_X = gui.Slider(movement_ref, "sync_movement_indicator.x", "Text X position", 280, 0, s_w);
local sync_movement_indicator_Y = gui.Slider(movement_ref, "sync_movement_indicator.y", "Text Y position", 190, 0, s_h);
local sync_movement_indicator_size = gui.Slider(movement_ref, "sync_movement_indicator.y", "Text size", 25, 0, 100);


function syncMovement(cmd, pos)
    local world_forward = {vector.Subtract( pos,  {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z} )}
    local ang_LocalPlayer = {engine.GetViewAngles().x, engine.GetViewAngles().y, engine.GetViewAngles().z }
    
    cmd.forwardmove = ( ( (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[2]) + (math.cos(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 200 ) -- mine
    cmd.sidemove = ( ( (math.cos(math.rad(ang_LocalPlayer[2]) ) * -world_forward[2]) + (math.sin(math.rad(ang_LocalPlayer[2]) ) * world_forward[1]) ) * 200 )
end

function is_movement_keys_down()
    return input.IsButtonDown( 87 ) or input.IsButtonDown( 65 ) or input.IsButtonDown( 83 ) or input.IsButtonDown( 68 ) or input.IsButtonDown( 32 )
end

function is_crouching(player)
    return player:GetProp('m_flDuckAmount') > 0.1
end



local is_synced = false

callbacks.Register("CreateMove", function(cmd)
    if not sync_movement:GetValue() then return end
    succ, err = pcall(function() is_movement_keys_down() is_synced = false end)
    if err or is_movement_keys_down() then return end
    
    local players = entities.FindByClass( "CCSPlayer" )
    
    for k, player in pairs(players) do
        local player_pos = {player:GetAbsOrigin().x, player:GetAbsOrigin().y, player:GetAbsOrigin().z}
        local distance = vector.Distance(player_pos, {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z})
        
        local z_dist = entities.GetLocalPlayer():GetAbsOrigin().z - player_pos[3]
        
        local d_min = 0
        local d_max = 0
        if not is_crouching(player) then
            d_min = 70
            d_max = 85
        else
            d_min = 50
            d_max = 64
        end
        if (distance > d_min and distance < d_max) and (z_dist > d_min and z_dist < d_max) then
            syncMovement(cmd, player_pos)
            is_synced = true
        else
            is_synced = false
        end
    end        
end)


callbacks.Register("Draw", function(cmd)
    if not sync_movement:GetValue() or not sync_movement_indicator:GetValue() then return end
    local main_font = draw.CreateFont("Verdana", sync_movement_indicator_size:GetValue());
    draw.SetFont(main_font)

    draw.Color(255,0,0)
    if is_synced then
        draw.Color(0,255,0)
        draw.Text(sync_movement_indicator_X:GetValue(),sync_movement_indicator_Y:GetValue(), "Synced")
    else
        draw.Text(sync_movement_indicator_X:GetValue(),sync_movement_indicator_Y:GetValue(), "Unsynced")
    end
    
end)



 







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

