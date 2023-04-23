local editbox = gui.Editbox(gui.Reference("visuals", "other", "extra"), "headesp", "Head ESP image link")
editbox:SetDescription("Make sure this is a direct link")
editbox:SetValue("https://enjoyersoflife.se/img/xane.png")
local image = http.Get("https://enjoyersoflife.se/img/xane.png")
local texture = draw.CreateTexture(common.DecodePNG(image))
local button = gui.Button(gui.Reference("visuals", "other", "extra"), "Apply Image", function()
    image = http.Get(editbox:GetValue())
    texture = draw.CreateTexture(common.DecodePNG(image))
end)

local function ondraw()
    local lp = entities.GetLocalPlayer()
    local viewangles = engine.GetViewAngles()
    viewangles.y = viewangles.y - 90
    viewangles:Normalize()
    draw.SetTexture(texture)
    for k, v in pairs(entities.FindByClass("CCSPlayer")) do
        if v ~= nil then
            if v:GetTeamNumber() ~= lp:GetTeamNumber() and v:GetHealth() > 0 then
                local headpos = v:GetHitboxPosition(0)
                local pos1 = Vector3(headpos.x - 7.5 * math.cos(viewangles.y/57.295779513082), headpos.y - 7.5 * math.sin(viewangles.y/57.295779513082), headpos.z + 8.5)
                local pos2 = Vector3(headpos.x + 7.5 * math.cos(viewangles.y/57.295779513082), headpos.y + 7.5 * math.sin(viewangles.y/57.295779513082), headpos.z - 8.5)
                local x1, y1 = client.WorldToScreen(pos1)
                local x2, y2 = client.WorldToScreen(pos2)
                draw.FilledRect(x1, y1, x2, y2)
            end
        end
    end
end

callbacks.Register("Draw", ondraw)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

