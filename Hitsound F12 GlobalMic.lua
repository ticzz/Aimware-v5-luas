local menu = gui.Reference("Visuals", "World", "Extra")
local f12killsound = gui.Checkbox(menu, "killsound", "Mic KillSound", 0)
f12killsound:SetDescription("Plays sound on mic when you kill someone")
local currentTime = 0
local timer = 0
local enabled = true
local snd_time = gui.Slider(menu, "snd_time", "soundfile length", 1.7, 0.1, 50, 0.1)
local fl_val, flp_val = nil, nil

local snd_time = 0

local function handler()
if entities.GetLocalPlayer() == nil then return end;
currentTime = globals.RealTime()
if currentTime >= timer then
timer = globals.RealTime() + snd_time
if enabled then
client.SetConVar("voice_loopback", 0, true)
client.SetConVar("voice_inputfromfile", 0, true)
client.Command("-voicerecord", true)
enabled = false

end
end
end

local function on_players_death(Event)
if not entities.GetLocalPlayer() or not Event:GetName() == 'player_death' or not f12killsound:GetValue() then
		return
	end

local INT_ATTACKER = Event:GetInt("attacker")
local INT_VICTIM = Event:GetInt('victim')
if INT_ATTACKER == nil then
return
end
local local_ent = client.GetLocalPlayerIndex()
local attacker_ent = entities.GetByUserID(INT_ATTACKER)
local victim_ent = entities.GetByUserID(INT_VICTIM)

if local_ent == nil or attacker_ent == nil then
return
end
if (attacker_ent:GetIndex() == local_ent) and ((victim_ent:GetIndex() ~= local_ent)) then
client.SetConVar("voice_loopback", 1, true)
client.SetConVar("voice_inputfromfile", 1, true)
client.Command("+voicerecord", true)
timer, enabled = globals.RealTime() + snd_time, true
end
end

client.AllowListener("player_death")
callbacks.Register("FireGameEvent", on_players_death)
callbacks.Register("Draw", handler)

callbacks.Register('Draw',function()
	if(f12killsound:GetValue()) then
		gui.SetValue("esp.world.hiteffects.sound", "Off");
	end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")