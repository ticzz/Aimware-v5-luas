---
--- Title: BetterChams
--- Desciption: Adds more materials for your local player, hands and weapons.
--- Author: superyu'#7167
---

--- Auto updater Variables
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/superyor/BetterChams/master/BetterChams.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/superyor/BetterChams/master/version.txt"; --- in case of update i need to update this. (Note by superyu'#7167 "so i don't forget it.")
local VERSION_NUMBER = "1.2b"; --- This too
local version_check_done = false;
local update_downloaded = false;
local update_available = false;

--- Auto Updater GUI Stuff
local BETTERCHAMS_UPDATER_TAB = gui.Tab(gui.Reference("Settings"), "betterchams.updater.tab", "BetterChams Autoupdater")
local BETTERCHAMS_UPDATER_GROUP = gui.Groupbox(BETTERCHAMS_UPDATER_TAB, "Auto Updater for BetterChams™ | v" .. VERSION_NUMBER, 15, 15, 500, 500)
local BETTERCHAMS_UPDATER_TEXT = gui.Text(BETTERCHAMS_UPDATER_GROUP, "")

----- Gui stuff
local BETTERCHAMS_TAB = gui.Tab(gui.Reference("Visuals"), "vis.betterchams.tab", "BetterChams")

--- Local chams stuff
local BETTERCHAMS_LOCAL_GROUP = gui.Groupbox(gui.Reference("Visuals", "BetterChams"), "Local", 15, 15, 600, 600)
local BETTERCHAMS_LOCAL = gui.Combobox(BETTERCHAMS_LOCAL_GROUP, "vis.betterchams.local", "Material", "Off", "Crystal", "Gold", "Glass", "Dark Chrome", "Pulse", "Speech Info", "Star Blur")
local BETTERCHAMS_LOCAL_ALPHA = gui.Slider(BETTERCHAMS_LOCAL_GROUP, "vis.betterchams.local.alpha", "Alpha", 255, 0, 255)
local BETTERCHAMS_LOCAL_SCOPETRANSPARENCY = gui.Checkbox(BETTERCHAMS_LOCAL_GROUP, "vis.betterchams.local.scopetransparency", "Scope Transparency", false)

--- Hand chams stuff
local BETTERCHAMS_HANDS_GROUP = gui.Groupbox(gui.Reference("Visuals", "BetterChams"), "Hands", 15, 210, 600, 600)
local BETTERCHAMS_HANDS = gui.Combobox(BETTERCHAMS_HANDS_GROUP, "vis.betterchams.hands", "Material", "Off", "Crystal", "Gold", "Glass", "Dark Chrome", "Pulse", "Speech Info", "Star Blur")
local BETTERCHAMS_HANDS_ALPHA = gui.Slider(BETTERCHAMS_HANDS_GROUP, "vis.betterchams.hands.alpha", "Alpha", 255, 0, 255)

--- Weapon chams stuff
local BETTERCHAMS_WEAPON_GROUP = gui.Groupbox(gui.Reference("Visuals", "BetterChams"), "Weapons", 15, 370, 600, 600)
local BETTERCHAMS_WEAPON = gui.Combobox(BETTERCHAMS_WEAPON_GROUP, "vis.betterchams.hands", "Material", "Off", "Crystal", "Gold", "Glass", "Dark Chrome", "Pulse", "Speech Info", "Star Blur")
local BETTERCHAMS_WEAPON_ALPHA = gui.Slider(BETTERCHAMS_WEAPON_GROUP, "vis.betterchams.hands.alpha", "Alpha", 255, 0, 255)

--- Vars for the material updater.
local mat_local = nil;
local last_mat_local = 0;
local mat_hands = nil;
local last_mat_hands = 0;
local mat_weapon = nil;
local last_mat_weapon = 0;

local function updateMaterials()
    if last_mat_local ~= BETTERCHAMS_LOCAL:GetValue() then
        if BETTERCHAMS_LOCAL:GetValue() == 1 then
            mat_local = materials.Find("models/inventory_items/trophy_majors/crystal_blue")
        elseif BETTERCHAMS_LOCAL:GetValue() == 2 then
            mat_local = materials.Find("models/inventory_items/trophy_majors/gold")
        elseif BETTERCHAMS_LOCAL:GetValue() == 3 then
            mat_local = materials.Find("models/inventory_items/cologne_prediction/cologne_prediction_glass")
        elseif BETTERCHAMS_LOCAL:GetValue() == 4 then
            mat_local = materials.Find("models/gibs/glass/glass")
        elseif BETTERCHAMS_LOCAL:GetValue() == 5 then
            mat_local = materials.Find("models/inventory_items/dogtags/dogtags_outline")
        elseif BETTERCHAMS_LOCAL:GetValue() == 6 then
            mat_local = materials.Find("models/extras/speech_info")
        elseif BETTERCHAMS_LOCAL:GetValue() == 7 then
            mat_local = materials.Find("models/inventory_items/dreamhack_trophies/dreamhack_star_blur")
        end
        last_mat_local = BETTERCHAMS_LOCAL:GetValue()
    end

    if last_mat_hands ~= BETTERCHAMS_HANDS:GetValue() then
        if BETTERCHAMS_HANDS:GetValue() == 1 then
            mat_hands = materials.Find("models/inventory_items/trophy_majors/crystal_blue")
        elseif BETTERCHAMS_HANDS:GetValue() == 2 then
            mat_hands = materials.Find("models/inventory_items/trophy_majors/gold")
        elseif BETTERCHAMS_HANDS:GetValue() == 3 then
            mat_hands = materials.Find("models/inventory_items/cologne_prediction/cologne_prediction_glass")
        elseif BETTERCHAMS_HANDS:GetValue() == 4 then
            mat_hands = materials.Find("models/gibs/glass/glass")
        elseif BETTERCHAMS_HANDS:GetValue() == 5 then
            mat_hands = materials.Find("models/inventory_items/dogtags/dogtags_outline")
        elseif BETTERCHAMS_HANDS:GetValue() == 6 then
            mat_hands = materials.Find("models/extras/speech_info")
        elseif BETTERCHAMS_HANDS:GetValue() == 7 then
            mat_hands = materials.Find("models/inventory_items/dreamhack_trophies/dreamhack_star_blur")
        end
        last_mat_hands = BETTERCHAMS_HANDS:GetValue()
    end

    if last_mat_weapon ~= BETTERCHAMS_WEAPON:GetValue() then
        if BETTERCHAMS_WEAPON:GetValue() == 1 then
            mat_weapon = materials.Find("models/inventory_items/trophy_majors/crystal_blue")
        elseif BETTERCHAMS_WEAPON:GetValue() == 2 then
            mat_weapon = materials.Find("models/inventory_items/trophy_majors/gold")
        elseif BETTERCHAMS_WEAPON:GetValue() == 3 then
            mat_weapon = materials.Find("models/inventory_items/cologne_prediction/cologne_prediction_glass")
        elseif BETTERCHAMS_WEAPON:GetValue() == 4 then
            mat_weapon = materials.Find("models/gibs/glass/glass")
        elseif BETTERCHAMS_WEAPON:GetValue() == 5 then
            mat_weapon = materials.Find("models/inventory_items/dogtags/dogtags_outline")
        elseif BETTERCHAMS_WEAPON:GetValue() == 6 then
            mat_weapon = materials.Find("models/extras/speech_info")
        elseif BETTERCHAMS_WEAPON:GetValue() == 7 then
            mat_weapon = materials.Find("models/inventory_items/dreamhack_trophies/dreamhack_star_blur")
        end
        last_mat_weapon = BETTERCHAMS_WEAPON:GetValue()
    end
end

local function DrawModelHook(Context)

    if Context:GetEntity() ~= nil then

        if entities.GetLocalPlayer() ~= nil and entities.GetLocalPlayer():IsAlive() then
            if Context:GetEntity():GetName() == entities.GetLocalPlayer():GetName() and BETTERCHAMS_LOCAL:GetValue() > 0 then
                if mat_local ~= nil then
                    if entities.GetLocalPlayer():GetPropBool("m_bIsScoped") and BETTERCHAMS_LOCAL_SCOPETRANSPARENCY:GetValue() then
                        mat_local:AlphaModulate(0.4)
                    else
                        mat_local:AlphaModulate(BETTERCHAMS_LOCAL_ALPHA:GetValue() / 255)
                    end
                    Context:ForcedMaterialOverride(mat_local)
                end
            end
        end

        if Context:GetEntity():GetClass() == "CBaseAnimating" and BETTERCHAMS_HANDS:GetValue() > 0 then
            if mat_hands ~= nil then
                mat_hands:AlphaModulate(BETTERCHAMS_HANDS_ALPHA:GetValue() / 255)
                Context:ForcedMaterialOverride(mat_hands)
            end
        end

        if Context:GetEntity():GetClass() == "CPredictedViewModel" and BETTERCHAMS_WEAPON:GetValue() > 0 then
            if mat_weapon ~= nil then
                mat_weapon:AlphaModulate(BETTERCHAMS_WEAPON_ALPHA:GetValue() / 255)
                Context:ForcedMaterialOverride(mat_weapon)
            end
        end
    end
end

callbacks.Register("Draw", updateMaterials)
callbacks.Register("DrawModel", DrawModelHook)

--- Auto updater by ShadyRetard/Shady#0001
local function handleUpdates()

    if (update_available and not update_downloaded) then
        BETTERCHAMS_UPDATER_TEXT:SetText("Update is getting downloaded.")
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false;
        update_downloaded = true;
    end

    if (update_downloaded) then
        BETTERCHAMS_UPDATER_TEXT:SetText("Update available, please reload the script.")
        return;
    end

    if (not version_check_done) then
        version_check_done = true;
        local version = http.Get(VERSION_FILE_ADDR);
        if (version ~= VERSION_NUMBER) then
            update_available = true;
        end
        BETTERCHAMS_UPDATER_TEXT:SetText("Your client is up to date. Current Version: v" .. VERSION_NUMBER)
    end
end

callbacks.Register("Draw", handleUpdates)













--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

