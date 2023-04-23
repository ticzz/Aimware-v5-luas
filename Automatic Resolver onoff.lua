--[===[

    Made by superyu'#7167

    How it works:
    We will loop through the entity list and check for packet choking, desync is done by choking and thus a desyncing player will choke packets.
    If a player chokes packets the Simtime won't update, if we check if the simtime is equal to the last ticks simtime then the entity is choking packets.
    We will use this information to enable/disable the resolver.

    Thanks to corrada for finding critical bug.
--]===]

--- Gui Stuff
local pos = gui.Reference("Ragebot", "Aimbot", "Extra")
local enabled = gui.Checkbox(pos, "rbot_autoresolver", "Automatic Resolver", 0)
local warningEnabled = gui.Checkbox(pos, "rbot_autoresolver_warning", "Desync Warning", 0)
local listEnabled = gui.Checkbox(pos, "rbot_autoresolver_list", "Desync List", 0)

--- Tables.
local isDesyncing = {};
local lastSimtime = {};
local desyncCooldown = {};

--- Variables
local lastTick = 0;
local pLocal = entities.GetLocalPlayer();
local resolverTextCount = 0;
local sampleTextWidth, sampleTextHeight


--- Hooks
local function drawHook()
    pLocal = entities.GetLocalPlayer();

    if listEnabled:GetValue() then

        if engine.GetMapName() ~= "" then
            draw.Text(2, 400, gui.GetValue("rbot.accuracy.posadj.resolver") and "Desyncing Players - Resolver: On" or "Desyncing Players - Resolver:  Off")
        end
        sampleTextWidth, sampleTextHeight = draw.GetTextSize("Sample Text")
    end

    if enabled:GetValue() then
        resolverTextCount = 0;
        for pEntityIndex, pEntity in pairs(entities.FindByClass("CCSPlayer")) do
            if pEntity:GetTeamNumber() ~= pLocal:GetTeamNumber() and pEntity:IsPlayer() and pEntity:IsAlive() then
                if globals.TickCount() > lastTick then
                    if lastSimtime[pEntityIndex] ~= nil then
                        if pEntity:GetProp("m_flSimulationTime") == lastSimtime[pEntityIndex] then
                            isDesyncing[pEntityIndex] = true;
                            desyncCooldown[pEntityIndex] = globals.TickCount();
                        else
                            if desyncCooldown[pEntityIndex] ~= nil then
                                if desyncCooldown[pEntityIndex] < globals.TickCount() - 128 then
                                    isDesyncing[pEntityIndex] = false;
                                end
                            else
                                isDesyncing[pEntityIndex] = false;
                            end
                        end
                    end
                    lastSimtime[pEntityIndex] = pEntity:GetProp("m_flSimulationTime")
                end

                if engine.GetMapName() ~= "" then
                    if isDesyncing[pEntityIndex] then
                        if listEnabled:GetValue() then
                            local pos = 410 + (sampleTextHeight * resolverTextCount)
                            draw.Text(2, pos, pEntity:GetName())
                        end
                        resolverTextCount = resolverTextCount+1
                    end
                end
            end
        end
        lastTick = globals.TickCount();
        if resolverTextCount ~= 0 then
            gui.SetValue("rbot.accuracy.posadj.resolver", 1);
        else
            gui.SetValue("rbot.accuracy.posadj.resolver", 0);
        end
    end
end

local function aimbotTargetHook(pEntity)
    if enabled:GetValue() then

        if not isDesyncing[pEntity:GetIndex()] then
            gui.SetValue("rbot.accuracy.posadj.resolver", 0);
        else
            gui.SetValue("rbot.accuracy.posadj.resolver", 1);
        end
    end
end

local function drawEspHook(builder)

    if warningEnabled:GetValue() then
        local pEntity = builder:GetEntity()

        if pEntity:IsPlayer() and pEntity:IsAlive() and pEntity:GetTeamNumber() ~= pLocal:GetTeamNumber() then

            if isDesyncing[pEntity:GetIndex()] then
                builder:Color(255, 25, 25, 255)
                builder:AddTextBottom("Desync")
            else
                builder:Color(255, 255, 25, 255)
                builder:AddTextBottom("No Desync")
            end
        end
    end
end

--- Callbacks
callbacks.Register("Draw", drawHook)
callbacks.Register("AimbotTarget", aimbotTargetHook)
callbacks.Register("DrawESP", drawEspHook)



 







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

