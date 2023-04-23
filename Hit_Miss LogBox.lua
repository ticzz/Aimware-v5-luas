local mouseX, mouseY, PosX, PosY, dx, dy, w, h = 0, 0, 25, 25, 0, 0, 300, 15;
local FontDefault = draw.CreateFont("Calibri", 14)
local menu = gui.Reference('Menu')

local function dragFeature()
if input.IsButtonDown(1) then
mouseX, mouseY = input.GetMousePos();
if shouldDrag then
PosX = mouseX - dx;
PosY = mouseY - dy;
end
if mouseX >= PosX and mouseX <= PosX + w and mouseY >= PosY and mouseY <= PosY + 40 then
shouldDrag = true;
dx = mouseX - PosX;
dy = mouseY - PosY;
end
else
shouldDrag = false;
end
end

client.AllowListener("player_hurt")
client.AllowListener("player_death")
client.AllowListener("weapon_fire")

local iFired = 0
local iHits = 0
local iAccuracy = 0
local iAccuracy_old = 0
local iTarget = nil

local ID = 0;
local MAX = 1;
local ListID = {};
local ListPlayer = {};
local ListDamage = {};
local ListHitbox = {};
local ListStatus = {};
local Hitboxes = {
    'Head',
    'Chest',
    'Stomach',
    'Left arm',
    'Right arm',
    'Left leg',
    'Right leg',
    'Body'
};

function DrawMenu()
if entities.GetLocalPlayer() or menu:IsActive() then

local ColorR = math.floor(math.sin(globals.RealTime() * 1) * 127 + 128)
local ColorG = math.floor(math.sin(globals.RealTime() * 1 + 2) * 127 + 128)
local ColorB = math.floor(math.sin(globals.RealTime() * 1 + 4) * 127 + 128)

draw.Color(ColorR, ColorG, ColorB, 255);
draw.FilledRect(PosX,PosY-1,PosX+300,PosY)
draw.Color(0,0,0,255)
draw.FilledRect(PosX,PosY,PosX+300,PosY+15)
draw.Color(0,0,0,55)
draw.FilledRect(PosX,PosY+15,PosX+300,PosY+5+(MAX*13))
draw.SetFont(FontDefault)
draw.Color(255,255,255,255)
draw.Text(PosX+3,PosY+3,"ID")
draw.Text(PosX+25,PosY+3,"PLAYER")
draw.Text(PosX+135,PosY+3,"DAMAGE")
draw.Text(PosX+185,PosY+3,"HITBOX")
draw.Text(PosX+255,PosY+3,"STATUS")
for index in pairs(ListID) do
    draw.Text(PosX+3,PosY + 5 + (index * 13), ListID[index])
    draw.Text(PosX+25,PosY + 5 + (index * 13), ListPlayer[index])
	draw.Text(PosX+135,PosY + 5 + (index * 13), ListDamage[index])
    draw.Text(PosX+185,PosY + 5 + (index * 13), ListHitbox[index])
	draw.Text(PosX+255,PosY + 5 + (index * 13), ListStatus[index])
end
end
dragFeature();
end

function ClearInLists()
MAX = MAX - 1
table.remove(ListID,1)
table.remove(ListPlayer,1)
table.remove(ListDamage,1)
table.remove(ListHitbox,1)
table.remove(ListStatus,1)
end

function IsValid(entity)
  return pcall(function() tostring(entity:GetAbsOrigin()) end)
end

callbacks.Register("FireGameEvent", function(e)
	if e then
        if e:GetName() == "round_start" then
            ID = 0
			MAX = 0
            ListID = {}
			ListPlayer = {}
			ListDamage = {}
			ListHitbox = {}
			ListStatus = {}
        end     
		if e:GetName() == "player_hurt" then
			local lp_index = entities.GetLocalPlayer():GetIndex()
			local lp_teamnum = entities.GetLocalPlayer():GetTeamNumber()
			local victim = entities.GetByUserID(e:GetInt("userid"));
			local attacker = entities.GetByUserID(e:GetInt("attacker"));
			local hitbox = e:GetInt("hitgroup")
			if attacker:GetIndex() == lp_index then			
				if (MAX == 11 or MAX > 11) then 
				ClearInLists()
				end
				MAX = MAX + 1
				ID = ID + 1
				local msg_id = ID
				local msg_player = victim:GetName()
				local msg_damage_hit = e:GetInt("dmg_health")
				local msg_damage_left = victim:GetHealth() - e:GetInt("dmg_health")
				if msg_damage_left < 0 then msg_damage_left = 0 end
				local msg_damage = msg_damage_hit .. " (" .. msg_damage_left .. ")"
				local msg_hitbox = (Hitboxes[hitbox] or "generic")
				local msg_status = "Hit"
				table.insert(ListID,msg_id)
				table.insert(ListPlayer,msg_player)
				table.insert(ListDamage,msg_damage)
				table.insert(ListHitbox,msg_hitbox)
				table.insert(ListStatus,msg_status)
				iHits = iHits + 1
				iAccuracy = iFired - iHits
			end
		elseif e:GetName() == "weapon_fire" then
			local shooter = entities.GetByUserID(e:GetInt("userid"));
			if shooter:GetIndex() == entities.GetLocalPlayer():GetIndex() then
				iFired = iFired + 1
				iAccuracy = iFired - iHits
			end
		end
	end
end)
callbacks.Register("Draw", function()
if iAccuracy ~= iAccuracy_old and iAccuracy ~= 0 then
	if iAccuracy > iAccuracy_old then
		if iTarget == nil then return end
		    if (MAX == 11 or MAX > 11) then
			ClearInLists()
			end
			MAX = MAX + 1
		    ID = ID + 1
			local msg_id = ID
			local msg_player = iTarget:GetName()
			local msg_damage = "0 (" .. iTarget:GetHealth() .. ")"
			local msg_hitbox = "-"
			local msg_status = "Miss"
			table.insert(ListID,msg_id)
			table.insert(ListPlayer,msg_player)
			table.insert(ListDamage,msg_damage)
			table.insert(ListHitbox,msg_hitbox)
			table.insert(ListStatus,msg_status)
	end
	iAccuracy_old = iAccuracy
end
end)
callbacks.Register("AimbotTarget", function(trgt) if IsValid(trgt) then iTarget = trgt else iTarget = nil end end)
callbacks.Register("Draw",DrawMenu);








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

