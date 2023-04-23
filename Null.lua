-- Null by stacky

local iScreenW, iScreenH = draw.GetScreenSize()

local guiGBOX = gui.Groupbox( gui.Reference( "Misc", "Movement" ), "Null", 16, 570, 298, 0 )
local guiType = gui.Combobox( guiGBOX, "null.type", "Type", "Switch", "Stay" )
local guiNullSideways = gui.Checkbox( guiGBOX, "null.sideways", "Null A/D", false )
guiNullSideways:SetDescription("Prevents you from pressing both A and D.")
local guiNullForwards = gui.Checkbox( guiGBOX, "null.forwards", "Null W/S", false )
guiNullForwards:SetDescription("Prevents you from pressing both W and S.")
local guiIndicator = gui.Checkbox( guiGBOX, "null.indicator", "Indicator", false )
guiIndicator:SetDescription("Display an indicator when it's nulling.")
local guiIndicatorColor = gui.ColorPicker( guiIndicator, "null.indicator.color", "Cock and ball torture", 3, 144, 252, 180 )
guiIndicatorColor:SetInvisible(true)
local guiIndicatorX = gui.Slider( guiGBOX, "null.indicator.x", "Indicator X Offset", iScreenW / 2, 0, iScreenW )
guiIndicatorX:SetInvisible(true)
local guiIndicatorY = gui.Slider( guiGBOX, "null.indicator.y", "Indicator Y Offset", iScreenH - 100, 0, iScreenH )
guiIndicatorY:SetInvisible(true)

local font = draw.CreateFont("Verdana Bold", 25, 700)
local bNullingSideways = false
local bNullingForwards = false

local flLastA, flLastD = 0, 0
local flLastW, flLastS = 0, 0

local W = 87
local S = 83
local A = 65
local D = 68

callbacks.Register("CreateMove", function(cmd)
    bNullingSideways = false
    bNullingForwards = false
    local switch = 1
    if guiType:GetValue() == 0 then switch = -1 end

    local hLocalPlayer = entities.GetLocalPlayer()
    if not hLocalPlayer then return end

    local bOnGround = bit.band(hLocalPlayer:GetPropInt("m_fFlags"), 1) ~= 0
    if bOnGround then return end

    if guiNullSideways:GetValue() and input.IsButtonDown(A) and input.IsButtonDown(D) then
        if flLastD < flLastA then
            cmd.sidemove = -450 * switch
        else
            cmd.sidemove = 450 * switch
        end

        bNullingSideways = true
    end

    if guiNullForwards:GetValue() and input.IsButtonDown(W) and input.IsButtonDown(S) then
        if flLastS < flLastW then
            cmd.forwardmove = 450 * switch
        else
            cmd.forwardmove = -450 * switch
        end

        bNullingForwards = true
    end

    if input.IsButtonDown(W) and not bNullingForwards then flLastW = globals.CurTime() end
    if input.IsButtonDown(S) and not bNullingForwards then flLastS = globals.CurTime() end
    if input.IsButtonDown(A) and not bNullingSideways then flLastA = globals.CurTime() end
    if input.IsButtonDown(D) and not bNullingSideways then flLastD = globals.CurTime() end
end)

callbacks.Register("Draw", function()
    if guiIndicator:GetValue() then
        guiIndicatorColor:SetInvisible(false)
        guiIndicatorX:SetInvisible(false)
        guiIndicatorY:SetInvisible(false)
    else
        guiIndicatorColor:SetInvisible(true)
        guiIndicatorX:SetInvisible(true)
        guiIndicatorY:SetInvisible(true)
    end

    if not guiIndicator:GetValue() then return end

    draw.SetFont( font )
    draw.Color(guiIndicatorColor:GetValue())
    local iScreenW, iScreenH = draw.GetScreenSize()

    if bNullingSideways then
        local iTextW, iTextH = draw.GetTextSize( "nulling A/D" )
        draw.Text(guiIndicatorX:GetValue() - iTextW / 2, guiIndicatorY:GetValue(), "nulling A/D")
    end

    if bNullingForwards then
        local iTextW, iTextH = draw.GetTextSize( "nulling W/S" )
        draw.Text(guiIndicatorX:GetValue() - iTextW / 2, guiIndicatorY:GetValue() - 40, "nulling W/S")
    end
end)













--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

