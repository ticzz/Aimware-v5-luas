--Variables
    --[[Log Vairiables]] logArray = {}

    --[[Needed Variables]] hurt = 0 hitboxes = {"head","body","pelvis","left arm","right arm","right leg","left leg"}

    --[[Future Variables]] bulletiPos = Vector3(1,2,3) viewAngles = Vector3(1,2,3)

				
    --[[Gui Variables]] local xx = gui.Checkbox( gui.Reference("Misc","General","Logs"), "elogging", "Enable Logging", 0 ) 
    local xy = gui.Multibox( gui.Reference("Misc","General","Logs"), "Logging Filter" ) 
    local yx = gui.Checkbox( xy, "hit.log", "Hit Log", 0 ) 
    local yy = gui.Checkbox( xy, "buy.log", "Buy Log", 0 ) 
    local yz = gui.Checkbox( xy, "miss.log", "Miss Log", 0 ) 
    local zz = gui.Checkbox( gui.Reference("Misc","General","Logs"), "meme.miss", "Meme Miss Reasons", 0 ) 
    local zzx = gui.Checkbox( gui.Reference("Misc","General","Logs"), "debug.info", "Add Debug Info", 0 ) 
    local zzz = gui.ColorPicker(gui.Reference("Misc","General","Logs") , "log.colour.picker", "Log Colour Picker", 255, 255, 255, 255 ) 
	local zzz2 = gui.ColorPicker(gui.Reference("Misc","General","Logs") , "log.shadow.colour.picker", "LogShadow Colour Picker", 255, 255, 255, 255 ) 
    local zzxc = gui.Slider( gui.Reference("Misc","General","Logs"), "log.expir", "Log Expiration", 3.7, 0, 5,0.1 )

	local i2=gui.Editbox( gui.Reference("Misc","General","Logs"), "log.font.name", "Font Name" )
	i2:SetDescription("Type in the Name of the font u want to use")
	local oo = gui.Slider( gui.Reference("Misc","General","Logs"),"log.fontsize.slider","Font Size",5,5,25)

	local k=gui.Button( gui.Reference("Misc","General","Logs"),"Apply Font",function()font=draw.CreateFont(i2:GetValue(),oo:GetValue(),1200)end)
	--[[Draw Variables]] 
	local font = draw.CreateFont("Verdana",18,1200)
	draw.SetFont(font)
	lastDis = globals.CurTime()

--[[Call This whenever u want to clear the tables]] function clearTables() logArray = {} end

--[[Call this to get your velocity]] local function velocityf() return math.sqrt(entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" )^2) end

--[[Call This to add a log]] function addLog(Text) table.insert( logArray, Text) end

--[[Initial Setup]] gui.SetValue( "misc.log.damage.enemy", 0 ) gui.SetValue( "misc.log.damage.friendly", 0 ) gui.SetValue( "misc.log.damage.local", 0 ) gui.SetValue( "misc.log.purchases", 0 ) gui.SetValue( "misc.log.console", 0 ) gui.Reference("Misc","General","Logs","Log Damage"):SetDisabled(1) gui.Reference("Misc","General","Logs","Log Purchases"):SetDisabled(1) gui.Reference("Misc","General","Logs","Log Console"):SetDisabled(1) gui.Reference("Misc","General","Logs","Log Damage"):SetInvisible(1) gui.Reference("Misc","General","Logs","Log Purchases"):SetInvisible(1) gui.Reference("Misc","General","Logs","Log Console"):SetInvisible(1)

--[[Miss shot log meme stuff]] mememiss = {"spread","polak's resolver lmao","your parents inbreeding","religion","uid issue","brain issue","server issue","Gaben stealing the bullets","enemy serversiding","enemy using godmode", "config issue","skin colour","virginity","niggers","the bullet getting used as a buttplug instead"} function randommeme() i = math.random(1,#mememiss) return mememiss[i] end

--[[Listener stuff]] client.AllowListener("weapon_fire") client.AllowListener("player_death") client.AllowListener("player_hurt") client.AllowListener("item_purchase") client.AllowListener("bullet_impact") client.AllowListener("player_disconnect")

--Event Callback
callbacks.Register( "FireGameEvent","EventHook", function(e)
    local En = e:GetName()
    if not xx:GetValue() then return end
    --Checks if the event name is player_hurt

    if En == "player_hurt" then
        

        if yx:GetValue() then addLog("[aimware] "..entities.GetByUserID(e:GetInt('attacker')):GetName().." did "..e:GetInt("dmg_health").." damage to "..client.GetPlayerNameByUserID(e:GetInt("userid")).." and they have "..e:GetInt("health").." hp left they were shot on their "..hitboxes[e:GetInt("hitgroup")].." using a "..string.gsub( e:GetString("weapon"),"weapon_","" )) end
        if client.GetPlayerNameByUserID(e:GetInt("attacker")) ~= entities.GetLocalPlayer():GetName() then return end
        hurt = 1
    end

    --Checks if the event name is weapon_fire
    if En == "weapon_fire" then
        if hurt == 1 then hurt = 0 return end
        if client.GetPlayerNameByUserID(e:GetInt("userid")) ~= entities.GetLocalPlayer():GetName() then return end if entities.GetLocalPlayer():GetWeaponType() == 0 then return end
        local accuracyy = 100-(entities.GetLocalPlayer():GetWeaponInaccuracy()*100)
        local player = entities.GetLocalPlayer();
        local src = player:GetAbsOrigin() + player:GetPropVector( "localdata", "m_vecViewOffset[0]" );
        if not yz:GetValue() then return end
        local dst = src + engine.GetViewAngles():Forward() * 100000;
        local tr = engine.TraceLine( src, dst, 0xFFFFFFF1 );
        --If your accuracy is lower than 85 or equal to then the miss reason is spread 1
        --We cant know if its the resolver but we CAN see if it is the spread by doing multiple checks
        if accuracyy <= 85 then
            if not zz:GetValue() and not zzx:GetValue() then addLog(" - missed shot due to spread (low accuracy)") end
            if zz:GetValue() and not zzx:GetValue() then addLog("[aimware] missed shot due to "..randommeme()) end
            if not zz:GetValue() and zzx:GetValue() then addLog("[Debug] - missed shot due to spread [low accuracy] | Accuracy : "..math.floor(accuracyy).."% | Velocity : "..math.floor(velocityf()).." u/s | Viewangles : "..math.floor(viewAngles.y).." "..math.floor(viewAngles.x)) end
            if zz:GetValue() and zzx:GetValue() then addLog("[aimware] missed shot due to "..randommeme().."| Accuracy : "..math.floor(accuracyy).."% | Velocity : "..math.floor(velocityf()).." u/s | Viewangles : "..math.floor(viewAngles.y).." "..math.floor(viewAngles.x)) end
        else
            --If your velocity is too high then u missed due to spread 2
            if math.sqrt(entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" )^2) >= 165 then
                if not zz:GetValue() and not zzx:GetValue() then addLog(" - missed shot due to spread (velocity)") end
                if zz:GetValue() and not zzx:GetValue() then addLog("[aimware] missed shot due to "..randommeme()) end
                if not zz:GetValue() and zzx:GetValue() then addLog("[Debug] - missed shot due to spread (velocity) | Accuracy : "..math.floor(accuracyy).."% | Velocity : "..math.floor(velocityf()).." u/s | Viewangles : "..math.floor(viewAngles.y).." "..math.floor(viewAngles.x)) end
                if zz:GetValue() and zzx:GetValue() then addLog("[aimware] missed shot due to "..randommeme().."| Accuracy : "..math.floor(accuracyy).."% | Velocity : "..math.floor(velocityf()).." u/s | Viewangles : "..math.floor(viewAngles.y).." "..math.floor(viewAngles.x)) end
            else
                --If the client-side and server-side impacts are way off the miss reason is spread 3
                if tr.endpos.y - bulletiPos.y > 100 or tr.endpos.x - bulletiPos.x > 100 or tr.endpos.y - bulletiPos.y < -100 or tr.endpos.x - bulletiPos.x < -100 then
                    if not zz:GetValue() and not zzx:GetValue() then addLog(" - missed shot due to spread (cl/sv not match)") end
                    if zz:GetValue() and not zzx:GetValue() then addLog("[aimware] missed shot due to "..randommeme()) end
                    if not zz:GetValue() and zzx:GetValue() then addLog("[Debug] - missed shot due to spread (3) | Accuracy : "..math.floor(accuracyy).."% | Velocity : "..math.floor(velocityf()).." u/s | Viewangles : "..math.floor(viewAngles.y).." "..math.floor(viewAngles.x)) end
                    if zz:GetValue() and zzx:GetValue() then addLog("[aimware] missed shot due to "..randommeme().."| Accuracy : "..math.floor(accuracyy).."% | Velocity : "..math.floor(velocityf()).." u/s | Viewangles : "..math.floor(viewAngles.y).." "..math.floor(viewAngles.x)) end
                else
                    if not zz:GetValue() and not zzx:GetValue() then addLog(" - missed shot due to resolver") end
                    if zz:GetValue() and not zzx:GetValue() then addLog("[aimware] missed shot due to "..randommeme()) end
                    if not zz:GetValue() and zzx:GetValue() then addLog("[Debug] - missed shot due to resolver | Accuracy : "..math.floor(accuracyy).."% | Velocity : "..math.floor(velocityf()).." u/s | Viewangles : "..math.floor(viewAngles.y).." "..math.floor(viewAngles.x)) end
                    if zz:GetValue() and zzx:GetValue() then addLog("[aimware] missed shot due to "..randommeme().."| Accuracy : "..math.floor(accuracyy).."% | Velocity : "..math.floor(velocityf()).." u/s | Viewangles : "..math.floor(viewAngles.y).." "..math.floor(viewAngles.x)) end
                end
            end
        end
    end

    --Checks if the event name is player_death

    if En == "player_death" then
    end

    --Checks if the event name is item_purchase

    if En == "item_purchase" then
        if yy:GetValue() then addLog("[aimware] "..client.GetPlayerNameByIndex(entities.GetByUserID(e:GetInt("userid")):GetIndex()).." has bought a "..string.gsub( e:GetString("weapon"),"weapon_","" )) end
    end

    --Checks if the event name is bullet_impact

    if En == "bullet_impact" then
        if client.GetPlayerNameByUserID(e:GetInt("userid")) ~= entities.GetLocalPlayer():GetName() then return end
        --Gets where the bullet landed
        bulletiPos = Vector3(e:GetFloat("x"),e:GetFloat("y"),e:GetFloat("z"))
    end
end)

--CUserCmd Callback
callbacks.Register( "CreateMove","CreateMoveHook", function(cmd)
    --This gets the viewangles every cusercmd so we can get it instantly when we need it :)
    viewAngles = Vector3(cmd.viewangles.x,cmd.viewangles.y,cmd.viewangles.z)
end)

--Draw Callback
callbacks.Register( "Draw", "DrawHook", function()
  draw.SetFont(font)
    for i=1,#logArray do
         draw.Color(zzz:GetValue())
draw.Text( 25, 20*i, logArray[i])
		 draw.Color(zzz2:GetValue())
draw.TextShadow( 25, 20*i, logArray[i])
    end
    if En == "player_disconnect" then clearTables() end

	if globals.CurTime() - zzxc:GetValue() >= lastDis and #logArray ~= (0 or nil) then
        lastDis = globals.CurTime()
        table.remove( logArray, 1)
        if globals.CurTime() - 1 >= lastDis then
        table.remove( logArray, 2)
        end
    end
    if #logArray >= 9 then
        for i=1,4 do
            table.remove( logArray,i)
        end
    end
end)

--Unload Callback
callbacks.Register( "Unload", function()
    gui.Reference("Misc","General","Logs","Log Damage"):SetInvisible(0)
    gui.Reference("Misc","General","Logs","Log Purchases"):SetInvisible(0)
    gui.Reference("Misc","General","Logs","Log Console"):SetInvisible(0)
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

