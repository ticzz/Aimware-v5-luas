-- Server Side Bullet Impacts by stacky

local REF = gui.Reference( "Visuals", "Local", "Helper" )
local SHOW = gui.Checkbox( REF, "bulletimpacts", "Server-Side Bullet Impacts", false )
SHOW:SetDescription("Show server-side bullet impacts.")
local SHOW_CLIENT = gui.Checkbox( REF, "bulletimpacts", "Client-Side Bullet Impacts", false )
SHOW_CLIENT:SetDescription("Show client-side bullet impacts.")
local COLOR = gui.ColorPicker( SHOW, "bulletimpacts.color", "cock", 0, 0, 255, 50 )

local bulletImpacts = {}
callbacks.Register( "Draw", function()
    if not SHOW:GetValue() then return end
    if not entities.GetLocalPlayer() then return end
    if table.getn(bulletImpacts) == 0 then return end

    if globals.CurTime() >= bulletImpacts[1][2] then
        table.remove(bulletImpacts, 1)
    end

    for i = 1, #bulletImpacts do
        local vecBullet = bulletImpacts[i][1]

        local topLeftBottomX, topLeftBottomY = client.WorldToScreen( vecBullet + Vector3(2, -2, 2) )
        local topLeftTopX, topLeftTopY = client.WorldToScreen( vecBullet + Vector3(-2, -2, 2) )
        local topRightBottomX, topRightBottomY = client.WorldToScreen( vecBullet + Vector3(2, 2, 2) )
        local topRightTopX, topRightTopY = client.WorldToScreen( vecBullet + Vector3(-2, 2, 2) )

        local botLeftBottomX, botLeftBottomY = client.WorldToScreen( vecBullet + Vector3(2, -2, -2) )
        local botLeftTopX, botLeftTopY = client.WorldToScreen( vecBullet + Vector3(-2, -2, -2) )
        local botRightBottomX, botRightBottomY = client.WorldToScreen( vecBullet + Vector3(2, 2, -2) )
        local botRightTopX, botRightTopY = client.WorldToScreen( vecBullet + Vector3(-2, 2, -2) )

        if topLeftBottomX == nil or topLeftTopX == nil or topRightBottomX == nil or topRightTopX == nil or botLeftBottomX == nil or botLeftTopX == nil or botRightBottomX == nil or botRightTopX == nil then 
            goto continue 
        end

        draw.Color( 0, 0, 0, 100)
        draw.Line( topLeftBottomX, topLeftBottomY, topLeftTopX, topLeftTopY )
        draw.Line( topLeftTopX, topLeftTopY, topRightTopX, topRightTopY )
        draw.Line( topRightTopX, topRightTopY, topRightBottomX, topRightBottomY )
        draw.Line( topRightBottomX, topRightBottomY, topLeftBottomX, topLeftBottomY )
        draw.Line( botLeftBottomX, botLeftBottomY, botLeftTopX, botLeftTopY )
        draw.Line( botLeftTopX, botLeftTopY, botRightTopX, botRightTopY )
        draw.Line( botRightTopX, botRightTopY, botRightBottomX, botRightBottomY )
        draw.Line( botRightBottomX, botRightBottomY, botLeftBottomX, botLeftBottomY )
        draw.Line( topLeftBottomX, topLeftBottomY, botLeftBottomX, botLeftBottomY )
        draw.Line( topLeftTopX, topLeftTopY, botLeftTopX, botLeftTopY )
        draw.Line( topRightTopX, topRightTopY, botRightTopX, botRightTopY )
        draw.Line( topRightBottomX, topRightBottomY, botRightBottomX, botRightBottomY )

        draw.Color( COLOR:GetValue() )  
        draw.Triangle( topLeftTopX, topLeftTopY, botLeftTopX, botLeftTopY, botLeftBottomX, botLeftBottomY )
        draw.Triangle( topLeftTopX, topLeftTopY, topLeftBottomX, topLeftBottomY, botLeftBottomX, botLeftBottomY )
        draw.Triangle( topRightTopX, topRightTopY, botRightTopX, botRightTopY, botRightBottomX, botRightBottomY )
        draw.Triangle( topRightTopX, topRightTopY, topRightBottomX, topRightBottomY, botRightBottomX, botRightBottomY )
        draw.Triangle( topLeftTopX, topLeftTopY, botLeftTopX, botLeftTopY, botRightTopX, botRightTopY )
        draw.Triangle( topLeftTopX, topLeftTopY, topRightTopX, topRightTopY, botRightTopX, botRightTopY )
        draw.Triangle( topLeftBottomX, topLeftBottomY, botLeftBottomX, botLeftBottomY, botRightBottomX, botRightBottomY )
        draw.Triangle( topLeftBottomX, topLeftBottomY, topRightBottomX, topRightBottomY, botRightBottomX, botRightBottomY )
        draw.Triangle( topLeftTopX, topLeftTopY, topLeftBottomX, topLeftBottomY, topRightBottomX, topRightBottomY )
        draw.Triangle( topLeftTopX, topLeftTopY, topRightTopX, topRightTopY, topRightBottomX, topRightBottomY )
        draw.Triangle( botLeftTopX, botLeftTopY, botLeftBottomX, botLeftBottomY, botRightBottomX, botRightBottomY )
        draw.Triangle( botLeftTopX, botLeftTopY, botRightTopX, botRightTopY, botRightBottomX, botRightBottomY )

        ::continue::
    end
end )

callbacks.Register( "FireGameEvent", function(event)
    if event:GetName() ~= "bullet_impact" then return end
    if not SHOW:GetValue() then return end
    if client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) ) ~= client.GetLocalPlayerIndex() then return end
    table.insert(bulletImpacts, {Vector3(event:GetFloat("x"), event:GetFloat("y"), event:GetFloat("z")), globals.CurTime() + 4})
end )
client.AllowListener( "bullet_impact" )

callbacks.Register( "CreateMove", function()
    if SHOW_CLIENT:GetValue() then
        client.SetConVar( "sv_showimpacts", 2, true )
    else
        client.SetConVar( "sv_showimpacts", 0, true )
    end
end )

callbacks.Register( "Unload", function()
    client.SetConVar( "sv_showimpacts", 0, true )
end )