-- Gui Setup
local teamNames = gui.Checkbox(gui.Reference("Visuals", "Overlay", "Friendly"), "team_hide_name", "Override Names", false);
teamNames:SetDescription("Diable Default name Esp for Team");

local enemynames = gui.Checkbox(gui.Reference("Visuals", "Overlay", "Enemy"), "enemy_hide_name", "Override Names", false);
enemynames:SetDescription("Diable Default name Esp for Enemys");

-- Name Esp
local colors = {"Yellow", "Purple", "Green", "Blue", "Orange"};

local function esp(builder)
    local localPlayer = entities.GetLocalPlayer();
    local ent = builder:GetEntity();
    
    if client.GetConVar("cl_sanitize_player_names") == "1" and ent:IsPlayer() then
        local resources = entities.GetPlayerResources();
        local index = ent:GetIndex();
        local color = resources:GetPropInt("m_iCompTeammateColor", index);
        
        if color >= 0 then
            if ent:GetTeamNumber() == localPlayer:GetTeamNumber() and teamNames:GetValue() then
                builder:AddTextTop(colors[color+1]);
            elseif ent:GetTeamNumber() ~= localPlayer:GetTeamNumber() and enemynames:GetValue() then
                builder:AddTextTop("Enemy "..colors[color+1]);
            end
        else
            if ent:GetTeamNumber() == localPlayer:GetTeamNumber() and teamNames:GetValue() then
                builder:AddTextTop("Bot");
            elseif ent:GetTeamNumber() ~= localPlayer:GetTeamNumber() and enemynames:GetValue() then
                builder:AddTextTop("Enemy Bot");
            end
        end
        
    elseif ent:IsPlayer() then
    
        if ent:GetTeamNumber() == localPlayer:GetTeamNumber() and teamNames:GetValue() then
            builder:AddTextTop(ent:GetName());
        elseif ent:GetTeamNumber() ~= localPlayer:GetTeamNumber() and enemynames:GetValue() then
            builder:AddTextTop(ent:GetName());
        end
        
    end
   
end

local function guiStuff()
    if teamNames:GetValue() then
        gui.SetValue("esp.overlay.friendly.name", false);
    end
    
    if enemynames:GetValue() then
        gui.SetValue("esp.overlay.enemy.name", false);
    end
end

callbacks.Register("DrawESP", "esp", esp);
callbacks.Register("Draw", guiStuff);