
-- global variables
local peek_abs_origin = {}
local is_peeking = false
local has_shot = false

-- gui		
local ui_groupbox = gui.Groupbox(gui.Reference("Ragebot", "Accuracy", "Movement"), "Auto Peek")
local ui_checkbox = gui.Checkbox(ui_groupbox, "lua_autopeek_enable", "Enable Auto Peek", false);
local ui_keybox = gui.Keybox(ui_groupbox, "lua_autopeek_key", "Auto Peek Bind", 18);
local ui_checkbox_visualize = gui.Checkbox(ui_groupbox, "lua_autopeek_visualize", "Visualize", false);
local ui_color_picker = gui.ColorPicker(ui_groupbox, "lua_autopeek_outlinecol", "Outline Color", 255, 255, 255, 255);
local ui_color_picker2 = gui.ColorPicker(ui_groupbox, "lua_autopeek_filcol", "Fill Color", 255, 255, 255, 255);

local function render(pos, radius)

if not ui_checkbox_visualize:GetValue() then
return
end

local center = {client.WorldToScreen(Vector3(pos.x, pos.y, pos.z)) }

for degrees = 1, 360, 1 do

        local cur_point = nil;
local old_point = nil;

        if pos.z == nil then
            cur_point = {pos.x + math.sin(math.rad(degrees)) * radius, pos.y + math.cos(math.rad(degrees)) * radius}; 
            old_point = {pos.x + math.sin(math.rad(degrees - 1)) * radius, pos.y + math.cos(math.rad(degrees - 1)) * radius};
        else
            cur_point = {client.WorldToScreen(Vector3(pos.x + math.sin(math.rad(degrees)) * radius, pos.y + math.cos(math.rad(degrees)) * radius, pos.z))};
            old_point = {client.WorldToScreen(Vector3(pos.x + math.sin(math.rad(degrees - 1)) * radius, pos.y + math.cos(math.rad(degrees - 1)) * radius, pos.z))};
        end

if cur_point[1] ~= nil and cur_point[2] ~= nil and old_point[1] ~= nil and old_point[2] ~= nil then 
-- fill
draw.Color(ui_color_picker2:GetValue())
draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], center[1], center[2])
-- outline
draw.Color(ui_color_picker:GetValue())
draw.Line(cur_point[1], cur_point[2], old_point[1], old_point[2]); 
        end
        
    end

end

callbacks.Register( "Draw", function()

    local m_local = entities.GetLocalPlayer()
if not m_local or not m_local:IsAlive() then return end

if input.IsButtonDown(ui_keybox:GetValue()) and not is_peeking then
peek_abs_origin = m_local:GetAbsOrigin()
is_peeking = true
end

if is_peeking and input.IsButtonDown(ui_keybox:GetValue()) then
render(peek_abs_origin, 12)
else 
if is_peeking then
peek_abs_origin = m_local:GetAbsOrigin()
end
end
end)

callbacks.Register("CreateMove", function(cmd)

local m_local = entities.GetLocalPlayer()

if has_shot and input.IsButtonDown(ui_keybox:GetValue()) then

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

local local_index = client.GetLocalPlayerIndex();
local victim_index = client.GetPlayerIndexByUserID( Event:GetInt( "userid" ) );
local attacker_index = client.GetPlayerIndexByUserID( Event:GetInt( "attacker" ) );

if ( victim_index == local_index and attacker_index ~= local_index ) then
has_shot = true
end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

