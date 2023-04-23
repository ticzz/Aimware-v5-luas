----    Base    code    for    auto    updating.
--
--local    cS    =    GetScriptName()
--local    cV    =    '1.0.0'
--local    gS    =    'PUT    LINK    TO    RAW    LUA    SCRIPT'
--local    gV    =    'PUT    LINK    TO    RAW    VERSION'
--
--local    function    AutoUpdate()
--	if    gui.GetValue('lua_allow_http')    and    gui.GetValue('lua_allow_cfg')    then
--		local    nV    =    http.Get(gV)
--		if    cV    ~=    nV    then
--			local    nF    =    http.Get(gS)
--			local    cF    =    file.Open(cS,    'w')
--			cF:Write(nF)
--			cF:Close()
--			print(cS,    'updated    from',    cV,    'to',    nV)
--		else
--			print(cS,    'is    up-to-date.')
--		end
--	end
--end		
--
--callbacks.Register('Draw',    'Auto    Update')
--callbacks.Unregister('Draw',    'Auto    Update')

local ref = gui.Reference("Visuals", "World", "Materials", "Skybox");

local skyboxes = {"Default", "cs_tibet", "embassy", "italy", "jungle", "office", "sky_cs15_daylight01_hdr",

"sky_csgo_cloudy01", "sky_csgo_night02", "sky_csgo_night02b", "sky_day02_05_hdr", "sky_day02_05", "sky_dust", "vertigo_hdr",

"vertigoblue_hdr", "vertigo", "vietnam", "galaxy", "space_1", "space_3", "space_5", "space_6", "space_7", "space_8", "space_9",

"space_10", "******"};


local skyboxesMenu = {"Default", "Tibet", "Embassy", "Italy", "Jungle", "Office", "CS15 Daylight HDR",

"Cloudy 1", "Night 2", "Night 2B", "Day 2 5 HDR", "Day 2 5", "Dust", "Vertigo HDR", "Vertigoblue HDR",

"Vertigo", "Vietnam", "Galaxy", "Space 1", "Space 2", "Space 3", "Space 4", "Space 5", "Space 6", "Space 7",

"Space 8", "Decent"};


ref:SetOptions(unpack(skyboxesMenu));

local set = client.SetConVar;

local last = ref:GetValue();


local function SkyBox()

    if last ~= ref:GetValue() then

        set("sv_skyname" , skyboxes[ref:GetValue() + 1], true);

        last = ref:GetValue();

    end

end

callbacks.Register("Draw", SkyBox)
