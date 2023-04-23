
local shotlogger = 
{
    size        = 3;
    timetolast  = 5;
    waittime    = 4.5,
}

local shotdata = {}


local function clear_data()
    shotdata = {}
end

local function is_even(num)
    if num % 2 == 0 then
        return true
    else
        return false
    end
end

local function hitshit(e)
	if entities.GetLocalPlayer() == nil then 
		return 
	end

	if e:GetName() ~= "player_hurt" then 
		return
	end

	if not (client.GetPlayerIndexByUserID(e:GetInt("attacker")) == client.GetLocalPlayerIndex() and client.GetPlayerIndexByUserID(e:GetInt("userid")) ~= client.GetLocalPlayerIndex()) then
		return
	end

    shotdata[#shotdata + 1] = 
    {
        fadewait    = 1;
        fadeanim    = 1;
        animtime    = 1;
        pos         = entities.GetByUserID(e:GetInt("userid")):GetHitboxPosition(hitGroup);
        damage      = e:GetInt("dmg_health");
        nigga_x     = 1;
        nigga_y     = 1;
        thing       = 1;
        velocity    = 0;
        velocity_x  = 0;
        shotnum     = 0;
    }

    for i, v in pairs(shotdata) do
        v.shotnum = v.shotnum + 1
    end

end

callbacks.Register("FireGameEvent", hitshit)

callbacks.Register("Draw", function()

    if entities.GetLocalPlayer() == nil then 
        clear_data()
		return 
	end

    for i, v in pairs(shotdata) do
        if shotdata[i]["animtime"] < 0 then
            shotdata[i] = nil
            goto continue
        end

        local x_hit, y_hit = client.WorldToScreen(v.pos);

        shotdata[i]["animtime"] = shotdata[i]["animtime"] - ((1.5 / shotlogger["timetolast"]) * globals.FrameTime())
        shotdata[i]["fadewait"] = shotdata[i]["fadewait"] - ((1.5 / shotlogger["waittime"]) * globals.FrameTime())

        if shotdata[i]["fadewait"] < 0 then
            shotdata[i]["fadeanim"] = shotdata[i]["fadeanim"] - ((1.5 / (shotlogger["timetolast"] - shotlogger["waittime"])) * globals.FrameTime())
            if shotdata[i]["fadeanim"] <= 0 then
                shotdata[i]["fadeanim"] = 0
            end
        end
        
        local alpha = math.floor(255 * shotdata[i]["fadeanim"])

        v.velocity_x = v.velocity_x + 10 * globals.FrameTime()
        
        v.velocity = v.velocity + 2000 * globals.FrameTime()
        v.thing = v.thing + 4 * globals.FrameTime()

        if v.thing <= 2 then
            v.velocity = -200
        end

        v.nigga_y = v.nigga_y + v.velocity * globals.FrameTime()

        if not is_even(v.shotnum) then
            v.nigga_x = v.nigga_x + v.velocity_x * globals.FrameTime()
        else
            v.nigga_x = v.nigga_x - v.velocity_x * globals.FrameTime()
        end

        draw.Color(255, 255, 255, alpha)

        local dmg = tostring(v.damage)

        draw.Text(x_hit + v.nigga_x, y_hit + v.nigga_y, dmg)

        ::continue::
    end

end)