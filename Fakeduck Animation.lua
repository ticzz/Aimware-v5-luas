--Fakeduck Viewmodel Animation by Grieschoel aka AEONS

local getLocal = function() return entities.GetLocalPlayer() end
local ref = gui.Tab(gui.Reference("Visuals"), "localtab", "Camera");
local whyamiwastingmytime = gui.Checkbox( ref, fuckmyass, "Fakeduck Animation", false )
local viewmodelZ = (client.GetConVar("viewmodel_offset_z"));
function yourmumsahoe()
if whyamiwastingmytime:GetValue() then
if getLocal() then
if getLocal():IsAlive() then
local shitthisisboring = gui.GetValue('rbot.antiaim.advanced.fakecrouchkey')
local andsofuckinguseless = input.IsButtonDown( shitthisisboring )                                            
local yourmum = entities.GetLocalPlayer();
local tbagmodeengaged = yourmum:GetProp('m_flDuckAmount')            
if  andsofuckinguseless == true then
client.SetConVar("viewmodel_offset_z", viewmodelZ - (tbagmodeengaged*8), true)
else client.SetConVar("viewmodel_offset_z", viewmodelZ, true)
end end end end end                        
callbacks.Register("Draw", yourmumsahoe)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

