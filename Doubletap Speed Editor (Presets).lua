--DT speed editor made by lntranets

--references
local dt = 'rbot.hitscan.accuracy.asniper.doublefire'
local processticks = gui.Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks')
local menu = gui.Reference('Ragebot', 'Accuracy', 'Weapon')
local fakelaglimit = 'misc.fakelag.factor'
local dthc = 'rbot.hitscan.accuracy.asniper.doublefirehc'
local x, y = draw.GetScreenSize()
local slidewalk = 'misc.slidewalk'
local last = 0
local state = true
x = x * 0.5;
y = y * 0.5;
--------------------------------

--pasted shit from luawiki
------------------------------------------------------------------------------------------------------
local dt_check = gui.Checkbox( menu, 'dt_checkbox', 'Use Lua DT', false );
--local dt_combo = gui.Combobox( dt_lua, 'dt_combobox', 'Combobox', 'Reliable', 'Faster', 'Dangerous');
local dt_slider = gui.Slider(menu, 'dt_slider', 'Tick Adjuster', 16 ,16, 61);
------------------------------------------------------------------------------------------------------

--dt handler
local function handledt()

	if dt_check:GetValue() then
		local getslider = dt_slider:GetValue()
		processticks:SetValue(getslider)
		gui.SetValue(fakelaglimit, 3)

    else return end
end
callbacks.Register('CreateMove', handledt)
--------------------------------

--pasted legbreak(auto on)
function Draw()
if globals.CurTime() > last then
		state = not state
		last = globals.CurTime() + 0.01
		gui.SetValue(slidewalk, state and true or false)
	end
end

callbacks.Register( 'Draw', Draw );
--------------------------------

--drawing ticks to screen
local function ontick()
	local gettick = processticks:GetValue()
	if dt_check:GetValue() then
        draw.TextShadow(x, y, gettick .. ' Ticks')
	end
end
callbacks.Register('Draw', 'ontick', ontick)
--------------------------------

--fd handler
local fakeduck = gui.Reference('Ragebot', 'Anti-Aim', 'Extra', 'Fake Duck')
local getfd = fakeduck:GetValue()

local function handlefd()
	if getfd == 0 then 
		return
	end
	if input.IsButtonDown(getfd) then 
		processticks:SetValue(16) 
	end
	if not input.IsButtonDown(getfd) then
		return
	end
end
callbacks.Register('CreateMove', handlefd)
--------------------------------







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

