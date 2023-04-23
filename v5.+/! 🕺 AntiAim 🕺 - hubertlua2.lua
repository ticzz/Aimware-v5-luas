localVersion = "0.11"
githubVersion = http.Get("https://raw.githubusercontent.com/ObamaAteMyKids/hubertlua2/main/version.txt")

if githubVersion then
    if githubVersion ~= localVersion then
        print("Updating Lua...")
        file.Delete(GetScriptName())
        file.Write(GetScriptName(), http.Get("https://raw.githubusercontent.com/ObamaAteMyKids/hubertlua2/main/hubertlua2.lua"))
        localVersion = githubVersion
        print("Updated Lua!")
        return
    end
end

local Gui = {
    customAAItems = {};
    visualItems = {};
    Init = function(self)
        local rageRef = gui.Reference("Ragebot")
        local rageTab = gui.Tab(rageRef, "hubertlua.tab", "HubertLua")
        local aaRef = gui.Groupbox(rageTab, "Anti-Aim", 15, 15, 297, 300)
        local visualsRef = gui.Groupbox(rageTab, "Visuals", 327, 15, 297, 300)

        self.aaMode = gui.Combobox(aaRef, "hubertlua.mode", "Mode", "Recommended", "Custom")

        self.customAAItems.yawSlider = gui.Slider(aaRef, "hubertlua.yaw", "Yaw", 180, -180, 180)
        self.customAAItems.flickYawSlider = gui.Slider(aaRef, "hubertlua.flickyaw", "Flick Yaw", 160, -180, 180)

        self.customAAItems.desyncSlider = gui.Slider(aaRef, "hubertlua.desync", "Desync", -58, -58, 58)
        self.customAAItems.flickDesyncSlider = gui.Slider(aaRef, "hubertlua.flickdesync", "Flick desync", -58, -58, 58)

        self.customAAItems.modeCombobox = gui.Combobox(aaRef, "hubertlua.desyncmode", "Desync Mode", "Desync", "Desync Jitter")
        self.customAAItems.flickModeCombobox = gui.Combobox(aaRef, "hubertlua.flickdesyncmode", "Flick Desync Mode", "Desync", "Desync Jitter")

        self.customAAItems.pitchBox = gui.Combobox(aaRef, "hubertlua.pitch", "Pitch", "Off", "89", "0", "180 (Untrusted)")
        self.customAAItems.flickPitchBox = gui.Combobox(aaRef, "hubertlua.flickpitch", "Flick Pitch", "Off", "89", "0", "180 (Untrusted)")

        self.customAAItems.flickSlider = gui.Slider(aaRef, "hubertlua.whentoflick", "When to flick", 10, 0, 100)

        self.customAAItems.invertFlickCheckbox = gui.Checkbox(aaRef, "hubertlua.invertonflick", "Invert Flick", true)
        self.customAAItems.invertFlickCheckbox:SetDescription("Invert Flick everytime it flicks")

        self.visualItems.indicatorsCheckbox = gui.Checkbox(visualsRef, "hubertlua.indicators", "Indicators", false)
        self.visualItems.hitmarkerMultiCombobox = gui.Multibox(visualsRef, "Hitmarker")

        self.visualItems.hitmarkerScreenCheckbox = gui.Checkbox(self.visualItems.hitmarkerMultiCombobox, "hubertlua.screenhitmarker", "Screen Hitmarker", false)
        self.visualItems.hitmarkerScreenColorpicker = gui.ColorPicker(self.visualItems.hitmarkerScreenCheckbox, "hubertlua.screenhitmarkercolor", "", 255, 255, 255, 255)
        self.visualItems.hitmarkerScreenHSColorpicker = gui.ColorPicker(self.visualItems.hitmarkerScreenCheckbox, "hubertlua.screenhitmarkerhscolor", "", 220, 60, 40, 255)

        self.visualItems.hitmarkerWorldCheckbox = gui.Checkbox(self.visualItems.hitmarkerMultiCombobox, "hubertlua.worldhitmarker", "World Hitmarker", false)
        self.visualItems.hitmarkerWorldColorpicker = gui.ColorPicker(self.visualItems.hitmarkerWorldCheckbox, "hubertlua.worldhitmarkercolor", "", 255, 255, 255, 255)
        self.visualItems.hitmarkerWorldHSColorpicker = gui.ColorPicker(self.visualItems.hitmarkerWorldCheckbox, "hubertlua.worldhitmarkerhscolor", "", 220, 60, 40, 255)
    end;

    OnDraw = function(self)
        local mode = self.aaMode:GetValue()

        for k, v in pairs(self.customAAItems) do
            if mode == 1 then
                v:SetInvisible(false)
                self.customAAItems.flickSlider:SetDescription("Flicks every ".. self.customAAItems.flickSlider:GetValue() .." miliseconds")
            else
                v:SetInvisible(true)
            end
        end
    end;
}

local globalCurtime = globals.CurTime();

function ShouldFlick(whenToFlick)
    if globals.CurTime() <= 0 then
        return false
    end

    if globals.CurTime() - globalCurtime >= whenToFlick then
        globalCurtime = globals.CurTime()
        return true
    end

    return false
end

local side = -1
flicked = false

local AntiAim = {
    Init = function()
        local yaw = 180
        local pitch = 1
        local flickYaw = 90
        local flickPitch = 1
        local whenToFlick = 0.12
        local invertFlick = true
        local desyncMode = " Desync"
        local desync = -58;
        local flickDesyncMode = " Desync"
        local flickDesync = -58;

        if Gui.aaMode:GetValue() == 1 then
            yaw = Gui.customAAItems.yawSlider:GetValue()
            pitch = Gui.customAAItems.pitchBox:GetValue()
            flickYaw = Gui.customAAItems.flickYawSlider:GetValue()
            flickPitch = Gui.customAAItems.flickPitchBox:GetValue()
            whenToFlick = Gui.customAAItems.flickSlider:GetValue() / 100
            invertFlick = Gui.customAAItems.invertFlickCheckbox:GetValue()
            desync = Gui.customAAItems.desyncSlider:GetValue()
            desyncMode = Gui.customAAItems.modeCombobox:GetValue() == 1 and " Desync Jitter" or " Desync"
        else
            if entities.GetLocalPlayer() then
                local flags = entities.GetLocalPlayer():GetProp("m_fFlags")
                local squareRoot = math.sqrt
                local x = entities.GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[0]")
                local y = entities.GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[1]")
                local velocityLength2D = squareRoot(x^2 + y^2)

                if flags == 256 or flags == 262 then --idfk how to use bitwise operators in lua
                    flickYaw = 160
                elseif velocityLength2D >= 10 then
                    desyncMode = " Desync Jitter"
                    desync = -16
                    flickYaw = 70
                end
            end
        end

        -------------------------------

        local finalYaw = yaw
        local finalPitch = pitch
        local finalDesync = desync
        local finalDesyncMode = desyncMode

        if globalCurtime > globals.CurTime() then
            globalCurtime = globals.CurTime()
        end

        flicked = false

        if ShouldFlick(whenToFlick) then
            if invertFlick then
                side = -side
            end
            finalYaw = flickYaw * side
            finalPitch = flickPitch
            finalDesync = flickDesync
            finalDesyncMode = flickDesyncMode
            flicked = true
        end

        gui.SetValue("rbot.antiaim.base", tostring(finalYaw) ..finalDesyncMode)
        gui.SetValue("rbot.antiaim.base.rotation", finalDesync)
        gui.SetValue("rbot.antiaim.advanced.pitch", finalPitch)
    end;
}

function Clamp(number, min, max)
    return number < min and min or number > max and max or number
end

attacked = false
attackedHS = false
hitTime = 0
headShot = false
finalAlpha = 0

local hits = {
}

OnFireGameEvent = function(event)

    if not Gui.visualItems.hitmarkerScreenCheckbox:GetValue() and not Gui.visualItems.hitmarkerWorldCheckbox:GetValue() then
        return
    end

    if not entities.GetLocalPlayer() then
        return
    end

    if not entities.GetLocalPlayer():IsAlive() then
        return
    end

    if event == nil then
        return
    end

    if event:GetName() == "player_hurt" then
        attacked = false
        local localPlayerIndex = client.GetLocalPlayerIndex()
        local attackerIndex = client.GetPlayerIndexByUserID(event:GetInt("attacker"))

        if attackerIndex == localPlayerIndex then
            attacked = true
            hitTime = globals.RealTime()

            headShot = event:GetInt("hitgroup") == 1

            if Gui.visualItems.hitmarkerWorldCheckbox:GetValue() then
                if not hits[#hits + 1] then
                    hits[#hits + 1] = {}
                end
                local latestHit = hits[#hits]

                local hitPos = entities.GetByUserID(event:GetInt("userid")):GetHitboxPosition(event:GetInt("hitgroup"))
                latestHit.worldPosX = hitPos.x
                latestHit.worldPosY = hitPos.y
                latestHit.worldPosZ = hitPos.z
                latestHit.hitTime = globals.RealTime()
                latestHit.finalAlpha = 0
                latestHit.attacked = true
                latestHit.headShot = event:GetInt("hitgroup") == 1
            end
        end
    end
end

client.AllowListener("player_hurt")

fpsVal = 0

local fonts = {
    indicator_font = draw.CreateFont("Verdana", 14)
};

local Visuals = {

    sizes = { --we dont wanna rape fps :)
        luaSize = draw.GetTextSize("Lua"),
        hubertSize = draw.GetTextSize("Hubert"),
        desyncSize = draw.GetTextSize("Desync: 58"),
        flickedSize = draw.GetTextSize("Flick"),
    }; --doesnt use correct font but accurate enough and better than calling GetTextSize every frame

    scopeOffset = 0;

    Indicators = function(self)

        if not entities.GetLocalPlayer():IsAlive() then
            return
        end

        if not Gui.visualItems.indicatorsCheckbox:GetValue() then
            return
        end

        screenWidth, screenHeight = draw.GetScreenSize()

        local hubertWidth, hubertHeight = self.sizes.hubertSize
        local luaWidth, luaHeight = self.sizes.luaSize
        local desyncWidth,  desyncHeight = self.sizes.desyncSize
        local flickedWidth, flickedHeight = self.sizes.flickedSize

        local isScoped = entities.GetLocalPlayer():GetPropBool("m_bIsScoped")
        local offset = 45

        if isScoped then
            self.scopeOffset = self.scopeOffset + 5 * fpsVal
        else
            self.scopeOffset = self.scopeOffset - 5 * fpsVal
        end

        self.scopeOffset = Clamp(self.scopeOffset, 0, 50)

        draw.Color(255, 255, 255, 255)
        draw.TextShadow(screenWidth / 2 - math.floor(hubertWidth / 2) - math.floor(luaWidth / 2) + self.scopeOffset, screenHeight / 2 + offset, "Hubert")

        draw.Color(220, 60, 40, 255)
        draw.TextShadow(screenWidth / 2 + math.floor(hubertWidth / 2) - math.floor(luaWidth / 2) - 1 + self.scopeOffset, screenHeight / 2 + offset, "Lua")
        offset = offset + 15

        local desyncAmount = "Desync: ".. gui.GetValue("rbot.antiaim.base.rotation")

        draw.Color(255, 255, 255, 255)
        draw.TextShadow(screenWidth / 2 - math.floor(desyncWidth / 2) + self.scopeOffset, screenHeight / 2 + offset, desyncAmount)
        offset = offset + 15

        local flick = "Flick"
        local flickedColor = not flicked and {255, 255, 255, 255} or {220, 60, 40, 255}

        draw.Color(flickedColor[1], flickedColor[2], flickedColor[3], flickedColor[4])
        draw.TextShadow(screenWidth / 2 - math.floor(flickedWidth / 2) + self.scopeOffset, screenHeight / 2 + offset, flick)
        offset = offset + 15
    end;

    Hitmarker = function()
        if not entities.GetLocalPlayer():IsAlive() then
            return
        end

        if not Gui.visualItems.hitmarkerScreenCheckbox:GetValue() and not Gui.visualItems.hitmarkerWorldCheckbox:GetValue() then
            return
        end

        if attacked then
            if Gui.visualItems.hitmarkerScreenCheckbox:GetValue() then
                local r, g, b, a = Gui.visualItems.hitmarkerScreenColorpicker:GetValue()

                if headShot then
                    r, g, b, a = Gui.visualItems.hitmarkerScreenHSColorpicker:GetValue()
                end

                if globals.RealTime() - hitTime >= 0.5 then
                    finalAlpha = finalAlpha - 10 * fpsVal
                else
                    finalAlpha = finalAlpha + 10 * fpsVal
                end

                finalAlpha = Clamp(finalAlpha, 0, Gui.visualItems.hitmarkerScreenColorpicker:GetValue())

                if finalAlpha == 0 then
                    attacked = false
                end

                draw.Color(r, g, b, finalAlpha)
                draw.Line(screenWidth / 2 - 10 * finalAlpha / 255, screenHeight / 2 - 10 * finalAlpha / 255,
                          screenWidth / 2 + 10 * finalAlpha / 255, screenHeight / 2 + 10 * finalAlpha / 255)

                draw.Line(screenWidth / 2 - 10 * finalAlpha / 255, screenHeight / 2 + 10 * finalAlpha / 255, 
                          screenWidth / 2 + 10 * finalAlpha / 255, screenHeight / 2 - 10 * finalAlpha / 255)
            end
        end

        if Gui.visualItems.hitmarkerWorldCheckbox:GetValue() then
            for k, v in pairs(hits) do
                if v.attacked then
                    local r, g, b, a = Gui.visualItems.hitmarkerWorldColorpicker:GetValue()

                    if v.headShot then
                        r, g, b, a = Gui.visualItems.hitmarkerWorldHSColorpicker:GetValue()
                    end

                    if globals.RealTime() - v.hitTime >= 0.5 then
                        v.finalAlpha = v.finalAlpha - 10 * fpsVal
                    else
                        v.finalAlpha = v.finalAlpha + 10 * fpsVal
                    end

                    v.finalAlpha = Clamp(v.finalAlpha, 0, Gui.visualItems.hitmarkerScreenColorpicker:GetValue())

                    if v.finalAlpha == 0 then
                        table.remove(v, k)
                        v.attacked = false
                    end

                    local ScreenPos = {client.WorldToScreen(Vector3(v.worldPosX, v.worldPosY, v.worldPosZ))}

                    draw.Color(0, 0, 0, v.finalAlpha)
                    draw.OutlinedCircle(ScreenPos[1], ScreenPos[2], 10 * (v.finalAlpha / 255.0))

                    draw.Color(r, g, b, v.finalAlpha)
                    draw.OutlinedCircle(ScreenPos[1], ScreenPos[2], 10.5 * (v.finalAlpha / 255.0))
                    draw.OutlinedCircle(ScreenPos[1], ScreenPos[2], 11 * (v.finalAlpha / 255.0))

                    draw.Color(0, 0, 0, v.finalAlpha)
                    draw.OutlinedCircle(ScreenPos[1], ScreenPos[2], 11.5 * (v.finalAlpha / 255.0))
                end
            end
        end
    end;

    OnDraw = function(self)
        if not entities.GetLocalPlayer() then
            return
        end

        fpsVal = 200 / (1 / globals.AbsoluteFrameTime())

        draw.SetFont(fonts.indicator_font)
        self:Indicators()
        self:Hitmarker()
    end;
}

Gui:Init()

callbacks.Register("CreateMove", function()
    AntiAim.Init()
end)

callbacks.Register("Draw", function()
    Gui:OnDraw()
    Visuals:OnDraw()
end)

callbacks.Register("FireGameEvent", function(event)
    OnFireGameEvent(event)
end)