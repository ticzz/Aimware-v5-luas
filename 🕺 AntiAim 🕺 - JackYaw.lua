-- referencias e coisas
ref = gui.Reference("Ragebot");
tab = gui.Tab(ref, "tab", "Extra");
box = gui.Groupbox(tab, "Ragebot", 20,20,200,0);
jackyaw = gui.Checkbox(box,"jackyaw","Jack Yaw", false);
inverter = gui.Keybox(box, "inverter", "Desync Inverter Key", 0);
doubletap = gui.Keybox(box, "doubletap", "Double Tap Key", 0);
damage = gui.Keybox(box, "damage", "Damage Override Key", 0);
mindmg = gui.Slider(box, "mindmg", "Minimum Damage Override", 1,1,100)
mindmg:SetInvisible(1)
autowall = gui.Keybox(box, "autowall", "Auto Wall Key", 0)
forcebaim = gui.Keybox(box, "hitbox", "Force Baim Key", 0)

asnipercache = gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
snipercache = gui.GetValue("rbot.hitscan.accuracy.sniper.mindamage")
hpistolcache = gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
pistolcache = gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
smgcache = gui.GetValue("rbot.hitscan.accuracy.smg.mindamage")
riflecache = gui.GetValue("rbot.hitscan.accuracy.rifle.mindamage")
shotguncache = gui.GetValue("rbot.hitscan.accuracy.shotgun.mindamage")
lmgcache = gui.GetValue("rbot.hitscan.accuracy.lmg.mindamage")
scoutcache = gui.GetValue("rbot.hitscan.accuracy.scout.mindamage")
sharedcache = gui.GetValue("rbot.hitscan.accuracy.shared.mindamage")

asnipercache2 = gui.GetValue("rbot.hitscan.points.asniper.scale")
snipercache2 = gui.GetValue("rbot.hitscan.points.sniper.scale")
hpistolcache2 = gui.GetValue("rbot.hitscan.points.hpistol.scale")
pistolcache2 = gui.GetValue("rbot.hitscan.points.pistol.scale")
smgcache2 = gui.GetValue("rbot.hitscan.points.smg.scale")
riflecache2 = gui.GetValue("rbot.hitscan.points.rifle.scale")
shotguncache2 = gui.GetValue("rbot.hitscan.points.shotgun.scale")
lmgcache2 = gui.GetValue("rbot.hitscan.points.lmg.scale")
scoutcache2 = gui.GetValue("rbot.hitscan.points.scout.scale")
sharedcache2 = gui.GetValue("rbot.hitscan.points.shared.scale")

local toggle = false;
local toggledt = false;
local toggledmg = false;
local toggleaw = false;
local togglebaim = false;
local posX,posY = draw.GetScreenSize();
posX = posX/2;
posY = posY/2;
baimpoints = "0 1 0 1 2 1 0 0 "
fonte = draw.CreateFont("tahoma negrito",18);
if fonte == nil then 
	fonte = draw.CreateFont("tahoma bold",18);
end

-- engine radar do luizin pika
callbacks.Register("Draw", function()
	for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
		Player:SetProp("m_bSpotted", 1);
	end
end)

-- get weapon in hand 
local function weapon()
	if not entities.GetLocalPlayer() then return end
	entity = entities.GetLocalPlayer()
	weaponID = entity:GetWeaponID()
	if weaponID==2 or weaponID==3 or weaponID==4 or weaponID==30 or weaponID==32 or weaponID==36 or weaponID==61 or weaponID==63 then
		return "pistol"
	elseif weaponID==9 then
		return "sniper"
	elseif weaponID==40 then
		return "scout"
	elseif weaponID==1 or weaponID==64 then
		return "hpistol"
	elseif weaponID==17 or weaponID== 19 or weaponID== 23 or weaponID== 24 or weaponID== 26 or weaponID== 33 or weaponID== 34 then
		return "smg"
	elseif weaponID==7 or weaponID==8 or weaponID== 10 or weaponID== 13 or weaponID== 16 or weaponID== 39 or weaponID== 61 then
		return "rifle"
	elseif weaponID== 25 or weaponID== 27 or weaponID== 29 or weaponID== 35 then
		return "shotgun"
	elseif weaponID == 38 or weaponID==11 then
		return "asniper"
	elseif weaponID == 28 or weaponID== 14 then
		return "lmg"
	else
		return nil
	end
end

local function utils()
	if not entities.GetLocalPlayer() then return end
	entity = entities.GetLocalPlayer()
	weaponID = entity:GetWeaponID()
	if weaponID == 49 then
		return "C4"
	elseif weaponID == 57 then
		return "MEDISHOT"
	elseif weaponID == 48 or weaponID == 81 or weaponID == 46 then
		return "INCENDIARY"
	elseif weaponID == 83 or weaponID == 44 then
		return "NADE"
	elseif weaponID == 82 or weaponID == 43 then
		return "FLASH"
	elseif weaponID == 45 then
		return "SMOKE"
	elseif weaponID == 47 then
		return "DECOY"
	elseif weaponID == 72 then
		return "TABLET"
	else
		return "KNIFE"
	end
end


-- jack yaw
callbacks.Register("Draw", function()
	local randomize = 58
	local randomize2 = math.random(170,180)
	if jackyaw:GetValue() then
		randomize = math.random(15,58)
		gui.SetValue("rbot.antiaim.base",randomize2)
	end
	draw.SetFont(fonte)
	draw.Color(255,183,0,255)
	if inverter:GetValue()~=0 then
		if input.IsButtonPressed(inverter:GetValue()) and toggle == false then
			toggle = true;
		elseif input.IsButtonPressed(inverter:GetValue()) and toggle == true then
			toggle = false;
		end
	end
	if toggle == false then
		gui.SetValue("rbot.antiaim.base.rotation", randomize)
		gui.SetValue("rbot.antiaim.base.lby", -116)
		if inverter:GetValue()~=0 and entities.GetLocalPlayer() and entities.GetLocalPlayer():IsAlive() then
			draw.TextShadow(posX-draw.GetTextSize("RIGHT")/2,posY+25, "RIGHT")
		end
	end
	if toggle == true then
		gui.SetValue("rbot.antiaim.base.rotation", -randomize)
		gui.SetValue("rbot.antiaim.base.lby", 116)
		if inverter:GetValue()~=0 and entities.GetLocalPlayer() and entities.GetLocalPlayer():IsAlive() then
			draw.TextShadow(posX-draw.GetTextSize("LEFT")/2,posY+25, "LEFT")
		end
	end
end)

-- dmg override
callbacks.Register("Draw", function()
	if damage:GetValue()==0 then
		mindmg:SetInvisible(1)
		return
	end
	mindmg:SetInvisible(0)
	if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end

	if toggledmg == false then
		gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage", asnipercache)
		gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", snipercache)
		gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", hpistolcache)
		gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage", pistolcache)
		gui.SetValue("rbot.hitscan.accuracy.smg.mindamage", smgcache)
		gui.SetValue("rbot.hitscan.accuracy.rifle.mindamage", riflecache)
		gui.SetValue("rbot.hitscan.accuracy.shotgun.mindamage", shotguncache)
		gui.SetValue("rbot.hitscan.accuracy.lmg.mindamage", lmgcache)
		gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", scoutcache)
		gui.SetValue("rbot.hitscan.accuracy.shared.mindamage", sharedcache)
	else
		gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.smg.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.rifle.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.shotgun.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.lmg.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", mindmg:GetValue())
		gui.SetValue("rbot.hitscan.accuracy.shared.mindamage", mindmg:GetValue())
	end
	if input.IsButtonPressed(damage:GetValue()) and toggledmg == false then
		toggledmg = true;
	elseif input.IsButtonPressed(damage:GetValue()) and toggledmg == true then
		toggledmg = false;
	end
	draw.SetFont(fonte)
	if weapon() == nil then
		draw.Color(255,255,255,100)
		if utils() ~= nil then
			draw.TextShadow(posX-draw.GetTextSize(utils())/2,posY+53, utils())
		end
	else
		draw.Color(255,255,255,255)
		draw.TextShadow(posX-draw.GetTextSize(gui.GetValue("rbot.hitscan.accuracy."..weapon()..".mindamage"))/2,posY+53, gui.GetValue("rbot.hitscan.accuracy."..weapon()..".mindamage"))
	end
end)

-- doubletap toggle
callbacks.Register("Draw", function()
	gui.SetValue("rbot.hitscan.accuracy.pistol.doublefireind",0)
	gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefireind",0)
	gui.SetValue("rbot.hitscan.accuracy.smg.doublefireind",0)
	gui.SetValue("rbot.hitscan.accuracy.lmg.doublefireind",0)
	gui.SetValue("rbot.hitscan.accuracy.asniper.doublefireind",0)
	gui.SetValue("rbot.hitscan.accuracy.sniper.doublefireind",0)
	gui.SetValue("rbot.hitscan.accuracy.scout.doublefireind",0)
	gui.SetValue("rbot.hitscan.accuracy.shared.doublefireind",0)
	gui.SetValue("rbot.hitscan.accuracy.shotgun.doublefireind",0)
	if toggledt == false then
		gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.pistol.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.smg.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.rifle.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.shotgun.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.lmg.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.scout.doublefire", 0)
		gui.SetValue("rbot.hitscan.accuracy.shared.doublefire", 0)
		draw.Color(255,0,0,255)
	else
		gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.pistol.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.smg.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.rifle.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.shotgun.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.lmg.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.scout.doublefire", 2)
		gui.SetValue("rbot.hitscan.accuracy.shared.doublefire", 2)
		draw.Color(0,255,0,255)
	end
	if doubletap:GetValue()==0 then return end
	if input.IsButtonPressed(doubletap:GetValue()) and toggledt == false then
		toggledt = true;
	elseif input.IsButtonPressed(doubletap:GetValue()) and toggledt == true then
		toggledt = false;
	end
	if input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) or gui.GetValue("rbot.antiaim.condition.shiftonshot") or toggledt==false then
		gui.SetValue("rbot.antiaim.advanced.antialign",1)
	else
		gui.SetValue("rbot.antiaim.advanced.antialign",0)
	end
	draw.SetFont(fonte)
	if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end
	draw.TextShadow(posX-draw.GetTextSize("DT")/2,posY+39, "DT")
end)

-- autowall
callbacks.Register("Draw", function()
	if autowall:GetValue()==0 then return end
	if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end
	draw.SetFont(fonte)
	if toggleaw == false then
		gui.SetValue("rbot.hitscan.mode.rifle.autowall", 0)
		gui.SetValue("rbot.hitscan.mode.smg.autowall", 0)
		gui.SetValue("rbot.hitscan.mode.pistol.autowall", 0)
		gui.SetValue("rbot.hitscan.mode.hpistol.autowall", 0)
		gui.SetValue("rbot.hitscan.mode.shared.autowall", 0)
		gui.SetValue("rbot.hitscan.mode.asniper.autowall", 0)
		gui.SetValue("rbot.hitscan.mode.sniper.autowall", 0)
		gui.SetValue("rbot.hitscan.mode.scout.autowall", 0)
		gui.SetValue("rbot.hitscan.mode.shotgun.autowall", 0)
		draw.Color(255,0,0,255)
	end
	if toggleaw == true then
		gui.SetValue("rbot.hitscan.mode.rifle.autowall", 1)
		gui.SetValue("rbot.hitscan.mode.smg.autowall", 1)
		gui.SetValue("rbot.hitscan.mode.pistol.autowall", 1)
		gui.SetValue("rbot.hitscan.mode.hpistol.autowall", 1)
		gui.SetValue("rbot.hitscan.mode.shared.autowall", 1)
		gui.SetValue("rbot.hitscan.mode.asniper.autowall", 1)
		gui.SetValue("rbot.hitscan.mode.sniper.autowall", 1)
		gui.SetValue("rbot.hitscan.mode.scout.autowall", 1)
		gui.SetValue("rbot.hitscan.mode.shotgun.autowall", 1)
		draw.Color(0,255,0,255)
	end
	if input.IsButtonPressed(autowall:GetValue()) and toggleaw == false then
		toggleaw = true;
	elseif input.IsButtonPressed(autowall:GetValue()) and toggleaw == true then
		toggleaw = false;
	end
	draw.TextShadow(posX-draw.GetTextSize("AUTOWALL")/2,posY+67, "AUTOWALL")
end)

-- force baim
callbacks.Register("Draw", function()
	if forcebaim:GetValue()==0 then return end
	if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end
	draw.SetFont(fonte)
	if togglebaim == false then
		gui.SetValue("rbot.hitscan.points.asniper.scale",asnipercache2)
		gui.SetValue("rbot.hitscan.points.sniper.scale",snipercache2)
		gui.SetValue("rbot.hitscan.points.hpistol.scale",hpistolcache2)
		gui.SetValue("rbot.hitscan.points.pistol.scale",pistolcache2)
		gui.SetValue("rbot.hitscan.points.smg.scale",smgcache2)
		gui.SetValue("rbot.hitscan.points.rifle.scale",riflecache2)
		gui.SetValue("rbot.hitscan.points.shotgun.scale",shotguncache2)
		gui.SetValue("rbot.hitscan.points.lmg.scale",lmgcache2)
		gui.SetValue("rbot.hitscan.points.scout.scale",scoutcache2)
		gui.SetValue("rbot.hitscan.points.shared.scale",sharedcache2)
		draw.Color(255,0,0,255)
	end
	if togglebaim == true then
		gui.SetValue("rbot.hitscan.points.asniper.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.sniper.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.hpistol.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.pistol.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.smg.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.rifle.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.shotgun.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.lmg.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.scout.scale",baimpoints)
		gui.SetValue("rbot.hitscan.points.shared.scale",baimpoints)
		draw.Color(0,255,0,255)
	end
	if input.IsButtonPressed(forcebaim:GetValue()) and togglebaim == false then
		togglebaim = true;
	elseif input.IsButtonPressed(forcebaim:GetValue()) and togglebaim == true then
		togglebaim = false;
	end
	draw.TextShadow(posX-draw.GetTextSize("BAIM")/2,posY+81, "BAIM")
end)


-- set legit aa
setLegitAA = gui.Button(box, "Legit AA", function()
	gui.SetValue("rbot.antiaim.advanced.autodir", "0 0")
	gui.SetValue("rbot.antiaim.base", "0.0 Desync")
	gui.SetValue("rbot.antiaim.advanced.pitch", 0)
	gui.SetValue("rbot.antiaim.advanced.antialign", "Lowerbody")
	gui.SetValue("rbot.antiaim.advanced.antiresolver", 0)
	gui.SetValue("rbot.antiaim.left", "0.0 Desync")
	gui.SetValue("rbot.antiaim.right", "0.0 Desync")
	gui.SetValue("rbot.antiaim.left.rotation", "58")
	gui.SetValue("rbot.antiaim.right.rotation", "-58")
	gui.SetValue("rbot.antiaim.left.lby", "-116")
	gui.SetValue("rbot.antiaim.right.lby", "116")
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

