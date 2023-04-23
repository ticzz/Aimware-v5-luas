-- Original code by OriginalLuzog (https://aimware.net/forum/user-316440.html) and LunarLuzog (ShiinaChan#5523)
-- Auto Updater
local clientVersion = "1.1"
local latestVersion = http.Get("https://raw.githubusercontent.com/GhostZ-AW/GhostZLuaPack/master/version.txt")
local function Update()
    if clientVersion ~= latestVersion then
        currentScript = file.Open(GetScriptName(), "w")
        currentScript:Write(http.Get("https://raw.githubusercontent.com/GhostZ-AW/GhostZLuaPack/master/GhostZLuaPack.lua"))
        currentScript:Close()
        LoadScript(GetScriptName())
    end
end

-- Menu GUI
local ghostzluapack_tab = gui.Tab(gui.Reference("Misc"), "ghostzluapack", "GhostZ's Lua Pack")
local updater_groupbox = gui.Groupbox(ghostzluapack_tab, "Updater", 16, 16, 160, 0)
local changelog_groupbox = gui.Groupbox(ghostzluapack_tab, "Changelog", 192, 16, 431, 167)
local luascripts_groupbox = gui.Groupbox(ghostzluapack_tab, "Lua Scripts", 16, 200, 296, 0)
local fieldofviewchanger_groupbox = gui.Groupbox(ghostzluapack_tab, "Field of View Changer", 328, 200, 296, 0)
local clientversion_text = gui.Text(updater_groupbox, "Client version: v" .. clientVersion)
local latestversion_text = gui.Text(updater_groupbox, "Latest version: v" .. latestVersion)
local update_button = gui.Button(updater_groupbox, "Update", Update)
local changelog_groupbox = gui.Text(changelog_groupbox, http.Get("https://raw.githubusercontent.com/GhostZ-AW/GhostZLuaPack/master/changelog.txt"))

-- Field of View Changer GetConVars
local curFOV = client.GetConVar("fov_cs_debug");
local curViewmodel = client.GetConVar("viewmodel_fov");
local curX = client.GetConVar("viewmodel_offset_x");
local curY = client.GetConVar("viewmodel_offset_y");
local curZ = client.GetConVar("viewmodel_offset_z");

-- Lua Scripts Groupboxes/Sliders
local antiaimfix_checkbox = gui.Checkbox(luascripts_groupbox, "antiaimfix", "Anti-Aim Fix", false)
local engineradar_checkbox = gui.Checkbox(luascripts_groupbox, "engineradar", "Engine Radar", false)
local fakduckingviewmodel_checkbox = gui.Checkbox(luascripts_groupbox, "fakeduckingviewmodel", "Fake Ducking Viewmodel", false)
local fieldofviewchanger_checkbox = gui.Checkbox(fieldofviewchanger_groupbox, "fieldofviewchanger", "Enable", false)
local viewfov_slider = gui.Slider(fieldofviewchanger_groupbox, "viewfov", "View", curFOV, 0, 120 )
local viewmodelfov_slider = gui.Slider(fieldofviewchanger_groupbox, "viewmodelfov", "Viewmodel", curViewmodel, 0, 120)
local viewmodeloffsetx_slider = gui.Slider(fieldofviewchanger_groupbox, "viewmodeloffsetx", "Viewmodel X Offset", curX, -10, 10, 0.1);
local viewmodeloffsety_slider = gui.Slider(fieldofviewchanger_groupbox, "viewmodeloffsety", "Viewmodel Y Offset", curY, -10, 10, 0.1);
local viewmodeloffsetz_slider = gui.Slider(fieldofviewchanger_groupbox, "viewmodeloffsetz", "Viewmodel Z Offset", curZ, -10, 10, 0.1);
local hidespec_checkbox = gui.Checkbox(luascripts_groupbox, "hidespec", "Hide Show Spectators in Main Menu", false)
local noblood_checkbox = gui.Checkbox(luascripts_groupbox, "noblood", "No Blood", false)
local noshadows_checkbox = gui.Checkbox(luascripts_groupbox, "noshadows", "No Shadows", false)
local nopanoramablur_checkbox = gui.Checkbox(luascripts_groupbox, "nopanoramablur", "No Panorama Blur", false)

-- Descriptions
fakduckingviewmodel_checkbox:SetDescription("Disable Field of View Changer first for this to work!")

-- Anti-Aim Fix by Eugen1763 (https://aimware.net/forum/user-120610.html)
local switch = true;

local function create_move(cmd)
    if not gui.GetValue( "rbot.master" ) then return end
    if gui.GetValue("misc.ghostzluapack.antiaimfix") and not input.IsButtonDown( "w" ) and not input.IsButtonDown( "a" ) and not input.IsButtonDown( "s" ) and not input.IsButtonDown( "d" ) and not input.IsButtonDown( "space" ) then 
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

-- Engine Radar by - Luiz (https://aimware.net/forum/user-70416.html)
local function engineradar()
        for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
            if engineradar_checkbox:GetValue() then
                Player:SetProp("m_bSpotted", 1);
            else
                Player:SetProp("m_bSpotted", 0);
            end
        end
    end

callbacks.Register("Draw", "engineradar", engineradar);

-- Fake Ducking Viewmodel by Grieschoel (https://aimware.net/forum/user-207256.html)
local getLocal = function() return entities.GetLocalPlayer() end
local viewmodelZ = (client.GetConVar("viewmodel_offset_z"));

function yourmumsahoe()
if gui.GetValue("misc.ghostzluapack.fakeduckingviewmodel") then
    if getLocal() then
        if getLocal():IsAlive() then
            local shitthisisboring = gui.GetValue('rbot.antiaim.advanced.fakecrouchkey')
            local andsofuckinguseless = input.IsButtonDown( shitthisisboring )                                            
            local yourmum = entities.GetLocalPlayer();
            local tbagmodeengaged = yourmum:GetProp('m_flDuckAmount')            
                if andsofuckinguseless == true then
                    client.SetConVar("viewmodel_offset_z", viewmodelZ - (tbagmodeengaged*8), true)
                else
                    client.SetConVar("viewmodel_offset_z", viewmodelZ, true)
            end
        end
    end
end
end

callbacks.Register("Draw", yourmumsahoe)

-- Field of View Changer by GhostZ (https://aimware.net/forum/user-271217.html)
local function fieldofview()
    if fieldofviewchanger_checkbox:GetValue() and viewfov_slider:GetValue() and viewmodelfov_slider:GetValue() and viewmodeloffsetx_slider:GetValue() and viewmodeloffsety_slider:GetValue() and viewmodeloffsetz_slider:GetValue() then
        client.SetConVar("fov_cs_debug", viewfov_slider:GetValue(), true)
        client.SetConVar("viewmodel_fov", viewmodelfov_slider:GetValue(), true);
        client.SetConVar("viewmodel_offset_x", viewmodeloffsetx_slider:GetValue(), true);
        client.SetConVar("viewmodel_offset_y", viewmodeloffsety_slider:GetValue(), true);
        client.SetConVar("viewmodel_offset_z", viewmodeloffsetz_slider:GetValue(), true);
    end
end

callbacks.Register("Draw", "Field of View", fieldofview)

-- Hide Show Spectators in Main Menu by Rickyy (https://aimware.net/forum/user-88883.html)
callbacks.Register("Draw", function()
    if hidespec_checkbox:GetValue() then
        if (entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil and engine.GetMapName() ~= "dz_blacksite" and engine.GetMapName() ~= "dz_sirocco") then
            gui.SetValue("misc.showspec", 1)
        else
            gui.SetValue("misc.showspec", 0)
        end
    end
end)

-- No Blood by ambien55 (https://aimware.net/forum/user-240129.html)
callbacks.Register("CreateMove", function()
    if noblood_checkbox:GetValue() and client.GetConVar("violence_hblood") ~= 0 then
        client.SetConVar("violence_hblood", 0, true)
    end
end)

-- No Shadows by GhostZ (https://aimware.net/forum/user-271217.html)
local function noshadows()
	if noshadows_checkbox:GetValue() then
		client.SetConVar("r_shadows", 0, true);
		client.SetConVar("cl_csm_static_prop_shadows", 0, true );
		client.SetConVar("cl_csm_shadows", 0, true );
		client.SetConVar("cl_csm_world_shadows", 0, true );
		client.SetConVar("cl_foot_contact_shadows", 0, true );
		client.SetConVar("cl_csm_viewmodel_shadows", 0, true );
		client.SetConVar("cl_csm_rope_shadows", 0, true );
		client.SetConVar("cl_csm_sprite_shadows", 0, true );
			else 
			client.SetConVar("r_shadows", 1, true);
			client.SetConVar("cl_csm_static_prop_shadows", 1, true );
			client.SetConVar("cl_csm_shadows", 1, true );
			client.SetConVar("cl_csm_world_shadows", 1, true );
			client.SetConVar("cl_foot_contact_shadows", 1, true );
			client.SetConVar("cl_csm_viewmodel_shadows", 1, true );
			client.SetConVar("cl_csm_rope_shadows", 1, true );
			client.SetConVar("cl_csm_sprite_shadows", 1, true );
	end
end

noshadows()

local function event(e)
if e:GetName() == "round_start" then
    noshadows()
    end        
end

client.AllowListener("round_start")
callbacks.Register ("FireGameEvent", event)

-- No Panorama Blur by GhostZ (https://aimware.net/forum/user-271217.html)
function nopanoramablur()
	if nopanoramablur_checkbox:GetValue() then
		client.SetConVar("@panorama_disable_blur", 1, true);
			else 
			client.SetConVar("@panorama_disable_blur", 0, true);
	end 
end

callbacks.Register("Draw", "No Panorama Blur", nopanoramablur)














--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

