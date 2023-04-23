local ui_get = gui.GetValue()
local new_checkbox = gui.Checkbox()
local new_color_picker = gui.ColorPicker()
local new_slider = gui:Slider()
local localplayer, uid_to_entindex, hitbox, is_enemy = entities.GetLocalPlayer, entities.GetByUserID( userID ), e:GetInt("hitgroup"), entities.GetTeamNumber()
local draw_line, w2s = renderer.line, renderer.world_to_screen
local ref = gui.Reference("Visuals", "Overlay", "Enemy")
local ref_gr = gui.Groupbox(ref, "Skeleton Settings")
local curtime = globals.curtime


    skelly = new_checkbox( gui.Reference( "Visuals" , "Overlay" , "Enemy" ), "Player Esp", "Draw skeleton on hit", false),
    skelly_c = new_color_picker(ref_gr,  "Draw skeleton on hit", 255, 255, 255, 255),
    hitfade = new_slider(ref_gr,  "Fade time", 2, 10, 4, true, "s", 1)


local skellyparts = {  -- im makin it out of hitboxes stfuuu
	main = {0, 1, 6, 5, 4, 3, 2},
	left_arm = {14, 18, 17, 1},
	right_arm = {13, 16, 15, 1},
	left_leg = {12, 10, 8, 2},
	right_leg = {11, 9, 7, 2}
} 

local loggedskellys = {}

callbacks.Register("FireGameEvent", function(e)

local local_player, userid, attacker = client.GetLocalPlayerIndex(), e:GetInt('userid'), e:GetInt('victim')
			local lp_index = entities.GetLocalPlayer():GetIndex()
			local lp_teamnum = entities.GetLocalPlayer():GetTeamNumber()
			local vic = entities.GetByUserID(e:GetInt("userid"));
			local att = entities.GetByUserID(e:GetInt("attacker"));
local localplyr = localplayer()
	if not localplyr then return end
	if e:GetName() ~= "player hurt" then return end
	if ui_get(skelly) and uid_to_entindex(e.attacker) == localplyr and is_enemy(uid_to_entindex(e.userid)) then
		if uid_to_entindex(e.userid) == localplyr then return end
			
		local skellypos = {}
		for i = 0, 18 do
			local x, y, z = hitbox(uid_to_entindex(e.userid), i)

			skellypos[i] = {x = x, y = y, z = z}
		end

		table.insert(loggedskellys, {tick = curtime(), bones = skellypos})
	end
end)

callbacks.Register("Draw", function()
	if not ui_get(skelly) then return end

	local r, g, b, a = ui_get(skelly_c)

	for skellyindex, skelly in pairs(loggedskellys) do

		local alpha = a
		if skelly.tick + ui_get(hitfade) - 1 <= curtime() then
			alpha = alpha * (1 - (curtime() - (skelly.tick + ui_get(hitfade) - 1)))
		end

		if skelly.tick + ui_get(hitfade) <= curtime() then
			table.remove(loggedskellys, skellyindex)
		else
			for group_name, group in pairs(skellyparts) do
				for index, part in pairs(group) do
					if index ~= #group then
						local x, y, z = skelly.bones[group[index]].x, skelly.bones[group[index]].y, skelly.bones[group[index]].z -- did this really bad cuz im lazy
						local parent_x, parent_y = w2s(x, y, z)

						local x1, y1, z1 = skelly.bones[group[index + 1]].x, skelly.bones[group[index + 1]].y, skelly.bones[group[index + 1]].z
						local child_X, child_y = w2s(x1, y1, z1)

						draw_line(parent_x, parent_y, child_X, child_y, r, g, b, alpha)
					end
				end
			end
		end
	end
end)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")