-- Legit Anti-Aim Indicators
-- made by TheKilledDead

local legitbotRef = gui.Reference( "Legitbot", "Semirage", "Anti-Aim" );
local indicatorCheckBox = gui.Checkbox( legitbotRef, ".indicator.checkbox", "Draw Anti-Aim Indicator", false );
local indicatorComboBox = gui.Combobox( legitbotRef, ".indicator.combobox", "Indicator Combobox", "Fake", "Real" );
local indicatorColorPicker = gui.ColorPicker( legitbotRef, ".indicator.color", "Anti-Aim Indicator Color", 200, 25, 25, 200 );
local indicatorScaleSlider = gui.Slider( legitbotRef, ".indicator.scale", "Indicator Scale", 1, 1, 5, 0.5 );
local indicatorGapSlider = gui.Slider( legitbotRef, ".indicator.gap", "Indicator Gap", 60, 10, 150, 10 );

-- Descriptions
indicatorCheckBox:SetDescription( "Draw Anti-Aim Indicators when checked" );
indicatorComboBox:SetDescription( "Choose to draw Fake or Real" );
indicatorColorPicker:SetDescription( "Set Color of Anti-Aim Indicators" );
indicatorScaleSlider:SetDescription( "Set Scale of Indicators" );
indicatorGapSlider:SetDescription( "Set Gap of Indicators" );

-- Helper Variables
local isLeft = false;
local isRight = false;
local font = draw.CreateFont( "Tahoma", 20 );

local function drawIndicators()
    if indicatorCheckBox:GetValue() then
        
        local screenW, screenH = draw.GetScreenSize();
        local screenWCenter = screenW * 0.5;
        local screenHCenter = screenH * 0.5;

        local leftKey = gui.GetValue( "lbot.antiaim.leftkey" ); -- left key
        local rightKey = gui.GetValue( "lbot.antiaim.rightkey" ); -- right key

        local indicatorScale = indicatorScaleSlider:GetValue();
        local indicatorGap = indicatorGapSlider:GetValue();

        if ( leftKey == 0 or rightKey == 0 ) then
            draw.SetFont( font );
            draw.Color( 255, 0, 0, 255 );
            draw.Text( 0, 0, " [Warning] Please set both keys for Manual Anti-Aim!" );
            return
        end

        if ( indicatorComboBox:GetValue() == 0 ) then -- If set to Fake

            if (isLeft or  input.IsButtonPressed( leftKey )) then -- draw right indicator
                isLeft = true;
                isRight = false;
                draw.Color(indicatorColorPicker:GetValue());
                draw.Triangle( screenWCenter + indicatorGap + (15 * indicatorScale), screenHCenter, screenWCenter + indicatorGap, screenHCenter + (10 * indicatorScale), screenWCenter + indicatorGap, screenHCenter - (10 * indicatorScale) );
            end

            if (isRight or input.IsButtonPressed( rightKey )) then -- draw left indicator
                isRight = true;
                isLeft = false;
                draw.Color(indicatorColorPicker:GetValue());
                draw.Triangle( screenWCenter - indicatorGap - (15 * indicatorScale), screenHCenter, screenWCenter - indicatorGap, screenHCenter - (10 * indicatorScale), screenWCenter - indicatorGap, screenHCenter + (10 * indicatorScale) );
            end
        end

        if ( indicatorComboBox:GetValue() == 1 ) then -- If set to Real

            if (isLeft or  input.IsButtonPressed( leftKey )) then -- draw left indicator
                isLeft = true;
                isRight = false;
                draw.Color(indicatorColorPicker:GetValue());
                draw.Triangle( screenWCenter - indicatorGap - (15 * indicatorScale), screenHCenter, screenWCenter - indicatorGap, screenHCenter - (10 * indicatorScale), screenWCenter - indicatorGap, screenHCenter + (10 * indicatorScale) );
            end
    
            if (isRight or input.IsButtonPressed( rightKey )) then -- draw right indicator
                isRight = true;
                isLeft = false;
                draw.Color(indicatorColorPicker:GetValue());
                draw.Triangle( screenWCenter + indicatorGap + (15 * indicatorScale), screenHCenter, screenWCenter + indicatorGap, screenHCenter + (10 * indicatorScale), screenWCenter + indicatorGap, screenHCenter - (10 * indicatorScale) );
            end
        end
   end
end

local function activationCheck()
    if (gui.GetValue( "lbot.master" )) then
        if (gui.GetValue( "lbot.antiaim.direction" ) == 1 ) then
            indicatorCheckBox:SetInvisible(false);
            indicatorColorPicker:SetInvisible(false);
            indicatorComboBox:SetInvisible(false);
            indicatorScaleSlider:SetInvisible(false);
            indicatorGapSlider:SetInvisible(false);
            drawIndicators();
        else
            indicatorCheckBox:SetInvisible(true);
            indicatorColorPicker:SetInvisible(true);
            indicatorComboBox:SetInvisible(true);
            indicatorScaleSlider:SetInvisible(true);
            indicatorGapSlider:SetInvisible(true);
        end
    end
end

callbacks.Register( "Draw", "LegitbotAntiAimIndicators",activationCheck );





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

