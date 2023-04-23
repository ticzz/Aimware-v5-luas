local ref = gui.Reference("Ragebot")
local tab = gui.Tab(ref, "jumpscout_tab", "Jumpscout")
local js_gb = gui.Groupbox(tab, "Jumpscout", 15, 15, 600,200)
local cb = gui.Checkbox(js_gb,"active", "Active", 0)
local hc = gui.Slider(js_gb, "hc", "Scout Hitchance", 50, 0, 100)
local slider = gui.Slider(js_gb, "jshc", "Jumpscout Hitchance", 50, 0, 100)

local pLocal = entities.GetLocalPlayer()
function js_fix()
    pLocal = entities.GetLocalPlayer()
    local velocity = math.sqrt(pLocal:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + pLocal:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)
    if pLocal:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_ssg08" then
        if velocity > 5 then
            gui.SetValue("misc.strafe.enable", true)
        else
            gui.SetValue("misc.strafe.enable", false)
        end
    else
        gui.SetValue("misc.strafe.enable", true)
    end
end

function js_hc(cmd)
    pLocal = entities.GetLocalPlayer()
    local flags = pLocal:GetPropInt("m_fFlags")
    if flags ~= nil then
        if cb:GetValue() == true then
            if pLocal:GetPropEntity("m_hActiveWeapon"):GetName():lower() == "weapon_ssg08" then
                if bit.band(flags, 1) == 0 then
                    -- in air
                    gui.SetValue("rbot.hitscan.accuracy.scout.hitchance", slider:GetValue())
                else
                    -- on ground
                    gui.SetValue("rbot.hitscan.accuracy.scout.hitchance", hc:GetValue())
                end
            else
                gui.SetValue("rbot.hitscan.accuracy.scout.hitchance", hc:GetValue())
            end
        end
    end
end

callbacks.Register("CreateMove", js_fix)
callbacks.Register("CreateMove", js_hc)