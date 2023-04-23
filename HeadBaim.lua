	local rage_ref =  gui.Reference("RAGE", "MAIN","AIMBOT")

	local BaimKey = gui.Keybox( rage_ref, "BaimKey", "BaimKey", 6 )
	local HeadKey = gui.Keybox( rage_ref, "HeadKey", "HeadKey", 5 )
	
   -- FBH lua
    local autosniper_head, autosniper_neck, autosniper_chest, autosniper_stomach, autosniper_pelvis, autosniper_hitbox, autosniper_ifwalk, autosniper_priority -- AutoSniper
    local Sniper_head, Sniper_neck, Sniper_chest, Sniper_stomach, Sniper_pelvis, Sniper_hitbox, Sniper_ifwalk, Sniper_priority -- Sniper
    local scout_head, scout_neck, scout_chest, scout_stomach, scout_pelvis, scout_hitbox, scout_ifwalk, scout_priority -- Scout
    local pistol_head, pistol_neck, pistol_chest, pistol_stomach, pistol_pelvis, pistol_hitbox, pistol_ifwalk, pistol_priority -- Pistol
    local revolver_head, revolver_neck, revolver_chest, revolver_stomach, revolver_pelvis, revolver_hitbox, revolver_ifwalk, revolver_priority	-- Revolver
    local BaimIfshots, BaimIfHp, HeadAim, autosniper_priority, FakeLatencyEn, FakeLatencyAmount, posadj  -- Other
	
	
	local RenderFontHB = draw.CreateFont("Tahoma", 25, 1300)
		
	local OnlyBaim = false
	local OnlyHead = false
	
	
	function SetHeadValues()
    gui.SetValue('rbot_autosniper_hitbox_head', 1)
    gui.SetValue('rbot_autosniper_hitbox_neck', 0)
    gui.SetValue('rbot_autosniper_hitbox_chest', 0)
    gui.SetValue('rbot_autosniper_hitbox_stomach', 0)
    gui.SetValue('rbot_autosniper_hitbox_pelvis', 0)
    gui.SetValue('rbot_autosniper_hitbox', 0)
    gui.SetValue('rbot_autosniper_hitbox_legs', 0)
	gui.SetValue('rbot_autosniper_headifwalking', 1)
	
    -- Scout
    gui.SetValue('rbot_scout_hitbox_head', 1)
    gui.SetValue('rbot_scout_hitbox_neck', 0)
    gui.SetValue('rbot_scout_hitbox_chest', 0)
    gui.SetValue('rbot_scout_hitbox_stomach', 0)
    gui.SetValue('rbot_scout_hitbox_pelvis', 0)
    gui.SetValue('rbot_scout_hitbox', 0)
    gui.SetValue('rbot_scout_hitbox_legs', 0)
	gui.SetValue('rbot_scout_headifwalking', 1)
    
    -- Sniper
    gui.SetValue('rbot_Sniper_hitbox_head', 1)
    gui.SetValue('rbot_Sniper_hitbox_neck', 0)
    gui.SetValue('rbot_Sniper_hitbox_chest', 0)
    gui.SetValue('rbot_Sniper_hitbox_stomach', 0)
    gui.SetValue('rbot_Sniper_hitbox_pelvis', 0)
    gui.SetValue('rbot_Sniper_hitbox', 0)
    gui.SetValue('rbot_sniper_hitbox_legs', 0)
	gui.SetValue('rbot_sniper_headifwalking', 1)
                    
    -- Pistols
    gui.SetValue('rbot_pistol_hitbox_head', 1)
    gui.SetValue('rbot_pistol_hitbox_neck', 0)
    gui.SetValue('rbot_pistol_hitbox_chest', 0)
    gui.SetValue('rbot_pistol_hitbox_stomach', 0)
    gui.SetValue('rbot_pistol_hitbox_pelvis', 0)
    gui.SetValue('rbot_pistol_hitbox', 0)
	gui.SetValue('rbot_pistol_headifwalking', 1)
    
    -- Revolver
    gui.SetValue('rbot_revolver_hitbox_head', 1)
    gui.SetValue('rbot_revolver_hitbox_neck', 0)
    gui.SetValue('rbot_revolver_hitbox_chest', 0)
    gui.SetValue('rbot_revolver_hitbox_stomach', 0)
    gui.SetValue('rbot_revolver_hitbox_pelvis', 0)
    gui.SetValue('rbot_revolver_hitbox', 0)
	gui.SetValue('rbot_revolver_headifwalking', 1)
                    
    -- Other
    gui.SetValue('rbot_autosniper_bodyaftershots', 0)
    gui.SetValue('rbot_autosniper_bodyifhplower', 0)
                    
    gui.SetValue('rbot_scout_bodyaftershots', 0)
    gui.SetValue('rbot_scout_bodyifhplower', 0)
    
    gui.SetValue('rbot_Sniper_bodyaftershots', 0)
    gui.SetValue('rbot_Sniper_bodyifhplower', 0)
                    
    gui.SetValue('rbot_revolver_bodyaftershots', 0)
    gui.SetValue('rbot_revolver_bodyifhplower', 0)
                    
    gui.SetValue('rbot_pistol_bodyaftershots', 0)
    gui.SetValue('rbot_pistol_bodyifhplower', 0)
                    
                    
    gui.SetValue("rbot_positionadjustment", 4)		
    end    

    function SetBaimValues()
	gui.SetValue('rbot_autosniper_hitbox_head', 0)
    gui.SetValue('rbot_autosniper_hitbox_neck', 0)
	gui.SetValue('rbot_autosniper_hitbox_chest', 1)
	gui.SetValue('rbot_autosniper_hitbox_stomach', 1)
	gui.SetValue('rbot_autosniper_hitbox_pelvis', 1)
	gui.SetValue('rbot_autosniper_hitbox', 4)
    gui.SetValue('rbot_autosniper_hitbox_legs', 0)
	gui.SetValue('rbot_autosniper_headifwalking', 0)

    -- Scout
    gui.SetValue('rbot_scout_hitbox_head', 0)
    gui.SetValue('rbot_scout_hitbox_neck', 0)
    gui.SetValue('rbot_scout_hitbox_chest', 1)
    gui.SetValue('rbot_scout_hitbox_stomach', 1)
    gui.SetValue('rbot_scout_hitbox_pelvis', 1)
    gui.SetValue('rbot_scout_hitbox', 4)
    gui.SetValue('rbot_scout_hitbox_legs', 0)
	gui.SetValue('rbot_scout_headifwalking', 0)

    -- Sniper
    gui.SetValue('rbot_Sniper_hitbox_head', 0)
    gui.SetValue('rbot_Sniper_hitbox_neck', 0)
    gui.SetValue('rbot_Sniper_hitbox_chest', 1)
    gui.SetValue('rbot_Sniper_hitbox_stomach', 1)
    gui.SetValue('rbot_Sniper_hitbox_pelvis', 1)
    gui.SetValue('rbot_Sniper_hitbox', 4)
    gui.SetValue('rbot_sniper_hitbox_legs', 0)
	gui.SetValue('rbot_sniper_headifwalking', 0)

    -- Pistols
    gui.SetValue('rbot_pistol_hitbox_head', 0)
    gui.SetValue('rbot_pistol_hitbox_neck', 0)
    gui.SetValue('rbot_pistol_hitbox_chest', 1)
    gui.SetValue('rbot_pistol_hitbox_stomach', 1)
    gui.SetValue('rbot_pistol_hitbox_pelvis', 1)
    gui.SetValue('rbot_pistol_hitbox', 4)
	gui.SetValue('rbot_pistol_headifwalking', 0)

    -- Revolver
    gui.SetValue('rbot_revolver_hitbox_head', 0)
    gui.SetValue('rbot_revolver_hitbox_neck', 0)
    gui.SetValue('rbot_revolver_hitbox_chest', 1)
    gui.SetValue('rbot_revolver_hitbox_stomach', 1)
    gui.SetValue('rbot_revolver_hitbox_pelvis', 1)
    gui.SetValue('rbot_revolver_hitbox', 4)
	gui.SetValue('rbot_revolver_headifwalking', 0)
	
    -- Other
   -- gui.SetValue('rbot_autosniper_bodyaftershots', 0)
   -- gui.SetValue('rbot_autosniper_bodyifhplower', 100)
   --
   -- gui.SetValue('rbot_scout_bodyaftershots', 0)
   -- gui.SetValue('rbot_scout_bodyifhplower', 100)
   --
   -- gui.SetValue('rbot_Sniper_bodyaftershots', 0)
   -- gui.SetValue('rbot_Sniper_bodyifhplower', 100)
   --
   -- gui.SetValue('rbot_revolver_bodyaftershots', 0)
   -- gui.SetValue('rbot_revolver_bodyifhplower', 100)
   --
   -- gui.SetValue('rbot_pistol_bodyaftershots', 0)
   -- gui.SetValue('rbot_pistol_bodyifhplower', 100)
	end


    function GetValues()
    autosniper_head  =  gui.GetValue('rbot_autosniper_hitbox_head')
    autosniper_head  =  gui.GetValue('rbot_autosniper_hitbox_head')
    autosniper_neck  =  gui.GetValue('rbot_autosniper_hitbox_neck')
    autosniper_chest =  gui.GetValue('rbot_autosniper_hitbox_chest')
    autosniper_stomach = gui.GetValue('rbot_autosniper_hitbox_stomach')
    autosniper_pelvis = gui.GetValue('rbot_autosniper_hitbox_pelvis')
    autosniper_legs = gui.GetValue('rbot_autosniper_hitbox_legs')
    autosniper_hitbox = gui.GetValue('rbot_autosniper_hitbox')
	autosniper_ifwalk = gui.GetValue('rbot_autosniper_headifwalking')

    -- Sniper
    Sniper_head  =  gui.GetValue('rbot_Sniper_hitbox_head')
    Sniper_neck  =  gui.GetValue('rbot_Sniper_hitbox_neck')
    Sniper_chest =  gui.GetValue('rbot_Sniper_hitbox_chest')
    Sniper_stomach = gui.GetValue('rbot_Sniper_hitbox_stomach')
    Sniper_pelvis = gui.GetValue('rbot_Sniper_hitbox_pelvis')
    Sniper_legs = gui.GetValue('rbot_Sniper_hitbox_legs')
    Sniper_hitbox = gui.GetValue('rbot_sniper_hitbox')
	sniper_ifwalk = gui.GetValue('rbot_sniper_headifwalking')

    -- Scout
    scout_head  =  gui.GetValue('rbot_scout_hitbox_head')
    scout_neck  =  gui.GetValue('rbot_scout_hitbox_neck')
    scout_chest =  gui.GetValue('rbot_scout_hitbox_chest')
    scout_stomach = gui.GetValue('rbot_scout_hitbox_stomach')
    scout_pelvis = gui.GetValue('rbot_scout_hitbox_pelvis')
    scout_legs = gui.GetValue('rbot_scout_hitbox_legs')
    scout_hitbox = gui.GetValue('rbot_scout_hitbox')
	scout_ifwalk = gui.GetValue('rbot_scout_headifwalking')

    -- Pistols
    pistol_head  =  gui.GetValue('rbot_pistol_hitbox_head')
    pistol_neck  =  gui.GetValue('rbot_pistol_hitbox_neck')
    pistol_chest =  gui.GetValue('rbot_pistol_hitbox_chest')
    pistol_stomach = gui.GetValue('rbot_pistol_hitbox_stomach')
    pistol_pelvis = gui.GetValue('rbot_pistol_hitbox_pelvis')
    pistol_hitbox = gui.GetValue('rbot_pistol_hitbox')
	pistol_ifwalk = gui.GetValue('rbot_pistol_headifwalking')
	
    -- Revolver
    revolver_head  =  gui.GetValue('rbot_revolver_hitbox_head')
    revolver_neck  =  gui.GetValue('rbot_revolver_hitbox_neck')
    revolver_chest =  gui.GetValue('rbot_revolver_hitbox_chest')
    revolver_stomach = gui.GetValue('rbot_revolver_hitbox_stomach')
    revolver_pelvis = gui.GetValue('rbot_revolver_hitbox_pelvis')
    revolver_hitbox = gui.GetValue('rbot_revolver_hitbox')
	revolver_ifwalk = gui.GetValue('rbot_revolver_headifwalking')

    -- Other
    autosniper_BaimIfshots = gui.GetValue('rbot_autosniper_bodyaftershots')
    BaimIfHp = gui.GetValue('rbot_autosniper_bodyifhplower')
    autosniper_priority = gui.GetValue('rbot_autosniper_hitbox')

    scout_BaimIfshots = gui.GetValue('rbot_scout_bodyaftershots')
    BaimIfHp = gui.GetValue('rbot_scout_bodyifhplower')
    scout_priority = gui.GetValue('rbot_scout_hitbox')

    pistol_BaimIfshots = gui.GetValue('rbot_pistol_bodyaftershots')
    BaimIfHp = gui.GetValue('rbot_pistol_bodyifhplower')
    pistol_priority = gui.GetValue('rbot_pistol_hitbox')

    Sniper_BaimIfshots = gui.GetValue('rbot_sniper_bodyaftershots')
    BaimIfHp = gui.GetValue('rbot_Sniper_bodyifhplower')
    Sniper_priority = gui.GetValue('rbot_sniper_hitbox')

    Revolver_BaimIfshots = gui.GetValue('rbot_Revolver_bodyaftershots')
    BaimIfHp = gui.GetValue('rbot_Sniper_bodyifhplower')
    revolver_priority = gui.GetValue('rbot_revolver_hitbox')

    posadj = gui.GetValue("rbot_positionadjustment")		
	end

    function RestoreValues()
    gui.SetValue('rbot_autosniper_hitbox_head', autosniper_head)
    gui.SetValue('rbot_autosniper_hitbox_neck', autosniper_neck)
    gui.SetValue('rbot_autosniper_hitbox_chest', autosniper_chest)
    gui.SetValue('rbot_autosniper_hitbox_stomach', autosniper_stomach)
    gui.SetValue('rbot_autosniper_hitbox_pelvis', autosniper_pelvis)
    gui.SetValue('rbot_autosniper_hitbox_legs', autosniper_legs)
	gui.SetValue('rbot_autosniper_headifwalking', autosniper_ifwalk)
	
    -- Scout
    gui.SetValue('rbot_scout_hitbox_head', scout_head)
    gui.SetValue('rbot_scout_hitbox_neck', scout_neck)
    gui.SetValue('rbot_scout_hitbox_chest', scout_chest)
    gui.SetValue('rbot_scout_hitbox_stomach', scout_stomach)
    gui.SetValue('rbot_scout_hitbox_pelvis', scout_pelvis)
    gui.SetValue('rbot_scout_hitbox_legs', scout_legs)
	gui.SetValue('rbot_scout_headifwalking', scout_ifwalk)

    -- Sniper
    gui.SetValue('rbot_Sniper_hitbox_head', Sniper_head)
    gui.SetValue('rbot_Sniper_hitbox_neck', Sniper_neck)
    gui.SetValue('rbot_Sniper_hitbox_chest', Sniper_chest)
    gui.SetValue('rbot_Sniper_hitbox_stomach', Sniper_stomach)
    gui.SetValue('rbot_Sniper_hitbox_pelvis', Sniper_pelvis)
    gui.SetValue('rbot_sniper_hitbox_legs', Sniper_legs)
	gui.SetValue('rbot_sniper_headifwalking', sniper_ifwalk)

    -- Pistols
    gui.SetValue('rbot_pistol_hitbox_head', pistol_head)
    gui.SetValue('rbot_pistol_hitbox_neck', pistol_neck)
    gui.SetValue('rbot_pistol_hitbox_chest', pistol_chest)
    gui.SetValue('rbot_pistol_hitbox_stomach', pistol_stomach)
    gui.SetValue('rbot_pistol_hitbox_pelvis', pistol_pelvis)
	gui.SetValue('rbot_pistol_headifwalking', pistol_ifwalk)


    --Revolver
    gui.SetValue('rbot_revolver_hitbox_head', revolver_head)
    gui.SetValue('rbot_revolver_hitbox_neck', revolver_neck)
    gui.SetValue('rbot_revolver_hitbox_chest', revolver_chest)
    gui.SetValue('rbot_revolver_hitbox_stomach', revolver_stomach)
    gui.SetValue('rbot_revolver_hitbox_pelvis', revolver_pelvis)
	gui.SetValue('rbot_revolver_headifwalking', revolver_ifwalk)


    -- Other
    gui.SetValue('rbot_autosniper_bodyaftershots', autosniper_BaimIfshots)
  --  gui.SetValue('rbot_autosniper_bodyifhplower', BaimIfHp)
    gui.SetValue('rbot_autosniper_hitbox', autosniper_priority)

    gui.SetValue('rbot_sniper_bodyaftershots', Sniper_BaimIfshots)
 --   gui.SetValue('rbot_sniper_bodyifhplower', BaimIfHp)
    gui.SetValue('rbot_sniper_hitbox', Sniper_hitbox)

    gui.SetValue('rbot_scout_bodyaftershots', scout_BaimIfshots)
  --  gui.SetValue('rbot_scout_bodyifhplower', BaimIfHp)
    gui.SetValue('rbot_scout_hitbox', scout_priority)

    gui.SetValue('rbot_pistol_bodyaftershots', pistol_BaimIfshots)
  --  gui.SetValue('rbot_pistol_bodyifhplower', BaimIfHp)
    gui.SetValue('rbot_pistol_hitbox', pistol_priority)

    gui.SetValue('rbot_revolver_bodyaftershots', Revolver_BaimIfshots)
  --  gui.SetValue('rbot_revolver_bodyifhplower', BaimIfHp)
    gui.SetValue('rbot_revolver_hitbox', revolver_priority)
	
	gui.SetValue("rbot_positionadjustment", posadj)		
	end

    
    function BaimActive()
		if BaimKey:GetValue() ~= 0 then
			if input.IsButtonDown(BaimKey:GetValue()) then
				return true
		else return false
		end
		end
		end

	function HeadActive()
		if HeadKey:GetValue() ~= 0 then
			if input.IsButtonDown(HeadKey:GetValue()) then
				return true
		else return false
		end
		end
        end
        


    local function Main()
	w, h = draw.GetScreenSize()
	draw.SetFont(RenderFont)
    draw.Color(0, 230, 0, 230)
    
    if BaimActive() and OnlyHead == false then
		draw.SetFont(RenderFontHB)
		draw.Text(w/2 - 30, h/2 + 30, "BAIM")
			if OnlyBaim == false then
				GetValues()
				OnlyBaim = true
		end
			SetBaimValues()
	else
		if OnlyBaim == true then
			RestoreValues()
            OnlyBaim = false
			draw.SetFont(normal)
	end
				
    if HeadActive() and OnlyBaim == false then
		draw.SetFont(RenderFontHB)
		draw.Text(w/2 - 55, h/2 + 30, "HEADAIM")
		if OnlyHead == false then
			GetValues()
			OnlyHead = true
		end
			SetHeadValues()
	else
		if OnlyHead == true then
			RestoreValues()
			OnlyHead = false
			draw.SetFont(normal)
end
end
end
end



callbacks.Register( "Draw", "Main", Main);
