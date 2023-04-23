local font = draw.CreateFont("Verdana Bold", 19,30)
local LP = entities.GetLocalPlayer
local originRecords = {}

local function hsind()

if gui.GetValue("rbot.antiaim.condition.shiftonshot") == true then

draw.SetFont(font)
draw.Color(160,160,160);
draw.Text(10, 650, "HS")

		else
	end
end

local function dtind()

if gui.GetValue("rbot.hitscan.accuracy.pistol.doublefire") == 2 or
   gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire") == 2 or
   gui.GetValue("rbot.hitscan.accuracy.smg.doublefire") == 2 or
   gui.GetValue("rbot.hitscan.accuracy.rifle.doublefire") == 2 or
   gui.GetValue("rbot.hitscan.accuracy.shotgun.doublefire") == 2 or
   gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire") == 2 or
   gui.GetValue("rbot.hitscan.accuracy.lmg.doublefire") == 2 then

draw.SetFont(font)
draw.Color(160,160,160);
draw.Text(10, 670, "DT")

		else
	end
end

local function lcind()


if LP() then
if LP():IsAlive() then
if originRecords[1] ~= nil and originRecords[2] ~= nil then
local delta = Vector3(originRecords[2].x - originRecords[1].x, originRecords[2].y - originRecords[1].y, originRecords[2].z - originRecords[1].z)
delta = delta:Length2D()^2
if delta > 4096 then

draw.SetFont(font)					
draw.Color(255,25,25,255)
draw.TextShadow(10,720, "LC")

else

end
if originRecords[3] ~= nil then
table.remove(originRecords, 1)
				end
			end
		end
	end
end

local function createMoveHook(cmd)
            if LP() then
            if LP():IsAlive() then
if cmd.sendpacket then
table.insert(originRecords, entities.GetLocalPlayer():GetAbsOrigin())
			end
		end
	end
end

local function fdind()

if input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
draw.SetFont(font)
draw.Color(160,160,160)
draw.TextShadow(10, 690, "FD")

end
end

callbacks.Register("CreateMove", createMoveHook)
callbacks.Register("Draw","hsind",hsind);
callbacks.Register("Draw","dtind",dtind);
callbacks.Register("Draw","lcind",lcind);
callbacks.Register("Draw","fdind",fdind);







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

