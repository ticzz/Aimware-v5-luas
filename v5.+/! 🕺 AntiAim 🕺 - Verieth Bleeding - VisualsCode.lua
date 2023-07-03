--region AUTO_UPDATER
local CURRENT_VERSION = "2.0"
--[[local LAST_VERSION = http.Get("https://raw.githubusercontent.com/MN1R/TheBleeding/main/VisualsVersion")

--writing file with our version to remove tonumber, string.gsub for random format
local latest_version_file_name = "bleeding_last_version.txt"
file.Write(latest_version_file_name,  tostring(LAST_VERSION))

--getting data from file, its 100% string
local file_open = file.Open(latest_version_file_name, 'r')
local file_data = file_open:Read()
file_open:Close()

--getting full vesrion without any memes
LAST_VERSION = string.sub(file_data, 0, string.len(CURRENT_VERSION));

--deleting file
file.Delete(latest_version_file_name)

--if lua is outdated
if LAST_VERSION ~= CURRENT_VERSION then

    print("Lua is outdated.")

    --getting latest data
    local LAST_LUA_DATA = http.Get("https://raw.githubusercontent.com/MN1R/TheBleeding/main/VisualsCode")

    --starting update
    local script_name = GetScriptName()

    --deleting current lua
    file.Delete(script_name)

    --writing new file with latest data
    file.Write(GetScriptName(), LAST_LUA_DATA)
    print("Script succesfully updated. Load it again.")
    return
end
]]
--if lua is updated
print("Successfully loaded " .. CURRENT_VERSION .. " version.")





--region GUI
local visuals_tab = gui.Tab(gui.Reference("Visuals"), "visuals_tab", "Visuals Tab");


--hit info
local visuals_hit_info = gui.Groupbox(visuals_tab, "Hit Info", 5, 10, 325, 450);

local visuals_hit_info_ui = 
{
    world_hitmarker = gui.Checkbox(visuals_hit_info, "world_hitmarker", "World Hitmarker", false),
    world_damage_marker = gui.Checkbox(visuals_hit_info, "world_damage_marker", "World Damage Marker", false),
    screen_hitmarker = gui.Checkbox(visuals_hit_info, "screen_hitmarker", "Screen Hitmarker", false),
    bullet_tracers = gui.Checkbox(visuals_hit_info, "screen_hitmarker", "Bullet Tracers", false)
};


local world_hitmarker_color = gui.ColorPicker(visuals_hit_info_ui.world_hitmarker, "world_hitmarker_color", "", 255, 255, 255);
local world_damage_marker_color = gui.ColorPicker(visuals_hit_info_ui.world_damage_marker, "world_damage_marker_color", "", 255, 255, 255);
local world_damage_marker_color_headshot = gui.ColorPicker(visuals_hit_info_ui.world_damage_marker, "world_danage_marker_color_headshot", "", 255, 40, 40);
local screen_hitmarker_color = gui.ColorPicker(visuals_hit_info_ui.screen_hitmarker, "screen_hitmarker_color", "", 255, 255, 255);
local bullet_tracers_color = gui.ColorPicker(visuals_hit_info_ui.bullet_tracers, "bullet_tracers_color", "", 255, 255, 255);


--user info
local visuals_user_info = gui.Groupbox(visuals_tab, "User Info", 5, 210, 325, 450);

local visuals_user_info_ui = 
{
    keybinds = gui.Checkbox(visuals_user_info, "keybinds", "Keybinds", false),
    keybinds_position_x, keybinds_position_y,
    weapon_info = gui.Checkbox(visuals_user_info, "weapon_info", "Weapon Info", false),
    weapon_info_position_x, weapon_info_position_y,
    --under_crosshair_indicator = gui.Checkbox(visuals_user_info, "under_crosshair_indicator", "Under Crosshair Indicator", false),
    watermark = gui.Checkbox(visuals_user_info, "watermark", "Watermark", false),
    visuals_color = gui.ColorPicker(visuals_user_info, "visuals_color", "Visuals Color", 140, 160, 245)
};

--local under_crosshair_indicator_color = gui.ColorPicker(visuals_user_info_ui.under_crosshair_indicator, "under_crosshair_indicator_color", "", 110, 110, 110, 255)


--other visuals
local visuals_other = gui.Groupbox(visuals_tab, "Other", 340, 10, 290, 350);

--local custom_scope = gui.Checkbox(visuals_other, "custom_scope", "Enable Custom Scope", false)

local visuals_other_ui = 
{
    --custom_scope_color = gui.ColorPicker(custom_scope, "custom_scope_color", "", 255, 255, 255, 255),

    --custom_scope_length = gui.Slider(visuals_other, "custom_scope_length", "Custom Scope Length", 120, 20, 400),
    --custom_scope_indent = gui.Slider(visuals_other, "custom_scope_indent", "Custom Scope Indent", 20, 0, 300),

    --gui.Text(visuals_other, "\n\t\t World Visuals\n"),

    view_model_changer = gui.Checkbox(visuals_other, "view_model_changer", "Enable Viewmodel Changer", false),
    view_model_changer_x = gui.Slider(visuals_other, "view_model_changer_x", "Viewmodel X", 0, -10, 10, 0.1),
    view_model_changer_y = gui.Slider(visuals_other, "view_model_changer_y", "Viewmodel Y", 0, -10, 10, 0.1),
    view_model_changer_z = gui.Slider(visuals_other, "view_model_changer_z", "Viewmodel Z", 0, -10, 10, 0.1),
    
    aspect_ratio = gui.Checkbox(visuals_other, "aspect_ratio", "Enable Aspectratio", false),
    aspect_ratio_value = gui.Slider(visuals_other, "aspect_ratio_value", "Aspectratio Value", 0, 0, 3, 0.05),

    world_modifications = gui.Checkbox(visuals_other, "world_modifications", "Enable World Modifications", false),
    world_modifications_exposure = gui.Slider(visuals_other, "world_modifications_exposure", "Exposure", 0, 0, 100, 1),
    world_modifications_ambient = gui.Slider(visuals_other, "world_modifications_ambient", "Ambient", 0, 0, 100, 1),
    world_modifications_bloom = gui.Slider(visuals_other, "world_modifications_bloom", "Bloom", 0, 0, 100, 1),
    world_modifications_ambient_color = gui.ColorPicker(visuals_other, "world_modifications_ambient_color", "Ambient Color", 0, 0, 0)
}
--endregion





--region EDIT_GUI
--creating sliders, that require a screen size
local screen_width, screen_height;

local function createSlidersUi()

    --creating position sliders later cuz they are need our screen size
    visuals_user_info_ui.keybinds_position_x = gui.Slider(visuals_user_info, "keybinds_position_x", "Keybinds Postion X", 300, 0, screen_width) 
    visuals_user_info_ui.keybinds_position_y = gui.Slider(visuals_user_info, "keybinds_position_y", "Keybinds Postion Y", 400, 0, screen_height)
            
    visuals_user_info_ui.weapon_info_position_x = gui.Slider(visuals_user_info, "weapon_info_position_x", "Weapon Info Postion X", 500, 0, screen_width)
    visuals_user_info_ui.weapon_info_position_y = gui.Slider(visuals_user_info, "weapon_info_position_y", "Weapon Info Postion Y", 400, 0, screen_height)
end


--just a function which controlling gui visibility in some cases
local function changeGui()

    --hiding position sliders
    visuals_user_info_ui.keybinds_position_x:SetInvisible(true)
    visuals_user_info_ui.keybinds_position_y:SetInvisible(true)
            
    visuals_user_info_ui.weapon_info_position_x:SetInvisible(true)
    visuals_user_info_ui.weapon_info_position_y:SetInvisible(true)

    --organizing other visuals gui
    --visuals_other_ui.custom_scope_length:SetInvisible(not custom_scope:GetValue())
    --visuals_other_ui.custom_scope_indent:SetInvisible(not custom_scope:GetValue())

    visuals_other_ui.view_model_changer_x:SetInvisible(not visuals_other_ui.view_model_changer:GetValue())
    visuals_other_ui.view_model_changer_y:SetInvisible(not visuals_other_ui.view_model_changer:GetValue())
    visuals_other_ui.view_model_changer_z:SetInvisible(not visuals_other_ui.view_model_changer:GetValue())

    visuals_other_ui.aspect_ratio_value:SetInvisible(not visuals_other_ui.aspect_ratio:GetValue())

    visuals_other_ui.world_modifications_exposure:SetInvisible(not visuals_other_ui.world_modifications:GetValue())
    visuals_other_ui.world_modifications_bloom:SetInvisible(not visuals_other_ui.world_modifications:GetValue())
    visuals_other_ui.world_modifications_ambient:SetInvisible(not visuals_other_ui.world_modifications:GetValue())
    visuals_other_ui.world_modifications_ambient_color:SetInvisible(not visuals_other_ui.world_modifications:GetValue())
end
--endregion





--region HANDLING
--get screen size
local function getScreenSize()
    screen_width, screen_height = draw.GetScreenSize()
end


--getting screen sizes and creating gui, that basing on them
local function handleScreenSizes()

    --getting screen sizes on draw callback and creating slider ui for them
    if not screen_width or not screen_height then
        getScreenSize()
        createSlidersUi()
    end
end


--function that handling all often-used variables
local constants = {};
local fonts = 
{
    keybinds_font = draw.CreateFont("Avenir Next LT Pro Light", 13),

    world_damage_font = draw.CreateFont("Bahnschrift SemiBold", 15, 800, 0),
    world_damage_font_outlined = draw.CreateFont("Bahnschrift SemiBold", 15, 800, 1),
};

local patterns =
{
    "%s+";
    "auto";
    "lightmachinegun";
    "submachinegun";
    "heavypistol";
}

local replacements =
{
    "";
    "a";
    "lmg";
    "smg";
    "hpistol";
}

local real_time = globals.RealTime();
local current_weapon_group = "shared"
local local_entity, mouse_pos, fps, tick_rate, server, server_ip, ping;
local tick_rate_taken = false

local function handleVariables()

    --local data
    local_entity = entities.GetLocalPlayer()
    
    current_weapon_group = string.lower(string.gsub(gui.GetValue("rbot.hitscan.accuracy"), '"', ""))
    for i = 1, #patterns do
        current_weapon_group = string.gsub(current_weapon_group, patterns[i], replacements[i])
    end

    --time
    real_time = globals.RealTime()

    --other
    mouse_pos = {input.GetMousePos()}
    fps = 1 / globals.AbsoluteFrameTime()
    
    --watermark info 
    if local_entity then

        ping = entities:GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())

        --should get once to save fps
        if not tick_rate_taken then

            --updating values
            server_ip = engine.GetServerIP()
            tick_rate = client.GetConVar("sv_maxcmdrate")

            tick_rate_taken = true
        end
    else

        --reseting data
        server_ip = nil
        tick_rate = nil
        ping = nil

        tick_rate_taken = false
    end

    --checking for server ip
    if server_ip then

        --getting server type by his ip
        if server_ip == "loopback" then
            server = "localhost"
        elseif string.find(server_ip, "A") then
            server = "valve"    
        else
            server = server_ip
        end
    else

        server = nil
    end
end


--getting current weapon group to use it
constants.SHORT_WEAPON_GROUP =  
{
    pistol = {2, 3, 4, 30, 32, 36, 61, 63}, 
    sniper = {9}, 
    scout = {40}, 
    hpistol = {1, 64}, 
    smg = {17, 19, 23, 24, 26, 33, 34}, 
    rifle = {60, 7, 8, 10, 13, 16, 39}, 
    shotgun = {25, 27, 29, 35}, 
    asniper = {38, 11}, 
    lmg = {28, 14},
    zeus = {31}
}

local function getWeaponGroup()
    if not local_entity or not local_entity:IsAlive() then
        return "shared"
    end

    --get current weapon group
    local local_weapon_id = local_entity:GetWeaponID()

    --iterating over weapon groups
    for group_name, group_weapons in pairs(constants.SHORT_WEAPON_GROUP) do

        --iterating over all weapon ids in weapon grops
        for weapon_id = 1, #group_weapons, 1 do

            --if weapon id == our weapon rerunring group
            if local_weapon_id == group_weapons[weapon_id] then

                return group_name
            end
        end
    end

    --returning shared if not find weapon group
    return "shared"
end

--endregion





--region SPECIFIC_FUNCTIONS
--calculating our animation's scale based on frametime, if u have 450 fps - ur animation scale is 1
constants.MIDDLE_FPS_ANIMATION_VALUE = 450;

local function getAnimationScale()
    return constants.MIDDLE_FPS_ANIMATION_VALUE / fps
end


--drawing outlined text based on 2 fonts
local function outlinedText(position_x, position_y, text, font, color, font_outlined, color_outlined)

    draw.SetFont(font_outlined)
    draw.Color(color_outlined[1], color_outlined[2], color_outlined[3], color_outlined[4])
    draw.Text(position_x, position_y, text)

    draw.SetFont(font)
    draw.Color(color[1], color[2], color[3], color[4])
    draw.Text(position_x, position_y, text)
end
--endregion





--region HIT_INFO
--getting data about our hit
local hit_array = {};
local hit_timer = 0;

constants.TIME_OF_VISIBILITY = 2;

local function getHitEvent(event)

    --checking for event
    if not event then return end

    --listening for player hurt event
    if event:GetName() == "player_hurt" then

        --checking, that attacker is our entity
        if client.GetPlayerIndexByUserID(event:GetInt("attacker")) == client.GetLocalPlayerIndex() 
            and client.GetPlayerIndexByUserID(event:GetInt("userid")) ~= client.GetLocalPlayerIndex() then
            
            --calculating hit_position
            local user_entity = entities.GetByUserID(event:GetInt("userid"))
            local hit_position = user_entity:GetHitboxPosition(event:GetInt("hitgroup"))

            --inseting everything into array
            if not hit_array[#hit_array + 1] then
                hit_array[#hit_array + 1] = {}
            end
            local last_hit = hit_array[#hit_array]

            --filling data about last hit and some randomization of position
            last_hit.time = real_time + constants.TIME_OF_VISIBILITY

            last_hit.position_y = hit_position.y

            --this positions will be modulated by world damage marker
            last_hit.position_x = hit_position.x + math.random(-5, 5)
            last_hit.position_z = hit_position.z

            --this positions won't be modulated and will used by world hit marker
            last_hit.static_position_x = hit_position.x
            last_hit.static_position_z = hit_position.z

            last_hit.damage = event:GetInt("dmg_health")
            last_hit.hit_ground = event:GetInt("hitgroup")

            --last_hit.entity_name = user_entity:GetName()

            hit_timer = real_time + constants.TIME_OF_VISIBILITY
        end
    end
end


--drawing world damage marker
constants.HIT_INFO_ALPHA_BY_TIME = 255 / constants.TIME_OF_VISIBILITY;

constants.WORLD_HITMARKER_MAX_SIZE = 13;
constants.WORLD_HITMARKER_SIZE_BY_TIME = constants.WORLD_HITMARKER_MAX_SIZE / constants.TIME_OF_VISIBILITY;

local function drawWorldHitInfo()

    --checking for enable
    if not visuals_hit_info_ui.world_damage_marker:GetValue() then
        return 
    end

    --iterating over all hits
    for hit_index, hit_data in pairs(hit_array) do

        --check for valid 
        if not hit_data then return end

        --time left since hit
        local delta_time = hit_data.time - real_time

        --deleting old data
        if delta_time < 0 then

            table.remove(hit_array, hit_index)

            --printDebugMessage("hit array been cleared from old hit")
        end


        --getting dinamic alpha of our visuals
        local alpha = delta_time * constants.HIT_INFO_ALPHA_BY_TIME

        --damage marker
        if visuals_hit_info_ui.world_damage_marker:GetValue() then

            --randomizing grow up animation 
            hit_data.position_x = hit_data.position_x + (math.random(-5, 5) / 100) * getAnimationScale()
            hit_data.position_z = hit_data.position_z + (math.random(5, 20) / 100) * getAnimationScale()

            local hit_position_screen = {client.WorldToScreen(Vector3(hit_data.position_x, hit_data.position_y, hit_data.position_z))}

            --checking for valid hit position
            if hit_position_screen[1] and hit_position_screen[2] then

                --setting font
                draw.SetFont(fonts.world_damage_font)

                local damage_text = tostring("-" .. hit_data.damage)
                local size_of_damage = {draw.GetTextSize(damage_text)}

                --getting color based on this been head hit or not
                local color = {world_damage_marker_color:GetValue()}
                local color_headshot = {world_damage_marker_color_headshot:GetValue()}

                local current_color = (hit_data.hit_ground == 1) and {color_headshot[1], color_headshot[2], color_headshot[3], alpha} or {color[1], color[2], color[3], alpha}

                
                --drawing damage text
                outlinedText(hit_position_screen[1] - size_of_damage[1] / 2, hit_position_screen[2] - size_of_damage[2], damage_text,
                             fonts.world_damage_font, current_color,
                             fonts.world_damage_font_outlined, {10, 10, 10, current_color[4]}
                            )
            end
        end


        --hitmarker
        if visuals_hit_info_ui.world_hitmarker:GetValue() then

            local hit_position_screen = {client.WorldToScreen(Vector3(hit_data.static_position_x, hit_data.position_y, hit_data.static_position_z))}

            --checking for valid hit position
            if hit_position_screen[1] and hit_position_screen[2] then

                --drawing hit marker
                local color = {world_hitmarker_color:GetValue()}


                draw.Color(color[1], color[2], color[3], alpha)
                draw.FilledCircle(hit_position_screen[1], hit_position_screen[2], constants.WORLD_HITMARKER_SIZE_BY_TIME * (constants.TIME_OF_VISIBILITY - delta_time))
            end
        end
    end
end


--drawing screen cross hitmarker
constants.HITMARKER_MAX_ANIMATION = 6;
constants.HITMARKER_ANIMATION_BY_TIME = constants.HITMARKER_MAX_ANIMATION / constants.TIME_OF_VISIBILITY;
constants.HITMARKER_DISTANCE_TO_CENTER = 3;
constants.HITMARKER_CROSS_SIZE = 5;

local function drawScreenHitInfo()

    --checking for enable
    if not visuals_hit_info_ui.screen_hitmarker:GetValue() or (hit_timer - real_time) <= 0 then
        return
    end

    --getting current animation
    local animation_lenght = constants.HITMARKER_ANIMATION_BY_TIME * (constants.TIME_OF_VISIBILITY - (hit_timer - real_time));

    
    --drawing hit marker
    local color = {screen_hitmarker_color:GetValue()}
    draw.Color(color[1], color[2], color[3], constants.HIT_INFO_ALPHA_BY_TIME * (hit_timer - real_time))

    --right up
    draw.Line(screen_width / 2 + constants.HITMARKER_DISTANCE_TO_CENTER + animation_lenght, screen_height / 2 - constants.HITMARKER_DISTANCE_TO_CENTER - animation_lenght,
              screen_width / 2 + constants.HITMARKER_DISTANCE_TO_CENTER + animation_lenght + constants.HITMARKER_CROSS_SIZE, 
              screen_height / 2 - constants.HITMARKER_DISTANCE_TO_CENTER - animation_lenght - constants.HITMARKER_CROSS_SIZE
             )

    --right down
    draw.Line(screen_width / 2 + constants.HITMARKER_DISTANCE_TO_CENTER + animation_lenght, screen_height / 2 + constants.HITMARKER_DISTANCE_TO_CENTER + animation_lenght,
              screen_width / 2 + constants.HITMARKER_DISTANCE_TO_CENTER + animation_lenght + constants.HITMARKER_CROSS_SIZE, 
              screen_height / 2 + constants.HITMARKER_DISTANCE_TO_CENTER + animation_lenght + constants.HITMARKER_CROSS_SIZE
             )
    
    --left up
    draw.Line(screen_width / 2 - constants.HITMARKER_DISTANCE_TO_CENTER - animation_lenght, screen_height / 2 - constants.HITMARKER_DISTANCE_TO_CENTER - animation_lenght,
              screen_width / 2 - constants.HITMARKER_DISTANCE_TO_CENTER - animation_lenght - constants.HITMARKER_CROSS_SIZE, 
              screen_height / 2 - constants.HITMARKER_DISTANCE_TO_CENTER - animation_lenght - constants.HITMARKER_CROSS_SIZE
             )

    --left down
    draw.Line(screen_width / 2 - constants.HITMARKER_DISTANCE_TO_CENTER - animation_lenght, screen_height / 2 + constants.HITMARKER_DISTANCE_TO_CENTER + animation_lenght,
              screen_width / 2 - constants.HITMARKER_DISTANCE_TO_CENTER - animation_lenght - constants.HITMARKER_CROSS_SIZE, 
              screen_height / 2 + constants.HITMARKER_DISTANCE_TO_CENTER + animation_lenght + constants.HITMARKER_CROSS_SIZE
             )
end


--bullet tracers
local bullet_impact_array = {}
local last_impact_frame = 0;

--getting impacts arrays
local function getImpactEvent(event)

    --checking for event
    if not event then return end

    --handling bullet impact
    if event:GetName() == "bullet_impact" then

        --checking, that we are userid and checking for frames to not add many tracers 
        if client.GetPlayerIndexByUserID(event:GetInt("userid")) == client.GetLocalPlayerIndex() and globals.FrameCount() - last_impact_frame >= 1 then

            --getting local eye pos
            local local_eye = local_entity:GetAbsOrigin() + Vector3(0, 0, local_entity:GetPropFloat("localdata", "m_vecViewOffset[2]"))

            --filing one more array with impact data
            bullet_impact_array[#bullet_impact_array + 1] = {real_time + constants.TIME_OF_VISIBILITY, Vector3(local_eye.x, local_eye.y, local_eye.z), 
                                                                                                 Vector3(event:GetFloat("x"), event:GetFloat("y"), event:GetFloat("z"))
                                                             }

            last_impact_frame = globals.FrameCount()
        end
    end
end


--drawing bullet tracer
local function drawBulletTracers()

    --checking for enable 
    if not visuals_hit_info_ui.bullet_tracers:GetValue() then

        --clearing the table
        bullet_impact_array = {}
        return 
    end


    --iterating over impact arrays
    for impact_index, impact_array in pairs(bullet_impact_array) do

        --checking for time
        if impact_array[1] - real_time > 0 and impact_array[1] - real_time < constants.TIME_OF_VISIBILITY then

            --getting screen position of local eye and last impact data
            local impact_position = {client.WorldToScreen(impact_array[3])}
            local local_eye_position = {client.WorldToScreen(impact_array[2])}

            --checking for visibility 
            if impact_position[1] and impact_position[2] and local_eye_position[1] and local_eye_position[2] then

                local color = {bullet_tracers_color:GetValue()}

                --drawing tracer
                draw.Color(color[1], color[2], color[3], (impact_array[1] - real_time) * constants.HIT_INFO_ALPHA_BY_TIME)
                draw.Line(impact_position[1], impact_position[2], local_eye_position[1], local_eye_position[2])

                --drawing cross 
                constants.CROSS_SIZE = 3
                draw.Line(impact_position[1] - constants.CROSS_SIZE, impact_position[2] - constants.CROSS_SIZE, impact_position[1], impact_position[2])
                draw.Line(impact_position[1] - constants.CROSS_SIZE, impact_position[2] + constants.CROSS_SIZE, impact_position[1], impact_position[2])
                draw.Line(impact_position[1] + constants.CROSS_SIZE, impact_position[2] - constants.CROSS_SIZE, impact_position[1], impact_position[2])
                draw.Line(impact_position[1] + constants.CROSS_SIZE, impact_position[2] + constants.CROSS_SIZE, impact_position[1], impact_position[2])
            end
            
        --removing old data
        elseif impact_array[1] - real_time <= 0 then
            table.remove(bullet_impact_array, impact_index)
        end
    end
end
--endregion





--region USER_INFO
--sizes
constants.KEYBINDS_SIZE = 160;
constants.KEYBINDS_HEADER_SIZE = 17;

--colors
constants.HEADER_COLOR = {30, 30, 30};
constants.BACKGROUND_COLOR = {80, 80, 80};
constants.TEXT_COLOR = {255, 255, 255};
constants.TEXT_OUTLINE_COLOR = {10, 10, 10};

--contoling position of keybinds | weapon info
local visuals_x_distance, visuals_y_distance = 0, 0;

local function controleVisualsPostion()

    --all gui, that has positions of visuals
    local visuals_positions = {{"esp.visuals_tab.keybinds_position_x", "esp.visuals_tab.keybinds_position_y"},
                               {"esp.visuals_tab.weapon_info_position_x", "esp.visuals_tab.weapon_info_position_y"}
                              }
    
    --getting menu position 
    local menu = gui.Reference("Menu")
    local menu_pos = {menu:GetValue()}
    local distance_to_menu = vector.Distance(menu_pos[1], menu_pos[2], 0, mouse_pos[1], mouse_pos[2], 0)  

    local closest = 1;
    local closest_distance = math.huge

    --iterating over all visuals
    for visual_index, visual_data in pairs(visuals_positions) do

        --getting distance between visuals and mouse
        local between_x = mouse_pos[1] - gui.GetValue(visual_data[1])
        local between_y = mouse_pos[2] - gui.GetValue(visual_data[2])

        --checking for valid pos
        if (between_x > 0 and between_x <= constants.KEYBINDS_SIZE) and (between_y > 0 and between_y <= constants.KEYBINDS_HEADER_SIZE) then

            --getting closest
            local distance = vector.Distance(gui.GetValue(visual_data[1]), gui.GetValue(visual_data[2]), 0,  mouse_pos[1], mouse_pos[2], 0)
            
            --returning the closest one
            if distance < closest_distance then
                closest = visual_index
                closest_distance = distance
            end
        end
    end

    --collecting delta data if mouse 1 is not pressed 
    if not input.IsButtonDown(1) then

        --getting distance between visuals and mouse
        visuals_x_distance = mouse_pos[1] - gui.GetValue(visuals_positions[closest][1])
        visuals_y_distance = mouse_pos[2] - gui.GetValue(visuals_positions[closest][2])
    end

    --setting positions 
    if input.IsButtonDown(1) and (visuals_x_distance > 0 and visuals_x_distance <= constants.KEYBINDS_SIZE) and 
        (visuals_y_distance > 0 and visuals_y_distance <= constants.KEYBINDS_HEADER_SIZE) and (distance_to_menu > 50) and menu:IsActive() then

        gui.SetValue(visuals_positions[closest][1], mouse_pos[1] - visuals_x_distance)
        gui.SetValue(visuals_positions[closest][2], mouse_pos[2] - visuals_y_distance)
    end
end


--controling bindable states of keybinds
local keybinds_states = {};
local keybind_states_text = {};
local keybind_states_type = {};
local keybind_states_values = {};

local function getKeybindsStates()

    --RAGE functions
    keybinds_states.double_tap_active = (current_weapon_group ~= "zeus" and gui.GetValue("rbot.accuracy.attack." .. current_weapon_group .. ".fire") == '"Defensive Warp Fire"')
                                                                        or (gui.GetValue("rbot.accuracy.attack.shared.fire") == '"Defensive Warp Fire"')

    keybinds_states.hide_shots_active = (current_weapon_group ~= "zeus" and (gui.GetValue("rbot.accuracy.attack." .. current_weapon_group .. ".fire") == '"Shift Fire"') 
                                                                        or (gui.GetValue("rbot.accuracy.attack.shared.fire") == '"Shift Fire"'))

    keybinds_states.fake_duck_active = cheat.IsFakeDucking()
    keybinds_states.slow_walk_active = gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey"))
    keybinds_states.third_person_active = gui.GetValue("esp.world.thirdperson")
    keybinds_states.fake_latency_active = gui.GetValue("misc.fakelatency.enable") and (gui.GetValue("misc.fakelatency.amount") > 0)
    keybinds_states.edge_jump_active = gui.GetValue("misc.edgejump") ~= 0 and input.IsButtonDown(gui.GetValue("misc.edgejump"))

    --LEGIT functions
    keybinds_states.autowall_active = gui.GetValue("lbot.weapon.vis." .. current_weapon_group .. ".autowall")
    keybinds_states.aimbot_active = gui.GetValue("lbot.aim.enable")
    keybinds_states.auto_fire_active = gui.GetValue("lbot.aim.autofire")
    keybinds_states.triggerbot_active = gui.GetValue("lbot.trg.enable") and (gui.GetValue("lbot.trg.key") ~= 0 and input.IsButtonDown(gui.GetValue("lbot.trg.key")))
    keybinds_states.backtrack_active = gui.GetValue("lbot.posadj.backtrack") and (gui.GetValue("lbot.extra.backtrack") > 0)
    keybinds_states.legit_aa_active = (gui.GetValue("lbot.antiaim.type") ~= '"Off"')
    keybinds_states.resolver_active = gui.GetValue("lbot.posadj.resolver")

    --selecting states, which we will show
    if gui.GetValue("lbot.master") then

        --legit
        keybind_states_values = {keybinds_states.aimbot_active, keybinds_states.triggerbot_active, keybinds_states.auto_fire_active, keybinds_states.autowall_active, 
                                 keybinds_states.resolver_active, keybinds_states.legit_aa_active, keybinds_states.backtrack_active
                                }

        keybind_states_text = {"aimbot", "triggerbot", "auto fire", "autowall", "resolver", "legit aa", "backtrack"}
        keybind_states_type = {"[holding]", "[holding]", "[holding]", "[holding]", "[holding]", "[toggled]", "[toggled]"}
    else

        --rage
        keybind_states_values = {keybinds_states.double_tap_active, keybinds_states.hide_shots_active, keybinds_states.fake_duck_active, keybinds_states.fake_latency_active, 
                                 keybinds_states.edge_jump_active, keybinds_states.slow_walk_active, keybinds_states.third_person_active
                                }

        keybind_states_text = {"double tap", "hide shots", "fake duck", "fake latency", "edge jump", "slow walk", "third person"}
        keybind_states_type = {"[toggled]", "[toggled]", "[toggled]", "[holding]", "[holding]", "[toggled]", "[toggled]"}
    end
end


--calculating sum of all array elements
local function sumFromTo(array, first_sum, last_sum)

    local sum = 0

    for counter = first_sum, last_sum, 1 do
        sum = sum + array[counter]
    end

    return sum
end


--creating animations for visuals
local keybind_states_animations = {0, 0, 0, 0, 0, 0, 0} 
local keybinds_alpha = 0;
local weapon_info_alpha = 0;

constants.KEYBINDS_ANIMATION_SPEED = 0.125;
constants.KEYBINDS_ANIMATION_LENGTH = 15;
constants.MAIN_ANIMATION_LENGTH = 25;
constants.MAIN_ANIMATION_SPEED = 0.20;
constants.MAIN_ANIMATION_START_VALUE = 7;

local function createVisualsAnimations()

    --STATES ANIMATION
    --iterating over all states
    for state = 1, #keybind_states_values, 1 do

        --animating them
        if keybind_states_values[state] and visuals_user_info_ui.keybinds:GetValue() and local_entity and local_entity:IsAlive() then

            --showing animation
            keybind_states_animations[state] = keybind_states_animations[state] + constants.KEYBINDS_ANIMATION_SPEED * getAnimationScale()

            if keybind_states_animations[state] > constants.KEYBINDS_ANIMATION_LENGTH then 
                keybind_states_animations[state] = constants.KEYBINDS_ANIMATION_LENGTH
            end
        else

            --disabling animation
            keybind_states_animations[state] = keybind_states_animations[state] - constants.KEYBINDS_ANIMATION_SPEED * getAnimationScale()

            if keybind_states_animations[state] < 0 then 
                keybind_states_animations[state] = 0
            end
        end
    end

    --MAIN ANIMATION
    --checking, that all states are disabling
    if sumFromTo(keybind_states_animations, 1, #keybind_states_animations) >= constants.MAIN_ANIMATION_START_VALUE and local_entity and local_entity:IsAlive() then

        --showing animation
        keybinds_alpha = keybinds_alpha + constants.MAIN_ANIMATION_SPEED * getAnimationScale()

        if keybinds_alpha > constants.MAIN_ANIMATION_LENGTH then
            keybinds_alpha = constants.MAIN_ANIMATION_LENGTH
        end
    else

        --disabling animation
        keybinds_alpha = keybinds_alpha - constants.MAIN_ANIMATION_SPEED * getAnimationScale()

        if keybinds_alpha < 0 then
            keybinds_alpha = 0
        end
    end

    --disable animation for unstandart guns(grenades, knife)
    if getWeaponGroup() == current_weapon_group and visuals_user_info_ui.weapon_info:GetValue() and local_entity and local_entity:IsAlive() then
 
        --showing animation
        weapon_info_alpha = weapon_info_alpha + constants.MAIN_ANIMATION_SPEED * getAnimationScale()
 
        if weapon_info_alpha > constants.MAIN_ANIMATION_LENGTH then
            weapon_info_alpha = constants.MAIN_ANIMATION_LENGTH
        end
    else

        --disabling animation
        weapon_info_alpha = weapon_info_alpha - constants.MAIN_ANIMATION_SPEED * getAnimationScale()

        if weapon_info_alpha < 0 then
            weapon_info_alpha = 0
        end
    end
end


--drawing keybinds 
constants.HEADER_ALPHA_SCALER = 0.8;
constants.BACKGROUND_ALPHA_SCALER = 0.2;
constants.HEADER_LINE_ALPHA_SCALER = 9;
constants.TEXT_ALPHA_SCALER = 9;
constants.STATE_TEXT_ALPHA_SCALER = 16;
constants.DISTANCE_FROM_HEADER = 10;
constants.DISTANCE_FROM_BORDERS = 3;


local function drawKeyinds()

    --checking for enable
    if keybinds_alpha <= 0 then
        return 
    end

    --useful values
    local position_x = visuals_user_info_ui.keybinds_position_x:GetValue()
    local position_y = visuals_user_info_ui.keybinds_position_y:GetValue()
    local header_line_color = {visuals_user_info_ui.visuals_color:GetValue()}

    --header
    draw.Color(constants.HEADER_COLOR[1], constants.HEADER_COLOR[2], constants.HEADER_COLOR[3], keybinds_alpha * constants.HEADER_ALPHA_SCALER)
    draw.FilledRect(position_x, position_y, position_x + constants.KEYBINDS_SIZE, position_y + constants.KEYBINDS_HEADER_SIZE)

    --header line
    draw.Color(header_line_color[1], header_line_color[2], header_line_color[3], keybinds_alpha * constants.HEADER_LINE_ALPHA_SCALER)
    draw.FilledRect(position_x, position_y - 2, position_x + constants.KEYBINDS_SIZE, position_y)

    --header text
    draw.SetFont(fonts.keybinds_font)
    local header_text_size = {draw.GetTextSize("keybindings")}

    draw.Color(constants.TEXT_COLOR[1], constants.TEXT_COLOR[2], constants.TEXT_COLOR[3], keybinds_alpha * constants.TEXT_ALPHA_SCALER)
    draw.Text(position_x + constants.KEYBINDS_SIZE / 2 - math.floor(header_text_size[1] / 2), 
              position_y + math.floor(constants.KEYBINDS_HEADER_SIZE / 2) - math.floor(header_text_size[2] / 2) - 1, "keybindings"
             )

    --states background
    draw.Color(constants.BACKGROUND_COLOR[1], constants.BACKGROUND_COLOR[2], constants.BACKGROUND_COLOR[3], keybinds_alpha * constants.BACKGROUND_ALPHA_SCALER)
    draw.FilledRect(position_x, position_y + constants.KEYBINDS_HEADER_SIZE, position_x + constants.KEYBINDS_SIZE,
                    position_y + constants.KEYBINDS_HEADER_SIZE + sumFromTo(keybind_states_animations, 1, 
                    #keybind_states_animations) + 2 * constants.DISTANCE_FROM_HEADER - constants.KEYBINDS_ANIMATION_LENGTH
                   )

    --states text
    --iterating over all states
    for state = 1, #keybind_states_values, 1 do

        if keybind_states_animations[state] > 0 then

            local state_text_size = {draw.GetTextSize(keybind_states_text[state])}
            local state_type_size = {draw.GetTextSize(keybind_states_type[state])}

            draw.Color(constants.TEXT_COLOR[1], constants.TEXT_COLOR[2], constants.TEXT_COLOR[3], keybind_states_animations[state] * constants.STATE_TEXT_ALPHA_SCALER)

            --state name
            draw.Text(position_x + constants.DISTANCE_FROM_BORDERS, 
                      position_y + constants.KEYBINDS_HEADER_SIZE + constants.DISTANCE_FROM_HEADER - constants.KEYBINDS_ANIMATION_LENGTH + 
                      sumFromTo(keybind_states_animations, 1, state) - math.floor(state_text_size[2] / 2) - 1, keybind_states_text[state]
                     )
            
            --state type
            draw.Text(position_x + constants.KEYBINDS_SIZE - constants.DISTANCE_FROM_BORDERS - state_type_size[1], 
                      position_y + constants.KEYBINDS_HEADER_SIZE + constants.DISTANCE_FROM_HEADER - constants.KEYBINDS_ANIMATION_LENGTH + 
                      sumFromTo(keybind_states_animations, 1, state) - math.floor(state_type_size[2] / 2) - 1, keybind_states_type[state]
                     )         
        end
    end
end


--drawing weapon info
constants.WEAPON_INFO_BACKGROUND_SIZE = 35;

local function drawWeaponInfo()

    --checking for enable
    if weapon_info_alpha <= 0 then
        return 
    end

    --useful values
    local position_x = visuals_user_info_ui.weapon_info_position_x:GetValue()
    local position_y = visuals_user_info_ui.weapon_info_position_y:GetValue()
    local header_line_color = {visuals_user_info_ui.visuals_color:GetValue()}

    --header
    draw.Color(constants.HEADER_COLOR[1], constants.HEADER_COLOR[2], constants.HEADER_COLOR[3], weapon_info_alpha * constants.HEADER_ALPHA_SCALER)
    draw.FilledRect(position_x, position_y, position_x + constants.KEYBINDS_SIZE, position_y + constants.KEYBINDS_HEADER_SIZE)

    --header line
    draw.Color(header_line_color[1], header_line_color[2], header_line_color[3], weapon_info_alpha * constants.HEADER_LINE_ALPHA_SCALER)
    draw.FilledRect(position_x, position_y - 2, position_x + constants.KEYBINDS_SIZE, position_y)

    --header text
    draw.SetFont(fonts.keybinds_font)
    local header_text_size = {draw.GetTextSize("weapon info")}

    draw.Color(constants.TEXT_COLOR[1], constants.TEXT_COLOR[2], constants.TEXT_COLOR[3], weapon_info_alpha * constants.TEXT_ALPHA_SCALER)
    draw.Text(position_x + constants.KEYBINDS_SIZE / 2 - math.floor(header_text_size[1] / 2), 
              position_y + math.floor(constants.KEYBINDS_HEADER_SIZE / 2) - math.floor(header_text_size[2] / 2) - 1, "weapon info"
             )

    --states background
    draw.Color(constants.BACKGROUND_COLOR[1], constants.BACKGROUND_COLOR[2], constants.BACKGROUND_COLOR[3], weapon_info_alpha * constants.BACKGROUND_ALPHA_SCALER)
    draw.FilledRect(position_x, position_y + constants.KEYBINDS_HEADER_SIZE, position_x + constants.KEYBINDS_SIZE,
                    position_y + constants.KEYBINDS_HEADER_SIZE + constants.WEAPON_INFO_BACKGROUND_SIZE
                   )

    --info text
    --weapon group
    local weapon_group_text_size = {draw.GetTextSize(current_weapon_group)}

    draw.Color(constants.TEXT_COLOR[1], constants.TEXT_COLOR[2], constants.TEXT_COLOR[3], weapon_info_alpha * constants.TEXT_ALPHA_SCALER)
    draw.Text(position_x + constants.DISTANCE_FROM_BORDERS, 
              position_y + constants.KEYBINDS_HEADER_SIZE + math.floor(constants.WEAPON_INFO_BACKGROUND_SIZE / 2) - math.floor(weapon_group_text_size[2] / 2) - 1, current_weapon_group
             )

    --damage 
    local damage_text = "damage: " .. gui.GetValue("rbot.hitscan.accuracy." .. current_weapon_group .. ".mindamage")
    local damage_text_size = {draw.GetTextSize(damage_text)}

    draw.Color(constants.TEXT_COLOR[1], constants.TEXT_COLOR[2], constants.TEXT_COLOR[3], weapon_info_alpha * constants.TEXT_ALPHA_SCALER)
    draw.Text(position_x + constants.KEYBINDS_SIZE - constants.DISTANCE_FROM_BORDERS - damage_text_size[1], 
              position_y + constants.KEYBINDS_HEADER_SIZE + constants.DISTANCE_FROM_HEADER - math.floor(damage_text_size[2] / 2) - 1, damage_text
             )

    --hitchance
    local hit_chance_text = "hitchance: " .. gui.GetValue("rbot.hitscan.accuracy." .. current_weapon_group .. ".hitchance")
    local hit_chance_text_size = {draw.GetTextSize(hit_chance_text)}

    draw.Color(constants.TEXT_COLOR[1], constants.TEXT_COLOR[2], constants.TEXT_COLOR[3], weapon_info_alpha * constants.TEXT_ALPHA_SCALER)
    draw.Text(position_x + constants.KEYBINDS_SIZE - constants.DISTANCE_FROM_BORDERS - hit_chance_text_size[1], 
              position_y + constants.WEAPON_INFO_BACKGROUND_SIZE + constants.KEYBINDS_HEADER_SIZE - constants.DISTANCE_FROM_HEADER - math.floor(hit_chance_text_size[2] / 2) - 1, hit_chance_text
             )
    
end


--drawing watermark
local user_name = cheat.GetUserName()
constants.WATERMARK_DISTANCE_TO_BORDER = 10

local function drawWatermark()

    --checking for enable 
    if not visuals_user_info_ui.watermark:GetValue() then
        return 
    end

    --creating watermark text
    local script_name = "bleeding"
    local divider = " | ";

    --values, that always not nil
    local watermark_text = script_name .. divider .. user_name .. divider .. math.floor(fps) .. " fps"

    --adding server
    if server then
        watermark_text = watermark_text .. divider .. server
    end

    --adding ping
    if ping then
        watermark_text = watermark_text .. divider .. "delay: " .. ping .. " ms"
    end

    --adding tickrate
    if tick_rate then
        watermark_text = watermark_text .. divider .. tick_rate .. " tick"
    end

    --getting text size
    draw.SetFont(fonts.keybinds_font)
    local watermark_text_size = {draw.GetTextSize(watermark_text)}

    --background
    draw.Color(constants.BACKGROUND_COLOR[1], constants.BACKGROUND_COLOR[2], constants.BACKGROUND_COLOR[3], constants.MAIN_ANIMATION_LENGTH * constants.BACKGROUND_ALPHA_SCALER)
    draw.FilledRect(screen_width - constants.WATERMARK_DISTANCE_TO_BORDER - watermark_text_size[1] - constants.DISTANCE_FROM_BORDERS, constants.WATERMARK_DISTANCE_TO_BORDER - constants.DISTANCE_FROM_BORDERS, 
                    screen_width - constants.WATERMARK_DISTANCE_TO_BORDER + constants.DISTANCE_FROM_BORDERS,  constants.WATERMARK_DISTANCE_TO_BORDER + watermark_text_size[2] + constants.DISTANCE_FROM_BORDERS)

    --header line
    local header_line_color = {visuals_user_info_ui.visuals_color:GetValue()}
    draw.Color(header_line_color[1], header_line_color[2], header_line_color[3], constants.MAIN_ANIMATION_LENGTH * constants.HEADER_LINE_ALPHA_SCALER)
    draw.FilledRect(screen_width - constants.WATERMARK_DISTANCE_TO_BORDER - watermark_text_size[1] - constants.DISTANCE_FROM_BORDERS, constants.WATERMARK_DISTANCE_TO_BORDER - constants.DISTANCE_FROM_BORDERS - 2, 
                    screen_width - constants.WATERMARK_DISTANCE_TO_BORDER + constants.DISTANCE_FROM_BORDERS,  constants.WATERMARK_DISTANCE_TO_BORDER - constants.DISTANCE_FROM_BORDERS)

    --text
    draw.Color(constants.TEXT_COLOR[1], constants.TEXT_COLOR[2], constants.TEXT_COLOR[3], constants.MAIN_ANIMATION_LENGTH * constants.TEXT_ALPHA_SCALER)
    draw.Text(screen_width - constants.WATERMARK_DISTANCE_TO_BORDER - watermark_text_size[1], constants.WATERMARK_DISTANCE_TO_BORDER - 1 , watermark_text)
end
--endregion





--region OTHER_VISUALS
--save convars
local convar_array = {};

local function setConvar(name, value)
    
    --checking for convar value is new
    if value ~= nil and (value ~= convar_array[name] or not convar_array[name]) then

        client.SetConVar(name, value, true)
        convar_array[name] = value
        --printDebugMessage(name .. " convar installed to the value: " .. value)
   end
end


--save props
local prop_array = {};

local function setProp(entity, name, value)

    --checking for prop value is new
    if entity and value ~= nil and (value ~= prop_array[name] or not prop_array[name]) then

        entity:SetProp(name, value)
        prop_array[name] = value
        --printDebugMessage(name .. " prop installed to the value: " .. value)
   end
end


--other visuals
--getting visuals caches
local view_model_cache = {client.GetConVar("viewmodel_offset_x"), client.GetConVar("viewmodel_offset_y"), client.GetConVar("viewmodel_offset_z")};
local aspect_ration_cache = client.GetConVar("r_aspectratio");
local ambient_cache = client.GetConVar("r_modelAmbientMin");
local world_ambient_cache = {client.GetConVar("mat_ambient_light_r"), client.GetConVar("mat_ambient_light_g"), client.GetConVar("mat_ambient_light_b")}

--setting caches of world modulations
local function setWorldModulationCaches()

    local tone_map_controller = entities.FindByClass('CEnvTonemapController')[1]

    setProp(tone_map_controller, "m_flCustomBloomScaleMinimum", 0)
    setProp(tone_map_controller, "m_flCustomBloomScale", 0);
    setProp(tone_map_controller, "m_flCustomAutoExposureMax", 1)
    setProp(tone_map_controller, "m_flCustomAutoExposureMin", 1)

    setConvar("r_modelAmbientMin", ambient_cache)
    setConvar("mat_ambient_light_r", world_ambient_cache[1])
    setConvar("mat_ambient_light_g", world_ambient_cache[2])
    setConvar("mat_ambient_light_b", world_ambient_cache[3])
end


--setting caches of viewmodel
local function setViewModelCaches()

    setConvar("viewmodel_offset_x", view_model_cache[1])
    setConvar("viewmodel_offset_y", view_model_cache[2])
    setConvar("viewmodel_offset_z", view_model_cache[3])
end


--setting caches of aspect ration
local function setAspectRationCache()

    setConvar("r_aspectratio", aspect_ration_cache)
end


--installing all visuals
constants.POST_PROCESSING = gui.Reference("Visuals", "Other", "Effects", "Effects Removal", "No Post Processing");
constants.MAX_COLOR_VALUE = 255;

local function otherVisuals()

    --aspect ratio
    if visuals_other_ui.aspect_ratio:GetValue() then
        setConvar("r_aspectratio", visuals_other_ui.aspect_ratio_value:GetValue())
    else
        setAspectRationCache()
    end

    --view model changer
    if visuals_other_ui.view_model_changer:GetValue() then
        setConvar("viewmodel_offset_x", visuals_other_ui.view_model_changer_x:GetValue())
        setConvar("viewmodel_offset_y", visuals_other_ui.view_model_changer_y:GetValue())
        setConvar("viewmodel_offset_z", visuals_other_ui.view_model_changer_z:GetValue())
    else
        setViewModelCaches()
    end

    --checking for world modifications enabled
    if visuals_other_ui.world_modifications:GetValue() then

        --disabling post processing on bloom
        if visuals_other_ui.world_modifications_bloom:GetValue() then
            constants.POST_PROCESSING:SetValue(false)
        end


        local tone_map_controller = entities.FindByClass('CEnvTonemapController')[1]

        --checking for tone map entity
        if tone_map_controller then

            --bloom
            setProp(tone_map_controller, "m_flCustomBloomScaleMinimum", visuals_other_ui.world_modifications_bloom:GetValue() * 0.1)
            setProp(tone_map_controller, "m_flCustomBloomScale", visuals_other_ui.world_modifications_bloom:GetValue() * 0.1);

            --exposure
            setProp(tone_map_controller, "m_flCustomAutoExposureMax", 1.01 - (visuals_other_ui.world_modifications_exposure:GetValue() * 0.01))
            setProp(tone_map_controller, "m_flCustomAutoExposureMin", 1.01 - (visuals_other_ui.world_modifications_exposure:GetValue() * 0.01))
        end

        --ambient
        setConvar("r_modelAmbientMin", visuals_other_ui.world_modifications_ambient:GetValue() * 0.1)

        --world ambient light
        local world_color_ambient = {visuals_other_ui.world_modifications_ambient_color:GetValue()}

        setConvar("mat_ambient_light_r", world_color_ambient[1] / constants.MAX_COLOR_VALUE)
        setConvar("mat_ambient_light_g", world_color_ambient[2] / constants.MAX_COLOR_VALUE)
        setConvar("mat_ambient_light_b", world_color_ambient[3] / constants.MAX_COLOR_VALUE)
    else
        setWorldModulationCaches()
    end

    --reseting props and convars tables
    if not local_entity then

        convar_array = {}
        prop_array = {}
    end
end
--endregion





--region CALLBACKS
callbacks.Register("Draw", function()

    --gui
    handleScreenSizes()
    changeGui()

    --handlers
    handleVariables()

    --events
    drawWorldHitInfo()
    drawScreenHitInfo()
    drawBulletTracers()

    --user info
    controleVisualsPostion()
    createVisualsAnimations()
    drawKeyinds()
    drawWeaponInfo()
    drawWatermark()

    --other visuals
    otherVisuals()
end)


callbacks.Register("PostMove", function()

    getKeybindsStates()
end)


callbacks.Register("FireGameEvent", function(event)
    
    getHitEvent(event)
    getImpactEvent(event)
end)


callbacks.Register("Unload", function()

    --installing convar and props caches
    setWorldModulationCaches()
    setViewModelCaches()
    setAspectRationCache()
end)
--endregion





--region ALLOW_LISTENERS
client.AllowListener("player_hurt")
client.AllowListener("bullet_impact")
--endregion
