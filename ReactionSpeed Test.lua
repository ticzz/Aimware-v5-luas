local screen_height, screen_weight = draw.GetScreenSize()

local lua_ref = gui.Reference("Visuals", "World", "Extra")

local pos_x = gui.Slider(lua_ref, "pos_x", "Position X", 400, 0, screen_weight, 1)
local pos_y = gui.Slider(lua_ref, "pos_y", "Position Y", 400, 0, screen_height, 1)

local game_started = false
local game_ended = false
local start_time = 0 
local green_time = 0
local click_time = 0
local reaction_time = 0
local last_time = 0
local time = 0
local alpha = 255

local text = ""
local rect_color = {255, 0, 0}
local text_size = {}

local start_test = gui.Button(lua_ref, "Start Reaction Test",
function ()
 game_started = true
 game_ended = false
 time = globals.RealTime()
 start_time = globals.RealTime() 
 green_time = globals.RealTime() + (math.random(100, 230) / 100)
 click_time = nil
 reaction_time = nil
 last_time = nil
 alpha = 255

end)
 
local font = draw.CreateFont('Bahnschrift Bold', 30)

local function reaction_game()
 time = globals.RealTime()

 if game_started == true and click_time == nil then
 if time < green_time then
 rect_color = {255, 0, 0}
 text = "wait for a green color"
 else
 rect_color = {0, 255, 0}
 text = "click"
 end
 end

 if input.IsButtonDown(1) and time - start_time > 0.2 and game_ended == false then
 click_time = globals.RealTime()

 if green_time - click_time > 0 then
 text = "too early"
 rect_color = {255, 0, 0}
 else
 text = tostring(string.format("%0.0f", (click_time - green_time) * 1000)) .. "ms"
 rect_color = {255, 0, 0}
 end

 game_ended = true
 last_time = globals.RealTime() + 2
 end

 if last_time ~= nil and last_time - globals.RealTime() < 0 then
 game_started = false
 end

 local scaling = (450 / (1 / globals.AbsoluteFrameTime()))

 if last_time ~= nil and last_time - globals.RealTime() > 0 then
 alpha = alpha - (0.3 * scaling)

 if alpha < 0 then 
 alpha = 0
 end
 end

 if game_started == true  then
 draw.SetFont(font)
 local text_size = {draw.GetTextSize(text)}
 draw.Color(rect_color[1], rect_color[2], rect_color[3], alpha)
 draw.FilledRect(pos_x:GetValue(), pos_y:GetValue(), pos_x:GetValue() + 400, pos_y:GetValue() + 400)
 draw.Color(245, 245, 245, alpha)
 draw.Text(pos_x:GetValue() + 200 - (text_size[1] / 2), pos_y:GetValue() + 200 - (text_size[2] / 2), text)
 end
end
callbacks.Register('Draw', reaction_game)

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")