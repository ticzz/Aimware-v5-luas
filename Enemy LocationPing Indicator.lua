local positionvec3 = Vector3(0,0,0)
local posx,posy = 0
local userID = 0
local username = ""
local urgent = 0
local ref = gui.Reference("Visuals","World","Extra")
local text = gui.ColorPicker( ref, "text.colour", "Text Colour", 255, 255, 255, 255 )
local fill = gui.ColorPicker( ref, "fill.colour", "Fill Colour", 255, 255, 255, 255 )
local fill2 = gui.ColorPicker( ref, "fill2.colour", "Fill2 Colour", 0, 0, 0, 255 )
local pingtable = {}
local zerovar = 0

client.AllowListener("player_ping")
callbacks.Register( "FireGameEvent", function(e)
    if e:GetName() == "player_ping" then
        positionvec3 = Vector3(e:GetFloat("x"),e:GetFloat("y"),e:GetFloat("z"))
        userID = e:GetInt("userid")
        username = entities.GetByUserID(e:GetInt("userid")):GetName()
        urgent = e:GetString("urgent")
        table.insert( pingtable, {positionvec3,userID,urgent,0,username} )
    end
end)

callbacks.Register( "Draw", function()
    
    if entities.GetByUserID(userID):GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber() then return end
    for i=1,#pingtable do
        for i2=1,#pingtable-1 do
            lasti2 = entities.GetByUserID(pingtable[#pingtable - i2][2])
            currenti = entities.GetByUserID(pingtable[2])
            if lasti2:GetIndex() == currenti:GetIndex() then
                table.remove( pingtable, i2 )
            end
        end
        posx,posy = client.WorldToScreen(pingtable[1])
        pingtable[4] = pingtable[4] + 1
        if pingtable[4] >= 1000 then table.remove( pingtable, 1 ) return end
        if pingtable[3] == "0" or pingtable[3] == 0 then
            draw.Color( text:GetValue() )
            draw.TextShadow( posx-56, posy+40, pingtable[5] )
            draw.Color( fill:GetValue() )
            draw.FilledCircle( posx, posy, 30 )
            draw.Color( fill2:GetValue() )
            draw.FilledRect( posx-3, posy-12, posx+3, posy-18 )
            draw.FilledRect( posx-3, posy-6, posx+3, posy+16 )
        elseif pingtable[3] == "1" or pingtable[3] == 1 then
            draw.Color( text:GetValue() )
            draw.TextShadow( posx-58, posy+16, pingtable[5] )
            draw.Color( fill:GetValue() )
            draw.Triangle( posx-50, posy, posx+50, posy, posx, posy-75 )
            draw.Color( fill2:GetValue() )
            draw.FilledRect( posx-3, posy-12, posx+3, posy-18 )
            draw.FilledRect( posx-3, posy-24, posx+3, posy-44 )
        end
    end
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

