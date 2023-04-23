--[[
Nice things to know when coding:
• Normal x,y startposition for groupboxes is 16
]]

--[[ Preprocesser Definitions (Not possible in lua because yes) ]]--
local DIRECTION_NONE = 0
local DIRECTION_LEFT = 1
local DIRECTION_RIGHT = 2

--[[ Initialize ragebotModule ]]--
local ragebotModule = { Groups = {} }

--[[ Initialize Features ]]--
ragebotModule.AntiAim = {}
ragebotModule.QuickPeek = {}
ragebotModule.ChokePeek = {}

--[[ Initialize Options ]]--
ragebotModule.AntiAim.Options = {}
ragebotModule.QuickPeek.Options = {}
ragebotModule.ChokePeek.Options = {}

--[[ Initialize Shared Variables ]]--
local chokingPackets = 0

--[[ Initialize Library ]]--
--local Library = LoadScript( "..\\library\\library.lua" ) (WIP So Im Excluding this)
local function MoveToAngle(newAngle, Cmd)
    Cmd.forwardmove = math.min(math.cos(math.rad((engine.GetViewAngles() - newAngle).y)) * 10000) -- thanks shady
    Cmd.sidemove = math.sin(math.rad((engine.GetViewAngles() - newAngle).y)) * 10000 -- thanks shady
end

local function MoveToPos(newPos, Cmd)
    local angleToDestination = (newPos - entities.GetLocalPlayer():GetAbsOrigin()):Angles() -- thanks shady
    Cmd.forwardmove = math.min(math.cos(math.rad((engine.GetViewAngles() - angleToDestination).y)) * 10000) -- thanks shady
    Cmd.sidemove = math.sin(math.rad((engine.GetViewAngles() - angleToDestination).y)) * 10000 -- thanks shady
end

local function Draw3DCircle(pos, radius, outlinecolor, filledcolor)
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
        if cur_point[1] ~= nil and cur_point[2] ~= nil and old_point[1] ~= nil and old_point[2] ~= nil and center[1] ~= nil and center[2] ~= nil then
            draw.Color(unpack(filledcolor))
            draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], center[1], center[2])

            draw.Color(unpack(outlinecolor))
            draw.Line(cur_point[1], cur_point[2], old_point[1], old_point[2]);
        end
    end
end

--[[ Initialize Gui References ]]--
local ragebotRef = gui.Reference( "Ragebot" )

--[[ Initialize Gui Objects ]]--
ragebotModule.Tab = gui.Tab( ragebotRef, "aimwarepp", "AimwarePP" )
ragebotModule.Groups.AntiAim = gui.Groupbox( ragebotModule.Tab, "AntiAim(WIP)", 16, 16, 300, 300 )
ragebotModule.AntiAim.Options.Enabled = gui.Checkbox( ragebotModule.Groups.AntiAim, "antiaim.enabled", "Enabled", false )
ragebotModule.AntiAim.Options.BaseDirection = gui.Slider( ragebotModule.Groups.AntiAim, "antiaim.basedirection", "BaseDirection", 0, -180, 180 )
ragebotModule.AntiAim.Options.Rotation = gui.Slider( ragebotModule.Groups.AntiAim, "antiaim.rotationoffset", "Rotation Offset", 0, -58, 58 )
ragebotModule.AntiAim.Options.LowerBodyYaw = gui.Slider( ragebotModule.Groups.AntiAim, "antiaim.lowerbodyyaw", "LowerBodyYaw", 0, -180, 180 )

ragebotModule.Groups.QuickPeek = gui.Groupbox( ragebotModule.Tab, "QuickPeek", 16, 260, 300, 300 )
ragebotModule.QuickPeek.Options.Enabled = gui.Checkbox( ragebotModule.Groups.QuickPeek, "quickpeek.enabled", "Enabled", false )
ragebotModule.QuickPeek.Options.PeekKey = gui.Keybox( ragebotModule.Groups.QuickPeek, "quickpeek.peekkey", "Key", 0 )


ragebotModule.Groups.ChokePeek = gui.Groupbox( ragebotModule.Tab, "ChokePeek", 332, 16, 300, 300 )
ragebotModule.ChokePeek.Options.Enabled = gui.Checkbox( ragebotModule.Groups.ChokePeek, "chokepeek.enabled", "Enabled", false )
ragebotModule.ChokePeek.Options.PeekKeyLeft = gui.Keybox( ragebotModule.Groups.ChokePeek, "chokepeek.leftdirection", "Left", 0 )
ragebotModule.ChokePeek.Options.PeekKeyRight = gui.Keybox( ragebotModule.Groups.ChokePeek, "chokepeek.rightdirection", "Right", 0 )

--[[ Error Handler (WIP) ]]--
local function ErrorHandler(Error)
    if(type(Error) ~= type("string")) then return false end
    print(Error)
end
    local localPlayer = entities.GetLocalPlayer()

local direction = DIRECTION_NONE
--[[ Initialize Feature Functions ]]--
function ragebotModule.AntiAim.OnDraw()
    if not (ragebotModule.AntiAim.Options.Enabled:GetValue()) then return end

    if(direction == DIRECTION_NONE) then
        gui.SetValue("rbot.antiaim.base", ragebotModule.AntiAim.Options.BaseDirection:GetValue() * -1 )
        gui.SetValue("rbot.antiaim.base.lby", ragebotModule.AntiAim.Options.LowerBodyYaw:GetValue() * -1 )
        gui.SetValue("rbot.antiaim.base.rotation", ragebotModule.AntiAim.Options.Rotation:GetValue() * -1 )
    elseif(direction == DIRECTION_LEFT) then
        gui.SetValue("rbot.antiaim.base", ragebotModule.AntiAim.Options.BaseDirection:GetValue() - 90 )
        gui.SetValue("rbot.antiaim.base.lby", ragebotModule.AntiAim.Options.LowerBodyYaw:GetValue() - 90 )
        gui.SetValue("rbot.antiaim.base.rotation", ragebotModule.AntiAim.Options.Rotation:GetValue() - 90 )
    elseif(direction == DIRECTION_RIGHT) then
        gui.SetValue("rbot.antiaim.base", ragebotModule.AntiAim.Options.BaseDirection:GetValue() + 90 )
        gui.SetValue("rbot.antiaim.base.lby", ragebotModule.AntiAim.Options.LowerBodyYaw:GetValue() + 90 )
        gui.SetValue("rbot.antiaim.base.rotation", ragebotModule.AntiAim.Options.Rotation:GetValue() + 90 )
    end
end

ragebotModule.QuickPeek.peekStartPos = entities.GetLocalPlayer():GetAbsOrigin()
ragebotModule.QuickPeek.holding = false
ragebotModule.QuickPeek.runningBack = false 
function ragebotModule.QuickPeek.OnCreateMove(Cmd)

   if (ragebotModule.QuickPeek.Options.Enabled:GetValue()) then return end

    if(ragebotModule.QuickPeek.Options.PeekKey:GetValue()) and input.IsButtonDown( ragebotModule.QuickPeek.Options.PeekKey:GetValue() ) then
        if( ragebotModule.QuickPeek.holding) then
            ragebotModule.QuickPeek.peekStartPos = localPlayer:GetAbsOrigin()
            ragebotModule.QuickPeek.runningBack = false
            ragebotModule.QuickPeek.holding = true
        else
            if(Cmd.buttons % 2 == 1) then ragebotModule.QuickPeek.runningBack = true end
            if(ragebotModule.QuickPeek.runningBack) then
                MoveToPos(ragebotModule.QuickPeek.peekStartPos, Cmd)
            end
        end
    else
        ragebotModule.QuickPeek.holding = false
    end

end

function ragebotModule.QuickPeek.OnDraw()
    if not (ragebotModule.QuickPeek.Options.Enabled:GetValue()) then return end
    if not (input.IsButtonDown(ragebotModule.QuickPeek.Options.PeekKey:GetValue()) ) then return end

    Draw3DCircle(ragebotModule.QuickPeek.peekStartPos, 10, {0,0,0,255}, {255,255,255,255})

    local startLinePosX,startLinePosY = client.WorldToScreen( entities.GetLocalPlayer():GetAbsOrigin() ) 
    local endLinePosX,endLinePosY = client.WorldToScreen( ragebotModule.QuickPeek.peekStartPos ) 
    if(startLinePosX == nil or startLinePosY == nil) then
        return
    end
    
    if(endLinePosX == nil or endLinePosY == nil) then
        return
    end
   
    draw.Color( 255, 255, 255, 255 )
    draw.Line( startLinePos.x, startLinePos.y, endLinePos.x, endLinePos.y )
end

local heldLastTickLeft = false
local heldLastTickRight = false
local startedHolding = false
function ragebotModule.ChokePeek.OnCreateMove(Cmd)
    if not (ragebotModule.ChokePeek.Options.Enabled:GetValue()) then return end
    
    if(input.IsButtonDown(ragebotModule.ChokePeek.Options.PeekKeyLeft:GetValue()) and not heldLastTickLeft) then 
        startedHolding = true 
    elseif(input.IsButtonDown(ragebotModule.ChokePeek.Options.PeekKeyRight:GetValue()) and not heldLastTickRight) then  
        startedHolding = true
    end

    if(startedHolding == true) then
        if(chokingPackets <= gui.GetValue("misc.fakelag.factor") / 2) then
            return
        else
            startedHolding = false
        end
    end

    local localPlayer = entities.GetLocalPlayer()
    local viewAngles = engine.GetViewAngles()
    if(gui.GetValue( "misc.fakelag.factor" ) % 2 ~= 0) then gui.SetValue( "misc.fakelag.factor", gui.GetValue( "misc.fakelag.factor" ) - 1 ) end-- need to be odd to work :)
    if ( input.IsButtonDown(ragebotModule.ChokePeek.Options.PeekKeyLeft:GetValue()) ) then
        if(chokingPackets <= gui.GetValue("misc.fakelag.factor") / 2) then
            MoveToPos(localPlayer:GetAbsOrigin() + viewAngles:Right(), Cmd)
        else
            MoveToPos(localPlayer:GetAbsOrigin() + viewAngles:Right() * -1, Cmd)
        end
    elseif ( input.IsButtonDown(ragebotModule.ChokePeek.Options.PeekKeyRight:GetValue()) ) then
        if(chokingPackets <= gui.GetValue("misc.fakelag.factor") / 2) then
            MoveToPos(localPlayer:GetAbsOrigin() + viewAngles:Right() * -1, Cmd)
        else
            MoveToPos(localPlayer:GetAbsOrigin() + viewAngles:Right(), Cmd)
        end
    end

    heldLastTickLeft = input.IsButtonDown(ragebotModule.ChokePeek.Options.PeekKeyLeft:GetValue())
    heldLastTickRight = input.IsButtonDown(ragebotModule.ChokePeek.Options.PeekKeyRight:GetValue())
end


--[[ Initialize Callbacks ]]--
function ragebotModule.OnCreateMove(Cmd)
    if(Cmd.command_number == 0) then return end
    ragebotModule.ChokePeek.OnCreateMove(Cmd)
    ragebotModule.QuickPeek.OnCreateMove(Cmd)
    if(Cmd.sendpacket == true) then chokingPackets = gui.GetValue("misc.fakelag.factor") else chokingPackets = chokingPackets - 1 end
end

function ragebotModule.OnDraw()
    ragebotModule.QuickPeek.OnDraw()
    ragebotModule.AntiAim.OnDraw()
end

ragebotModule.Init = function()
    callbacks.Register( "CreateMove", ragebotModule.OnCreateMove )
    callbacks.Register( "Draw", ragebotModule.OnDraw )
end

ragebotModule.Shutdown = function()
    UnloadScript( GetScriptName() )
end

return ragebotModule