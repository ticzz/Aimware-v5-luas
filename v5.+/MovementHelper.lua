local Version = 1.0;
-- Gui
local SettingsTab = gui.Reference("SETTINGS");

local MovementTab = gui.Tab(SettingsTab, "MovementTab", "Movement");

local IndicatorsGroupBox = gui.Groupbox(MovementTab, "Indicators", 16, 16, 287.5, 50);
local MovementFeaturesGroupBox = gui.Groupbox(MovementTab, "Movement Features", 16 + 287.5 + 16, 16, 287.5, 50);
local InfoGroupBox = gui.Groupbox(MovementTab, "Info", 16, 16 + 330 + 16, 287.5, 50);

local VersionText = gui.Text(InfoGroupBox, "Version: " .. tostring(Version));
local CreatorText = gui.Text(InfoGroupBox, "Creator: SpookGG");

local VelocityIndicatorCheckbox = gui.Checkbox(IndicatorsGroupBox, "MovementIndicatorsVelocityIndicator",
    "Velocity Indicator", false);
local VelocityIndicatorTakeOffCheckbox = gui.Checkbox(IndicatorsGroupBox, "MovementIndicatorsVelocityIndicatorTakeOff",
    "Show Take OFF", false);
local VelocityIndicatorAlphaCheckbox = gui.Checkbox(IndicatorsGroupBox, "MovementIndicatorsVelocityIndicatorAlpha",
    "Velocity Alpha", false);
local StaminaIndicatorCheckbox = gui.Checkbox(IndicatorsGroupBox, "MovementIndicatorsStamina", "Stamina Inicator", false);
local StaminaStaticColorPicker = gui.ColorPicker(IndicatorsGroupBox, "MovementIndicatorsStaminaStaticColorPicker",
    "Stamina Staic Color", 255, 255, 255, 255);
local IndicatorsFeaturesMultiBox = gui.Multibox(IndicatorsGroupBox, "Indicator Options");

local IndicatorsJumpBug = gui.Checkbox(IndicatorsFeaturesMultiBox, "MovementIndicatorsIndicatorsFeaturesMultiboxJumpBug"
    , "Jump Bug", false);
local IndicatorsLongJump = gui.Checkbox(IndicatorsFeaturesMultiBox,
    "MovementIndicatorsIndicatorsFeaturesMultiboxLongJump", "Long Jump", false);
local IndicatorsMiniJump = gui.Checkbox(IndicatorsFeaturesMultiBox,
    "MovementIndicatorsIndicatorsFeaturesMultiboxMiniJump", "Mini Jump", false);
local IndicatorsEdgeBug = gui.Checkbox(IndicatorsFeaturesMultiBox, "MovementIndicatorsIndicatorsFeaturesMultiboxEdgeBug"
    , "EdgeBug", false);
local IndicatorsColor = gui.ColorPicker(IndicatorsFeaturesMultiBox,
    "MovementIndicatorsIndicatorsFeaturesMultiboxIndicatorsColor", "Indicator Color", 255, 255, 255, 255);

local IndicatorPosSlider = gui.Slider(IndicatorsGroupBox, "MovementIndicatorsIndicatorPos", "Indicator Postion", 80, 0,
    100);

local JumpBugCheckbox = gui.Checkbox(MovementFeaturesGroupBox, "MovementMovementFeaturesJumpBug", "Jump Bug", false);
local LongJumpCheckbox = gui.Checkbox(MovementFeaturesGroupBox, "MovementMovementFeaturesLongJump", "Long Jump", false);
local MiniJumpCheckbox = gui.Checkbox(MovementFeaturesGroupBox, "MovementMovementFeaturesMiniJump", "Mini Jump", false);
local EdgeBugCheckbox = gui.Checkbox(MovementFeaturesGroupBox, "MovementMovementFeaturesEdgeBug", "Edge Bug", false);

--Fonts
local VelocityIndicatorFont = draw.CreateFont("Verdana", 26, 900);

-- BackUp Vars
local BackUpFlags = 0;


local LastVelocity = 0;
local TakeOffVelocity = 0;
local LastTick = 0;
local TakeOffed = false;
local TakeOffVelocity = 0;
function DrawIndicator()
    if (entities.GetLocalPlayer() and entities.GetLocalPlayer():IsAlive()) then
        local LocalPlayer = entities.GetLocalPlayer();

        local vX, vY = LocalPlayer:GetPropFloat("localdata", 'm_vecVelocity[0]'),
            LocalPlayer:GetPropFloat("localdata", 'm_vecVelocity[1]');
        local Velocity = math.floor(math.min(10000, math.sqrt(vX * vX + vY * vY) + 0.5));
        local Stamina = LocalPlayer:GetPropFloat("cslocaldata", 'm_flStamina');
        local Text = tostring(Velocity);
        local IndicatorsFeaturesCompostion = "";

        if (IndicatorsJumpBug:GetValue() and JumpBugCheckbox:GetValue()) then
            IndicatorsFeaturesCompostion = IndicatorsFeaturesCompostion .. " jb ";
        end

        if (IndicatorsLongJump:GetValue() and LongJumpCheckbox:GetValue()) then
            IndicatorsFeaturesCompostion = IndicatorsFeaturesCompostion .. " lj ";
        end

        if (IndicatorsMiniJump:GetValue() and MiniJumpCheckbox:GetValue()) then
            IndicatorsFeaturesCompostion = IndicatorsFeaturesCompostion .. " mj ";
        end

        if (IndicatorsEdgeBug:GetValue() and EdgeBugCheckbox:GetValue()) then
            IndicatorsFeaturesCompostion = IndicatorsFeaturesCompostion .. " eb ";
        end

        local Flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
        local Onground = bit.band(Flags, 1) ~= 0;

        local Delta = Velocity - LastVelocity;

        if (VelocityIndicatorTakeOffCheckbox:GetValue()) then
            if not (Onground) then
                if not (TakeOffed) then
                    TakeOffVelocity = Velocity;
                    TakeOffed = true;
                end
                Text = Velocity .. "(" .. TakeOffVelocity .. ")";
            else
                if (TakeOffed) then
                    TakeOffed = false;
                end
                Text = tostring(Velocity);
            end
        end

        draw.SetFont(VelocityIndicatorFont);
        local screenX, screenY = draw.GetScreenSize();
        local MidX, MidY = screenX / 2, screenY / 2;

        local PositionRaw = IndicatorPosSlider:GetValue();
        local PositionAbsolute = 0;
        if (PositionRaw > 50) then
            PositionAbsolute = (screenY / 100) * (PositionRaw - 50);
        elseif (PositionRaw == 50) then
            PositionAbsolute = 0;
        elseif (PositionRaw < 50) then
            PositionAbsolute = (screenY / 100) * (PositionRaw - 50);
        end


        if (VelocityIndicatorCheckbox:GetValue()) then
            local TextWidht, TextHeight = draw.GetTextSize(Text);

            local Alpha = 255;
            if (VelocityIndicatorAlphaCheckbox:GetValue()) then
                if (Velocity < 255) then
                    Alpha = Velocity;
                else
                    Alpha = 255
                end
            end

            draw.Color(0, 0, 0, Alpha);
            draw.Text(MidX - (TextWidht / 2) + 1, MidY - (TextHeight / 2) + 1 + PositionAbsolute, Text);
            if (Delta > 0) then
                draw.Color(25, 255, 125, Alpha);
            elseif (Delta == 0) then
                draw.Color(255, 200, 100, Alpha);
            elseif (Delta < 0) then
                draw.Color(225, 100, 100, Alpha);
            end
            draw.Text(MidX - (TextWidht / 2), MidY - (TextHeight / 2) + PositionAbsolute, Text);
        end

        if (StaminaIndicatorCheckbox:GetValue()) then
            local StaminaText = string.sub(tostring(Stamina), 0, 4);
            local TextWidht, TextHeight = draw.GetTextSize(StaminaText);
            local Alpha = 0;
            if (Stamina < 39) then
                Alpha = Stamina * 7;
            else
                Alpha = 255;
            end
            draw.Color(0, 0, 0, Alpha);
            draw.Text(MidX - (TextWidht / 2) + 1, MidY - (TextHeight / 2) + PositionAbsolute + 31 + 1, StaminaText);
            local ColorR, ColorG, ColorB, ColorA = StaminaStaticColorPicker:GetValue();
            draw.Color(ColorR, ColorG, ColorB, Alpha);
            draw.Text(MidX - (TextWidht / 2), MidY - (TextHeight / 2) + PositionAbsolute + 31, StaminaText);
        end

        local IndicatorColorR, IndicatorColorG, IndicatorColorB, IndicatorColorA = IndicatorsColor:GetValue();
        local IndicatorTextWidht, IndicatorTextHeight = draw.GetTextSize(IndicatorsFeaturesCompostion);
        draw.Color(0, 0, 0, IndicatorColorA);
        draw.Text(MidX - (IndicatorTextWidht / 2) + 1, MidY - (IndicatorTextHeight / 2) + PositionAbsolute - 31 + 1,
            IndicatorsFeaturesCompostion);
        draw.Color(IndicatorColorR, IndicatorColorG, IndicatorColorB, IndicatorColorA);
        draw.Text(MidX - (IndicatorTextWidht / 2), MidY - (IndicatorTextHeight / 2) + PositionAbsolute - 31,
            IndicatorsFeaturesCompostion);

        if ((LastTick + 5) < globals.TickCount()) then
            LastTick = globals.TickCount();
            LastVelocity = Velocity;
        end
    end
end

function DoJumpBug(UserCmd)
    gui.SetValue("misc.autojump", 0);
    if (not (bit.band(BackUpFlags, 1) ~= 0) and (bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) ~= 0)) then
        UserCmd.buttons = bit.bor(UserCmd.buttons, 4);
        UserCmd.buttons = bit.band(UserCmd.buttons, bit.bnot(2));
    end
end

local SaveTickCountLongJump = 0;
local CanLongJump = false;
function DoLongJump(UserCmd)
    if (bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) ~= 0) then
        SaveTickCountLongJump = UserCmd.tick_count;
    end

    if (UserCmd.tick_count - SaveTickCountLongJump > 2) then
        CanLongJump = false;
    else
        CanLongJump = true;
    end

    if (CanLongJump and not (bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) ~= 0)) then
        UserCmd.buttons = bit.bor(UserCmd.buttons, 4);
        client.Command("-forward", true);
    end

    if (not (bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) ~= 0) and (bit.band(BackUpFlags, 1) ~= 0)) then
        UserCmd.buttons = bit.bor(UserCmd.buttons, 2);
    end
end

local PerformMiniJump = false;
local MiniJumpTicks = 0;
function DoMiniJump(UserCmd)
    if ((bit.band(BackUpFlags, 1) ~= 0) and not (bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) ~= 0)) then
        UserCmd.buttons = bit.bor(UserCmd.buttons, 2);
        PerformMiniJump = true;
        MiniJumpTicks = UserCmd.tick_count + 1;
    end

    if (PerformMiniJump) then
        if (UserCmd.tick_count < MiniJumpTicks) then
            UserCmd.buttons = bit.bor(UserCmd.buttons, 4);
        end
    end
end

function EdgeBug(UserCmd)
    if ((bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) ~= 0)) then
        return;
    end

    if ((bit.band(BackUpFlags, 1) ~= 0)) then
        UserCmd.buttons = bit.bor(UserCmd.buttons, 4);
    end
end

callbacks.Register("Draw", function()
    DrawIndicator();
end);

callbacks.Register("PreMove", function(UserCmd)
    BackUpFlags = entities.GetLocalPlayer():GetPropInt("m_fFlags");
end);

callbacks.Register("PostMove", function(UserCmd)
    if (JumpBugCheckbox:GetValue()) then
        DoJumpBug(UserCmd);
    else
        gui.SetValue("misc.autojump", 1);
    end

    if (LongJumpCheckbox:GetValue()) then
        DoLongJump(UserCmd);
    end

    if (MiniJumpCheckbox:GetValue()) then
        DoMiniJump(UserCmd);
    end

    if (EdgeBugCheckbox:GetValue()) then
        EdgeBug(UserCmd);
    end
end);
--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")
