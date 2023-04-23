local weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}

local options = {0,0,0,0,0,0,0,0,0,0,0}

local violet_ref = gui.Groupbox(gui.Reference("Ragebot","Hitscan"),"Violet.lua",329,315,296)

local violet_main = gui.Groupbox(gui.Reference("Ragebot","Hitscan"),"Violet.lua main",16,468,296)

local violet_ = {

     gui.Checkbox(violet_main,"violet.firemode","Fire mode",0)
    ,gui.Combobox(violet_main,"violet.firemode.selection","Fire mode","Off","Shift fire","Defensive fire","Defensive warp fire")
    ,gui.Checkbox(violet_main,"violet.damage.override","Minimum damage override",0)
    ,gui.Checkbox(violet_main,"violet.keybinds","Key binds",0)

}

local keybinds = gui.Window("violet.keybinds","Binds",500,500,200,36)

local binds = {

     gui.Text(keybinds,"Shift Fire")
    ,gui.Text(keybinds,"Defensive Fire")
    ,gui.Text(keybinds,"Defensive Warp Fire")
    ,gui.Text(keybinds,"Minimum Damage Override")
    ,gui.Text(keybinds,"Roll Angle")
    ,gui.Text(keybinds,"Fake Duck")
    ,gui.Text(keybinds,"Slow Walk")
    ,gui.Text(keybinds,"Auto Peek")
    ,gui.Text(keybinds,"Edge Jump")

}

for i = 1,#options do

    options[weapons[i]] = {

         gui.Checkbox(violet_ref,"violet.enabled."..weapons[i],"Enable",0)
        ,gui.Slider(violet_ref,"violet.default.damage."..weapons[i],"Minimum damage [Default]",50,1,130)
        ,gui.Slider(violet_ref,"violet.defensivewarpfire.damage."..weapons[i],"Minimum damage [Defensive warp fire]",50,1,130)
        ,gui.Slider(violet_ref,"violet.override.damage."..weapons[i],"Minimum damage [Override]",50,1,130)
        ,gui.Slider(violet_ref,"violet.default.hitchance."..weapons[i],"Hitchance [Default]",50,0,100)
        ,gui.Slider(violet_ref,"violet.defensivewarpfire.hitchance."..weapons[i],"Hitchance [Defensive warp fire]",50,0,100)
        ,gui.Slider(violet_ref,"violet.burst.hitchance."..weapons[i],"Hitchance [Burst]",50,0,100)
        ,gui.Slider(violet_ref,"violet.inair.hitchance."..weapons[i],"Hitchance [In air]",50,0,100)

    }

    if weapons[i] == "scout" or weapons[i] == "asniper" or weapons[i] == "sniper" then

        options[weapons[i]][#options[weapons[i]]+1] = gui.Slider(violet_ref,"violet.noscope.hitchance."..weapons[i],"Hitchance [No scope]",50,0,100)

    end
end

local function menu_weapon(var)
    local w = var:match("%a+"):lower()
    local w = w:find("heavy") and "hpistol" or w:find("auto") and "asniper" or w:find("submachine") and "smg" or w:find("light") and "lmg" or w
    return w
end

local function menu_hanlde()

    violet_[2]:SetInvisible(1)

    if violet_[1]:GetValue() then violet_[2]:SetInvisible(0) end

    local weapon = menu_weapon(gui.GetValue("rbot.hitscan.accuracy"))

    for i = 1,#options do

        for v = 1,#options[weapons[i]] do

            options[weapons[i]][v]:SetInvisible(1)

        end
    end

    options[weapon][1]:SetInvisible(0)

    if options[weapon][1]:GetValue() then

        for k = 1,#options[weapon] - 1 do

            options[weapon][k+1]:SetInvisible(0)

        end
    end
end

local function ragebot_hanlde()

    local lplayer = entities.GetLocalPlayer()

    if not lplayer then return end
    if not lplayer:IsAlive() then return end

    local weapon = menu_weapon(gui.GetValue("rbot.hitscan.accuracy"))

    local is_dt = gui.GetValue("rbot.accuracy.attack."..menu_weapon(gui.GetValue("rbot.accuracy.attack"))..".fire") == '"Defensive Warp Fire"'

    if options[weapon][1]:GetValue() then

        local dmg,hc,burst = 0,0,0

        if is_dt then

            dmg = options[weapon][3]:GetValue()
            hc = options[weapon][6]:GetValue()

        else

            dmg = options[weapon][2]:GetValue()
            hc = options[weapon][5]:GetValue()

        end

        if violet_[3]:GetValue() then

            dmg = options[weapon][4]:GetValue()

        end

        burst = options[weapon][7]:GetValue()

        if bit.band(lplayer:GetPropInt("m_fFlags"),1) == 0 then

            hc = options[weapon][8]:GetValue()

        end

        if weapon == "scout" or weapon == "asniper" or weapon == "sniper" then

            if not lplayer:GetPropBool("m_bIsScoped") then

                hc = options[weapon][9]:GetValue()

            end
        end

        gui.SetValue("rbot.hitscan.accuracy."..weapon..".mindamage",dmg)
        gui.SetValue("rbot.hitscan.accuracy."..weapon..".hitchance",hc)
        gui.SetValue("rbot.hitscan.accuracy."..weapon..".hitchanceburst",burst)

    end

    if violet_[1]:GetValue() then

        local fire_mode = '"Off"'

        if violet_[2]:GetValue() == 1 then

            fire_mode = '"Shift Fire"'

        elseif violet_[2]:GetValue() == 2 then

            fire_mode = '"Defensive Fire"'

        elseif violet_[2]:GetValue() == 3 then

            fire_mode = '"Defensive Warp Fire"'

        end

        gui.SetValue("rbot.accuracy.attack."..menu_weapon(gui.GetValue("rbot.accuracy.attack"))..".fire",fire_mode)

    end

    keybinds:SetActive(0)

    keybinds:SetHeight(36)

    if violet_[4]:GetValue() then

        keybinds:SetActive(1)

        local h,th = 0,0

        for i = 1,#binds do

            binds[i]:SetInvisible(1)

        end

        if gui.GetValue("rbot.accuracy.attack."..menu_weapon(gui.GetValue("rbot.accuracy.attack"))..".fire") == '"Shift Fire"' then

            h=h+15;keybinds:SetHeight(36+h);binds[1]:SetPosX(8);binds[1]:SetPosY(th+8);binds[1]:SetInvisible(0);th=th+15;

        end

        if gui.GetValue("rbot.accuracy.attack."..menu_weapon(gui.GetValue("rbot.accuracy.attack"))..".fire") == '"Defensive Fire"' then

            h=h+15;keybinds:SetHeight(36+h);binds[2]:SetPosX(8);binds[2]:SetPosY(th+8);binds[2]:SetInvisible(0);th=th+15;

        end

        if gui.GetValue("rbot.accuracy.attack."..menu_weapon(gui.GetValue("rbot.accuracy.attack"))..".fire") == '"Defensive Warp Fire"' then

            h=h+15;keybinds:SetHeight(36+h);binds[3]:SetPosX(8);binds[3]:SetPosY(th+8);binds[3]:SetInvisible(0);th=th+15;

        end

        if violet_[3]:GetValue() then

            h=h+15;keybinds:SetHeight(36+h);binds[4]:SetPosX(8);binds[4]:SetPosY(th+8);binds[4]:SetInvisible(0);th=th+15;

        end

        if gui.GetValue("rbot.antiaim.advanced.roll") then

            h=h+15;keybinds:SetHeight(36+h);binds[5]:SetPosX(8);binds[5]:SetPosY(th+8);binds[5]:SetInvisible(0);th=th+15;

        end

        if gui.GetValue("rbot.antiaim.extra.fakecrouchkey") ~= 0 then

            if input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then

                h=h+15;keybinds:SetHeight(36+h);binds[6]:SetPosX(8);binds[6]:SetPosY(th+8);binds[6]:SetInvisible(0);th=th+15;

            end
        end

        if gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 then

            if input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) then

                h=h+15;keybinds:SetHeight(36+h);binds[7]:SetPosX(8);binds[7]:SetPosY(th+8);binds[7]:SetInvisible(0);th=th+15;

            end
        end

        if gui.GetValue("rbot.accuracy.walkbot.peek") then

            if gui.GetValue("rbot.accuracy.walkbot.peekkey") ~= 0 then

                if input.IsButtonDown(gui.GetValue("rbot.accuracy.walkbot.peekkey")) then

                    h=h+15;keybinds:SetHeight(36+h);binds[8]:SetPosX(8);binds[8]:SetPosY(th+8);binds[8]:SetInvisible(0);th=th+15;

                end
            end
        end

        if gui.GetValue("misc.edgejump") ~= 0 then

            if input.IsButtonDown(gui.GetValue("misc.edgejump")) then

                h=h+15;keybinds:SetHeight(36+h);binds[9]:SetPosX(8);binds[9]:SetPosY(th+8);binds[9]:SetInvisible(0);th=th+15;

            end
        end
    end
end

callbacks.Register("Draw",function()

    menu_hanlde()

    ragebot_hanlde()

end)


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")