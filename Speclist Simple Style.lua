--SimpleSpeclist by Cheeseot
local specshit = gui.Reference( "MISC", "GENERAL", "Extra")
local BetterSpecBox = gui.Checkbox( specshit, "lua_betterspec", "Simple speclist", 1 )
BetterSpecBox:SetDescription("Position based on default spectator window.")

function betterspec()
local specfont = draw.CreateFont('Vendetta', 20)
local sorting = 0
local specpos1, specpos2 = gui.GetValue("spectators")
	if BetterSpecBox:GetValue() then
	gui.SetValue("misc.showspec", 0)
	local lp = entities.GetLocalPlayer()
		if lp ~= nil then
			for i, v in ipairs(entities.FindByClass("CCSPlayer")) do
			local player = v
				if player ~= lp and not player:IsAlive() then
				local name = player:GetName()
					if player:GetPropEntity("m_hObserverTarget") ~= nil then
					local playerindex = player:GetIndex()
					local botcheck = client.GetPlayerInfo(playerindex)
						if (not botcheck["IsGOTV"] and not botcheck["IsBot"]) then
						local target = player:GetPropEntity("m_hObserverTarget");
							if target:IsPlayer() then
							local targetindex = target:GetIndex()
							local myindex = client.GetLocalPlayerIndex()
								if lp:IsAlive() then
									if targetindex == myindex then
									draw.SetFont(specfont)
									draw.Color(255,255,255,255)
									draw.Text( specpos1, specpos2 + (sorting * 16), name )
									draw.TextShadow( specpos1, specpos2 + (sorting * 16), name )
									sorting = sorting + 1
									end
								end	
								if not lp:IsAlive() then
									if lp:GetPropEntity("m_hObserverTarget") ~= nil then
									local myspec = lp:GetPropEntity("m_hObserverTarget")
									local myspecindex = myspec:GetIndex()
									if targetindex == myspecindex then
									draw.SetFont(specfont)
									draw.Color(255,255,255,255)
									draw.Text( specpos1, specpos2 + (sorting * 16), name )
									draw.TextShadow( specpos1, specpos2 + (sorting * 16), name )
									sorting = sorting + 1
									end
								end
								end
							end
						end
					end
				end
			end
		end
	end
end	
callbacks.Register ("Draw", "betterspec", betterspec)--SimpleSpeclist by Cheeseot












--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

