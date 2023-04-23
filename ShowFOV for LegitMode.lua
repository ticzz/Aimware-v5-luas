local lp = entities.GetLocalPlayer()

-- Simple script for your legit CFG
-- Yes i'm know about tables
-- by Ozaron#5101

local ScrW, ScrH = draw.GetScreenSize()
local function isSMG()
		if not lp then return end
		if not lp:IsAlive() then return end
		local weapon = lp:GetPropEntity("m_hActiveWeapon");
		local name = weapon:GetName();
		if (string.find(name, "mac10") or string.find(name, "mp9") or string.find(name, "mp7") or string.find(name, "ump45") or string.find(name, "bizon") or string.find(name,  "p90")) then return true else return false end
end
callbacks.Register("Draw", "FovAimbot", function()
		if not lp then return end
		if not lp:IsAlive() then return end
		local weapon = lp:GetPropEntity("m_hActiveWeapon");
		local name = weapon:GetName();
		draw.Color(255, 255, 255, 255)
		if (string.find(name, "revolver") or string.find(name, "deagle")) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.hpistol.maxfov") * 17  )

		elseif (string.find(name, "glock") or string.find(name, "cz75a") or string.find(name, "p250") or string.find(name, "fiveseven") or string.find(name, "elite") or string.find(name, "tec9") or string.find(name, "hkp2000") or string.find(name, "usp_silencer")) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.pistol.maxfov") * 17  )
		elseif isSMG() then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.smg.maxfov") * 17  )
		elseif (string.find(name, "galilar") or string.find(name, "famas") or string.find(name, "ak47") or string.find(name, "m4a1") or string.find(name, "m4a1_silencer") or string.find(name, "sg556") or string.find(name, "aug")) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.rifle.maxfov") * 17  )
		elseif (string.find(name, "ssg08")) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("llbot.weapon.target.scout.maxfov") * 17  )
		elseif (string.find(name, "awp") ) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.sniper.maxfov") * 17  )
		elseif (string.find(name, "g3gs1") or string.find(name, "scar20")) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.asniper.maxfov") * 17  )
		elseif (string.find(name, "nova") or string.find(name, "xm1014") or string.find(name, "sawedoff") or string.find(name, "mag7")) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.shotgun.maxfov") * 17  )
		elseif (string.find(name, "m249") or string.find(name, "negev")) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.lmg.maxfov") * 17  )
		elseif (string.find(name, "zeus")) then
			draw.OutlinedCircle( ScrW/2, ScrH/2, gui.GetValue("lbot.weapon.target.zeus.maxfov") * 17  )
		end															
end)














--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

