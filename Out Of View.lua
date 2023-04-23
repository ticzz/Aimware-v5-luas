local Helper = gui.Reference( "Visuals", "Local", "Helper" )
local Lofi = {
    Color = gui.ColorPicker( Helper, "color", "Color", 255, 255, 255, 255 ),
    ColorDormant = gui.ColorPicker( Helper, "color", "Dormant Color", 255, 255, 255, 255 )
}

function RotateTriangle(Angle, Radius)
    local ScrW, ScrH = draw.GetScreenSize()
    ScrW, ScrH = ScrW / 2, ScrH / 2

    Angle = Angle - 90

    local A = math.rad(Angle)
    local B = math.rad(Angle - 5)
    local C = math.rad(Angle + 5)

    local D = math.cos(A) * (Radius + 15)
    local E = math.sin(A) * (Radius + 15)

    local F = math.cos(B) * Radius
    local G = math.sin(B) * Radius

    local H = math.cos(C) * Radius
    local I = math.sin(C) * Radius

    return {
        A = {
            ScrW + D,
            ScrH + E
        },
        B = {
            ScrW + F,
            ScrH + G
        },
        C = {
            ScrW + H,
            ScrH + I
        }
    }
end

function GetAngle(Player, Entity)
    local Angle = (Player:GetAbsOrigin() - Entity:GetAbsOrigin()):Angles().y
    return (engine.GetViewAngles().y - Angle + 180)
end

function Draw()
    for _, Player in next, entities.FindByClass( "CCSPlayer" ) do
        local ScrW, ScrH = draw.GetScreenSize()
        if Player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and Player:IsAlive() then
            local x, y = client.WorldToScreen( Player:GetAbsOrigin() )
            if Player:IsDormant() then
                local Angle = GetAngle(entities.GetLocalPlayer(), Player)
                local Points = RotateTriangle(Angle, 100)
                if Player:IsDormant() then
                    local r,g,b,a = Lofi.ColorDormant:GetValue()
                    draw.Color( r, g, b, a )
                else
                    local r,g,b,a = Lofi.Color:GetValue()
                    draw.Color( r, g, b, a )
                end
                draw.Triangle( Points.A[1], Points.A[2], Points.B[1], Points.B[2], Points.C[1], Points.C[2] )
            else
                if not x or not y or x < 0 or x > ScrW or y < 0 or y > ScrH then
                    local Angle = GetAngle(entities.GetLocalPlayer(), Player)
                    local Points = RotateTriangle(Angle, 100)
                    if Player:IsDormant() then
                        local r,g,b,a = Lofi.ColorDormant:GetValue()
                        draw.Color( r, g, b, a )
                    else
                        local r,g,b,a = Lofi.Color:GetValue()
                        draw.Color( r, g, b, a )
                    end
                    draw.Triangle( Points.A[1], Points.A[2], Points.B[1], Points.B[2], Points.C[1], Points.C[2] )
                end
            end
        end
    end
end

callbacks.Register( "Draw", Draw )







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

