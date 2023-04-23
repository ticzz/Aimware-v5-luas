local steps = {}
local last_step = {}
local GetLocalPlayerIndex = client.GetLocalPlayerIndex()
local GetLocalPlayer = entities.GetLocalPlayer()

local Visuals_Enemies_Reference = gui.Reference("VISUALS", "ENEMIES", "Filter")
local SoundESP_Text = gui.Text(Visuals_Enemies_Reference, "")
local SoundESP_Text2 = gui.Text(Visuals_Enemies_Reference, "Step ESP")
local Enable_Checkbox = gui.Checkbox(Visuals_Enemies_Reference, "vis_soundesp_enable", "Enable", false)
local Name_Checkbox = gui.Checkbox(Visuals_Enemies_Reference, "vis_soundesp_name", "Name", false)
local Size_Slider = gui.Slider(Visuals_Enemies_Reference, "vis_soundesp_size", "Circle Size", 10, 1, 100)
local Thickness_Slider = gui.Slider(Visuals_Enemies_Reference, "vis_soundesp_thic", "Circle Thickness", 0, 0, 10)
local Duration_Slider = gui.Slider(Visuals_Enemies_Reference, "vis_soundesp_dur", "Duration", 20, 1, 100)
local Distance_Slider = gui.Slider(Visuals_Enemies_Reference, "vis_soundesp_dist", "Distance", 100, 1, 1000)
local R_Slider = gui.Slider(Visuals_Enemies_Reference, "vis_soundesp_red", "Red", 160, 0, 255)
local G_Slider = gui.Slider(Visuals_Enemies_Reference, "vis_soundesp_green", "Green", 160, 0, 255)
local B_Slider = gui.Slider(Visuals_Enemies_Reference, "vis_soundesp_blue", "Blue", 160, 0, 255)
local A_Slider = gui.Slider(Visuals_Enemies_Reference, "vis_soundesp_alpha", "Alpha", 255, 0, 255)

local function drawCircle(x, y, z, radius, thickness, quality, r, g, b, a)
    local quality = quality or 20
    local thickness = thickness or  8
    local Screen_X_Line_Old, Screen_Y_Line_Old
    for rot=0, 360, quality do
        local rot_temp = math.rad(rot)
        local LineX, LineY, LineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
        local Screen_X_Line, Screen_Y_Line = client.WorldToScreen(LineX, LineY, LineZ)
        if Screen_X_Line ~=nil and Screen_X_Line_Old ~= nil then
            draw.Color(r, g, b, a)
            draw.Line(Screen_X_Line, Screen_Y_Line, Screen_X_Line_Old, Screen_Y_Line_Old)
                for i = 0, thickness do
                    draw.Line(Screen_X_Line, Screen_Y_Line+i, Screen_X_Line_Old, Screen_Y_Line_Old+i)
                end
        end
        Screen_X_Line_Old, Screen_Y_Line_Old = Screen_X_Line, Screen_Y_Line
    end
end

local function distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
end

local function isEnemy(player)
    return player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber()
end

function ResetTables(event)
    if Enable_Checkbox:GetValue() then    
        if ( event:GetName( ) ~= 'round_start' ) then
            return
        end
        steps = {}
        last_step = {}
    end
end
client.AllowListener( 'round_start' )
callbacks.Register( 'FireGameEvent', 'Reset Tables', ResetTables )

local function getPlayers()
    local plys = entities.FindByClass( "CCSPlayer" )

    for i = 1, #plys do
        local plyer = plys[ i ]
        return plyer
    end
end    

local function onStep(player)    
    local curtime = globals.CurTime()
    local local_x, local_y, local_z = entities.GetLocalPlayer():GetAbsOrigin()
    local max_distance = Distance_Slider:GetValue()*10
    local x, y, z = player:GetAbsOrigin()
    
    if ((player:GetIndex() ~= GetLocalPlayerIndex ) and isEnemy(player)) then
        if x ~= nil and local_x ~= nil then
            if max_distance > distance(local_x, local_y, local_z, x, y, z) then
                table.insert(steps, {curtime, x, y, z, player})
            end
        else
        end
    end
end

function onStepEvent( event )
    if Enable_Checkbox:GetValue() then
        if ( entities.GetLocalPlayer() ~= nil ) then
        if ( event:GetName( ) ~= 'player_footstep' ) then
            return
        end

        local uId = event:GetInt( 'userid' )
        local ply = entities.GetByUserID( uId )
        
        if ( ply ~= nil ) then
            local playerName = ply:GetName()
            onStep(ply)
        end
        end
    end
end
client.AllowListener( 'player_footstep' )
callbacks.Register( 'FireGameEvent', 'onStep Event', onStepEvent )

local function onDrawStep()
    if Enable_Checkbox:GetValue() then
        if #steps > 0 then
            local curtime = globals.CurTime()
            local r, g, b, a = math.floor(R_Slider:GetValue()), math.floor(G_Slider:GetValue()), math.floor(B_Slider:GetValue()), math.floor(A_Slider:GetValue())
            local duration = Duration_Slider:GetValue()*0.1
            local steps_new = {}
            
            for i=1, #steps do
                local step = steps[i]

                if step[1] + duration > curtime then
                    local time_since_step = curtime - step[1]
                    local opacity_multiplier = 1
                    local size_multiplier = ((time_since_step) / duration)
                    if duration-time_since_step < duration then
                        opacity_multiplier = (duration - time_since_step) / duration
                    end
                    opacity_multiplier = math.min(opacity_multiplier, 1)
                    opacity_multiplier = math.max(opacity_multiplier, 0)

                    local wx, wy = client.WorldToScreen(step[2], step[3], step[4])
                    local tx, ty = client.WorldToScreen(step[2], step[3], step[4])

                    if wx ~= nil then
                        local size = 120
                        local width = 20
                        width = width + (1-size_multiplier)*2    
                        if ( entities.GetLocalPlayer() ~= nil ) then
                            drawCircle(step[2], step[3], step[4], size_multiplier*Size_Slider:GetValue(), math.floor(Thickness_Slider:GetValue()), 15, r, g, b, a*opacity_multiplier)
                        end
                        if Name_Checkbox:GetValue() then
                            local text_size = draw.GetTextSize()
                            local pName = (step[5]:GetName())
                            draw.Text(tx-Size_Slider:GetValue(), ty, pName)
                        end
                    end
                    table.insert(steps_new, step)
                end
            end
            steps = steps_new
        end
    end
end
callbacks.Register( "Draw", "Draw Step ESP", onDrawStep)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

