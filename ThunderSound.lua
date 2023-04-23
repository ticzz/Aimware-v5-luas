-- Thunder for AIMWARE Counter-Strike: Global Offensive
-- by https://aimware.net/forum/user-205601.html

local sounds = {
    [1] = "ambient\\playonce\\weather\\thunder4.wav",
    [2] = "ambient\\playonce\\weather\\thunder5.wav",
    [3] = "ambient\\playonce\\weather\\thunder6.wav",
    [4] = "ambient\\playonce\\weather\\thunder_distant_01.wav",
    [5] = "ambient\\playonce\\weather\\thunder_distant_02.wav",
    [6] = "ambient\\playonce\\weather\\thunder_distant_06.wav",
}

local last = globals.TickCount()

function work()
   if not entities.GetLocalPlayer() then
       return
   end

   if globals.TickCount() - last > 384 then
       client.Command("play " .. sounds[math.random(1, 6)
], true);
       last = globals.TickCount()
   end
end

local function work_events(event)
   if event:GetName() == "game_newmap" then
       last = 0
   end
end

client.AllowListener("game_newmap");
callbacks.Register("FireGameEvent", "work_events_thunder", work_events);
callbacks.Register("Draw", "work_thunder", work);




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")