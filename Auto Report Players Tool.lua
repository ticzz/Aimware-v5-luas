-- Autoreport by zinn
-- GUI
local report_window = gui.Window("Report", "Auto Report by ~zinn#0001", 100, 100, 220, 270)
local start_box = gui.Groupbox(report_window, "Report Starter", 10, 10, 200, 0 )
local report_starter = gui.Checkbox(start_box, "report.starter", "Start reporting", false)
local report_box = gui.Groupbox(report_window, "Settings", 10, 100, 200, 0 )
local report_delay = gui.Slider(report_box, "report.speed", "Reporting delay (s)", 1, 0.2, 10)
local report_choice = gui.Checkbox(report_box, "report.teammates", "Report Teammates", false)
-- Variables
local i=1;
local Local_Index
local player
local report_tick = 0
local Player_Index
local checker
local reported = {}

local function reporter()
	if report_starter:GetValue() then
		report_window:SetInvisible(true)
		local players = entities.FindByClass("CCSPlayer");
		Local_Index = client.GetLocalPlayerIndex()
		Local_Player = entities.GetLocalPlayer()
		player = players[i]
		Player_Index = player:GetIndex()
		checker = globals.CurTime() - report_tick;
		if checker < report_delay:GetValue() then
			return
		end
		if checker > report_delay:GetValue() then
			if report_choice:GetValue() then
				if reported[i] ~= true and Local_Index ~= Player_Index and Player_Index ~= nil and client.GetPlayerInfo(Player_Index)["IsBot"] == false and client.GetPlayerInfo(Player_Index)["IsGOTV"] == false then
					panorama.RunScript(string.format([[
					GameStateAPI.SubmitPlayerReport(GameStateAPI.GetPlayerXuidStringFromEntIndex(%i), "grief,aimbot,wallhack,speedhack");]],Player_Index));
					report_tick = globals.CurTime()
					reported[i] = true;
				end
			else
				if player:GetTeamNumber() ~= Local_Player:GetTeamNumber() and reported[i] ~= true and Local_Index ~= Player_Index and Player_Index ~= nil and client.GetPlayerInfo(Player_Index)["IsBot"] == false and client.GetPlayerInfo(Player_Index)["IsGOTV"] == false then
					panorama.RunScript(string.format([[
					GameStateAPI.SubmitPlayerReport(GameStateAPI.GetPlayerXuidStringFromEntIndex(%i), "grief,aimbot,wallhack,speedhack");]],Player_Index));
					report_tick = globals.CurTime()
					reported[i] = true;
				end
			end
		end
		if i >= #players then
			i = 1
			return;
		else
			i = i + 1
		end
	end
end
callbacks.Register('Draw', 'reporter', reporter)