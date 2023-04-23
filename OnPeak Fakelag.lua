local DT_REF = gui.Reference( "MISC", "Enhancement", "Fakelag" )
local predict_amount = gui.Slider(DT_REF, "Prediction_amount", "Prediction amount", 0.50, 0.01, 1, 0.01)
local Factor_test = gui.Slider(DT_REF, "Factor_test", "Peak FakelagFactor", 17, 3, 17)
local Factor_Triggor = gui.Slider(DT_REF, "Factor_Triggor", "NonPeak Fakelag Factor", 3, 3, 17)
local F_key = gui.Keybox(DT_REF, "factor_key", "Factor Triggor key (Set to None for auto Mode)", nil)
local testget = "misc.fakelag.factor"


function predict_velocity(entity, prediction_amount)
local VelocityX = entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
local VelocityY = entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
local VelocityZ = entity:GetPropFloat( "localdata", "m_vecVelocity[2]" );

absVelocity = {VelocityX, VelocityY, VelocityZ}

pos_ = {entity:GetAbsOrigin()}

modifed_velocity = {vector.Multiply(absVelocity, prediction_amount)}

return {vector.Subtract({vector.Add(pos_, modifed_velocity)}, {0,0,0})}
end


function PlayersFilter(fn) -- lets check for valid player 
local valid = {}
for k, player in pairs(entities.FindByClass("CCSPlayer")) do
if fn and fn(player) then
table.insert(valid, player)
end
end
return valid
end

local Triggor = false

callbacks.Register("Draw", function()


local LocalPlayer = entities.GetLocalPlayer()

if not LocalPlayer then return end 

if F_key:GetValue() ~= 0 and input.IsButtonReleased(F_key:GetValue()) then
Triggor = false
end

--print(F_key:GetValue())
if LocalPlayer and not F_key:GetValue() ~= 0 or (F_key:GetValue() and input.IsButtonDown(F_key:GetValue())) then
local my_pos = LocalPlayer:GetAbsOrigin()
local prediction = predict_velocity(LocalPlayer, predict_amount:GetValue())
local x,y,z = vector.Add(
{my_pos.x, my_pos.y, my_pos.z},
{prediction[1], prediction[2], prediction[3]}
)

prediction = Vector3(x,y,z + 32)
local players = PlayersFilter(function(player)
local tr = engine.TraceLine(prediction,
player:GetAbsOrigin() + Vector3(0,0,32), 4294967295)

return tr and tr.entity and tr.entity:IsPlayer() and
tr.entity:GetTeamNumber() ~= LocalPlayer:GetTeamNumber()

end)

if #players ~= 0 and not Triggor then
Triggor = true
gui.SetValue( "misc.fakelag.factor", Factor_Triggor:GetValue() ) 
elseif Triggor then
    gui.SetValue( "misc.fakelag.factor", Factor_test:GetValue() ) 
Triggor = false
--elseif testget:GetValue() == Factor_Triggor:GetValue() and not Triggor and #players == 0 then --idk if this work lol
 --   gui.SetValue( "misc.fakelag.factor", Factor_test:GetValue() ) 
end

end
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

