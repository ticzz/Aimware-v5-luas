-- An example lua implementation of message API
-- Please use this for any and everything you want

-- Basic Gui 
local ref = gui.Reference("Misc", "General", "Logs");
-- Multi box for events
local logMultiBox = gui.Multibox(ref, "Log Events");
local logConsole = gui.Checkbox(logMultiBox, "log.console.enable", "Console", true);
-- Logging options
local logDamage = gui.Checkbox(logMultiBox, "log.damage.enable", "Damage", true);
local colorDamage = gui.ColorPicker(logDamage, "log.damage.color", "", 0, 255, 0, 255);
local logHurt = gui.Checkbox(logMultiBox, "log.hurt.enable", "Hurt", true);
local colorHurt = gui.ColorPicker(logHurt, "log.hurt.color", "", 255, 0, 0, 255);
local logPurchase = gui.Checkbox(logMultiBox, "log.Purchase.enable", "Purchase", true);
local colorPurchase = gui.ColorPicker(logPurchase, "log.Purchase.color", "", 255, 255, 255, 255);
-- Stuff
local localPlayer = entities.GetLocalPlayer();
local hitGroups = {"Generic", "Head", "Chest", "Stomach", "Left arm", "Right arm", "Left leg", "Right leg", "Neck"};
local weaponNames = {["weapon_glock"] = "Glock-18", ["weapon_elite"] = "Dual Berettas", ["weapon_p250"] = "P250", ["weapon_tec9"] = "Tec-9", ["weapon_cz75a"] = "CZ75-Auto", ["weapon_deagle"] = "Desert Eagle", ["weapon_revolver"] = "R8 Revolver", ["weapon_usp_silencer"] = "USP-S", ["weapon_hkp2000"] = "P2000", ["weapon_fiveseven"] = "Five-Seven",
                     ["weapon_nova"] = "Nova", ["weapon_xm1014"] = "XM1014", ["weapon_sawedoff"] = "Sawed-Off", [" weapon_m249"] = "M249", ["weapon_negev"] = "Negev", ["weapon_mag7"] = "Mag-7",
                     ["weapon_ssg08"] = "Scout", ["weapon_awp"] = "AWP", ["weapon_galilar"] = "Galil AR", ["weapon_ak47"] = "AK47", ["weapon_sg556"] = "SG 553", ["weapon_g3sg1"] = "G3SG1", ["weapon_famas"] = "FAMAS", ["weapon_m4a1"] = "M4A4", ["weapon_m4a1_silencer"] = "M4A1-S", ["weapon_aug"] = "AUG", ["weapon_scar20"] = "SCAR-20",
                     ["weapon_molotov"] = "Molotov", ["weapon_incgrenade"] = "Incendiary Grenade", ["weapon_decoy"] = "Decoy Grenade", ["weapon_flashbang"] = "Flashbang", ["weapon_hegrenade"] = "High Explosive Grenade", ["weapon_smokegrenade"] = "Smoke Grenade", ["weapon_taser"]  = "Zeus x27", ["item_kevlar"] = "kevlar Armor", ["item_assaultsuit"] = "Kevlar Armor and Helmet"};

-- Example of logging events
local function hFireGameEvent(event)
    localPlayer = entities.GetLocalPlayer();
    local eventName = event:GetName();

    if eventName == "player_hurt" then
        local attacker = entities.GetByUserID(event:GetInt("attacker"));
        local victim = entities.GetByUserID(event:GetInt("userid"));

        local eventDamage = event:GetInt("dmg_health");
        local eventHealth = event:GetInt("health");
        local eventHitGroup = event:GetInt("hitgroup") + 1;

        -- Hurt logs
        if victim:GetIndex() == localPlayer:GetIndex() and logHurt:GetValue() then
            local r, g, b, a = colorHurt:GetValue();
            local clr = {r = r, b = b, g = g, a = a};

            local msg = string.format("-%s in %s from %s", eventDamage, hitGroups[eventHitGroup], attacker:GetName());
            AddToNotify(clr, msg, logConsole:GetValue());
        -- Damage logs
        elseif attacker and attacker:GetIndex() == localPlayer:GetIndex() and attacker:GetIndex() ~= victim:GetIndex() then
            local r, g, b, a = colorDamage:GetValue();
            local clr = {r = r, b = b, g = g, a = a};

            local msg = string.format("-%s in %s to %s", eventDamage, hitGroups[eventHitGroup], victim:GetName());

            -- Add to mnessages list using API
            AddToNotify(clr, msg, logConsole:GetValue());
        end
        
    elseif eventName == "item_purchase" then
        local player = entities.GetByUserID(event:GetInt("userid"));
        local weapon = weaponNames[event:GetString("weapon")];

        if player:GetTeamNumber() ~= localPlayer:GetTeamNumber() and logPurchase:GetValue() then
            local r, g, b, a = colorPurchase:GetValue();
            local clr = {r = r, b = b, g = g, a = a};

            local msg = string.format("%s bought %s", player:GetName(), weapon);

            -- Add to mnessages list using API
            AddToNotify(clr, msg, logConsole:GetValue());
        end
    end
end
-- Listeners for event logs add your own if you want
client.AllowListener("player_hurt");
client.AllowListener("item_purchase");

callbacks.Register("FireGameEvent", "hFireGameEvent", hFireGameEvent);

callbacks.Register("Draw", function()
    -- Update notifications before drawing them using API
    UpdateNotify();
    DrawNotify();
end);

local notifyText = {};
local notifyTime = 8;

local fontName = "Comic Sans MS";
local fontSize = 18;
local fontweight = 900;

local xOffset = 15;
local yOffset = 10;

local function clamp(var, lo, hi)
    if var > hi then
        return hi;
    elseif var < lo then
        return lo;
    end

    return var;
end

local function DrawTextShadow(x, y, string, r, g, b, a)
    draw.Color(0, 0, 0, a);
    draw.Text(x+1, y+1, string); 
    draw.Color(r, g, b, a);
    draw.Text(x, y, string);
end

-- I dont really need a function for this tbh but its here
function AddToNotify(clr, msg, console)
    table.insert(notifyText, {clr = clr, text = msg, liferemaining = notifyTime});

    if console == true then
        client.Command("echo \""..msg.."\"", true);
    end
end

-- updates lifetime for the notifications
function UpdateNotify()
	for i = #notifyText, 1, -1 do
		
		local notify = notifyText[i];

		notify.liferemaining = notify.liferemaining - globals.FrameTime();

		if notify.liferemaining <= 0.0 then
			table.remove(notifyText, i);
        end
			
	end
end

-- Drawing animation magic ripped straight from leaked source code :)
function DrawNotify()
    local drawFont = draw.CreateFont(fontName, fontSize, fontWeight);
    draw.SetFont(drawFont);

    -- Log base offsets
    local x = xOffset;
	local y = yOffset;
    
    -- Get font height
    local fontTall = fontSize;
    for i = 1, #notifyText do
        local notify = notifyText[i];

		local timeleft = notify.liferemaining;
        
		clr = notify.clr;

        -- only fade when about to expire
		if timeleft < 0.5 then
			local alphaFactor = clamp(timeleft, 0.0, 0.5) / 0.5;

			clr.a = alphaFactor * 255;

            -- Only move towards end of fade
			if i == 1 and alphaFactor < 0.2 then
				y = y - fontTall * (1.0 - alphaFactor / 0.2);
            end
		else
			clr.a = 255;
        end

        DrawTextShadow( x, y, notify.text, clr.r, clr.g, clr.b, clr.a)
        
		y = y + fontTall;
	end
end












--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

