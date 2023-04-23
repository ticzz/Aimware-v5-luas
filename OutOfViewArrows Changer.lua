local ref = gui.Reference("Visuals","Local","Helper");
local checkbox = gui.Checkbox(ref,"oof.checkbox", "Out Of View Extra", true);
checkbox:SetDescription("Provides out of view indicator with more customizability!");
local rainbowcheckbox = gui.Checkbox(ref,"oof.rainbow","Rainbow Arrows",true);
rainbowcheckbox:SetDescription("RGB mode!");
local colorpicker = gui.ColorPicker( ref, "oof.color", "Arrow's Colour", 255, 255, 255, 255 );
local arrowwidth = gui.Slider(ref,"oof.arrowwidth","Arrow's Width",5,1,100);
local arrowheight = gui.Slider(ref,"oof.arrowheight","Arrow's Height",50,1,100);
local radius = gui.Slider(ref,"oof.radius","Radius",280,100,1000);

function ESP()
    local finalheight = arrowheight:GetValue() + radius:GetValue() ;
    local screen_width,screen_height = draw.GetScreenSize();
    local screen_center_x = screen_width / 2 ;
    local screen_center_y = screen_height / 2 ;
    local players = entities.FindByClass( "CCSPlayer" );
    local localplayer = entities.GetLocalPlayer();
    local viewangle = engine.GetViewAngles();
    
    draw.Color(colorpicker:GetValue());
    if checkbox:GetValue() == true then
        for k,v in pairs(players) do
            local player = v;
            if player:IsAlive() and player:IsPlayer() and player:GetName() ~= localplayer:GetName() and player:GetTeamNumber() ~= localplayer:GetTeamNumber() then
                local v1 = localplayer:GetProp("m_vecOrigin");
                local v2 = player:GetAbsOrigin();
                local angle = ( v2 - v1):Angles();
                angle.y = angle.y * -1 ;
                angle.y = angle.y + viewangle.y - 90;
                angle.y = math.rad(angle.y);
                local w2sx,w2sy = client.WorldToScreen(player:GetAbsOrigin());
                if w2sx == nil and w2sy == nil or w2sx < 100 or w2sy < 100 or w2sx > screen_width-100 or w2sy > screen_height-100 then
                    draw.Triangle(screen_center_x+(radius:GetValue()*math.cos(angle.y-math.rad(arrowwidth:GetValue()*100/radius:GetValue()))), screen_center_y+(radius:GetValue()*math.sin(angle.y-math.rad(arrowwidth:GetValue()*100/radius:GetValue()))), screen_center_x+(radius:GetValue()*math.cos(angle.y+math.rad(arrowwidth:GetValue()*100/radius:GetValue()))), screen_center_y+(radius:GetValue()*math.sin(angle.y+math.rad(arrowwidth:GetValue()*100/radius:GetValue()))), screen_center_x+(finalheight*math.cos(angle.y)), screen_center_y+(finalheight*math.sin(angle.y)));
                end
            end
        end
    end
end

function rainbow()
    local frequency = 1;
    local red = math.sin((globals.RealTime() / frequency) * 4) * 127 + 128;
    local green = math.sin((globals.RealTime() / frequency) * 4 + 2) * 127 + 128;
    local blue = math.sin((globals.RealTime() / frequency) * 4 + 4) * 127 + 128;
    if rainbowcheckbox:GetValue() == true and checkbox:GetValue() == true then
        colorpicker:SetValue(red,green,blue,255);
    end
end

callbacks.Register("Draw",rainbow);
callbacks.Register("Draw",ESP);
