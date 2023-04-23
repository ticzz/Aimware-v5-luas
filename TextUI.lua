--Text-UI by Dragon--

local font = draw.CreateFont('Consolas', 15)

local function welcome()
    draw.SetFont( font );
    draw.Color( 252, 211, 3 );
    --EDIT ONLY THE NAME--
    draw.TextShadow( 320, 64, "Hello Dragon!" );
    --EDIT ONLY THE NAME--
end

local function textui()
    draw.SetFont( font );
        if gui.GetValue("lbot.aim.enable") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 96, "LegitBot: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 96, "LegitBot: Off");
    end
        if gui.GetValue("lbot.trg.enable") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 111, "TriggerBot: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 111, "TriggerBot: Off");
    end
        if gui.GetValue("esp.overlay.enemy.box") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 126, "Box ESP: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 126, "Box ESP: Off");
    end
        if gui.GetValue("esp.overlay.enemy.precision") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 141, "Box Precision: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 141, "Box Precision: Off");
    end
        if gui.GetValue("esp.chams.enemy.visible") == 0 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 156, "Chams: Off" );
        
        elseif gui.GetValue("esp.chams.enemy.visible") == 1 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 156,  "Chams: Flat" );
        
        elseif gui.GetValue("esp.chams.enemy.visible") == 2 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 156,  "Chams: Color" );
        
        elseif gui.GetValue("esp.chams.enemy.visible") == 3 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 156,  "Chams: Metallic" );
        
        elseif gui.GetValue("esp.chams.enemy.visible") == 4 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 156,  "Chams: Glow" );
        
        elseif gui.GetValue("esp.chams.enemy.visible") == 5 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 156,  "Chams: Textured" );
        
        elseif gui.GetValue("esp.chams.enemy.visible") == 6 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 156,  "Chams: Invisible" );
    end
        if gui.GetValue("esp.chams.enemy.occluded") == 0 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 171, "Chams XQZ: Off" );
        
        elseif gui.GetValue("esp.chams.enemy.occluded") == 1 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 171,  "Chams XQZ: Flat" );
        
        elseif gui.GetValue("esp.chams.enemy.occluded") == 2 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 171,  "Chams XQZ: Color" );
        
        elseif gui.GetValue("esp.chams.enemy.occluded") == 3 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 171,  "Chams XQZ: Metallic" );
        
        elseif gui.GetValue("esp.chams.enemy.occluded") == 4 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 171,  "Chams XQZ: Glow" );
    end
        if gui.GetValue("esp.chams.backtrack.visible") == 0 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 186, "Backtrack Chams: Off" );
        
        elseif gui.GetValue("esp.chams.backtrack.visible") == 1 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 186,  "Backtrack Chams: Flat" );
        
        elseif gui.GetValue("esp.chams.backtrack.visible") == 2 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 186,  "Backtrack Chams: Color" );
        
        elseif gui.GetValue("esp.chams.backtrack.visible") == 3 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 186,  "Backtrack Chams: Metallic" );
        
        elseif gui.GetValue("esp.chams.backtrack.visible") == 4 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 186,  "Backtrack Chams: Glow" );
        
        elseif gui.GetValue("esp.chams.backtrack.visible") == 5 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 186,  "Backtrack Chams: Textured" );
        
        elseif gui.GetValue("esp.chams.backtrack.visible") == 6 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 186,  "Backtrack Chams: Invisible" );
    end
        if gui.GetValue("esp.chams.backtrack.occluded") == 0 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 201, "Backtrack Chams XQZ: Off" );
        
        elseif gui.GetValue("esp.chams.backtrack.occluded") == 1 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 201,  "Backtrack Chams XQZ: Flat" );
        
        elseif gui.GetValue("esp.chams.backtrack.occluded") == 2 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 201,  "Backtrack Chams XQZ: Color" );
        
        elseif gui.GetValue("esp.chams.backtrack.occluded") == 3 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 201,  "Backtrack Chams XQZ: Metallic" );
        
        elseif gui.GetValue("esp.chams.backtrack.occluded") == 4 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow(320, 201,  "Backtrack Chams XQZ: Glow" );
    end
        if gui.GetValue("esp.other.antiobs") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 216, "Anti-OBS: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 216, "Anti-OBS: Off");
    end
        if gui.GetValue("esp.local.outofview") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 231, "Out of View Indicators: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 320, 231, "Out of View Indicators: Off");
    end
        if gui.GetValue("misc.strafe.enable") == false then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 96, "Auto Strafe: Off" );
        
        elseif gui.GetValue("misc.strafe.mode") == 0 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 96, "Auto Strafe: Silent" );
        
        elseif gui.GetValue("misc.strafe.mode") == 1 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 96,  "Auto Strafe: Normal" );
        
        elseif gui.GetValue("misc.strafe.mode") == 2 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 96,  "Auto Strafe: Sideways" );
        
        elseif gui.GetValue("misc.strafe.mode") == 3 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 96,  "Auto Strafe: W-Only" );
        
        elseif gui.GetValue("misc.strafe.mode") == 4 then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 96,  "Auto Strafe: Mouse" );
    end
        --if gui.GetValue("rbot.aim.extra.knife") == 0 then
        --draw.Color( 255, 255, 255, 255 );
        --draw.TextShadow( 550, 111, "KnifeBot: Off" );
        
        --elseif gui.GetValue("rbot.aim.extra.knife") == 1 then
        --draw.Color( 255, 255, 255, 255 );
        --draw.TextShadow( 550, 111,  "KnifeBot: Default" );
        
        --elseif gui.GetValue("rbot.aim.extra.knife") == 2 then
        --draw.Color( 255, 255, 255, 255 );
        --draw.TextShadow( 550, 111,  "KnifeBot: Backstab Only" );
        
        --elseif gui.GetValue("rbot.aim.extra.knife") == 3 then
        --draw.Color( 255, 255, 255, 255 );
        --draw.TextShadow( 550, 111,  "KnifeBot: Quick" );
    --end
        if gui.GetValue("misc.log.damage") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 111, "Log Damage: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 111, "Log Damage: Off");
    end
        if gui.GetValue("misc.log.purchases") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 126, "Log Purchases: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 126, "Log Purchases: Off");
    end
        if gui.GetValue("misc.log.console") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 141, "Log Console: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 141, "Log Console: Off");
    end
        if gui.GetValue("misc.fakelag.enable") then
        draw.Color( 255, 255, 255 ,255 );
        Draw.TextShadow( 550, 156, "Fakelag: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 156, "Fakelag: Off");
    end
        if gui.GetValue("misc.fakelatency.enable") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 171, "Fakelatency: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 171, "Fakelatency: Off");
    end
        if gui.GetValue("esp.world.hitmarkers") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 186, "Hitmarker: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 186, "Hitmarker: Off");
    end
        if gui.GetValue("misc.clantag") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 201, "Clantag: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 201, "Clantag: Off");
    end
        if gui.GetValue("rbot.aim.enable") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 231, "RageBot: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 231, "RageBot: Off");
    end
        if gui.GetValue("rbot.aim.target.silentaim") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 246, "Silent Aim: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 246, "Silent Aim: Off");
    end
        if gui.GetValue("rbot.accuracy.posadj.resolver") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 261, "Resolver: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 261, "Resolver: Off");
    end
        if gui.GetValue("rbot.accuracy.posadj.backtrack") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 276, "Backtrack: On" );
        else
        draw.Color ( 255, 255, 255, 255 );
        draw.TextShadow( 550, 276, "Backtrack: Off");
    end
        if gui.GetValue("rbot.accuracy.weapon.asniper.doublefire") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 291, "DoubleTap: On");
        else
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 291, "DoubleTap: Off");
    end
        if gui.GetValue("rbot.antiaim.advanced.antialign") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 306, "Anti-Alignment: On" );
        else
        draw.Color ( 255, 255, 255, 255 );
        draw.TextShadow( 550, 306, "Anti-Alignment: Off");
    end
        if gui.GetValue("rbot.antiaim.advanced.autodir") then
        draw.Color( 255, 255, 255, 255 );
        draw.TextShadow( 550, 321, "Auto Direction: On" );
        else
        draw.Color ( 255, 255, 255, 255 );
        draw.TextShadow( 550, 321, "Auto Direction: Off");
    end
end

callbacks.Register( "Draw", "welcome", welcome );
callbacks.Register( "Draw", "textui", textui );