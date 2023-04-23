-- Info: Fakeduck Indicator and Animationfix activates automatically

local w, h = draw.GetScreenSize()

local storedTick = 0
local crouched_ticks = { }


local function toBits(num)
    local t = { }
    while num > 0 do
        rest = math.fmod(num,2)
        t[#t+1] = rest
        num = (num-rest) / 2
    end

    return t
end

callbacks.Register("DrawESP", "FD_Indicator", function(Builder)
    local g_Local = entities.GetLocalPlayer()
    local Entity = Builder:GetEntity()

  

    if g_Local == nil or Entity == nil or not Entity:IsAlive() then
        return
    end

    local index = Entity:GetIndex()
    local m_flDuckAmount = Entity:GetProp("m_flDuckAmount")
    local m_flDuckSpeed = Entity:GetProp("m_flDuckSpeed")
    local m_fFlags = Entity:GetProp("m_fFlags")

    if crouched_ticks[index] == nil then
        crouched_ticks[index] = 0
    end

    if m_flDuckSpeed ~= nil and m_flDuckAmount ~= nil then
        if m_flDuckSpeed == 8 and m_flDuckAmount <= 0.9 and m_flDuckAmount > 0.01 and toBits(m_fFlags)[1] == 1 then
            if storedTick ~= globals.TickCount() then
                crouched_ticks[index] = crouched_ticks[index] + 1
                storedTick = globals.TickCount()
            end

            if crouched_ticks[index] >= 5 then
                Builder:Color(255, 0, 0, 255)
                Builder:AddTextRight("Fake Duck")
            end
        else
            crouched_ticks[index] = 0

end end end)

--******************************************************************************

--Fakeduck Viewmodel Animation by Grieschoel aka AEONS

local getLocal = function() return entities.GetLocalPlayer() end
local viewmodelZ = (client.GetConVar("viewmodel_offset_z"));
local function yourmumsahoe()
if getLocal() then
if getLocal():IsAlive() then
local shitthisisboring = gui.GetValue('rbot.antiaim.extra.fakecrouchkey')
if (shitthisisboring == 0) then return end;
local andsofuckinguseless = input.IsButtonDown( shitthisisboring)                                            
local yourmum = entities.GetLocalPlayer();
local tbagmodeengaged = yourmum:GetProp('m_flDuckAmount')            
if not andsofuckinguseless or shitthisisboring == 0 then

client.SetConVar("viewmodel_offset_z", (viewmodelZ - (tbagmodeengaged*8)), true)
else 
client.SetConVar("viewmodel_offset_z", viewmodelZ, true)

end end end end
callbacks.Register("Draw", yourmumsahoe)

callbacks.Register("Unload", function()

client.SetConVar("viewmodel_offset_z", 0, true);

end)

--***********************************************--

--#--#--# Fakeduck anti-standup fix

local max_ticks = gui.Reference("Misc", "General", "Server", "sv_maxusrcmdprocessticks")
local fd_max_ticks_slider = gui.Slider(gui.Reference("Ragebot", "Anti-Aim", "Extra"), "Chicken.fd_max_ticks", "Max ticks on fakeduck", 25, 15, 61)

callbacks.Register("Draw", function()
	if (gui.GetValue("rbot.antiaim.extra.fakecrouchkey") == 0) then return end;
	
	if input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
		max_ticks:SetValue(fd_max_ticks_slider:GetValue())
	else
		max_ticks:SetValue(16)
	end
end)

--***********************************************--
--***********************************************--











--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

