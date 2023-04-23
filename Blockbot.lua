-- * Useful functions
local function round(n, d)
    local p = 10^d
    return math.floor(n*p)/p
end

local function cap(x, min, max)
    if x < min then
        return min
    elseif x > max then
        return max
    end

    return x
end

-- * Register Menu
local GriefReference = gui.Reference("MISC","Movement")
--local GriefMenuTab = gui.Tab(GriefReference, "griefmenu.tab", "Griefing")

-- Blockbot groupbox
local GriefBlockbotGroupbox = gui.Groupbox(GriefReference, "Blockbot", 330, 760, 200, 100)
BlockbotEnable = gui.Checkbox(GriefBlockbotGroupbox, "blockboit.enable", "Enable", false)
BlockbotExtrapolation = gui.Checkbox(GriefBlockbotGroupbox, "blockbot.lerp", "Extrapolation", true)
BlockbotKey = gui.Keybox(GriefBlockbotGroupbox, "blockbot.key", "Key", 0)
BlockbotRetreatBhop = gui.Checkbox(GriefBlockbotGroupbox, "blockbot.retreat", "Retreat on Bhop", 0)
BlockbotRetreatSpeed = gui.Slider(GriefBlockbotGroupbox, "blockbot.retreat.speed", "Retreat Speed", 285.0, 50.0, 300.0)

-- * Blockbot
local BlockbotIconFont = draw.CreateFont("Veranda", 64, 64)
local BlockbotTextFont = draw.CreateFont("Veranda", 32, 64)
local BlockbotTarget = nil
local BlockbotCrouchBlock = false
local BlockbotLocalPlayer = nil

local function BlockbotOnFrameMain()
    if BlockbotEnable:GetValue() == false then
        return
    end
    
    BlockbotLocalPlayer = entities.GetLocalPlayer()
    if BlockbotLocalPlayer == nil or engine.GetServerIP() == nil then
        return
    end

    if (BlockbotKey:GetValue() == nil or BlockbotKey:GetValue() == 0) or not BlockbotLocalPlayer:IsAlive() then
        return
    end

    if input.IsButtonDown(BlockbotKey:GetValue()) and BlockbotTarget == nil then
        for Index, Entity in pairs(entities.FindByClass("CCSPlayer")) do
            if Entity:GetIndex() ~= BlockbotLocalPlayer:GetIndex() and Entity:IsAlive() then
                if BlockbotTarget == nil then
                    BlockbotTarget = Entity;
                elseif (BlockbotLocalPlayer:GetAbsOrigin() - BlockbotTarget:GetAbsOrigin()):Length() > (BlockbotLocalPlayer:GetAbsOrigin() - Entity:GetAbsOrigin()):Length() then
                    BlockbotTarget = Entity;
                end
            end
        end
    elseif not input.IsButtonDown(BlockbotKey:GetValue()) or not BlockbotTarget:IsAlive() then
        BlockbotTarget = nil
    end

    if BlockbotTarget ~= nil then
        local TargetPos = BlockbotTarget:GetBonePosition(5)
        local PosX, PosY = client.WorldToScreen(TargetPos)
        if PosX ~= nil and PosY ~= nil then
            -- Indicator
            if BlockbotTarget:GetHitboxPosition(0).z < BlockbotLocalPlayer:GetAbsOrigin().z and vector.Distance({BlockbotLocalPlayer:GetAbsOrigin()}, {BlockbotTarget:GetAbsOrigin()}) < 100 then
                BlockbotCrouchBlock = true
                draw.Color(255, 255, 0, 255)    
            else
                BlockbotCrouchBlock = false
                draw.Color(255, 0, 0, 255)
            end
            draw.SetFont(BlockbotIconFont)
            local IconSizeW, IconSizeH = draw.GetTextSize("+")
            draw.TextShadow(PosX - IconSizeW / 2, PosY, "+")
            
            -- Distance
            local Diff = BlockbotLocalPlayer:GetAbsOrigin() - BlockbotTarget:GetAbsOrigin()
            local Distance = tostring(round(Diff:Length(), 0))
            draw.Color(64, 255, 64, 255)
            draw.SetFont(BlockbotTextFont)
            local DistanceSizeW, DistanceSizeH = draw.GetTextSize(Distance)
            draw.TextShadow(PosX - DistanceSizeW / 2, PosY + IconSizeH*5/4, Distance)
            
            -- Velocity
            local TargetSpeed = vector.Length(BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[0]"), BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[1]"), BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[2]"))
            draw.Color(64, 64, 255, 255)
            if TargetSpeed > BlockbotRetreatSpeed:GetValue() and BlockbotRetreatBhop:GetValue() then
                draw.Color(255, 255, 64, 255)
            end
            local SpeedStr = tostring(round(TargetSpeed, 0))
            local SpeedSizeW, SpeedSizeH = draw.GetTextSize(SpeedStr)
            draw.TextShadow(PosX - SpeedSizeW / 2, PosY - IconSizeH*2/4, SpeedStr)
        end
    end
end

local targetAccel
local localAccel
local lastTargetSpeed = Vector3(0,0,0)
local lastLocalSpeed = Vector3(0,0,0)
local function BlockbotOnCreateMoveMain(UserCmd)
    if BlockbotEnable:GetValue() == false then
        return
    end
    if BlockbotTarget ~= nil then
	targetAccel = Vector3(BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[0]"), BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[1]"), BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[2]"))
	targetAccel = (targetAccel - lastTargetSpeed) * globals.TickInterval()
	local lastTargetSpeed = Vector3(BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[0]"), BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[1]"), BlockbotTarget:GetPropFloat("localdata", "m_vecVelocity[2]"))
        local TargetSpeed = lastTargetSpeed:Length()

	localAccel = Vector3(BlockbotLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[0]"), BlockbotLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[1]"), BlockbotLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[2]"))
	localAccel = (localAccel - lastLocalSpeed) * globals.TickInterval()
	local lastLocalSpeed = Vector3(BlockbotLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[0]"), BlockbotLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[1]"), BlockbotLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[2]"))

        local LocalAngles = UserCmd:GetViewAngles()
	local VecForward
	if BlockbotExtrapolation:GetValue() == true then
       	    VecForward = BlockbotTarget:GetAbsOrigin() + lastTargetSpeed * globals.TickInterval() + targetAccel * globals.TickInterval()*globals.TickInterval() / 2 - BlockbotLocalPlayer:GetAbsOrigin() + lastLocalSpeed * globals.TickInterval() + localAccel * globals.TickInterval()*globals.TickInterval() / 2
	else
            VecForward = BlockbotTarget:GetAbsOrigin() - BlockbotLocalPlayer:GetAbsOrigin()
	end
        local AimAngles = VecForward:Angles()
        
        if BlockbotCrouchBlock == true then
            UserCmd.forwardmove = cap( ((math.sin(math.rad(LocalAngles.y) ) *  VecForward.y) + (math.cos(math.rad(LocalAngles.y) ) * VecForward.x)) * 450, -450, 450)
            UserCmd.sidemove    = cap( ((math.cos(math.rad(LocalAngles.y) ) * -VecForward.y) + (math.sin(math.rad(LocalAngles.y) ) * VecForward.x)) * 450, -450, 450)
        else
            local DiffYaw = AimAngles.y - LocalAngles.y
            if DiffYaw > 180 then
                DiffYaw = DiffYaw - 360
            elseif DiffYaw < -180 then
                DiffYaw = DiffYaw + 360
            end
            if TargetSpeed > BlockbotRetreatSpeed:GetValue() and BlockbotRetreatBhop:GetValue() then
                UserCmd.forwardmove = -math.abs(TargetSpeed)
            end
            if DiffYaw > 0.25 then
                UserCmd.sidemove = -450
            elseif DiffYaw < -0.25 then
                UserCmd.sidemove = 450
            end
        end
    end
end

callbacks.Register("Draw", "BlockbotOnFrameMain", BlockbotOnFrameMain)
callbacks.Register("CreateMove", "BlockbotOnCreateMoveMain", BlockbotOnCreateMoveMain)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

