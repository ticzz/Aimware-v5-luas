-- {shit semirage helper created by xwk1337}--
local font = draw.CreateFont("Microsoft Tai Le", 32, 1000);
local font1 = draw.CreateFont("Verdana", 22, 400);
local ref = gui.Reference("Ragebot");
local tab = gui.Tab(ref, "upper", "Upper Hook");
local screen_w, screen_h = draw.GetScreenSize();

local main_box = gui.Groupbox(tab, "Main", 16, 16, 200, 0);
local main_customsc = gui.Checkbox(main_box, "main.newscope", "Custom Scope", false);
local main_forcech = gui.Checkbox(main_box, "main.forcech", "Force CrossHair", false);
local main_unlockinv = gui.Checkbox(main_box, "main.unlockinv", "Unlock Inventory", false);
local main_fixrevolver = gui.Checkbox(main_box, "main.fixrevolver", "Disable FL With Revolver", false);
local main_clr = gui.ColorPicker(main_box, "main.color", "Accent Color", 255, 130, 255, 255);

local legit_aa_box = gui.Groupbox(tab, "Legit Anti-Aim", 232, 16, 200, 0);
local legit_aa_enable = gui.Checkbox(legit_aa_box, "aa.enable", "Enable", false);
local legit_aa_dis_on_fd = gui.Checkbox(legit_aa_box, "aa.disonfd", "Disable On FD", false);
local legit_aa_type = gui.Combobox(legit_aa_box, "aa.type", "DeSync Type", "Default", "Low");
local legit_aa_key = gui.Keybox(legit_aa_box, "aa.inverter", "Inverter", 0);

local switch_box = gui.Groupbox(tab, "Switch", 448, 16, 174, 0);
local switch_enable = gui.Checkbox(switch_box, "switch.enable", "Enable", false);
local switch_fbaim_key = gui.Keybox(switch_box, "switch.force", "Force Baim", 0);
local switch_awall_key = gui.Keybox(switch_box, "switch.autowall", "Auto Wall", 0);

local dynamic_box = gui.Groupbox(tab, "Dynamic Fov", 232, 264, 200, 0);
local dynamic_enable = gui.Checkbox(dynamic_box, "dynamic.enable", "Enable", false);
local dynamic_min_slider = gui.Slider(dynamic_box, "dynamic.min", "Fov Min", 9, 1, 30);
local dynamic_max_slider = gui.Slider(dynamic_box, "dynamic.max", "Fov Max", 15, 1, 30);

local view_model_box = gui.Groupbox(tab, "View Model", 448, 227, 174, 0);
local view_model_aspect = gui.Slider(view_model_box, "model.aspect", "Aspect Ratio", 0, 0, 18);
local view_model_x = gui.Slider(view_model_box, "model.x", "Offset X", 1, -40, 40);
local view_model_y = gui.Slider(view_model_box, "model.y", "Offset Y", 1, -40, 40);
local view_model_z = gui.Slider(view_model_box, "model.z", "Offset Z", -1, -40, 40);

local aspect_table = {0, 2.0, 1.9, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1, 1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3};
local weapons_table = {"asniper", "hpistol", "lmg", "pistol", "rifle", "scout", "smg", "shotgun", "sniper", "zeus",
                      "shared"};
local aa_side = false;
local switch_fbaim = false;
local switch_awall = false;
local fakeducking = false;
local time = 0.0;

local function rect(x, y, w, h, col)
    draw.Color(col[1], col[2], col[3], col[4]);
    draw.FilledRect(x, y, x + w, y + h);
end

local function gradient_h(x1, y1, x2, y2, col1, left)
    local w = x2 - x1;
    local h = y2 - y1;

    for i = 0, w do
        local a = (i / w) * 200;
        local r, g, b = col1[1], col1[2], col1[3];
        draw.Color(r, g, b, a);
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h);
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h);
        end
    end
end

local function gradient_v(x, y, w, h, col1, col2, down)
    rect(x, y, w, h, col1);

    local r, g, b = col2[1], col2[2], col2[3];

    for i = 1, h do
        local a = i / h * 255;
        if down then
            rect(x, y + i, w, 1, {r, g, b, a});
        else
            rect(x, y - i, w, 1, {r, g, b, a});
        end
    end
end

local function check(option)
    if not option:GetValue() then
        return false;
    end
    if not gui.GetValue("rbot.master") then
        return false;
    end
    local lc = entities.GetLocalPlayer();
    if not lc or not lc:IsAlive() then
        return false;
    end
    return true;
end

local function get_weapon_class(lp)
    local weapon_id = lp:GetWeaponID();

    if weapon_id == 11 or weapon_id == 38 then
        return "asniper";
    elseif weapon_id == 1 or weapon_id == 64 then
        return "hpistol";
    elseif weapon_id == 14 or weapon_id == 28 then
        return "lmg";
    elseif weapon_id == 2 or weapon_id == 3 or weapon_id == 4 or weapon_id == 30 or weapon_id == 32 or weapon_id == 36 or weapon_id == 61 or weapon_id == 63 then
        return "pistol";
    elseif weapon_id == 7 or weapon_id == 8 or weapon_id == 10 or weapon_id == 13 or weapon_id == 16 or weapon_id == 39 or weapon_id == 60 then
        return "rifle";
    elseif weapon_id == 40 then
        return "scout";
    elseif weapon_id == 17 or weapon_id == 19 or weapon_id == 23 or weapon_id == 24 or weapon_id == 26 or weapon_id == 33 or weapon_id == 34 then
        return "smg";
    elseif weapon_id == 25 or weapon_id == 27 or weapon_id == 29 or weapon_id == 35 then
        return "shotgun";
    elseif weapon_id == 9 then
        return "sniper";
    elseif weapon_id == 31 then
        return "zeus";
    end

    return "shared";
end

local function antiaim()
    if not check(legit_aa_enable) then
        return;
    end

    if legit_aa_enable:GetValue() and not fakeducking then
        draw.SetFont(font);
        if gui.GetValue("rbot.antiaim.base.lby") == -120 then
            draw.Color(255, 255, 255, 255);
            draw.TextShadow(screen_w / 2 - 148, screen_h / 2 - 10, "⮜");
            draw.Color(main_clr:GetValue());
            draw.TextShadow(screen_w / 2 + 132, screen_h / 2 - 10, "⮞");
        elseif gui.GetValue("rbot.antiaim.base.lby") == 120 then
            draw.Color(main_clr:GetValue());
            draw.TextShadow(screen_w / 2 - 148, screen_h / 2 - 10, "⮜");
            draw.Color(255, 255, 255, 255);
            draw.TextShadow(screen_w / 2 + 132, screen_h / 2 - 10, "⮞");
        end
    end

    if fakeducking then
        gui.SetValue("rbot.antiaim.base", "0.0 Off");
        return;
    end

    gui.SetValue("rbot.antiaim.base", "0.0 Desync");
    gui.SetValue("rbot.antiaim.advanced.pitch", 0);
    gui.SetValue("rbot.antiaim.advanced.autodir.edges", 1);
    gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0);

    if legit_aa_key:GetValue() ~= 0 then
        if input.IsButtonPressed(legit_aa_key:GetValue()) then
            if not aa_side then
                if legit_aa_type:GetValue() == 0 then
                    gui.SetValue("rbot.antiaim.base.rotation", -58);
                elseif legit_aa_type:GetValue() == 1 then
                    gui.SetValue("rbot.antiaim.base.rotation", -35);
                end
                gui.SetValue("rbot.antiaim.base.lby", 120);
                aa_side = true;
            else
                if legit_aa_type:GetValue() == 0 then
                    gui.SetValue("rbot.antiaim.base.rotation", 58);
                elseif legit_aa_type:GetValue() == 1 then
                    gui.SetValue("rbot.antiaim.base.rotation", 35);
                end
                gui.SetValue("rbot.antiaim.base.lby", -120);
                aa_side = false;
            end
        end
    end
end

local function dynamic()
    if not check(dynamic_enable) then
        return;
    end

    if dynamic_min_slider:GetValue() > dynamic_max_slider:GetValue() then
        return;
    end

    if math.abs(globals.CurTime() - time) > 1 then
        gui.SetValue("rbot.aim.target.fov", math.random(dynamic_min_slider:GetValue(), dynamic_max_slider:GetValue()));
        time = globals.CurTime();
    end
end

local function switch()

    local lc = entities.GetLocalPlayer();
    if lc and lc:IsAlive() then
        draw.SetFont(font1);

        draw.Color(255, 255, 255, 255);
        draw.Text(screen_w / 2 - 738, screen_h / 2, "Fov:");
        draw.Text(screen_w / 2 - 782, screen_h / 2 + 20, "Damage:");
        draw.Text(screen_w / 2 - 783, screen_h / 2 + 40, "Autowall:");
        draw.Text(screen_w / 2 - 800, screen_h / 2 + 60, "Forcebaim:");
        draw.Text(screen_w / 2 - 785, screen_h / 2 + 80, "Resolver:");
        draw.Text(screen_w / 2 - 786, screen_h / 2 + 100, "Accuracy:");

        draw.Color(main_clr:GetValue());
        draw.Text(screen_w / 2 - 688, screen_h / 2, gui.GetValue("rbot.aim.target.fov"));

        draw.Text(screen_w / 2 - 688, screen_h / 2 + 20, gui.GetValue("rbot.hitscan.accuracy." .. get_weapon_class(lc) .. ".mindamage"));

        if switch_awall then
            draw.Color(0, 255, 0, 255);
            draw.Text(screen_w / 2 - 688, screen_h / 2 + 40, "On");
        else
            draw.Color(255, 0, 0, 255);
            draw.Text(screen_w / 2 - 688, screen_h / 2 + 40, "Off");
        end

        if switch_fbaim then
            draw.Color(0, 255, 0, 255);
            draw.Text(screen_w / 2 - 688, screen_h / 2 + 60, "On");
        else
            draw.Color(255, 0, 0, 255);
            draw.Text(screen_w / 2 - 688, screen_h / 2 + 60, "Off");
        end

        if gui.GetValue("rbot.accuracy.posadj.resolver") then
            draw.Color(0, 255, 0, 255);
            draw.Text(screen_w / 2 - 688, screen_h / 2 + 80, "On");
        else
            draw.Color(255, 0, 0, 255);
            draw.Text(screen_w / 2 - 688, screen_h / 2 + 80, "Off");
        end

        local accuracy = 100 - math.floor(entities.GetLocalPlayer():GetWeaponInaccuracy() * 10 ^ 3 + 0.5) / 10 ^ 3 * 100;

        if accuracy > 90 then
            draw.Color(0, 255, 0, 255);
            draw.Text(screen_w / 2 - 688, screen_h / 2 + 100, "High");
        else
            draw.Color(255, 0, 0, 255);
            draw.Text(screen_w / 2 - 688, screen_h / 2 + 100, "Low");
        end
    end

    if not check(switch_enable) then
        return;
    end

    if switch_fbaim_key:GetValue() ~= 0 then
        if input.IsButtonPressed(switch_fbaim_key:GetValue()) then
            if not switch_fbaim then
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".bodyaim.force", 1);
                end
                switch_fbaim = true;
            else
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".bodyaim.force", 0);
                end
                switch_fbaim = false;
            end
        end
    end

    if switch_awall_key:GetValue() ~= 0 then
        if input.IsButtonPressed(switch_awall_key:GetValue()) then
            if not switch_awall then
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".autowall", 1);
                end
                switch_awall = true;
            else
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".autowall", 0);
                end
                switch_awall = false;
            end
        end
    end
end

local function viewmodel()
    if not gui.GetValue("rbot.master") then
        return;
    end

    local lc = entities.GetLocalPlayer();
    if not lc or not lc:IsAlive() then
        return;
    end

    client.SetConVar("r_aspectratio", aspect_table[view_model_aspect:GetValue() + 1], true);
    client.SetConVar("viewmodel_offset_x", view_model_x:GetValue(), true);
    client.SetConVar("viewmodel_offset_y", view_model_y:GetValue(), true);
    client.SetConVar("viewmodel_offset_z", view_model_z:GetValue(), true);
end

local function main()
    if legit_aa_dis_on_fd:GetValue() then
        local fdvalue = gui.GetValue("rbot.antiaim.extra.fakecrouchkey");
        if fdvalue ~= 0 then
            if input.IsButtonDown(fdvalue) then
                fakeducking = true;
            else
                fakeducking = false;
            end
        end
    else
        fakeducking = false;
    end

    if check(main_fixrevolver) then
        local weaponid = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetWeaponID();

        if weaponid == 64 then
            gui.SetValue("misc.fakelag.enable", false);
        else
            gui.SetValue("misc.fakelag.enable", true);
        end
    end

    if check(main_customsc) then
        local scoped = entities.GetLocalPlayer():GetPropBool("m_bIsScoped");
        local r, g, b, a = main_clr:GetValue();

        gui.SetValue("esp.other.noscopeoverlay", false);
        gui.SetValue("esp.other.crosshair", false);

        if scoped then
            gradient_h(screen_w / 2, screen_h / 2, screen_w / 2 + 130, screen_h / 2 - 1, {r, g, b, a}, true);
            gradient_h(screen_w / 2 - 130, screen_h / 2, screen_w / 2, screen_h / 2 - 1, {r, g, b, a}, false);
            gradient_v(screen_w / 2, screen_h / 2, 1, 130, {255, 255, 255, 0}, {r, g, b, a}, true);
            gradient_v(screen_w / 2, screen_h / 2, 1, 130, {255, 255, 255, 0}, {r, g, b, a}, false);
            client.SetConVar("r_drawvgui", "0", true);
        else
            client.SetConVar("r_drawvgui", "1", true);
        end
    else
        client.SetConVar("r_drawvgui", "1", true);
    end

    if check(main_forcech) then
        client.SetConVar("weapon_debug_spread_show", 3, true);
    else
        client.SetConVar("weapon_debug_spread_show", 0, true);
    end

    if check(main_unlockinv) then
        panorama.RunScript([[ LoadoutAPI.IsLoadoutAllowed = () => { return true; }; ]]);
    end
end

callbacks.Register("Draw", "legit_aa", antiaim);
callbacks.Register("Draw", "dynamic_fov", dynamic);
callbacks.Register("Draw", "switch", switch);
callbacks.Register("Draw", "view_model", viewmodel);
callbacks.Register("Draw", "defaults", main);



--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")