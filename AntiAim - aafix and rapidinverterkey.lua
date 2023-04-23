-- menu
local ref = gui.Reference("Misc")
local luas_tab = gui.Tab(ref, "luas", "l33t's lua pack")
local luascripts_groupbox = gui.Groupbox(luas_tab, "Lua Scripts", 10, 10, 296, 0)
local antiaimfix_checkbox = gui.Checkbox(luascripts_groupbox, "antiaimfix", "Anti-Aim Fix", false)
antiaimfix_checkbox:SetDescription("this bs removes your LBY")
local indicator_checkbox = gui.Checkbox( luascripts_groupbox, "indicator", "Indicator", false) 
local inverter_key = gui.Keybox( luascripts_groupbox, "inverter", "AA Inverter", 0)
indicator_checkbox:SetDescription("indicates autodir and inverter")
local rapidinvert_checkbox = gui.Checkbox( luascripts_groupbox, "rapidinvert", "Rapid Anti-aim Inverter", false)
local switch = true;
local jitter = 0

--end
--LBY bullshit aka aafix
local function create_move(cmd)
    if not gui.GetValue( "rbot.master" ) then return end
    if gui.GetValue("misc.luas.antiaimfix") and not input.IsButtonDown( "w" ) and not input.IsButtonDown( "a" ) and not input.IsButtonDown( "s" ) and not input.IsButtonDown( "d" ) and not input.IsButtonDown( "space" ) then 
        if switch == true then
            cmd.sidemove = 2;
            switch = false;
        elseif switch == false then
            cmd.sidemove = -2;
            switch = true;
        end
    end
end

callbacks.Register( "CreateMove", create_move );
--end


local function rapidinvert()
    if gui.GetValue("misc.luas.rapidinvert") == true then
        if jitter == 0 then
            gui.SetValue("rbot.antiaim.base.rotation", 58 )
            jitter = 1
        else
            gui.SetValue("rbot.antiaim.base.rotation", -58 )
            jitter = 0
        end
    end
end
callbacks.Register( "Draw", rapidinvert)


--inverter bullshit
local function inverter()
    if input.IsButtonPressed(inverter_key:GetValue()) then
        if gui.GetValue("rbot.antiaim.base.rotation") == 58 then
            gui.SetValue( "rbot.antiaim.base.rotation", -58)
            gui.SetValue("rbot.antiaim.base.lby", 50)  
        elseif gui.GetValue("rbot.antiaim.base.rotation") == -58 then
            gui.SetValue( "rbot.antiaim.base.rotation", 58)
            gui.SetValue("rbot.antiaim.base.lby", -50)  
        end
    end
end

callbacks.Register( "Draw", inverter)
--indicators bullshit

callbacks.Register("Draw", function()
    localplayer = entities.GetLocalPlayer()
    local w, h = draw.GetScreenSize()
    draw.Color(130,200,0,255)
    draw.SetFont(draw.CreateFont("Calibri", 30, 1000))
    if indicator_checkbox:GetValue() and localplayer then
        if not gui.GetValue( "rbot.master" ) then return end

        if (gui.GetValue("rbot.antiaim.advanced.autodir") == true) then
            draw.TextShadow(2, 500, "AUTODIR")
        end
        if (gui.GetValue("rbot.antiaim.base.rotation") == -58) then
            draw.TextShadow(2, 530, "Left")
        end
        if (gui.GetValue("rbot.antiaim.base.rotation") == 58) then
            draw.TextShadow(2, 530, "Right")
        end
        if (gui.GetValue("rbot.antiaim.base.rotation") == -58) then
            gui.SetValue("rbot.antiaim.base.lby", 50)  
        end
        if (gui.GetValue("rbot.antiaim.base.rotation") == 58) then
            gui.SetValue("rbot.antiaim.base.lby", -50) 
        end
    end
 end)

--coded by nigga l33t#5156