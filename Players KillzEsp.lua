local ref = gui.Reference("VISUALS", "Other")
local ref_grp = gui.Groupbox(ref, "Kill counter", 330,275,295,10)
local cp_Default_Color = gui.ColorPicker(ref_grp,"visuals.other.extra.outline.clr","Kill counter Color", 255, 255, 255)
local cb_Outline = gui.Checkbox(ref_grp, "visuals.other.extra.outline", "Kill counter Outline", true)
local cp_Outline_Color = gui.ColorPicker(ref_grp,"visuals.other.extra.outline.clr","Kill counter Outline color", 0, 0, 0)
local sd_MaxDistance = gui.Slider(ref_grp,"visuals.other.extra.max_dist","Maximum distance",470,0,2048)

local playerFrags = {}
local playerFragsAlpha = {}
local function lerp(t,v0,v1)
    return v0 + t * (v1 - v0)
end
callbacks.Register("Draw", function()
    local defaultClr = {cp_Default_Color:GetValue()}
    local outLineClr = {cp_Outline_Color:GetValue()}

    for k,v in pairs(entities.FindByClass("CCSPlayer")) do
        if(not playerFrags[v:GetIndex()]) then playerFrags[v:GetIndex()] = 0 end
        
        local pX, pY = client.WorldToScreen(v:GetAbsOrigin() + Vector3(0,0,70))
        local lPos = entities.GetLocalPlayer():GetAbsOrigin()
        local vPos = v:GetAbsOrigin()
        local dist = vector.Distance({vPos.x,vPos.y,vPos.z}, {lPos.x,lPos.y,lPos.z})
        if(not playerFragsAlpha[v:GetIndex()]) then playerFragsAlpha[v:GetIndex()] = 0 end
        if(pX and pY and v:IsAlive() and dist <= sd_MaxDistance:GetValue()) then
            playerFragsAlpha[v:GetIndex()] = lerp(0.25, playerFragsAlpha[v:GetIndex()], 255)
        else
            playerFragsAlpha[v:GetIndex()] = lerp(0.05, playerFragsAlpha[v:GetIndex()], 0)
        end
        
        if(playerFragsAlpha[v:GetIndex()] ~= 0) then
            local text = "☠ " .. playerFrags[v:GetIndex()]
            local tW, tH = draw.GetTextSize(text)
            if(cb_Outline:GetValue()) then
                draw.Color(outLineClr[1],outLineClr[2],outLineClr[3],playerFragsAlpha[v:GetIndex()])
                draw.Text((pX - tW / 2) - 1, (pY - tH / 2) - 1, text)
                draw.Text((pX - tW / 2) + 1, (pY - tH / 2) - 1, text)
                draw.Text((pX - tW / 2) - 1, (pY - tH / 2) + 1, text)
                draw.Text((pX - tW / 2) + 1, (pY - tH / 2) + 1, text)
            end
            draw.Color(defaultClr[1],defaultClr[2],defaultClr[3],playerFragsAlpha[v:GetIndex()])
            draw.Text(pX - tW / 2, pY - tH / 2, text)
        end
    end
end)

client.AllowListener("player_death")
client.AllowListener("round_prestart")
callbacks.Register("FireGameEvent", function(event)
    if(event:GetName() == "player_death") then
        local victim = entities.GetByUserID(event:GetInt("userid"))
        local attacker = entities.GetByUserID(event:GetInt("attacker"))
        playerFrags[attacker:GetIndex()] = playerFrags[attacker:GetIndex()] + 1
        playerFrags[victim:GetIndex()] = 0
        print(victim:GetIndex(),attacker:GetIndex())
    elseif(event:GetName() == "round_prestart") then
        playerFrags = {}
    end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

