   ------Auto Hold Postion by Mario------

local players = entities.FindByClass( "CCSPlayer" )
local isBot = false

--AW Gui--
local Ref_BotCmd = gui.Reference("MISC", "AUTOMATION", "Other");
local CC_Text2 = gui.Text(Ref_BotCmd, "#~#~  Bots HoldPosition  ~#~#")
local Checkbox_BotCmd = gui.Checkbox( Ref_BotCmd, "msc_holdpos_active", "Auto Hold Position", 0 );

--Timer--
local timer = timer or {}
local timers = {}
---------

function checkBot()    --Checking if there is a Bot in your team (*exept u)
    for i = 1, #players do
                local player = players[ i ];

        botDificulty = entities.GetPlayerResources():GetPropInt("m_iBotDifficulty", player:GetIndex());
        
        if player:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber() then
            if botDificulty >= 0 then            --Yup... I am to dumb and lazy to find a proper way
                isBot = true
				return true
            else
                isBot = false
				return false
            end
        else
        end
    end
end

function holdPos(event)        --Holdpos function
    if (event:GetName() == "round_freeze_end") then
		if Checkbox_BotCmd:GetValue() then
		checkBot()
            if (isBot() == true) then
                timer.Create("holdpos_delay", 1.0, 1, function()
                    client.Command("holdpos", true)
                end)
            end
        end
    end
end

client.AllowListener("round_freeze_end")
callbacks.Register("FireGameEvent", holdPos);



----------------------GLuaTimer---------------------------            
--Timer by imacookie https://aimware.net/forum/thread-86687.html?highlight=glua+Timer


function timer.Create(name, delay, times, func)

    table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})

end

function timer.Remove(name)

    for k,v in pairs(timers or {}) do
    
        if (name == v["name"]) then table.remove(timers, k) end
    
    end

end

function timer.Tick()

    for k,v in pairs(timers or {}) do
    
        if (v["times"] <= 0) then table.remove(timers, k) end
        
        if (v["lastTime"] + v["delay"] <= globals.RealTime()) then 
            timers[k]["lastTime"] = globals.RealTime()
            timers[k]["times"] = timers[k]["times"] - 1
            v["func"]() 
        end
    
    end

end

callbacks.Register( "Draw", timer.Tick);
--------------------------------------------------------------