------------weapon_hegrenade  weapon_incgrenade  weapon_molotov
local function jump_scout_fix()
	local lp = entities.GetLocalPlayer()
	if lp and lp:IsAlive() then
		local vel = math.sqrt(lp:GetPropFloat("localdata", "m_vecVelocity[0]") ^ 2 + lp:GetPropFloat("localdata", "m_vecVelocity[1]") ^ 2)
		if lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_ssg08" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_awp" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_glock" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_hkp2000" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_usp_silencer" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_elite" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_p250" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_fiveseven" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_tec9" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_cz75a" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_deagle" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_revolver" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_nova" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_xm1014" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_mag7" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_sawedoff" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_m249" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_negev" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_mp9" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_mac10" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_mp7" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_mp5sd" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_ump45" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_p90" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_bizon" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_galilar" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_famas" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_ak47" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_m4a1" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_m4a1_silencer" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_sg556" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_aug" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_g3sg1" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_scar20" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_decoy" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_flashbang" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_smokegrenade" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_molotov" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_hegrenade" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_healthshot" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_c4" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_t" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_outdoor" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_skeleton" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_canis" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_cord" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_css" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_bayonet" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_flip" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_gut" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_karambit" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_m9_bayonet" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_tactical" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_butterfly" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_falchion" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_push" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_survival_bowie" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_ursus" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_gypsy_jackknife" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_stiletto" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_widowmaker" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knifegg" 
		or lp:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_knife_ghost" then
			if vel > 25 then
				gui.SetValue("misc.strafe.enable", true)
			else
				gui.SetValue("misc.strafe.enable", false)
			end
		else
			gui.SetValue("misc.strafe.enable", true)
		end
	else
		gui.SetValue("misc.strafe.enable", true)
	end
end
callbacks.Register("Draw", jump_scout_fix)


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")
