local PlayerIndexByUserID, LocalPlayerIndex, PlayerNameByUserID, g_curtime, draw_SetFont, draw_GetTextSize, draw_Color, draw_TextShadow, table_remove, string_format = client.GetPlayerIndexByUserID, client.GetLocalPlayerIndex, client.GetPlayerNameByUserID, globals.CurTime, draw.SetFont, draw.GetTextSize, draw.Color, draw.TextShadow, table.remove, string.format

local HitLog = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Logs"), "msc_hitlog", "Hit Log", false)

local ScreenY = 3
local hit_logs = {}
local hitgroup_names = {"head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg"}

local Tf13 = draw.CreateFont("Tahoma", 13, 1200)

function hitlog(e)
	if not HitLog:GetValue() or e:GetName() ~= "player_hurt" then
		return
	end

	if PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() then
		log = string_format("Hit %s in the %s for %s damage (%s health remaining)",
							PlayerNameByUserID(e:GetInt("userid")),
							hitgroup_names[e:GetInt("hitgroup")] or "body",
							e:GetString("dmg_health"),
							e:GetString("health")
						)

		hit_logs[#hit_logs + 1] = {g_curtime(), log}
	end
end

function draw_hitlog()
	if not HitLog:GetValue() or hit_logs[1] == nil then
		return
	end

	local ScreenY = 3

	for k, v in pairs(hit_logs) do
		local a = (v[1] - g_curtime() + 12) / 12

		if 255*a > 67.5 then
			draw_SetFont(Tf13)
			local tW, tH = draw_GetTextSize(v[2])
			draw_Color(255, 255, 255, 255*a)
			draw_TextShadow(8, ScreenY, v[2])
			ScreenY = ScreenY + tH
		else
			table_remove(hit_logs, k)
		end
	end
end

callbacks.Register("Draw", draw_hitlog)
callbacks.Register("FireGameEvent", hitlog)













--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

