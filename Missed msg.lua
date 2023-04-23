callbacks.Register("FireGameEvent", function(event)
local event_name = event:GetName()
local local_player_index = client.GetLocalPlayerIndex()
local uid = client.GetPlayerIndexByUserID(event:GetInt( 'userid' ))


-- Increment hitchance on miss
if event_name == "weapon_fire" and uid == local_player_index then
missed = true

timer.Simple("missed", 0.04, function()
if missed then
print("Aimware missed this shot")
draw.Text(10, 10, "Aimware missed this shot")
local base_hc = gui.GetValue("rbot.hitscan.accuracy.asniper.hitchance")
missed_count = missed_count + 1
gui.SetValue("rbot.hitscan.accuracy.asniper.hitchance", 5 * missed_count + base_hc:GetValue())
if timer.Exists("SetBaseHitchance") then
timer.Restart("SetBaseHitchance")
else
timer.Simple("SetBaseHitchance", 0.6, function()
gui.SetValue("rbot.hitscan.accuracy.asniper.hitchance", base_hc:GetValue())
missed_count = 0
end)
end
end
end)
elseif event_name == "player_hurt" then
missed = false
end
end)


client.AllowListener("weapon_fire")
client.AllowListener("player_hurt")







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

