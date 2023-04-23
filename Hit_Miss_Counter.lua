local hit_window = gui.Window("window.counter", "Hit Counter", 10, 500, 100, 130)
 -- x, y, h, w

local shots1 = gui.Text(hit_window, "")
local hits1 = gui.Text(hit_window, "")
local misses1 = gui.Text(hit_window, "")

local shots = 0;
local hits = 0;
local misses = 0;

local function Events( Event, Entity )
local lp = entities.GetLocalPlayer()

if lp == nil or  not lp:IsAlive() then return end

	local weapon = lp:GetPropEntity("m_hActiveWeapon");
    local name = weapon:GetName();
	
	if (name ~= "knife" and name ~= "knife t" and name ~= "bayonet" and name ~= "knife flip"
        and name ~= "knife gut" and name ~= "knife karambit" and name ~= "knife m9 bayonet"
        and name ~= "knife tactical" and name ~= "knife falchion" and name ~= "knife survival bowie"
        and name ~= "knife butterfly" and name ~= "knife push" and name ~= "knife ursus"
        and name ~= "knife gypsy jackknife" and name ~= "knife stiletto" and name ~= "knife widowmaker"
		and name ~= "flashbang" and name ~= "hegrenade" and name ~= "smokegrenade" 
and name ~= "decoy" 
		and name ~= "molotov" and name ~= "incgrenade") then -- for eample = check following events only, if your guns name is different to the ones in the list
        
		if ( Event:GetName() == "player_hurt" ) then
            local ME = client.GetLocalPlayerIndex();

            local INT_UID = Event:GetInt( "userid" );
            local INT_ATTACKER = Event:GetInt( "attacker" );

            local INDEX_ATTACKER = client.GetPlayerIndexByUserID( INT_ATTACKER );
            local INDEX_VICTIM = client.GetPlayerIndexByUserID( INT_UID );
            
            if ( INDEX_ATTACKER == ME and INDEX_Victim ~= ME) then           
                hits = hits + 1;
            end
        end
    end
        if ( Event:GetName() == "weapon_fire" ) then
            local ME = client.GetLocalPlayerIndex();
            
            local INT_UID = Event:GetInt("userid");

            local INDEX_VICTIM = client.GetPlayerIndexByUserID( INT_UID );
            
            if ( INDEX_VICTIM == ME ) then           
                shots = shots + 1;
            end
        end
    
    if ( Event:GetName() == "round_start" ) then
        shots = 0;
        hits = 0;
        missed = 0;
    end
end

local function DrawMissedShots()
 


if entities.GetLocalPlayer() ~= nil then
        if shots == 999 or hits == 999 or misses == 999 then
            shots = 0;
            hits = 0;
            missed = 0;
        end
        
        local weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon");
        local name = weapon:GetName();
        
			if (name ~= "knife" and name ~= "knife t" and name ~= "bayonet" and name ~= "knife flip"
            and name ~= "knife gut" and name ~= "knife karambit" and name ~= "knife m9 bayonet"
            and name ~= "knife tactical" and name ~= "knife falchion" and name ~= "knife survival bowie"
            and name ~= "knife butterfly" and name ~= "knife push" and name ~= "knife ursus"
            and name ~= "knife gypsy jackknife" and name ~= "knife stiletto" and name ~= "knife widowmaker"
			and name ~= "flashbang" and name ~= "hegrenade" and name ~= "smokegrenade" 
and name ~= "decoy"
			and name ~= "molotov" and name ~= "incgrenade") then
            misses = shots - hits;
        else
            misses = misses;
        end
        
        shots1:SetText("Fired = " .. shots)
		hits1:SetText("Hits = " .. hits)
        misses1:SetText("Missed = " .. misses)
    
    end
end

client.AllowListener( "player_hurt" );
client.AllowListener( "weapon_fire" );
client.AllowListener( "round_start" );
callbacks.Register( "Draw", "DrawMissedShots", DrawMissedShots );
callbacks.Register( "FireGameEvent", "Events", Events );







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

