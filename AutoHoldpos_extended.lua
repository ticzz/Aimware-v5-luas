-- credits for original script: RadicalMario

local timer = timer or {}
local timers = {}
local mode =  1 -- 1: holdpos, 2: followpos

--AW Gui--
local Ref_BotCmd = gui.Reference("MISC", "General", "Extra");
local CC_Text2 = gui.Text(Ref_BotCmd, "#~#~  Bots HoldPosition  ~#~#")
local Checkbox_BotCmd = gui.Checkbox( Ref_BotCmd, "msc.holdpos.active", "Stop Auto BotHoldPosition", true );

-- by imacookie
function timer.Create(name, delay, times, func)
    table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})
end

function timer.Remove(name)
    for k,v in pairs(timers or {}) do
        if (name == v["name"]) then table.remove(timers, k) end
    end
end

function are_there_any_bots()
    local players = entities.FindByClass("CCSPlayer")

    for i = 1, #players do
        local player = players[i];
        if(player:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber()) then
            local player_info = client.GetPlayerInfo(player:GetIndex())
            if(player_info["IsBot"] == true) then
                return true
            end
        end
    end

    return false
end

local function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

client.AllowListener("round_freeze_end")

callbacks.Register('FireGameEvent', function(event)
    
if(engine.GetServerIP() == "loopback") then 
	return 
	end
	if Checkbox_BotCmd:GetValue() then return 
else
     if (event:GetName( ) == "round_freeze_end") then
        if (are_there_any_bots()) then
            timer.Create("holdpos_delay", 1.0, 1, function()
                if (mode == 1) then 
                    client.Command("holdpos", true)
                elseif (mode == 2) then
                    client.Command("followme", true)
              end
            end)
        end
		end
    end
end)

callbacks.Register("DispatchUserMessage", function(msg)
    if (msg:GetID() == 6) then
        local index = msg:GetInt(1)
        local message = msg:GetString(4, 1)
        message = trim(message)

        if(index == client.GetLocalPlayerIndex()) then
            if (message == "bot hold" or message == "holdpos") then
                mode = 1
            elseif (message == "bot follow" or message == "followme") then
                mode = 2
            end
        end
    end
end)

callbacks.Register("Draw", function()
    for k,v in pairs(timers or {}) do
    
        if (v["times"] <= 0) then table.remove(timers, k) end
        
        if (v["lastTime"] + v["delay"] <= globals.RealTime()) then 
            timers[k]["lastTime"] = globals.RealTime()
            timers[k]["times"] = timers[k]["times"] - 1
            v["func"]() 
        end
    
    end
end)