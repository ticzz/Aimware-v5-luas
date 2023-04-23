local RunScript = panorama.RunScript
local version = "2"
local lastTime = 0

local newestVer = http.Get("https://raw.githubusercontent.com/Trollface7272/Aimware-Lobbies/main/.version")
local newestVer = newestVer:sub(1, #newestVer - 1)

if version ~= newestVer then RunScript('$.Msg("Download new version! https://aimware.net/forum/thread/149882")') error("Download new version! https://aimware.net/forum/thread/149882") end

local function Search() 
	if globals.RealTime() - lastTime > 60 then
		RunScript([[if (Lobbies) Lobbies.RegisterButton.SendRegister()]])
		lastTime = globals.RealTime()
	end
end

local function Unload()
	RunScript([[if (Lobbies) Lobbies.Unload()]])
end

local script = http.Get("https://raw.githubusercontent.com/Trollface7272/Aimware-Lobbies/main/panorama.js")
RunScript(script)
callbacks.Register("Unload", Unload)
callbacks.Register("Draw", Search)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")
