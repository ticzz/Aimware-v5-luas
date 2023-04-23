--Working on aimware
--by qi

--gui
local HealthArmor_Reference = gui.Reference( "Visuals","Local","Camera" )
local HealthArmor_Checkbox = gui.Checkbox(HealthArmor_Reference, "hparmorui.enable", "Health Armor UI", 0);

--var
local w, h = draw.GetScreenSize()
local font = draw.CreateFont( "Segoe UI", 28, 500 )

--alpha function
local function alpha_stop( val, min, max )
    if val < min then return min end
    if val > max then return max end
    return val;
end
--On darw
local function Ondarw()

    local lp = entities.GetLocalPlayer()
    if lp ~= nil and HealthArmor_Checkbox:GetValue() then 
        local x, y = 15,1025
        local hp = lp:GetHealth()
        local armor = lp:GetProp("m_ArmorValue")
        client.SetConVar("hidehud", 8, true)

        local fade_factor = ((1.0 / 0.15) * globals.FrameTime()) * 25;

        if alpha == nil then
        alpha = {hp = 100};
        end
        if hp ~= 100 then--hp alpha animation
            alpha.hp = alpha_stop( alpha.hp - fade_factor, hp, 100 );
        else
            alpha.hp = alpha_stop( alpha.hp + fade_factor, 0, hp );
        end

        if alpha2 == nil then
            alpha2 = {armor = 100};
        end
        if armor ~= 100 then--armor alpha animation
            alpha2.armor = alpha_stop( alpha2.armor - fade_factor, armor, 100 );
        else
            alpha2.armor = alpha_stop( alpha2.armor + fade_factor, 0, armor );
        end

        draw.SetFont( font )
        draw.Color( 4, 4, 4, 200 )
        draw.Text( x+4, y+6, hp )
        draw.Text( x+154, y+6, armor )

        if hp > 85 then
            draw.Color( 0, 255, 0, 255 )
        elseif hp > 75 then
            draw.Color( 173, 255, 47, 255 )
        elseif hp > 60 then
            draw.Color( 255, 255, 0, 255 ) 
        elseif hp > 40 then
            draw.Color( 209, 154, 102, 255 )  
        elseif hp > 20 then
            draw.Color( 238, 99, 99, 255 ) 
        elseif hp >= 0 then
            draw.Color( 255, 0, 0, 255 ) 
        end

        draw.FilledRect( x, y+30, x+alpha.hp*1.15, y+45 )
        draw.Text( x+5, y+7, hp )
        draw.Color( 8, 165, 224, 255 ) 
        draw.Text( x+155, y+7, armor )
        draw.FilledRect( x+150, y+30, x+150+alpha2.armor*1.6, y+45 )
    
        draw.Color( 4, 4, 4, 255 )
        draw.Text( x+74, y+6, "HP" )
        draw.Text( x+224, y+6, "ARMOR" )
        draw.Color( 255, 255, 255, 255 )
        draw.Text( x+75, y+7, "HP" )
        draw.Text( x+225, y+7, "ARMOR" )

        draw.Color( 4, 4, 4, 255 )
        draw.OutlinedRect( x-1, y+30, x+115, y+45 )
        draw.OutlinedRect( x+149, y+30, x+310, y+45 )
    else
        client.SetConVar("hidehud", 0, true)
    end   
     
end
--callbacks
callbacks.Register("Draw", Ondarw)    
--end
--







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

