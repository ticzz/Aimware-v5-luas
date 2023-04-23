local defusing = false;
local plantedat = 0;
local planter = "???";
local planting = false;
local bombsite = "???";
local plantingStarted = 0;
local display = false

local iconData = [[<svg width="40" height="40">
  <title>Layer 1</title>
  <path fill="#ffffff" id="svg_1" d="m34.904,18.621c-0.307,0.154 -0.652,0.336 -1.016,0.288c-0.521,-0.071 -1.125,-0.601 -1.543,-0.858
  c-1.645,-1.011 -3.383,-1.828 -5.275,-2.246c-1.084,-0.239 -2.053,-0.188 -3.148,-0.146c-1.41,0.054 -2.785,0.381 -4.193,0.472
  c-0.803,0.052 -1.406,0.069 -2.143,-0.233c-0.271,-0.111 -0.557,-0.192 -0.834,-0.285c-0.176,-0.059 -0.334,-0.197 -0.438,-0.024
  c-0.107,0.178 -0.189,0.362 -0.35,0.494c-0.275,0.229 -0.34,0.193 -0.152,0.489c0.143,0.226 0.277,0.458 0.428,0.678
  c0.197,0.288 0.848,0.861 0.848,1.203c0,0.25 0.939,0.824 1.137,0.988c0.098,0.081 0.295,0.007 0.152,0.221c-0.051,0.077 -0.211,0.295 -0.326,0.238
  c-0.238,-0.12 -0.443,-0.29 -0.66,-0.448c0.154,0.643 0.371,1.3 0.453,1.956c0.127,0.998 0.213,1.997 0.482,2.969c0.5,1.806 1.383,3.528 2.639,4.925
  c0.594,0.657 1.262,1.241 1.982,1.756c0.311,0.222 0.99,0.563 1.027,1.006c0.027,0.299 0.053,0.66 -0.078,0.942c-0.066,0.139 -0.24,0.228 -0.283,0.378
  c-0.074,0.276 -0.045,0.32 -0.316,0.4c-0.174,0.051 -0.377,0.182 -0.543,0.211c-0.313,0.056 -0.619,-0.189 -0.867,-0.337c-0.768,-0.459 -1.496,-0.994 -2.176,-1.573
  c-2.447,-2.084 -4.336,-5.148 -4.676,-8.382c-0.156,-1.479 -0.352,-2.938 -0.535,-4.411c-0.035,-0.29 -0.281,-0.396 -0.428,-0.636
  c-0.213,-0.352 -0.406,-0.728 -0.645,-1.063c-0.371,-0.522 -0.881,-1.325 -1.467,-1.567c-0.686,-0.282 -1.357,-0.571 -2.051,-0.83
  c-0.441,-0.164 -0.797,-0.557 -1.156,-0.851c-1.475,-1.204 -2.945,-2.406 -4.416,-3.608c-0.144,-0.122 -0.226,-0.208 -0.337,-0.363
  c0.008,0.011 0.133,-0.389 0.182,-0.437c0.102,-0.103 0.262,-0.089 0.385,-0.043c0.732,0.281 1.465,0.562 2.197,0.841c0.959,0.367 1.92,0.735 2.879,1.103
  c0.688,0.263 0.863,0.254 0.947,1.024c0.045,0.4 0.637,0.374 0.871,0.117c0.041,-0.046 0.098,-0.299 0.166,-0.389c0.156,-0.204 0.311,-0.407 0.465,-0.611
  c0.266,-0.35 -0.133,-0.499 -0.41,-0.406c-0.27,0.09 -0.486,-0.012 -0.648,-0.225c-1.098,-1.45 -2.193,-2.9 -3.291,-4.35c-0.143,-0.188 -0.286,-0.376 -0.429,-0.564
  c-0.32,-0.423 0.207,-0.434 0.45,-0.434c0.123,0 0.287,0.174 0.383,0.24c0.353,0.247 0.708,0.495 1.062,0.742c0.871,0.607 1.742,1.216 2.613,1.825
  c0.281,0.195 0.561,0.39 0.84,0.585c0.09,0.063 0.395,0.135 0.42,0.171c0.459,0.638 0.918,1.276 1.373,1.916c0.199,0.278 0.412,0.517 0.646,0.767
  c0.164,0.177 0.707,0.226 0.959,0.303c0.717,0.214 1.432,0.421 2.166,0.558c0.705,0.132 1.523,-0.069 2.234,-0.128c1.404,-0.117 2.828,-0.108 4.234,-0.163
  c1.104,-0.042 2.324,-0.045 3.395,0.236c0.592,0.156 1.238,0.245 1.783,0.537c0.668,0.359 1.34,0.72 2.01,1.08c1.127,0.606 2.168,1.482 3.227,2.206
  c0.405,0.406 0.401,1.444 -0.205,1.746zm-15.109,-0.391c-0.203,-0.409 -0.369,-0.417 -0.801,-0.586c-0.262,-0.102 -0.668,-0.376 -0.961,-0.261
  c-0.301,0 -0.104,0.465 0.084,0.512c0.221,0.056 0.441,0.11 0.662,0.166c0.231,0.057 0.795,0.316 1.016,0.169zm-2.184,-0.219
  c-0.227,-0.076 -0.297,0.201 -0.146,0.352c0.264,0.264 0.799,0.448 1.125,0.638c0.189,0.111 0.709,0.315 0.563,-0.16c-0.361,-0.208 -0.727,-0.409 -1.092,-0.613
  c-0.151,-0.085 -0.286,-0.163 -0.45,-0.217zm2.659,-1.034c-0.137,-0.104 -0.322,-0.111 -0.488,-0.139c-0.391,-0.067 -0.781,-0.134 -1.172,-0.2
  c-0.209,0 -0.248,0.542 0,0.542c0.086,0.058 0.34,0.041 0.439,0.054c0.391,0.048 0.783,0.116 1.178,0.116c0.195,0 0.119,-0.285 0.043,-0.373z"/>
</svg>]]

local outlineData = [[<svg width="40" height="40">
  <title>Layer 1</title>
  <path id="svg_1" d="m22.661,34.3c-0.317,0 -0.59,-0.174 -0.81,-0.314l-0.119,-0.074c-0.749,-0.448 -1.495,-0.987 -2.216,-1.603
  c-2.667,-2.271 -4.454,-5.478 -4.779,-8.579c-0.118,-1.118 -0.259,-2.225 -0.399,-3.335l-0.135,-1.07c-0.009,-0.077 -0.05,-0.125 -0.157,-0.236
  c-0.074,-0.077 -0.157,-0.163 -0.229,-0.281c-0.072,-0.119 -0.141,-0.24 -0.211,-0.361c-0.134,-0.233 -0.268,-0.468 -0.422,-0.685l-0.127,-0.182
  c-0.324,-0.464 -0.768,-1.1 -1.209,-1.282l-0.511,-0.212c-0.508,-0.211 -1.013,-0.421 -1.53,-0.614c-0.383,-0.142 -0.7,-0.424 -0.979,-0.673
  c-0.088,-0.078 -0.175,-0.155 -0.262,-0.227l-4.416,-3.608c-0.167,-0.136 -0.266,-0.241 -0.392,-0.416c-0.066,-0.092 -0.075,-0.214 -0.022,-0.314
  c0,-0.001 0.001,-0.002 0.001,-0.003l0.032,-0.085c0.091,-0.251 0.132,-0.353 0.204,-0.423c0.163,-0.165 0.435,-0.209 0.701,-0.109l5.25,2.009
  c0.618,0.229 0.873,0.356 0.966,1.207c0.025,0.059 0.286,0.02 0.351,-0.053c-0.022,0.021 -0.01,-0.012 0.002,-0.05c0.04,-0.113 0.08,-0.23 0.146,-0.318l0.424,-0.558
  c-0.016,0.001 -0.027,0.004 -0.036,0.007c-0.095,0.032 -0.191,0.048 -0.285,0.048c-0.188,0 -0.46,-0.065 -0.697,-0.376l-3.72,-4.915
  c-0.207,-0.274 -0.177,-0.48 -0.115,-0.604c0.155,-0.311 0.593,-0.311 0.804,-0.311c0.198,0 0.356,0.131 0.484,0.237c0.025,0.021 0.049,0.041 0.068,0.055l4.519,3.154
  c0.033,0.018 0.105,0.04 0.169,0.061c0.159,0.053 0.255,0.085 0.324,0.184c0.457,0.636 0.917,1.274 1.372,1.915c0.182,0.255 0.38,0.479 0.621,0.736
  c0.066,0.058 0.369,0.119 0.514,0.148c0.12,0.024 0.231,0.048 0.314,0.073c0.717,0.214 1.422,0.417 2.133,0.55c0.468,0.088 0.994,0.013 1.507,-0.056
  c0.222,-0.03 0.439,-0.059 0.648,-0.076c0.942,-0.079 1.902,-0.102 2.832,-0.124c0.473,-0.011 0.945,-0.022 1.416,-0.041c0.319,-0.012 0.647,-0.021 0.979,-0.021
  c1.016,0 1.812,0.084 2.504,0.267c0.15,0.04 0.304,0.075 0.458,0.11c0.468,0.107 0.951,0.217 1.39,0.453l2.01,1.08c0.771,0.415 1.503,0.953 2.21,1.473
  c0.348,0.256 0.695,0.511 1.043,0.75c0.334,0.328 0.469,0.836 0.388,1.331c-0.07,0.427 -0.299,0.767 -0.629,0.931c-0.369,0.186 -0.753,0.375 -1.189,0.316
  c-0.458,-0.062 -0.912,-0.382 -1.313,-0.665c-0.125,-0.088 -0.242,-0.17 -0.347,-0.235c-1.816,-1.117 -3.511,-1.839 -5.183,-2.208
  c-0.549,-0.121 -1.104,-0.175 -1.8,-0.175c-0.37,0 -0.743,0.015 -1.131,0.03l-0.141,0.005c-0.739,0.028 -1.488,0.136 -2.213,0.24c-0.642,0.093 -1.307,0.188 -1.973,0.231
  c-0.156,0.01 -0.305,0.019 -0.448,0.024l0.618,0.102c0.16,0.022 0.36,0.051 0.534,0.183c0.151,0.165 0.26,0.449 0.158,0.673c-0.143,0.311 -0.587,0.243 -0.934,0.205
  c0.141,0.096 0.267,0.235 0.389,0.481c0.067,0.135 0.023,0.299 -0.102,0.383c-0.195,0.13 -0.513,0.101 -0.808,0.016c0.049,0.028 0.099,0.056 0.148,0.085
  c0.065,0.038 0.114,0.099 0.137,0.171c0.064,0.209 0.049,0.381 -0.047,0.511c-0.049,0.066 -0.163,0.177 -0.38,0.177c-0.114,0 -0.231,-0.031 -0.331,-0.068
  c0.008,0.014 0.015,0.029 0.022,0.046c0.073,0.185 -0.036,0.347 -0.077,0.408c-0.166,0.252 -0.346,0.381 -0.535,0.381c-0.046,0 -0.132,-0.02 -0.174,-0.041
  c-0.012,-0.006 -0.023,-0.012 -0.035,-0.018c0.105,0.398 0.207,0.807 0.259,1.219l0.066,0.541c0.099,0.828 0.193,1.61 0.408,2.385c0.509,1.837 1.398,3.498 2.573,4.804
  c0.56,0.62 1.21,1.196 1.934,1.712c0.055,0.039 0.122,0.082 0.195,0.129c0.386,0.249 0.915,0.589 0.957,1.096c0.034,0.365 0.053,0.753 -0.105,1.093
  c-0.053,0.111 -0.129,0.188 -0.191,0.251c-0.027,0.028 -0.068,0.07 -0.077,0.087l-0.021,0.086c-0.069,0.281 -0.153,0.414 -0.498,0.515c-0.063,0.019 -0.13,0.051 -0.198,0.082
  c-0.121,0.056 -0.246,0.113 -0.378,0.136c-0.049,0.012 -0.098,0.016 -0.146,0.016zm-18.32,-23.976c0.053,0.062 0.107,0.112 0.186,0.176l4.417,3.608
  c0.093,0.077 0.187,0.159 0.281,0.243c0.252,0.224 0.512,0.456 0.79,0.559c0.524,0.196 1.037,0.409 1.551,0.623l0.509,0.211c0.604,0.25 1.085,0.939 1.473,1.494l0.125,0.177
  c0.165,0.232 0.31,0.483 0.453,0.733c0.067,0.117 0.134,0.234 0.204,0.349c0.037,0.061 0.088,0.114 0.148,0.176c0.127,0.133 0.287,0.298 0.321,0.58l0.135,1.068
  c0.141,1.114 0.282,2.226 0.401,3.347c0.31,2.952 2.02,6.012 4.572,8.185c0.697,0.594 1.415,1.113 2.135,1.544l0.133,0.083c0.162,0.103 0.345,0.22 0.487,0.22l0.04,-0.003
  c0.057,-0.01 0.149,-0.052 0.231,-0.09c0.096,-0.044 0.191,-0.087 0.28,-0.113c0.045,-0.014 0.07,-0.022 0.084,-0.028c0,0 0,0 0,0c-0.012,0 -0.007,-0.025 0,-0.055l0.028,-0.108
  c0.046,-0.161 0.15,-0.267 0.226,-0.344c0.027,-0.027 0.068,-0.069 0.076,-0.086c0.094,-0.202 0.076,-0.499 0.05,-0.785c-0.018,-0.215 -0.435,-0.483 -0.685,-0.644
  c-0.082,-0.053 -0.157,-0.101 -0.218,-0.145c-0.758,-0.542 -1.441,-1.147 -2.031,-1.799c-1.237,-1.375 -2.172,-3.12 -2.705,-5.046
  c-0.227,-0.819 -0.328,-1.66 -0.425,-2.473l-0.065,-0.538c-0.055,-0.437 -0.176,-0.889 -0.293,-1.326c-0.054,-0.2 -0.107,-0.4 -0.154,-0.598
  c-0.03,-0.122 0.021,-0.25 0.125,-0.319c0.031,-0.021 0.065,-0.035 0.101,-0.043c-0.374,-0.29 -0.537,-0.487 -0.537,-0.707c-0.009,-0.131 -0.335,-0.495 -0.492,-0.669
  c-0.125,-0.14 -0.237,-0.267 -0.304,-0.364c-0.104,-0.151 -0.2,-0.308 -0.296,-0.465l-0.138,-0.222c-0.229,-0.362 -0.204,-0.554 0.104,-0.792l0.11,-0.087
  c0.084,-0.07 0.145,-0.176 0.215,-0.299l0.07,-0.12c0.155,-0.256 0.49,-0.237 0.697,-0.143c0.03,0.013 0.061,0.028 0.092,0.038l0.243,0.079c0.205,0.065 0.411,0.132 0.61,0.213
  c0.592,0.243 1.188,0.264 2.01,0.212c0.643,-0.042 1.295,-0.135 1.926,-0.226c0.74,-0.106 1.505,-0.216 2.275,-0.246l0.141,-0.005c0.396,-0.016 0.777,-0.03 1.155,-0.03
  c0.741,0 1.336,0.058 1.929,0.189c1.738,0.384 3.494,1.13 5.368,2.283c0.114,0.07 0.242,0.16 0.378,0.255c0.328,0.231 0.736,0.518 1.048,0.561
  c0.256,0.034 0.537,-0.106 0.807,-0.241c0.247,-0.123 0.316,-0.371 0.339,-0.509c0.049,-0.296 -0.026,-0.622 -0.178,-0.774c-0.311,-0.206 -0.663,-0.465 -1.017,-0.725
  c-0.691,-0.508 -1.405,-1.033 -2.139,-1.428l-2.01,-1.08c-0.368,-0.197 -0.811,-0.298 -1.24,-0.396c-0.161,-0.037 -0.321,-0.074 -0.477,-0.115
  c-0.642,-0.168 -1.389,-0.247 -2.352,-0.247c-0.324,0 -0.644,0.009 -0.955,0.021c-0.474,0.019 -0.949,0.03 -1.425,0.041c-0.92,0.021 -1.872,0.044 -2.796,0.121
  c-0.199,0.017 -0.407,0.045 -0.618,0.073c-0.574,0.077 -1.207,0.144 -1.697,0.051c-0.74,-0.138 -1.461,-0.346 -2.197,-0.565c-0.07,-0.021 -0.161,-0.04 -0.259,-0.059
  c-0.321,-0.065 -0.653,-0.133 -0.834,-0.328c-0.256,-0.273 -0.468,-0.514 -0.67,-0.796c-0.44,-0.62 -0.885,-1.237 -1.329,-1.854c-0.021,-0.007 -0.045,-0.015 -0.07,-0.023
  c-0.145,-0.049 -0.246,-0.085 -0.323,-0.139l-4.516,-3.155c-0.03,-0.02 -0.068,-0.051 -0.11,-0.086c-0.04,-0.032 -0.113,-0.093 -0.143,-0.105
  c-0.053,0.002 -0.096,0.005 -0.131,0.008l3.682,4.865c0.105,0.139 0.19,0.139 0.219,0.139c0.029,0 0.061,-0.006 0.095,-0.018c0.327,-0.105 0.716,0.01 0.843,0.267
  c0.053,0.107 0.111,0.329 -0.099,0.605l-0.466,0.612c-0.01,0.019 -0.04,0.104 -0.056,0.15c-0.038,0.11 -0.065,0.189 -0.124,0.255c-0.164,0.181 -0.429,0.291 -0.692,0.291
  c-0.381,0 -0.663,-0.23 -0.702,-0.572c-0.056,-0.517 -0.066,-0.521 -0.578,-0.71l-5.255,-2.011c-0.025,-0.01 -0.052,-0.015 -0.072,-0.015
  c0.011,0.001 -0.017,0.088 -0.045,0.164zm11.714,6.069c0.003,0.005 0.007,0.011 0.011,0.017l0.142,0.229c0.091,0.148 0.182,0.297 0.28,0.44c0.055,0.081 0.151,0.186 0.255,0.302
  c0.168,0.187 0.314,0.355 0.425,0.513c0.083,-0.123 0.218,-0.196 0.371,-0.196c0.013,0 0.039,0.003 0.067,0.007c-0.024,-0.082 -0.033,-0.164 -0.023,-0.237
  c0.026,-0.211 0.181,-0.359 0.393,-0.382c0.055,-0.017 0.114,-0.027 0.174,-0.03c-0.008,-0.048 -0.011,-0.093 -0.011,-0.13c0,-0.222 0.089,-0.408 0.227,-0.508
  c-0.31,-0.043 -0.596,-0.123 -0.892,-0.245c-0.184,-0.075 -0.375,-0.136 -0.565,-0.196l-0.25,-0.081c-0.048,-0.016 -0.096,-0.037 -0.142,-0.058l-0.006,0.011
  c-0.087,0.152 -0.185,0.324 -0.354,0.463l-0.102,0.081z"/>
</svg>]]

local iconRGBA, iconW, iconH = common.RasterizeSVG(iconData, 1)
local outlineRGBA, outlineW, outlineH = common.RasterizeSVG(outlineData, 1)
local iconTexture = draw.CreateTexture(iconRGBA, iconW, iconH)
local outlineTexture = draw.CreateTexture(outlineRGBA, outlineW, outlineH)

local defaultTexture = draw.CreateTexture()

local function lerp_pos(x1, y1, z1, x2, y2, z2, percentage) 

local x = (x2 - x1) * percentage + x1 
local y = (y2 - y1) * percentage + y1
local z = (z2 - z1) * percentage + z1 

	return x, y, z 
	
end

local function sitename(site) 

local avec = entities.GetPlayerResources():GetProp("m_bombsiteCenterA")
local bvec = entities.GetPlayerResources():GetProp("m_bombsiteCenterB")
local sitevec1 = site:GetMins()
local sitevec2 = site:GetMaxs()
local site_x, site_y, site_z = lerp_pos(sitevec1.x, sitevec1.y, sitevec1.z , sitevec2.x, sitevec2.y, sitevec2.z, 0.5)
local distance_a, distance_b = vector.Distance({site_x, site_y, site_z}, {avec.x, avec.y, avec.z}), vector.Distance({site_x, site_y, site_z}, {bvec.x, bvec.y, bvec.z})

	return distance_b > distance_a and "A" or "B" 

end

function EventHook(Event)

	if Event:GetName() == "bomb_beginplant" then 
		
		display = true
		planter = client.GetPlayerNameByUserID(Event:GetInt("userid")) 
		plantingStarted = globals.CurTime() 
		bombsite = sitename(entities.GetByIndex(Event:GetInt("site")))
		planting = true 
		
		
	end
	
	if Event:GetName() == "bomb_abortplant" then 
	
		display = false
		planting = false
		
	end
	
	if Event:GetName() == "bomb_begindefuse" then
		
		defusing = true
	
	elseif Event:GetName() == "bomb_abortdefuse" then
	
		defusing = false
	
	elseif Event:GetName() == "round_officially_ended" or Event:GetName() == "bomb_defused" or Event:GetName() == "bomb_exploded" then
		
		display = false
		defusing = false
		planting = false
	
	end
	
	if Event:GetName() == "bomb_planted" then

		plantedat = globals.CurTime()
		planting = false
	
	end
	
end

function DrawingHook()

	if display then
	local font1 = draw.CreateFont("Verdana", 30)
	local font2 = draw.CreateFont("Verdana", 23)
	draw.SetFont(font1)

	if planting == true then

		local Player = entities.GetLocalPlayer();
        local ScreenW, ScreenH = draw.GetScreenSize();
		local PlantMath = (globals.CurTime() - plantingStarted) / 3.125
        local PlantTime = math.floor((((plantingStarted - globals.CurTime()) + 3.125) * 10)) / 10
        PlantTime = tostring(PlantTime)
        if not string.find(PlantTime, "%.") then
            PlantTime = PlantTime .. ".0"
        end

		draw.Color(75,225,0,255)
		draw.TextShadow(ScreenW/100, 7, bombsite .. " - Planting")
		draw.Color(255,255,255,255)
		draw.SetFont(font2)
		draw.TextShadow(ScreenW/100, 58, planter .. " - " .. PlantTime .. "s")
		draw.Color(0, 0, 0, 170);
		draw.FilledRect( 0, 0, ScreenW/200, ScreenH );
		draw.Color(0, 255, 0, 255);
		draw.FilledRect( 0, ScreenH - (ScreenH * PlantMath), ScreenW/200, ScreenH );
		draw.Color(255, 255, 255, 255);
		if Player:GetTeamNumber() == 3 then
		if Player:GetPropBool("m_bHasDefuser") == true then
		draw.Color(255,255,255,255)
		draw.SetTexture(iconTexture)
		draw.FilledRect(ScreenW/100, 75, ScreenW/100 + 40, 115)
		draw.SetTexture(outlineTexture)
		draw.FilledRect(ScreenW/100, 75, ScreenW/100 + 40, 115)
		draw.SetTexture(defaultTexture)
		end
		end
		
	end

	if entities.FindByClass("CPlantedC4")[1] ~= nil then

		local Bomb = entities.FindByClass("CPlantedC4")[1];

		if Bomb:GetProp("m_bBombTicking") and Bomb:GetProp("m_bBombDefused") == 0 and globals.CurTime() < Bomb:GetProp("m_flC4Blow") then

		local ScreenW, ScreenH = draw.GetScreenSize(); 
		local Player = entities.GetLocalPlayer(); 
		local bombtimer = math.floor((plantedat - globals.CurTime() + Bomb:GetProp("m_flTimerLength")) * 10) / 10
		
			if bombtimer < 0 then bombtimer = 0.0 end

			if defusing == true then
			
				local BombMath = ((globals.CurTime() - Bomb:GetProp("m_flDefuseCountDown")) * (0 - 1)) / ((Bomb:GetProp("m_flDefuseCountDown") - Bomb:GetProp("m_flDefuseLength")) - Bomb:GetProp("m_flDefuseCountDown")) + 1; 

				draw.Color(0, 0, 0, 170);
				draw.FilledRect( 0, 0, ScreenW/200, ScreenH );
				draw.Color(0, 135, 255, 255);
				draw.FilledRect( 0, ScreenH * BombMath, ScreenW/200, ScreenH );
				
				if bombtimer < 5 then
				
					draw.Color(240, 20, 0, 255);
					
				elseif bombtimer < 10 then
				
					draw.Color(210, 150, 0, 255);
				
				else
				
					draw.Color(75, 225, 0, 255);

				end
                
                bombtimer = tostring(bombtimer)
                if not string.find(bombtimer, "%.") then
                    bombtimer = bombtimer .. ".0"
                end

				draw.SetFont(font1)
				draw.TextShadow( ScreenW/100, 7, bombsite .. " - " .. bombtimer .. "s");
				draw.Color(255, 255, 255, 255);

				if Bomb:GetProp("m_flDefuseCountDown") > Bomb:GetProp("m_flC4Blow") then
				
					draw.Color(255, 0, 0, 255);
				
				end
				
				local defusetime = math.floor( (Bomb:GetProp("m_flDefuseCountDown") - globals.CurTime()) * 10 ) / 10
                
                defusetime = tostring(defusetime)
                if not string.find(defusetime, "%.") then
                    defusetime = defusetime .. ".0"
                end

				draw.SetFont(font2)
				draw.TextShadow(ScreenW/100, 58, "Defusing - " .. defusetime .. "s")
				
				if Player:GetTeamNumber() == 3 then
				if Player:GetPropBool("m_bHasDefuser") == true then
				draw.Color(255,255,255,255)
				draw.SetTexture(iconTexture)
				draw.FilledRect(ScreenW/100, 75, ScreenW/100 + 40, 115)
				draw.SetTexture(outlineTexture)
				draw.FilledRect(ScreenW/100, 75, ScreenW/100 + 40, 115)
				draw.SetTexture(defaultTexture)
				end
				end

			else
			
				local BombMath = ((globals.CurTime() - Bomb:GetProp("m_flC4Blow")) * (0 - 1)) / ((Bomb:GetProp("m_flC4Blow") - Bomb:GetProp("m_flTimerLength")) - Bomb:GetProp("m_flC4Blow")) + 1;
				
				draw.Color(0, 0, 0, 170);
				draw.FilledRect( 0, 0, ScreenW/200, ScreenH );
				draw.Color(0, 255, 0, 255);
				draw.FilledRect( 0, ScreenH * BombMath, ScreenW/200, ScreenH );
				
				if bombtimer < 5 then
				
					draw.Color(240, 20, 0, 255);
					
				elseif bombtimer < 10 then
				
					draw.Color(210, 150, 0, 255);
				
				else
				
					draw.Color(75, 225, 0, 255);

				end
                
                bombtimer = tostring(bombtimer)
                if not string.find(bombtimer, "%.") then
                    bombtimer = bombtimer .. ".0"
                end

				draw.SetFont(font1)
				draw.TextShadow( ScreenW/100, 7, bombsite .. " - " .. bombtimer .. "s");
				
				if Player:GetTeamNumber() == 3 then
				if Player:GetPropBool("m_bHasDefuser") == true then
				draw.Color(255,255,255,255)
				draw.SetTexture(iconTexture)
				draw.FilledRect(ScreenW/100, 75, ScreenW/100 + 40, 115)
				draw.SetTexture(outlineTexture)
				draw.FilledRect(ScreenW/100, 75, ScreenW/100 + 40, 115)
				draw.SetTexture(defaultTexture)
				end
				end

			end

			if Player:IsAlive() and globals.CurTime() < Bomb:GetProp("m_flC4Blow") then
			
				local hpleft = math.floor(0.5 + BombDamage(Bomb, Player))
				
				if hpleft >= Player:GetHealth() then
				
					draw.Color(240, 20, 0, 255)
					draw.SetFont(font2)
					local formatting = draw.GetTextSize("FATAL")
					draw.TextShadow(ScreenW/2 - formatting/2, ScreenH/20 + 5, "FATAL");
				
				elseif hpleft <= 0 then return
				
				else
				
					draw.Color(75, 225, 0, 255)
					draw.SetFont(font2)
					local formattinghp = draw.GetTextSize("-" .. hpleft .. " HP")
					draw.TextShadow(ScreenW/2 - formattinghp/2, ScreenH/20 + 5, "-" .. hpleft .. " HP");
					
				end
			end
			
		elseif Bomb:GetProp("m_bBombTicking") and Bomb:GetProp("m_bBombDefused") == 0 and globals.CurTime() < (Bomb:GetProp("m_flC4Blow") + 2) then
		
			local ScreenW, ScreenH = draw.GetScreenSize(); 
			local Player = entities.GetLocalPlayer(); 
		
			if Player:IsAlive() and globals.CurTime() < (Bomb:GetProp("m_flC4Blow") + 1) then
			
				local hpleft = math.floor(0.5 + BombDamage(Bomb, Player))
				
				if hpleft >= Player:GetHealth() then
				
					draw.Color(240, 20, 0, 255)
					draw.SetFont(font2)
					local formatting = draw.GetTextSize("FATAL")
					draw.TextShadow(ScreenW/2 - formatting/2, ScreenH/20 + 5, "FATAL");
				
				elseif hpleft <= 0 then return
				
				else
				
					draw.Color(75, 225, 0, 255)
					draw.SetFont(font2)
					local formattinghp = draw.GetTextSize("-" .. hpleft .. " HP")
					draw.TextShadow(ScreenW/2 - formattinghp/2, ScreenH/20 + 5, "-" .. hpleft .. " HP");
					
				end
			end
		end
	end
	end
end

function BombDamage(Bomb, Player)

    local playerOrigin = Player:GetAbsOrigin()
    local bombOrigin = Bomb:GetAbsOrigin()

	local C4Distance = math.sqrt((bombOrigin.x - playerOrigin.x) ^ 2 + 
	(bombOrigin.y - playerOrigin.y) ^ 2 + 
	(bombOrigin.z - playerOrigin.z) ^ 2);

	local Gauss = (C4Distance - 75.68) / 789.2 
	local flDamage = 450.7 * math.exp(-Gauss * Gauss);

		if Player:GetProp("m_ArmorValue") > 0 then

			local flArmorRatio = 0.5;
			local flArmorBonus = 0.5;

			if Player:GetProp("m_ArmorValue") > 0 then
			
				local flNew = flDamage * flArmorRatio;
				local flArmor = (flDamage - flNew) * flArmorBonus;
			 
				if flArmor > Player:GetProp("m_ArmorValue") then
				
					flArmor = Player:GetProp("m_ArmorValue") * (1 / flArmorBonus);
					flNew = flDamage - flArmor;
					
				end
			 
			flDamage = flNew;

			end

		end 
		
	return math.max(flDamage, 0);
	
end

client.AllowListener( "bomb_beginplant" );
client.AllowListener( "bomb_abortplant" );
client.AllowListener( "bomb_begindefuse" );
client.AllowListener( "bomb_abortdefuse" ); 
client.AllowListener( "bomb_defused" );
client.AllowListener( "bomb_exploded" );
client.AllowListener( "round_officially_ended" );
client.AllowListener( "bomb_planted" );

callbacks.Register("FireGameEvent", "EventHookB", EventHook);
callbacks.Register("Draw", "DrawingHookB", DrawingHook)