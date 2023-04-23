    local tick_count = 0
    local ref_c = gui.Reference("Ragebot", "Aimbot", "Toggle")
    local check_c = gui.Checkbox(ref_c, "fakelag.onshot", "Fakelag on Shot", false)

    local ref = gui.Reference("Ragebot", "Hitscan", "Mode")
    local key_aw = gui.Keybox(ref, "autowall.key", "Autowall on key", 0)
    local tickcount = 0

    local ref_1 = gui.Reference("Ragebot", "Anti-Aim", "Advanced")
    local box_left = gui.Keybox(ref_1, "manual.aa.left", "Left ", gui.GetValue("lbot.antiaim.leftkey"))
    local box_right = gui.Keybox(ref_1, "manual.aa.right", "Right ", gui.GetValue("lbot.antiaim.rightkey"))

    local left = false
    local right = false
    local fonts = { "Verdana", "Arial", "Fixedsys" }
    
    local indicator_tabl = { {} };
    
    local function IndicatorForCheckbox(text, var, mode, status, r1, g1, b1, a1, r2, g2, b2, a2)
        local on
        if mode == 0 then
            on = true
            if gui.GetValue(var) then
                rf, gf, bf, af = r1, g1, b1, a1
            else
                rf, gf, bf, af = r2, g2, b2, a2
            end
        else
            if gui.GetValue(var) then
                on = true
                rf, gf, bf, af = r1, g1, b1, a1
            else
                on = false
            end
        end
        if status and on then
            indicator_tabl[#indicator_tabl + 1] = { text, rf, gf, bf, af };
        end
    end
    
    local function IndicatorForKeybox(text, var, mode, status, r1, g1, b1, a1, r2, g2, b2, a2)
        local on
        if entities.GetLocalPlayer() == nil or not entities.GetLocalPlayer():IsAlive() then
            return
        end
        if gui.GetValue(var) ~= 0 then
            if mode == 0 or mode == 3 then
                on = true
                if input.IsButtonDown(gui.GetValue(var)) then
                    rf, gf, bf, af = r1, g1, b1, a1
                else
                    rf, gf, bf, af = r2, g2, b2, a2
                end
            elseif mode == 1 then
                if input.IsButtonDown(gui.GetValue(var)) then
                    rf, gf, bf, af = r1, g1, b1, a1
                    on = true
                else
                    on = false
                end
            elseif mode == 2 then
                on = true
                if input.IsButtonDown(gui.GetValue(var)) then
                    rf, gf, bf, af = r1, g1, b1, a1
                else
                    rf, gf, bf, af = r2, g2, b2, a2
                end
            elseif mode == 4 then
                on = false
            end
        elseif gui.GetValue(var) == 0 then
            if mode == 2 then
                rf, gf, bf, af = r2, g2, b2, a2
                on = true
            elseif mode == 3 then
                rf, gf, bf, af = r1, g1, b1, a1
                on = true
            elseif mode == 4 then
                rf, gf, bf, af = r1, g1, b1, a1
                on = true
            end
        end
    
        if on and status then
            indicator_tabl[#indicator_tabl + 1] = { text, rf, gf, bf, af };
        end
    end

    local ref_trigger = gui.Reference( "Legitbot","Triggerbot","Toggle")
    local magnet = gui.Keybox( ref_trigger, "magnet", "Magnet", 0 )
    magnet:SetDescription("Activates Ragebot autoshot while pressed for fov set below")
    local fov_slider = gui.Slider(ref_trigger,"magnet.fov","Magnet Fov",1,0,180)
    local magnet_silent = gui.Checkbox( ref_trigger, "magnet.silent", "Silent Magnet", false )
    fov_slider:SetDescription("Use manual legit aa, after setting keys reload")
    gui.SetValue("rbot.antiaim.base","0.0 Desync")
    gui.SetValue("rbot.antiaim.advanced.pitch","Off")
    gui.SetValue("rbot.antiaim.advanced.autodir",false)
    gui.SetValue("rbot.antiaim.advanced.antialign",false)
    gui.SetValue("rbot.antiaim.advanced.antiresolver",false)
    local text = ""
    local font_inj = draw.CreateFont( "Arial", 40, 500 )
    local fac = 1
    callbacks.Register("Draw", function()

        local left_key = box_left:GetValue()
        local right_key = box_right:GetValue()
        local aw = key_aw:GetValue()
        local magnet_key = magnet:GetValue()
        local x,y = draw.GetScreenSize()

        if left_key ~= 0 or right_key ~= 0 then
            if input.IsButtonPressed(right_key) then
                gui.SetValue("rbot.antiaim.base.rotation", -58)
                gui.SetValue("rbot.antiaim.base.lby", 120)
                text = ">"
                fac = -20
            elseif input.IsButtonPressed(left_key) then
                gui.SetValue("rbot.antiaim.base.rotation", 58)
                gui.SetValue("rbot.antiaim.base.lby", -120)
                text = "<"
                fac = 20
            end
        end

        local size, sizey = draw.GetTextSize( text )
        draw.SetFont( font_inj )
        draw.Color(255,255,0,255)
        local wigh = x/2-(fac*size)
        draw.Text(wigh,y/2-sizey, text)

        if  magnet_key ~= 0 then 
            IndicatorForKeybox("Magnet Trigger", "lbot.trg.magnet", 1, true, 134, 235, 52,255)
            if input.IsButtonDown(magnet_key) then
                gui.SetValue("rbot.master",true)
                gui.SetValue("rbot.aim.key", magnet_key)
                gui.SetValue("rbot.aim.target.fov", fov_slider:GetValue())
                gui.SetValue("rbot.aim.target.silentaim", magnet_silent:GetValue())
            end
            if not input.IsButtonDown(magnet_key) then
                gui.SetValue("lbot.master",true)
            end
        end

        if aw ~= 0 then  
            if input.IsButtonPressed(aw) and not gui.GetValue("rbot.hitscan.mode.shared.autowall") then
                gui.SetValue("rbot.hitscan.mode.shared.autowall", true)
            elseif input.IsButtonPressed(aw) and gui.GetValue("rbot.hitscan.mode.shared.autowall") then
                gui.SetValue("rbot.hitscan.mode.shared.autowall", false)
            end
        end

        IndicatorForCheckbox("Autowall", "rbot.hitscan.mode.shared.autowall", 1, true,134, 235, 52,255)
        
    end)

    callbacks.Register("CreateMove", function(cmd)
        
        if not check_c:GetValue() or not gui.GetValue("rbot.master") then
            return
        end

        local IN_ATTACK = bit.lshift(1, 0)
        local IN_ATTACK2 = bit.lshift(1, 11)
        if bit.band(cmd.buttons, IN_ATTACK) == IN_ATTACK then
            tick_count = globals.TickCount()
            cmd:SetSendPacket(false)
        end

        if tick_count + 7 > globals.TickCount() then
            cmd:SetSendPacket(false)
        end
    end)

    local box
    local wight_slider
    local high_slider
    local gap_slider
    local theme_combo
    local font_size
    local font_thickness
    local setup_done = false
    
    local function set_up_gui(x, y)
        if (not setup_done) then
            vis_main = gui.Reference('VISUALS', "MISC", "Assistance");
            box = gui.Groupbox(vis_main, "Indicator")
            wight_slider = gui.Slider(box, "wight_slider_indicator", "X Pos", 30, 10, x);
            high_slider = gui.Slider(box, "high_slider_indicator", "Y-Pos", 45, 30, y);
            gap_slider = gui.Slider(box, "gap_slider", "Gap", 25, 0, 100);
            theme_combo = gui.Combobox(box, 'Fonts_Indicator', " Font", "Verdana", "Arial", "Fixedsys");
            font_size = gui.Slider(box, "font_slider_indicator", "Font Size", 25, 0, 60);
            font_thickness = gui.Slider(box, "font_slider_indicator", "Font Size", 700, 100, 1000);
            setup_done = true
        end
    end
    
    
    local function draw_Indicator()
        local sw, sh = draw.GetScreenSize();
        set_up_gui(sw, sh)
        if setup_done then
            top_text = sh - (gap_slider:GetValue() * #indicator_tabl) - high_slider:GetValue();
            draw.SetFont(draw.CreateFont(fonts[theme_combo:GetValue() + 1], math.floor(font_size:GetValue()), math.floor(font_thickness:GetValue())))
            for i = 1, #indicator_tabl do
                draw.Color(indicator_tabl[i][2], indicator_tabl[i][3], indicator_tabl[i][4], indicator_tabl[i][5]);
                draw.TextShadow(wight_slider:GetValue(), top_text + gap_slider:GetValue() * i, indicator_tabl[i][1]);
            end
            indicator_tabl = {};
        end
    end
    
    callbacks.Register("Draw", "draw_Indicator", draw_Indicator);