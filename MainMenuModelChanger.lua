-- Main Menu Model Changer & Fortnite Dances by stacky

panorama.RunScript([[
    var model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
]] )

local models = {
    {"Invisible"},
	{"Local T Agent", "models/player/custom_player/legacy/tm_phoenix.mdl"},
	{"Local CT Agent", "models/player/custom_player/legacy/ctm_sas.mdl"},
	{"Blackwolf | Sabre", "models/player/custom_player/legacy/tm_balkan_variantj.mdl"},
	{"Rezan The Ready | Sabre", "models/player/custom_player/legacy/tm_balkan_variantg.mdl"},
	{"Maximus | Sabre", "models/player/custom_player/legacy/tm_balkan_varianti.mdl"},
	{"Dragomir | Sabre", "models/player/custom_player/legacy/tm_balkan_variantf.mdl"},
	{"Lt. Commander Ricksaw | NSWC SEAL", "models/player/custom_player/legacy/ctm_st6_varianti.mdl"},
	{"'Two Times' McCoy | USAF TACP", "models/player/custom_player/legacy/ctm_st6_variantm.mdl"},
	{"Buckshot | NSWC SEAL", "models/player/custom_player/legacy/ctm_st6_variantg.mdl"},
	{"Seal Team 6 Soldier | NSWC SEAL", "models/player/custom_player/legacy/ctm_st6_variante.mdl"},
	{"3rd Commando Company | KSK", "models/player/custom_player/legacy/ctm_st6_variantk.mdl"},
	{"'The Doctor' Romanov | Sabre", "models/player/custom_player/legacy/tm_balkan_varianth.mdl"},
	{"Michael Syfers  | FBI Sniper", "models/player/custom_player/legacy/ctm_fbi_varianth.mdl"},
	{"Markus Delrow | FBI HRT", "models/player/custom_player/legacy/ctm_fbi_variantg.mdl"},
	{"Operator | FBI SWAT", "models/player/custom_player/legacy/ctm_fbi_variantf.mdl"},
	{"Slingshot | Phoenix", "models/player/custom_player/legacy/tm_phoenix_variantg.mdl"},
	{"Enforcer | Phoenix", "models/player/custom_player/legacy/tm_phoenix_variantf.mdl"},
	{"Soldier | Phoenix", "models/player/custom_player/legacy/tm_phoenix_varianth.mdl"},
	{"The Elite Mr. Muhlik | Elite Crew", "models/player/custom_player/legacy/tm_leet_variantf.mdl"},
	{"Prof. Shahmat | Elite Crew", "models/player/custom_player/legacy/tm_leet_varianti.mdl"},
	{"Osiris | Elite Crew", "models/player/custom_player/legacy/tm_leet_varianth.mdl"},
	{"Ground Rebel  | Elite Crew", "models/player/custom_player/legacy/tm_leet_variantg.mdl"},
	{"Special Agent Ava | FBI", "models/player/custom_player/legacy/ctm_fbi_variantb.mdl"},
	{"B Squadron Officer | SAS", "models/player/custom_player/legacy/ctm_sas_variantf.mdl"},
	{"Anarchist", "models/player/custom_player/legacy/tm_anarchist.mdl"},
	{"Anarchist (Variant A)", "models/player/custom_player/legacy/tm_anarchist_varianta.mdl"},
	{"Anarchist (Variant B)", "models/player/custom_player/legacy/tm_anarchist_variantb.mdl"},
	{"Anarchist (Variant C)", "models/player/custom_player/legacy/tm_anarchist_variantc.mdl"},
	{"Anarchist (Variant D)", "models/player/custom_player/legacy/tm_anarchist_variantd.mdl"},
	{"Pirate", "models/player/custom_player/legacy/tm_pirate.mdl"},
	{"Pirate (Variant A)", "models/player/custom_player/legacy/tm_pirate_varianta.mdl"},
	{"Pirate (Variant B)", "models/player/custom_player/legacy/tm_pirate_variantb.mdl"},
	{"Pirate (Variant C)", "models/player/custom_player/legacy/tm_pirate_variantc.mdl"},
	{"Pirate (Variant D)", "models/player/custom_player/legacy/tm_pirate_variantd.mdl"},
	{"Professional", "models/player/custom_player/legacy/tm_professional.mdl"},
	{"Professional (Variant 1)", "models/player/custom_player/legacy/tm_professional_var1.mdl"},
	{"Professional (Variant 2)", "models/player/custom_player/legacy/tm_professional_var2.mdl"},
	{"Professional (Variant 3)", "models/player/custom_player/legacy/tm_professional_var3.mdl"},
	{"Professional (Variant 4)", "models/player/custom_player/legacy/tm_professional_var4.mdl"},
	{"Separatist", "models/player/custom_player/legacy/tm_separatist.mdl"},
	{"Separatist (Variant A)", "models/player/custom_player/legacy/tm_separatist_varianta.mdl"},
	{"Separatist (Variant B)", "models/player/custom_player/legacy/tm_separatist_variantb.mdl"},
	{"Separatist (Variant C)", "models/player/custom_player/legacy/tm_separatist_variantc.mdl"},
	{"Separatist (Variant D)", "models/player/custom_player/legacy/tm_separatist_variantd.mdl"},
	{"GIGN", "models/player/custom_player/legacy/ctm_gign.mdl"},
	{"GIGN (Variant A)", "models/player/custom_player/legacy/ctm_gign_varianta.mdl"},
	{"GIGN (Variant B)", "models/player/custom_player/legacy/ctm_gign_variantb.mdl"},
	{"GIGN (Variant C)", "models/player/custom_player/legacy/ctm_gign_variantc.mdl"},
	{"GIGN (Variant D)", "models/player/custom_player/legacy/ctm_gign_variantd.mdl"},
	{"GSG-9", "models/player/custom_player/legacy/ctm_gsg9.mdl"},
	{"GSG-9 (Variant A)", "models/player/custom_player/legacy/ctm_gsg9_varianta.mdl"},
	{"GSG-9 (Variant B)", "models/player/custom_player/legacy/ctm_gsg9_variantb.mdl"},
	{"GSG-9 (Variant C)", "models/player/custom_player/legacy/ctm_gsg9_variantc.mdl"},
	{"GSG-9 (Variant D)", "models/player/custom_player/legacy/ctm_gsg9_variantd.mdl"},
	{"IDF", "models/player/custom_player/legacy/ctm_idf.mdl"},
	{"IDF (Variant B)", "models/player/custom_player/legacy/ctm_idf_variantb.mdl"},
	{"IDF (Variant C)", "models/player/custom_player/legacy/ctm_idf_variantc.mdl"},
	{"IDF (Variant D)", "models/player/custom_player/legacy/ctm_idf_variantd.mdl"},
	{"IDF (Variant E)", "models/player/custom_player/legacy/ctm_idf_variante.mdl"},
	{"IDF (Variant F)", "models/player/custom_player/legacy/ctm_idf_variantf.mdl"},
	{"SWAT", "models/player/custom_player/legacy/ctm_swat.mdl"},
	{"SWAT (Variant A)", "models/player/custom_player/legacy/ctm_swat_varianta.mdl"},
	{"SWAT (Variant B)", "models/player/custom_player/legacy/ctm_swat_variantb.mdl"},
	{"SWAT (Variant C)", "models/player/custom_player/legacy/ctm_swat_variantc.mdl"},
	{"SWAT (Variant D)", "models/player/custom_player/legacy/ctm_swat_variantd.mdl"},
	{"SAS (Variant A)", "models/player/custom_player/legacy/ctm_sas_varianta.mdl"},
	{"SAS (Variant B)", "models/player/custom_player/legacy/ctm_sas_variantb.mdl"},
	{"SAS (Variant C)", "models/player/custom_player/legacy/ctm_sas_variantc.mdl"},
	{"SAS (Variant D)", "models/player/custom_player/legacy/ctm_sas_variantd.mdl"},
	{"ST6", "models/player/custom_player/legacy/ctm_st6.mdl"},
	{"ST6 (Variant A)", "models/player/custom_player/legacy/ctm_st6_varianta.mdl"},
	{"ST6 (Variant B)", "models/player/custom_player/legacy/ctm_st6_variantb.mdl"},
	{"ST6 (Variant C)", "models/player/custom_player/legacy/ctm_st6_variantc.mdl"},
	{"ST6 (Variant D)", "models/player/custom_player/legacy/ctm_st6_variantd.mdl"},
	{"Balkan (Variant E)", "models/player/custom_player/legacy/tm_balkan_variante.mdl"},
	{"Balkan (Variant A)", "models/player/custom_player/legacy/tm_balkan_varianta.mdl"},
	{"Balkan (Variant B)", "models/player/custom_player/legacy/tm_balkan_variantb.mdl"},
	{"Balkan (Variant C)", "models/player/custom_player/legacy/tm_balkan_variantc.mdl"},
	{"Balkan (Variant D)", "models/player/custom_player/legacy/tm_balkan_variantd.mdl"},
	{"Jumpsuit (Variant A)", "models/player/custom_player/legacy/tm_jumpsuit_varianta.mdl"},
	{"Jumpsuit (Variant B)", "models/player/custom_player/legacy/tm_jumpsuit_variantb.mdl"},
	{"Jumpsuit (Variant C)", "models/player/custom_player/legacy/tm_jumpsuit_variantc.mdl"},
	{"Phoenix Heavy", "models/player/custom_player/legacy/tm_phoenix_heavy.mdl"},
	{"Heavy", "models/player/custom_player/legacy/ctm_heavy.mdl"},
	{"Leet (Variant A)", "models/player/custom_player/legacy/tm_leet_varianta.mdl"},
	{"Leet (Variant B)", "models/player/custom_player/legacy/tm_leet_variantb.mdl"},
	{"Leet (Variant C)", "models/player/custom_player/legacy/tm_leet_variantc.mdl"},
	{"Leet (Variant D)", "models/player/custom_player/legacy/tm_leet_variantd.mdl"},
	{"Leet (Variant E)", "models/player/custom_player/legacy/tm_leet_variante.mdl"},
	{"Phoenix", "models/player/custom_player/legacy/tm_phoenix.mdl"},
	{"Phoenix (Variant A)", "models/player/custom_player/legacy/tm_phoenix_varianta.mdl"},
	{"Phoenix (Variant B)", "models/player/custom_player/legacy/tm_phoenix_variantb.mdl"},
	{"Phoenix (Variant C)", "models/player/custom_player/legacy/tm_phoenix_variantc.mdl"},
	{"Phoenix (Variant D)", "models/player/custom_player/legacy/tm_phoenix_variantd.mdl"},
	{"FBI", "models/player/custom_player/legacy/ctm_fbi.mdl"},
	{"FBI (Variant A)", "models/player/custom_player/legacy/ctm_fbi_varianta.mdl"},
	{"FBI (Variant C)", "models/player/custom_player/legacy/ctm_fbi_variantc.mdl"},
	{"FBI (Variant D)", "models/player/custom_player/legacy/ctm_fbi_variantd.mdl"},
	{"FBI (Variant E)", "models/player/custom_player/legacy/ctm_fbi_variante.mdl"},
    {"SAS", "models/player/custom_player/legacy/ctm_sas.mdl"},
    {"Chicken", "models/chicken/chicken.mdl"},
    {"Cuddle Team Leader", "models/player/custom_player/legacy/cuddleleader.mdl"}
}

local dances = {
    {"None"},
    {"Fonzie Pistol", "Emote_Fonzie_Pistol"},
    {"Bring It On", "Emote_Bring_It_On"},
    {"Thumbs Down", "Emote_ThumbsDown"},
    {"Thumbs Up", "Emote_ThumbsUp"},
    {"Celebration Loop", "Emote_Celebration_Loop"},
    {"Blow Kiss", "Emote_BlowKiss"},
    {"Calculated", "Emote_Calculated"},
    {"Confused", "Emote_Confused",},
    {"Chug", "Emote_Chug"},
    {"Cry", "Emote_Cry"},
    {"Dusting Off Hands", "Emote_DustingOffHands"},
    {"Dust Off Shoulders", "Emote_DustOffShoulders",},
    {"Facepalm", "Emote_Facepalm"},
    {"Fishing", "Emote_Fishing"},
    {"Flex", "Emote_Flex"},
    {"Golfclap", "Emote_golfclap",},
    {"Hand Signals", "Emote_HandSignals"},
    {"Heel Click", "Emote_HeelClick"},
    {"Hotstuff", "Emote_Hotstuff"},
    {"IBreakYou", "Emote_IBreakYou",},
    {"IHeartYou", "Emote_IHeartYou"},
    {"Kung", "Emote_Kung-Fu_Salute"},
    {"Laugh", "Emote_Laugh"},
    {"Luchador", "Emote_Luchador",},
    {"Make It Rain", "Emote_Make_It_Rain"},
    {"Not Today", "Emote_NotToday"},
    {"[RPS] Paper", "Emote_RockPaperScissor_Paper"},
    {"[RPS] Rock", "Emote_RockPaperScissor_Rock",},
    {"[RPS] Scissor", "Emote_RockPaperScissor_Scissor"},
    {"Salt", "Emote_Salt"},
    {"Salute", "Emote_Salute"},
    {"Smooth Drive", "Emote_SmoothDrive",},
    {"Snap", "Emote_Snap"},
    {"StageBow", "Emote_StageBow",},
    {"Wave2", "Emote_Wave2"},
    {"Yeet", "Emote_Yeet"},
    {"Dance Moves", "DanceMoves"},
    {"Zippy Dance", "Emote_Zippy_Dance"},
    {"Electro Shuffle", "ElectroShuffle"},
    {"Aerobic Champ", "Emote_AerobicChamp"},
    {"Bendy", "Emote_Bendy"},
    {"Band Of The Fort", "Emote_BandOfTheFort"},
    {"Capoeira", "Emote_Capoeira"},
    {"Charleston", "Emote_Charleston"},
    {"Chicken", "Emote_Chicken"},
    {"No Bones", "Emote_Dance_NoBones",},
    {"Shoot", "Emote_Dance_Shoot"},
    {"Swipe It", "Emote_Dance_SwipeIt"},
    {"Disco 1", "Emote_Dance_Disco_T3"},
    {"Disco 2", "Emote_DG_Disco",},
    {"Worm", "Emote_Dance_Worm"},
    {"Loser", "Emote_Dance_Loser"},
    {"Breakdance", "Emote_Dance_Breakdance"},
    {"Pump", "Emote_Dance_Pump",},
    {"Ride The Pony", "Emote_Dance_RideThePony"},
    {"Dab", "Emote_Dab"},
    {"Fancy Feet", "Emote_FancyFeet",},
    {"Floss Dance", "Emote_FlossDance"},
    {"Flippn Sexy", "Emote_FlippnSexy"},
    {"Fresh", "Emote_Fresh"},
    {"Groove Jam", "Emote_GrooveJam",},
    {"Guitar", "Emote_guitar"},
    {"Hiphop", "Emote_Hiphop_01"},
    {"Korean Eagle", "Emote_KoreanEagle",},
    {"Kpop", "Emote_Kpop_02"},
    {"Living Large", "Emote_LivingLarge"},
    {"Maracas", "Emote_Maracas"},
    {"Pop Lock", "Emote_PopLock"},
    {"Pop Rock", "Emote_PopRock"},
    {"Robot Dance", "Emote_RobotDance"},
    {"T-Rex", "Emote_T-Rex",},
    {"Techno Zombie", "Emote_TechnoZombie"},
    {"Twist", "Emote_Twist"},
    {"Wiggle", "Emote_Wiggle"},
    {"You're Awesome", "Emote_Youre_Awesome"}
}

local lastModel = models[1][1]

local REFERENCE = gui.Reference( "Visuals", "Other" )
local GBOX = gui.Groupbox( REFERENCE, "Main Menu Model Changer", 328, 820, 298, 0 )

local MODEL = gui.Combobox( GBOX, "model.change", "Main Menu Model", "" )

local DANCE = gui.Combobox( GBOX, "model.dance", "Fortnite Dance", "" )
local APPLY_DANCE = gui.Button( GBOX, "Apply Dance", function()
    local model_path = models[MODEL:GetValue() + 1][2]
    local dance_path = dances[DANCE:GetValue() + 1][2]
    panorama.RunScript([[
        model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
        model.visible = true;
        model.SetScene("resource/ui/fornite_dances.res", "]] .. model_path .. [[", false)
        model.PlaySequence("]] .. dance_path .. [[", true)
    ]] )
end )

local MODEL_CHANGECOLOR = gui.Checkbox( GBOX, "model.changecolor", "Change Color", false )
local MODEL_COLOR = gui.ColorPicker( MODEL_CHANGECOLOR, "model.color", "cock", 255, 0, 0, 255 )

local model_names = {}
for i = 1, #models do
    table.insert(model_names, models[i][1])
end
MODEL:SetOptions(unpack(model_names))

local dance_names = {}
for i = 1, #dances do
    table.insert(dance_names, dances[i][1])
end
DANCE:SetOptions(unpack(dance_names))

callbacks.Register( "Draw", function()
    if entities.GetLocalPlayer() then return end
    if MODEL_CHANGECOLOR:GetValue() then
        local r, g, b, a = MODEL_COLOR:GetValue()  
        panorama.RunScript( [[
            model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
            model.SetAmbientLightColor(]] .. r .. [[, ]] .. g .. [[, ]] .. b .. [[);
        ]] )
    end

    if lastModel ~= models[MODEL:GetValue() + 1][1] then
        lastModel = models[MODEL:GetValue() + 1][1]
        local model_path = models[MODEL:GetValue() + 1][2]
        if model_path == nil then
            panorama.RunScript([[
                model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
                model.visible = false;
            ]] )    
        else
            panorama.RunScript([[
                model = $.GetContextPanel().GetChild(0).FindChildInLayoutFile( 'JsMainmenu_Vanity' );
                model.visible = true;
                model.SetScene("resource/ui/econ/ItemModelPanelCharMainMenu.res", "models/player/custom_player/legacy/ctm_sas.mdl", false)
                model.SetSceneModel("]] .. model_path .. [[")
            ]] )    
        end
    end
end )
















--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

