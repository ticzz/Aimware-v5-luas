-- Walkbot by ShadyRetard

local config = {}

config.modules = {
    "gui",
    "map_manager",
    "mesh_manager",
    "debug",
    "mesh_navigation",
    "objective",
    "objective_use",
    "movement",
    "memory",
    "autoqueue",
    "aimbot"
}
config.main_directory = "walkbot"
config.data_directory = config.main_directory .. "\\data"               -- Path to the data folder
config.modules_directory = config.main_directory .. "\\modules"         -- Path to the module folder
config.tab_width = 640                                                  -- Width for a tab, defaults to 640
config.tab_padding = 16                                                 -- Width for padding around items, defaults to 16
config.debug_x = 16                                                     -- x position for debug
config.debug_y = 16                                                     -- y position for debug
config.debug_width = 200                                                -- Width for debug
config.memory_time = 3                                                  -- How long walkbot keeps its player memory for
config.objective_switching_time = 10                                    -- How often the objective can be changed in seconds
config.aim_smoothing = 40                                               -- The amount of smoothing for aiming at locations
config.aimbot_smoothing = 7                                             -- Smoothing for aimbot
config.aimbot_fov = 15                                                  -- The FOV after which aimbot_smoothing is used instead of aim_smoothing
config.reload_threshold_pistol = 9                                      -- Bullets in pistol magazine before reload
config.reload_threshold_sniper = 3                                      -- Bullets in sniper magazine before reload
config.reload_threshold_smg = 13                                        -- Bullets in smg magazine before reload
config.reload_threshold_rifle = 10                                      -- Bullets in rifle magazine before reload
config.reload_threshold_shotgun = 3                                     -- Bullets in shotgun magazine before reload
config.reload_threshold_heavy = 30                                      -- Bullets in heavy magazine before reload

return config