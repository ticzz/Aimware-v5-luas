--Encode

    local function dec_to_binary(data)
        local dst = ""
        local remainder, quotient

        if not data then return dst end
        if not tonumber(data) then return dst end

        if "string" == type(data) then
            data = tonumber(data)
        end

        while true do
            quotient = math.floor(data / 2)
            remainder = data % 2
            dst = dst..remainder
            data = quotient
            if 0 == quotient then
                break
            end
        end

        dst = string.reverse(dst)

        if 8 > #dst then
            for i = 1, 8 - #dst, 1 do
                dst = "0"..dst
            end
        end
        return dst
    end

    local function binary_to_dec(data)
        local dst = 0
        local tmp = 0

        if not data then return dst end
        if not tonumber(data) then return dst end

        if "string" == type(data) then
            data = tostring(tonumber(data))
        end

        if "number" == type(data) then
            data = tostring(data)
        end

        for i = #data, 1, -1 do
            tmp = tonumber(data:sub(-i, -i))
            if 0 ~= tmp then
                for j = 1, i - 1, 1 do
                    tmp = 2 * tmp
                end
            end
            dst = dst + tmp
        end
        return dst
    end

    local function base64encode(data)
        local basecode = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        local code = ""
        local dst = ""
        local tmp
        local encode_num = 0
        local num = 0
        local len = 1

        if not data then return dst end

        for i = 1, #data, 1 do
            tmp = data:byte(i)
            if 0 > tmp or 255 < tmp then
                return dst
            end
            code = code..dec_to_binary(tmp)
        end

        num = 3 - #data % 3
        if 0 < num then
            for i = 1, num, 1 do
                code = code.."00000000"
            end
        end

        encode_num = #code / 6

        for i = 1, #code, 6 do
            tmp = binary_to_dec(code:sub(i, i + 5))
            tmp = tmp + 1
            if 0 == num then
                dst = dst..basecode:sub(tmp, tmp)
                len = len + 1
                encode_num = encode_num - 1

                if 76 == len then
                    dst = dst.."\n"
                    len = 1
                end
            end

            if 0 < num then
                if encode_num == num and 1 == tmp then
                    dst = dst.."="
                    len = len + 1
                    encode_num = encode_num - 1
                    num = num - 1
                    if 76 == len then
                        dst = dst.."\n"
                        len = 1
                    end
            else
                dst = dst..basecode:sub(tmp, tmp)
                len = len + 1
                encode_num = encode_num - 1
                if 76 == len then
                    dst = dst.."\n"
                    len = 1
                end
            end
            end
        end
        return dst
    end

    local function base64decode(str64)
        local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        str64 = string.gsub(str64, '[^'..b64chars..'=]', '')
        return (str64:gsub('.', function(x)
            if (x == '=') then return '' end
            local r,f='',(b64chars:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
                return string.char(c)
        end))
    end

    local function random_string(size)
        local word = {}
        local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local chars_size = string.len(chars)
       
        for i = 1, size, 1 do
        local random_char = math.random(1, chars_size)
        word[#word + 1] = string.sub(chars, random_char, random_char)
        end
       
        return table.concat(word, "")
    end

--

--Library

    gui.Mod = function(object,x,y,w,h)
    if not object then
    return
    end
    if x then object:SetPosX(x) end
    if y then object:SetPosY(y) end
    if w then object:SetWidth(w) end
    if h then object:SetHeight(h) end
    end

    local renderer = {}

    renderer.text = function(x,y,clr,string,flags,font)
    if font then draw.SetFont(font) end
    local adjx = 0
    local adjy = 0
    if string.find(flags,"c") then
    w,h = draw.GetTextSize(string)
    adjx = w * 0.5
    end
    if string.find(flags,"v") then
    w,h = draw.GetTextSize(string)
    adjy = h * 0.5
    end
    if string.find(flags,"l") then
    w,h = draw.GetTextSize(string)
    adjx = w
    end
    if string.find(flags,"f") then
    draw.Text(math.ceil(x-adjx),math.ceil(y-adjy),string,draw.Color(clr[1],clr[2],clr[3],clr[4]))
    elseif string.find(flags,"s") then
    draw.TextShadow(math.ceil(x-adjx),math.ceil(y-adjy),string,draw.Color(clr[1],clr[2],clr[3],clr[4]))
    elseif string.find(flags,"o") then
    draw.Color(0,0,0,clr[4])
    draw.Text(math.ceil(x-adjx-1),math.ceil(y-adjy-1),string)
    draw.Text(math.ceil(x-adjx-1),math.ceil(y-adjy+1),string)
    draw.Text(math.ceil(x-adjx+1),math.ceil(y-adjy-1),string)
    draw.Text(math.ceil(x-adjx+1),math.ceil(y-adjy+1),string)
    draw.Text(math.ceil(x-adjx),math.ceil(y-adjy-1),string)
    draw.Text(math.ceil(x-adjx-1),math.ceil(y-adjy),string)
    draw.Text(math.ceil(x-adjx+1),math.ceil(y-adjy),string)
    draw.Text(math.ceil(x-adjx),math.ceil(y-adjy+1),string)
    draw.Text(math.ceil(x-adjx),math.ceil(y-adjy),string,draw.Color(clr[1],clr[2],clr[3],clr[4]))
    end
    end

    renderer.gradient_text = function(x,y,clr,clr1,str,flags,font)
    local w = 0
    local r,g,b,a = clr[1],clr[2],clr[3],clr[4]
    if font then draw.SetFont(font) end
    local string = {}
    for v = 1,#str do
    string[v] = str:sub(v,v)
    end
    for i = 1,#string do
    if flags:find("o") then
    draw.Color(0,0,0,a)
    draw.Text(x+w-1,y,string[i])
    draw.Text(x+w+1,y,string[i])
    draw.Text(x+w,y-1,string[i])
    draw.Text(x+w,y+1,string[i])
    draw.Text(x+w-1,y-1,string[i])
    draw.Text(x+w-1,y+1,string[i])
    draw.Text(x+w+1,y-1,string[i])
    draw.Text(x+w+1,y+1,string[i])
    draw.Text(x+w,y,string[i],draw.Color(r,g,b,a))
    elseif flags:find("s") then
    draw.TextShadow(x+w,y,string[i],draw.Color(r,g,b,a))
    elseif flags:find("f") then
    draw.Text(x+w,y,string[i],draw.Color(r,g,b,a))
    end
    if string[i] ~= " " then
    r = r + math.ceil((clr1[1]-clr[1])/#string)
    g = g + math.ceil((clr1[2]-clr[2])/#string)
    b = b + math.ceil((clr1[3]-clr[3])/#string)
    a = a + math.ceil((clr1[4]-clr[4])/#string)
    end
    w = w + math.ceil(draw.GetTextSize(string[i]))
    end
    end

    renderer.text_size = function(str,font)
    draw.SetFont(font)
    return draw.GetTextSize(str)
    end

    renderer.rectangle = function(x,y,w,h,clr,flags,radius)
    draw.Color(clr[1],clr[2],clr[3],clr[4])
    local w = (w<0) and (x-math.abs(w)) or x + w
    local h = (h<0) and (y-math.abs(h)) or y + h
    if flags:find("f") then
    draw.FilledRect(x,y,w,h)
    elseif flags:find("o") then
    draw.OutlinedRect(x,y,w,h)
    elseif flags:find("s") then
    draw.ShadowRect(x,y,w,h,radius or 0)
    end
    end

    renderer.gradient = function(x,y,w,h,clr,clr1,ltr)
    local abs_w = math.abs(w)
    local abs_h = math.abs(h)
    local rectangle = renderer.rectangle
    if ltr then
    if clr[4] ~= 0 then
    if clr[4] and clr1[4] ~= 255 then
    for i = 1, abs_w do
    local a1 = i / abs_w * clr[4]
    local x = (w<0) and (x+w+i-1) or (x+i-1)
    rectangle(x,y,1,h,{clr[1],clr[2],clr[3],a1},"f")
    end
    else
    rectangle(x,y,w,h,{clr[1],clr[2],clr[3],clr[4]},"f")
    end
    end
    if clr1[4] ~= 0 then
    for i = 1, abs_w do
    local a2 = i / abs_w * clr1[4]
    local x = (w<0) and (x-i) or (x+w-i)
    rectangle(x,y,1,h,{clr1[1],clr1[2],clr1[3],a2},"f")
    end
    end
    else
    if clr[4] ~= 0 then
    if clr[4] and clr1[4] ~= 255 then
    for i = 1, abs_h do
    local a1 = i / abs_h * clr[4]
    local y = (h<0) and (y+h+i-1) or (y+i-1)
    rectangle(x,y,w,1,{clr[1],clr[2],clr[3],a1},"f")
    end
    else
    rectangle(x,y,w,h,{clr[1],clr[2],clr[3],clr[4]},"f")
    end
    end
    if clr1[4] ~= 0 then
    for i = 1, abs_h do
    local a2 = i / abs_h * clr1[4]
    local y = (h<0) and (y-i) or (y+h-i)
    rectangle(x,y,w,1,{clr1[1],clr1[2],clr1[3],a2},"f")
    end
    end
    end
    end

    renderer.circle_outline = function(x, y, radius, start_degrees, percentage, thickness, clr, radian)
    draw.Color(clr[1],clr[2],clr[3],clr[4])
    local thickness = radius - thickness
    local percentage = math.abs(percentage * 360)
    local radian = radian or 1
    for i = start_degrees, start_degrees + percentage - radian, radian do
    local cos_1 = math.cos(i * math.pi / 180)
    local sin_1 = math.sin(i * math.pi / 180)
    local cos_2 = math.cos((i + radian) * math.pi / 180)
    local sin_2 = math.sin((i + radian) * math.pi / 180)
    local xa = x + cos_1 * radius
    local ya = y + sin_1 * radius
    local xb = x + cos_2 * radius
    local yb = y + sin_2 * radius
    local xc = x + cos_1 * thickness
    local yc = y + sin_1 * thickness
    local xd = x + cos_2 * thickness
    local yd = y + sin_2 * thickness
    draw.Triangle(xa, ya, xb, yb, xc, yc)
    draw.Triangle(xc, yc, xb, yb, xd, yd)
    end
    end

    renderer.circle_3d = function(pos,radius,clr,tri,line,zadd,edgee)

        local center = {client.WorldToScreen(Vector3(pos.x,pos.y,pos.z+(zadd or 0)))}
    
        local r,g,b,a = clr[1],clr[2],clr[3],clr[4]
    
        if center[1] and center[2] then
    
            local edge = (360/(edgee ~= nil and edgee or 30))
    
            local edge = math.ceil(edge*1000)*0.001
    
            for degrees = 1,edgee or 30,1 do
    
                local cur_point = nil
                local old_point = nil
    
                local pos_x1 = pos.x + math.sin(math.rad(degrees*edge)) * radius
                local pos_x2 = pos.x + math.sin(math.rad(degrees*edge-edge)) * radius
                local pos_y1 = pos.y + math.cos(math.rad(degrees*edge)) * radius
                local pos_y2 = pos.y + math.cos(math.rad(degrees*edge-edge)) * radius
    
                if pos.z then
    
                    cur_point = {client.WorldToScreen(Vector3(pos_x1,pos_y1,pos.z+(zadd or 0)))}
                    old_point = {client.WorldToScreen(Vector3(pos_x2,pos_y2,pos.z+(zadd or 0)))}
    
                end
    
                if cur_point[1] and cur_point[2] and old_point[1] and old_point[2] then
    
                    if tri == 1 then
    
                        draw.Triangle(cur_point[1],cur_point[2],old_point[1],old_point[2],center[1],center[2],draw.Color(r,g,b,a))
                    
                    end
    
                    if line == 1 then
                    
                        draw.Line(cur_point[1],cur_point[2],old_point[1],old_point[2],draw.Color(r,g,b,255))
                    
                    end
                end
            end
        end
    end

--

--Variable

    local version = "4.1.8"

    local s0x0,s0x1 = draw.GetScreenSize()
    local screen = {x=s0x0,y=s0x1}

    local aimbot_target = nil

    local font = {
         verdana13 = draw.CreateFont("Verdana",13)
        ,verdana12 = draw.CreateFont("Verdana",12)
        ,verdanab15 = draw.CreateFont("Verdana Bold",15)
        ,mini712 = draw.CreateFont("Mini 7 Condensed",14,400)
    }

    local hit_sound = {
        {"Wood stop","Wood strain","Wood plank impact","Warning",},
        {"doors\\wood_stop1","physics\\wood\\wood_strain7","physics\\wood\\wood_plank_impact_hard4","resource\\warning"}
    }

--

--Configuration

    local gui_objects = {}

    local function gui_new_object(ref,object,contents)

        local f = nil

        if object:find("checkbox") then
            f = gui.Checkbox(ref,contents[1],contents[2],contents[3])
        end

        if object:find("slider") then
            f = gui.Slider(ref,contents[1],contents[2],contents[3],contents[4],contents[5],contents[6] or 1)
        end

        if object:find("keybox") then
            f = gui.Keybox(ref,contents[1],contents[2],contents[3])
        end

        if object:find("combobox") then
            local v = gui.Combobox(ref,contents[1],contents[2],"default")
            v:SetOptions(unpack(contents[3]))
            f = v
        end

        if object:find("colorpicker") then
            f = gui.ColorPicker(ref,contents[1],contents[2],contents[3] or 255,contents[4] or 255,contents[5] or 255,contents[6] or 255)
        end

        if object:find("editbox") then
            f = gui.Editbox(ref,contents[1],contents[2])
        end

        if object:find("button") then
            gui.Button(ref,contents[1],contents[2])
        end

        if object:find("multibox") then
            gui.Multibox(ref,contents[1])
        end

        if object:find("listbox") then
            local v = gui.Listbox(ref,contents[1],contents[2])
            v:SetOptions(unpack(contents[3]))
            f = v
        end

        if f ~= nil then table.insert(gui_objects,f) end
        return f

    end

    local function converRGBA2Hex(clr)
        if #clr > 4 then return "ffffffff" end
        local str = ""
        for i = 1,#clr do
            if string.len(string.sub(string.format("%#x",clr[i]),3)) == 1 then
                str = str.."0"..string.sub(string.format("%#x",clr[i]),3)
            elseif string.len(string.sub(string.format("%#x",clr[i]),3)) == 0 then
                str = str.."00"
            else
                str = str..string.sub(string.format("%#x",clr[i]),3)
            end
        end
        return str
    end

    local function converHex2RGBA(hex)
        return tonumber("0x"..hex:sub(1,2)),tonumber("0x"..hex:sub(3,4)),tonumber("0x"..hex:sub(5,6)),tonumber("0x"..hex:sub(7,8))
    end

    local function string_handle(str)
        local output = tonumber(str)
        local string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for i = 1,#string do
            if str:find(string:sub(i,i)) then
                output = str
                if i < 7 then
                    if #str == 8 then
                        local r,g,b,a = converHex2RGBA(str)
                        output = {r,g,b,a}
                    end
                end
                break
            end
        end
        return output
    end

    local function type_handle(data)
        local output = 0
        if type(data) == "boolean" then
            return data == true and "1" or "0"
        elseif type(data) == "table" then
            return converRGBA2Hex({data[1],data[2],data[3],data[4]})
        elseif type(data) == "number" then
            return tostring(data)
        elseif type(data) == "string" then
            if data == "" then data = "blank" end
            return data
        end
    end

    local configuration_list = {}

    local function fetch_configs(filename)
        if filename:find(".dat") then
            for str in string.gmatch(file.Read(filename),"([^\n]+)") do
                if not str:split(";")[1]:find("east") then return end
                table.insert(configuration_list,filename:sub(1,-5))
                break
            end
        end
    end

    local function refresh_config(data)
        configuration_list = {}
        file.Enumerate(fetch_configs)
        data:SetOptions(unpack(configuration_list))
    end

    local function save_config(filename)
        file.Write(filename,nil)
        for i = 1,#gui_objects do
            local data = nil
            local r,g,b,a = gui_objects[i]:GetValue()
            if (g and b and a) then
                data = type_handle({r,g,b,a})
            else
                data = type_handle(gui_objects[i]:GetValue())
            end
            local str = "east-adaptive;"..base64encode(data)..";"..random_string(math.random(8,20)).."==;"..random_string(math.random(8,20)).."==\n"
            file.Open(filename,"a"):Write(str)
            file.Open(filename,"a"):Close()
        end
    end

    local configuration_data = {}

    local function load_config(filename)
        configuration_data = {}
        local fileread = file.Read(filename)
        for str in string.gmatch(fileread,"([^\n]+)") do
            configuration_data[#configuration_data+1] = string_handle(base64decode(str:split(";")[2]))
        end
        for i = 1,#configuration_data do
            if type(configuration_data[i]) ~= "table" then
                gui_objects[i]:SetValue(configuration_data[i])
            else
                local r,g,b,a = configuration_data[i][1],configuration_data[i][2],configuration_data[i][3],configuration_data[i][4]
                gui_objects[i]:SetValue(r,g,b,a)    
            end
        end
    end

    local new_tab = gui.Tab(gui.Reference("Settings"),"east-adaptive.configuration","East settings")

    local new_grp = gui.Groupbox(new_tab,"Configurations",10,10,620)

    local new_lst = gui.Listbox(new_grp,"config-list",250,"Default");refresh_config(new_lst);new_lst:SetPosX(200);new_lst:SetWidth(390)

    local edt_nme = gui.Editbox(new_grp,"Save","File path");edt_nme:SetPosY(10);edt_nme:SetWidth(180);edt_nme:SetValue("Configuration\\default.dat")

    local btn_sav = gui.Button(new_grp,"Save",function()
        if string.gsub(edt_nme:GetValue()," ","") ~= "" and string.find(edt_nme:GetValue(),".dat") then
            save_config(edt_nme:GetValue())
        else
            save_config(configuration_list[new_lst:GetValue()+1]..".dat")
        end
        refresh_config(new_lst)
    end)

    local btn_load = gui.Button(new_grp,"Load",function()
        load_config(configuration_list[new_lst:GetValue()+1]..".dat")
    end)

    local btn_delt = gui.Button(new_grp,"Delete",function()
       file.Delete(configuration_list[new_lst:GetValue()+1]..".dat")
       refresh_config(new_lst)
    end)

    local btn_ref = gui.Button(new_grp,"Refresh",function()
        refresh_config(new_lst)
    end)
--

--Gui

    local main_tab = gui.Tab(gui.Reference("Settings"),"east.tab","East version 4.1")

    local group_sel = gui.Groupbox(main_tab,"Selection",10,10,620)

    local selection = gui.Combobox(group_sel,"selection","","Aimbot","Visuals","ESP","Misc") gui.Mod(selection,90,0,400,20)

    local group_boxes = {

        {
            gui.Groupbox(main_tab,"Aimbot",10,105,305,0),
            gui.Groupbox(main_tab,"Accuracy",325,105,305,0)
        },
        {
            gui.Groupbox(main_tab,"Visuals",10,105,305,0),
            gui.Groupbox(main_tab,"Effects",325,105,305,0)
        },
        {
            gui.Groupbox(main_tab,"ESP",10,105,305,0)
        },
        {
            gui.Groupbox(main_tab,"Misc",10,105,305,0)
        }
    }
--

--Ragebot

    local function active_weapon()

        if not entities.GetLocalPlayer() then return end
        if not entities.GetLocalPlayer():IsAlive() then return end

        local active = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetName()

        if active == "weapon_taser" then
            return "Taser"
        elseif active == "weapon_hkp2000" or active == "weapon_elite" or active == "weapon_p250" or
                active == "weapon_fiveseven" or active == "weapon_glock" or active == "weapon_tec9" or
                active == "weapon_cz75a" or active == "weapon_usp_silencer" then
            return "Pistol"
        elseif active == "weapon_deagle" then
            return "Deagle"
        elseif active == "weapon_revolver" then
            return "Revolver"
        elseif active == "weapon_mac10" or active == "weapon_mp5sd" or active == "weapon_mp7" or
                active == "weapon_ump45" or active == "weapon_p90" or active == "weapon_bizon" or
                active == "weapon_mp9" then
            return "SMG"
        elseif active == "weapon_famas" or active == "weapon_m4a1" or active == "weapon_m4a1_silencer" or
                active == "weapon_ak47" or active == "weapon_ak47" or active == "weapon_sg556" or
                active == "weapon_galilar" or active == "weapon_aug" or active == "weapon_sg553" then
            return "Rifle"
        elseif active == "weapon_nova" or active == "weapon_xm1014" or active == "weapon_mag7" or
                active == "weapon_sawedoff" then
            return "Shotgun"
        elseif active == "weapon_ssg08" then
            return "Scout"
        elseif active == "weapon_scar20" or active == "weapon_g3sg1" then
            return "Auto"
        elseif active == "weapon_awp" then
            return "AWP"
        elseif active == "weapon_negev" or active == "weapon_m249" then
            return "LMG"
        else
            return "Global"
        end
    end

    local weapons = {"Global","Taser","Pistol","Deagle","Revolver","SMG","Rifle","Shotgun","Scout","Auto","AWP","LMG"}

    local aimbot = {

        general = {

             enable = gui_new_object(group_boxes[1][1],"checkbox",{"aimbot.master","Enable",0})
            ,speedburst = gui_new_object(group_boxes[1][1],"checkbox",{"aimbot.speedburst","Speed burst",0})
            ,flonshot = gui_new_object(group_boxes[1][1],"checkbox",{"aimbot.flonshot","Fake lag on shots",0})
            ,autopeek = gui_new_object(group_boxes[1][1],"combobox",{"aimbot.autopeek","Auto peek",{"Off","Retreat On Shot","+ Retreat On Key Release"}})
            ,dmgkey1 = gui_new_object(group_boxes[1][1],"checkbox",{"aimbot.dmgkey1","Minimum damage override 1",0})
            ,dmgkey2 = gui_new_object(group_boxes[1][1],"checkbox",{"aimbot.dmgkey2","Minimum damage override 2",0})
            ,hckey = gui_new_object(group_boxes[1][1],"checkbox",{"aimbot.hckey","Hitchance override",0})
            ,weapons = gui_new_object(group_boxes[1][1],"combobox",{"aimbot.weapons","Weapons",weapons})

        },

        weapon = {0,0,0,0,0,0,0,0,0,0,0,0}

    }

    aimbot.weapon[weapons[1]:lower()] = {

        enable = gui_new_object(group_boxes[1][2],"checkbox",{"accuracy.enable."..weapons[1]:lower(),"Enable",1}),

        dmg = {

             gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.def."..weapons[1]:lower(),"Minimum damage [Default]",50,1,130})
            ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.vis."..weapons[1]:lower(),"Minimum damage [Visible]",0,0,130})
            ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.war."..weapons[1]:lower(),"Minimum damage [Defensive warp fire]",0,0,130})
            ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.ke1."..weapons[1]:lower(),"Minimum damage [Override 1]",0,0,130})
            ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.ke2."..weapons[1]:lower(),"Minimum damage [Override 2]",0,0,130})
            ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.nos."..weapons[1]:lower(),"Minimum damage [No scope]",0,0,130})
            ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.air."..weapons[1]:lower(),"Minimum damage [In air]",0,0,130})
            ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.tol."..weapons[1]:lower(),"Minimum damage [Tolerance]",0,0,30})

        },

        hc = {

            gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.def."..weapons[1]:lower(),"Hitchance [Default]",50,0,100})
           ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.war."..weapons[1]:lower(),"Hitchance [Defensive warp fire]",0,0,100})
           ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.key."..weapons[1]:lower(),"Hitchance [Override]",0,0,100})
           ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.nos."..weapons[1]:lower(),"Hitchance [No scope]",0,0,100})
           ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.air."..weapons[1]:lower(),"Hitchance [In air]",0,0,100})
           ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.bur."..weapons[1]:lower(),"Hitchance [Burst]",25,0,100})

       },

       disaw = gui_new_object(group_boxes[1][1],"checkbox",{"accuracy.disaw."..weapons[1]:lower(),"Disable automatic penetration",0})

    }

    for i = 2,#aimbot.weapon do

        local v = weapons[i]

        aimbot.weapon[v:lower()] = {

            enable = gui_new_object(group_boxes[1][2],"checkbox",{"accuracy.enable."..v:lower(),"Enable",0}),

            dmg = {

                 gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.def."..v:lower(),"Minimum damage [Default]",50,1,130})
                ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.vis."..v:lower(),"Minimum damage [Visible]",0,0,130})
                ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.war."..v:lower(),"Minimum damage [Defensive warp fire]",0,0,130})
                ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.ke1."..v:lower(),"Minimum damage [Override 1]",0,0,130})
                ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.ke2."..v:lower(),"Minimum damage [Override 2]",0,0,130})
                ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.nos."..v:lower(),"Minimum damage [No scope]",0,0,130})
                ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.air."..v:lower(),"Minimum damage [In air]",0,0,130})
                ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.dmg.tol."..v:lower(),"Minimum damage [Tolerance]",0,0,30})

            },

            hc = {

                gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.def."..v:lower(),"Hitchance [Default]",50,0,100})
               ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.war."..v:lower(),"Hitchance [Defensive warp fire]",0,0,100})
               ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.key."..v:lower(),"Hitchance [Override]",0,0,100})
               ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.nos."..v:lower(),"Hitchance [No scope]",0,0,100})
               ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.air."..v:lower(),"Hitchance [In air]",0,0,100})
               ,gui_new_object(group_boxes[1][2],"slider",{"accuracy.hc.bur."..v:lower(),"Hitchance [Burst]",25,0,100})

           },
           
           disaw = gui_new_object(group_boxes[1][1],"checkbox",{"accuracy.disaw."..v:lower(),"Disable automatic penetration",0})

        }

    end

    local function is_visible()
        local is_vis = false
        local lp = entities.GetLocalPlayer()
    
        if not (lp and lp:IsAlive()) then
            return is_vis
        end
    
        local origin = lp:GetAbsOrigin()
        for k, v in pairs(entities.FindByClass("CCSPlayer")) do
            if v:IsPlayer() and v:GetTeamNumber() ~= lp:GetTeamNumber() and v:IsAlive() and not v:IsDormant() then
                for i = 0, 4 do
                    for x = 0, 4 do
                        local v = v:GetHitboxPosition(i)
                        if x == 0 then
                            v.x = v.x
                            v.y = v.y
                        elseif x == 1 then
                            v.x = v.x
                            v.y = v.y + 4
                        elseif x == 2 then
                            v.x = v.x
                            v.y = v.y - 4
                        elseif x == 3 then
                            v.x = v.x + 4
                            v.y = v.y
                        elseif x == 4 then
                            v.x = v.x - 4
                            v.y = v.y
                        end
                        if engine.TraceLine(Vector3(origin.x, origin.y, origin.z + lp:GetPropFloat("localdata", "m_vecViewOffset[2]")), v, 0x1).contents == 0 then
                            is_vis = true
                            break
                        end
                    end
                end
            end
        end
        return is_vis
    end

    local function menu_weapon(var)
        local w = var:match("%a+"):lower()
        local w = w:find("heavy") and "hpistol" or w:find("auto") and "asniper" or w:find("submachine") and "smg" or w:find("light") and "lmg" or w
        return w
    end

    local function ragebot_handle()

        if aimbot.general.enable:GetValue() then

            --Pre handle

                gui.Reference("Ragebot","Hitscan","Accuracy"):SetValue("\"Shared\"")

                local lplayer = entities.GetLocalPlayer()

                if not lplayer then
                    return
                elseif not lplayer:IsAlive() then
                    return 
                end

                local v = active_weapon():lower()

                local dmg,hc,aw = 0,0,0

                if aimbot.weapon[v].enable:GetValue() == false then

                    v = weapons[1]:lower()

                end

            --

            --Minimum damage

                local dpath = aimbot.weapon[v].dmg

                dmg = dpath[1]:GetValue()

                if dpath[2]:GetValue() ~= 0 then

                    if is_visible() then

                        dmg = dpath[2]:GetValue()

                    end
                end

                if dpath[3]:GetValue() ~= 0 then

                    if gui.GetValue("rbot.accuracy.attack."..menu_weapon(gui.GetValue("rbot.accuracy.attack"))..".fire") == '"Defensive Warp Fire"' then

                        dmg = dpath[3]:GetValue()

                    end
                end

                if dpath[4]:GetValue() ~= 0 then

                    if aimbot.general.dmgkey1:GetValue() then

                        dmg = dpath[4]:GetValue()

                    end
                end

                if dpath[6]:GetValue() ~= 0 then

                    if (active_weapon() == "Scout" or active_weapon() == "Auto" or active_weapon() == "AWP") then

                        if not lplayer:GetPropBool("m_bIsScoped") then
    
                            dmg = dpath[6]:GetValue()
    
                        end
                    end
                end

                if dpath[7]:GetValue() ~= 0 then

                    if bit.band(lplayer:GetPropInt("m_fFlags"),1) == 0 then
    
                        dmg = dpath[7]:GetValue()
    
                    end
                end

                if dpath[5]:GetValue() ~= 0 then

                    if aimbot.general.dmgkey2:GetValue() then
        
                        dmg = dpath[5]:GetValue()

                    end
                end

                gui.SetValue("rbot.hitscan.accuracy.shared.mindamage",dmg)
                gui.SetValue("rbot.hitscan.accuracy.shared.mindamagehp",dpath[8]:GetValue())

            --

            --Hitchance

                local hpath = aimbot.weapon[v].hc

                hc = hpath[1]:GetValue()

                if hpath[2]:GetValue() ~= 0 then

                    if gui.GetValue("rbot.accuracy.attack."..menu_weapon(gui.GetValue("rbot.accuracy.attack"))..".fire") == '"Defensive Warp Fire"' then

                        hc = hpath[2]:GetValue()

                    end
                end

                if hpath[3]:GetValue() ~= 0 then

                    if aimbot.general.hckey:GetValue() then

                        hc = hpath[3]:GetValue()

                    end
                end

                if hpath[4]:GetValue() ~= 0 then

                    if (active_weapon() == "Scout" or active_weapon() == "Auto" or active_weapon() == "AWP") then

                        if not lplayer:GetPropBool("m_bIsScoped") then
    
                            hc = hpath[4]:GetValue()
    
                        end
                    end
                end

                if hpath[5]:GetValue() ~= 0 then

                    if bit.band(lplayer:GetPropInt("m_fFlags"),1) == 0 then

                        hc = hpath[5]:GetValue()

                    end
                end

                gui.SetValue("rbot.hitscan.accuracy.shared.hitchance",hc)
                gui.SetValue("rbot.hitscan.accuracy.shared.hitchanceburst",hpath[6]:GetValue())

            --

            --Extra

                gui.SetValue("rbot.hitscan.accuracy.shared.autowall",1)

                if aimbot.weapon[v].disaw:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.shared.autowall",0)
                end
            --
        end
    end

    local has_weapon_fire = false

    local fakelag_on_shots = 0

    callbacks.Register("FireGameEvent",function(e)
        if aimbot.general.enable:GetValue() then
            if e:GetName() == "weapon_fire" then
                if (client.GetPlayerIndexByUserID(e:GetInt("userid")) == client.GetLocalPlayerIndex() and client.GetPlayerIndexByUserID(e:GetInt("attacker")) ~= client.GetLocalPlayerIndex()) then
                    has_weapon_fire = true
                    if aimbot.general.flonshot:GetValue() then
                        fakelag_on_shots = globals.CurTime() + 0.2
                        entities.GetLocalPlayer():SetPropFloat(0.75,"m_flPoseParameter","012")
                    end
                end
            end
        end
    end)

    local bursted,charge,timer = 0,0,0

    local function speedburst()

        if aimbot.general.enable:GetValue() then

            local lplayer = entities.GetLocalPlayer()

            if not (lplayer and lplayer:IsAlive()) then
                return
            end

            gui.SetValue("misc.speedburst.key",0)

            if aimbot.general.speedburst:GetValue() then

                gui.SetValue("misc.speedburst.enable",1)

                bursted = 0

                if has_weapon_fire then

                    if charge ~= 1 then

                        if aimbot.general.autopeek:GetValue() == 0 then

                            cheat.RequestSpeedBurst()

                            charge = 1

                            timer = globals.CurTime() + 0.1

                        end
                    end
                end

                if charge == 1 then

                    if timer < globals.CurTime() then

                        gui.SetValue("misc.speedburst.enable",0)

                    end

                    if is_visible() == false then

                        charge = 0

                    end
                end
            
            else

                if bursted == 0 then

                    cheat.RequestSpeedBurst();bursted = 1

                end

                gui.SetValue("misc.speedburst.enable",0)

            end
        end
    end

    gui.Text(group_boxes[1][1],base64decode("aHR0cHM6Ly9haW13YXJlLm5ldC9mb3J1bS91c2VyLzQ3MDY2NQ=="))

    local function is_wasd_down()
        if input.IsButtonDown(87) or input.IsButtonDown(65) or input.IsButtonDown(83) or input.IsButtonDown(68) then
            return false
        else
            return true
        end
    end

    local function quickpeek(cmd)

        if aimbot.general.enable:GetValue() then

            local lplayer = entities.GetLocalPlayer()

            if not (lplayer and lplayer:IsAlive()) then
                return
            end

            if aimbot.general.autopeek:GetValue() ~= 0 then

                if lp_abs_origin == nil then lp_abs_origin = lplayer:GetAbsOrigin() end

                renderer.circle_3d(lp_abs_origin,30,{255,0,0,65},1,1)

                if got == nil then local got = 0 end
                if move == nil then local move = 0 end
                if fire == nil then local fire = 0 end

                if has_weapon_fire then

                    fire = 1

                end

                if aimbot.general.autopeek:GetValue() == 2 then

                    if move ~= 1 then
                        if (input.IsButtonDown(87) or input.IsButtonDown(65) or input.IsButtonDown(83) or input.IsButtonDown(68)) and (got ~= 1) then
                            got = 1
                        end
                        if got == 1 then
                            if is_wasd_down() == true then
                                move = 1
                                got = 0
                            end
                        end
                    end
                end

                if move == 1 or fire == 1 then

                    local local_angle = {engine.GetViewAngles().x,engine.GetViewAngles().y,engine.GetViewAngles().z}
                    local world_forward = {
                        vector.Subtract({lp_abs_origin.x,lp_abs_origin.y,lp_abs_origin.z},{lplayer:GetAbsOrigin().x,lplayer:GetAbsOrigin().y,lplayer:GetAbsOrigin().z})
                    }
        
                    cmd.forwardmove = (((math.sin(math.rad(local_angle[2])) * world_forward[2]) + (math.cos(math.rad(local_angle[2])) * world_forward[1])) * 200)
                    cmd.sidemove = (((math.cos(math.rad(local_angle[2])) * -world_forward[2]) + (math.sin(math.rad(local_angle[2])) * world_forward[1])) * 200)

                    if aimbot.general.speedburst:GetValue() then
                        if distance == nil then distance = vector.Length(world_forward) end
                        if peek_bursted == nil then
                            if vector.Length(world_forward) < distance * 0.9 then
                                cheat.RequestSpeedBurst()
                                peek_bursted = true
                            end
                        end
                    end     
        
                    if vector.Length(world_forward) < 10 then
                        fire = 0
                        got = 0
                        move = 0
                        peek_bursted = nil
                        distance = nil
                    end
                end
            else

                lp_abs_origin = nil

            end
        end
    end

--

--Visuals

    local indicators = {

         gui_new_object(group_boxes[2][1],"checkbox",{"indicator.states","States indicator",0})

    }

    local colour = {

         autopeek = gui_new_object(aimbot.general.autopeek,"colorpicker",{"colour.autopeek","Autopeek",88,101,242,65})
        ,adaptive = gui_new_object(indicators[1],"colorpicker",{"colour.adaptive","Adaptive",88,101,242,255})

    }

    local function target_prediction()
        
        local target = "Unkown"
    
        if (entities.GetLocalPlayer() and entities.GetLocalPlayer():IsAlive()) then

            local origin = entities.GetLocalPlayer():GetAbsOrigin()

            local minimum_dis = 800

            for k,v in pairs(entities.FindByClass("CCSPlayer")) do

                if v:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and v:IsAlive() and not v:IsDormant() then

                    local f = v:GetAbsOrigin()

                    if vector.Distance({origin.x,origin.y,origin.z},{f.x,f.y,f.z}) < minimum_dis then

                        minimum_dis = vector.Distance({origin.x,origin.y,origin.z},{f.x,f.y,f.z})

                        target = v:GetName()

                    end

                    local head = engine.TraceLine(Vector3(origin.x,origin.y,origin.z+30),v:GetHitboxPosition(0),0x1).contents == 0
                    local pelvis = engine.TraceLine(Vector3(origin.x,origin.y,origin.z+30),v:GetHitboxPosition(3),0x1).contents == 0

                    if head or pelvis then

                        target = v:GetName()

                        break

                    end
                end
            end
        end

        if aimbot_target ~= nil then

            target = aimbot_target:GetName()

        end

        return target
        
    end

    local function indicator_states()

        if indicators[1]:GetValue() then

            if aimbot.general.enable:GetValue() then

                local lplayer = entities.GetLocalPlayer()

                if not (lplayer and lplayer:IsAlive()) then
                    return
                end

                local r,g,b,a = colour.adaptive:GetValue()

                local yadd = 30

                renderer.gradient_text(screen.x/2-math.floor(renderer.text_size("east-adaptive",font.verdanab15)/2),screen.y/2+20,{220,220,220,255},{r,g,b,a},"east-adaptive","cs",font.verdanab15)

                renderer.text(screen.x/2,screen.y/2+36,{220,220,220,255},target_prediction(),"sc",font.verdana13)

                if gui.GetValue("rbot.accuracy.attack."..menu_weapon(gui.GetValue("rbot.accuracy.attack"))..".fire") == '"Defensive Warp Fire"' then
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{r,g,b,a},"DWF","oc",font.mini712)
                else
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{0,0,0,a},"DWF","oc",font.mini712)
                end

                yadd = yadd + 12

                if aimbot.general.dmgkey1:GetValue() and aimbot.general.dmgkey2:GetValue() == false then
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{r,g,b,a},"DMG1","oc",font.mini712)
                elseif aimbot.general.dmgkey2:GetValue() then
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{r,g,b,a},"DMG2","oc",font.mini712)
                else
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{0,0,0,a},"DMG","oc",font.mini712)
                end

                yadd = yadd + 12

                if aimbot.general.hckey:GetValue() then
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{r,g,b,a},"HC","oc",font.mini712)
                else
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{0,0,0,a},"HC","oc",font.mini712)
                end

                yadd = yadd + 12

                if aimbot.general.speedburst:GetValue() then
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{r,g,b,a},"SPPEDBURST","oc",font.mini712)
                else
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{0,0,0,a},"SPPEDBURST","oc",font.mini712)
                end

                yadd = yadd + 12

                if aimbot.general.autopeek:GetValue() ~= 0 then
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{r,g,b,a},"QUICKPEEK","oc",font.mini712)
                else
                    renderer.text(screen.x/2,screen.y/2+20+yadd,{0,0,0,a},"QUICKPEEK","oc",font.mini712)
                end

                yadd = yadd + 12
            end
        end
    end

--

--Esp

    local esp_options = {

         gui_new_object(group_boxes[3][1],"combobox",{"esp.name","Name",{"Off","Normal","Shadow","Outlined","Gradient","Shadow gradient","Outlined gradient"}})
        ,gui_new_object(group_boxes[3][1],"combobox",{"esp.hbar","Health bar",{"Off","Normal","Outlined","Gradient","Outlined gradient"}})
        ,gui_new_object(group_boxes[3][1],"combobox",{"esp.hnum","Health number",{"Off","Normal","Shadow","Outlined"}})

    }

    local esp_colour = {
         gui_new_object(esp_options[1],"colorpicker",{"esp.name.clr","Name",220,220,220,255})
        ,gui_new_object(esp_options[1],"colorpicker",{"esp.name.clr1","Name",220,220,220,255})
        ,gui_new_object(esp_options[2],"colorpicker",{"esp.hbar.clr","Health bar",220,220,220,255})
        ,gui_new_object(esp_options[2],"colorpicker",{"esp.hbar.clr1","Health bar",220,220,220,255})
        ,gui_new_object(esp_options[3],"colorpicker",{"esp.hnum.clr","Health number",220,220,220,255})
    }

    local function draw_esp(esp)

        local lplayer = entities.GetLocalPlayer()

        if not lplayer then return end

        local entity = esp:GetEntity()

        if entity:IsAlive() and entity:IsPlayer() and entity:GetTeamNumber() ~= lplayer:GetTeamNumber() then

            local x0,y0,x1,y1 = esp:GetRect()

            local x,y,w,h = x0,y0,x1-x0,y1-y0

            if esp_options[1]:GetValue() ~= 0 then
                local r,g,b,a = esp_colour[1]:GetValue()
                local r1,g1,b1,a1 = esp_colour[2]:GetValue()
                if esp_options[1]:GetValue() == 1 then
                    renderer.text(x+(w/2),y-10,{r,g,b,a},entity:GetName(),"fc",font.verdana12)
                elseif esp_options[1]:GetValue() == 2 then
                    renderer.text(x+(w/2),y-10,{r,g,b,a},entity:GetName(),"sc",font.verdana12)
                elseif esp_options[1]:GetValue() == 3 then
                    renderer.text(x+(w/2),y-10,{r,g,b,a},entity:GetName(),"oc",font.verdana12)
                elseif esp_options[1]:GetValue() == 4 then
                    renderer.gradient_text(x+(w/2)-(renderer.text_size(entity:GetName(),font.verdana12)/2),y-10,{r,g,b,a},{r1,g1,b1,a1},entity:GetName(),"f",font.verdana12)
                elseif esp_options[1]:GetValue() == 5 then
                    renderer.gradient_text(x+(w/2)-(renderer.text_size(entity:GetName(),font.verdana12)/2),y-10,{r,g,b,a},{r1,g1,b1,a1},entity:GetName(),"s",font.verdana12)
                elseif esp_options[1]:GetValue() == 6 then
                    renderer.gradient_text(x+(w/2)-(renderer.text_size(entity:GetName(),font.verdana12)/2),y-10,{r,g,b,a},{r1,g1,b1,a1},entity:GetName(),"o",font.verdana12)
                end
            end

            if esp_options[2]:GetValue() ~= 0 then
                local r,g,b,a = esp_colour[3]:GetValue()
                local r1,g1,b1,a1 = esp_colour[4]:GetValue()
                if esp_options[2]:GetValue() == 1 then
                    renderer.rectangle(x-3,y+h-math.floor(h*(entity:GetHealth()/100)),3,math.floor(h*(entity:GetHealth()/100))+2,{r,g,b,a},"f")
                elseif esp_options[2]:GetValue() == 2 then
                    renderer.rectangle(x-4,y+h-math.floor(h*(entity:GetHealth()/100))-1,5,math.floor(h*(entity:GetHealth()/100))+2,{0,0,0,255},"o")
                    renderer.rectangle(x-3,y+h-math.floor(h*(entity:GetHealth()/100)),3,math.floor(h*(entity:GetHealth()/100))+2,{r,g,b,a},"f")
                elseif esp_options[2]:GetValue() == 3 then
                    renderer.gradient(x-3,y+h-math.floor(h*(entity:GetHealth()/100)),3,math.floor(h*(entity:GetHealth()/100)),{r,g,b,a},{r1,g1,b1,a1},nil)
                elseif esp_options[2]:GetValue() == 4 then
                    renderer.rectangle(x-4,y+h-math.floor(h*(entity:GetHealth()/100))-1,5,math.floor(h*(entity:GetHealth()/100))+2,{0,0,0,255},"o")
                    renderer.gradient(x-3,y+h-math.floor(h*(entity:GetHealth()/100)),3,math.floor(h*(entity:GetHealth()/100)),{r,g,b,a},{r1,g1,b1,a1},nil)
                end
            end

            if esp_options[3]:GetValue() ~= 0 then
                local r,g,b,a = esp_colour[5]:GetValue()
                if esp_options[3]:GetValue() == 1 then
                    renderer.text(x-2,y+h-(h*(entity:GetHealth()/100)),{r,g,b,a},tostring(entity:GetHealth()),"fc",font.verdana12)
                elseif esp_options[3]:GetValue() == 2 then
                    renderer.text(x-2,y+h-(h*(entity:GetHealth()/100)),{r,g,b,a},tostring(entity:GetHealth()),"sc",font.verdana12)
                elseif esp_options[3]:GetValue() == 3 then
                    renderer.text(x-2,y+h-(h*(entity:GetHealth()/100)),{r,g,b,a},tostring(entity:GetHealth()),"co",font.verdana12)
                end
            end
        end
    end

--

--Misc

    local misc = {
         hitsound = gui_new_object(group_boxes[4][1],"checkbox",{"misc.hitsound","Hit sound",0})
        ,hit_sound = gui_new_object(group_boxes[4][1],"combobox",{"misc.hitsound.sel","Hit sound",hit_sound[1]})
    }

    local function play_hit_sound(event)

        if misc.hitsound:GetValue() then

            local lplayer = entities.GetLocalPlayer()

            if not (lplayer and lplayer:IsAlive()) then
                return
            end

            if event:GetName() == "player_hurt" then
                if entities.GetByUserID(event:GetInt("attacker")):GetIndex() == entities.GetLocalPlayer():GetIndex() then
                    client.Command("play "..hit_sound[2][misc.hit_sound:GetValue()+1],true)
                end
            end
        end
    end
--

--Other

    local function menu_handle()

        for i = 1,#group_boxes do
            for v = 1,#group_boxes[i] do
                group_boxes[i][v]:SetInvisible(1)
            end
        end

        for i = 1,#group_boxes do
            if selection:GetValue() + 1 == i then
                for v = 1,#group_boxes[i] do
                    group_boxes[i][v]:SetInvisible(0)
                end
                aimbot.general.flonshot:SetInvisible(1)
                aimbot.general.speedburst:SetInvisible(1)
                aimbot.general.autopeek:SetInvisible(1)
                aimbot.general.dmgkey1:SetInvisible(1)
                aimbot.general.dmgkey2:SetInvisible(1)
                aimbot.general.hckey:SetInvisible(1)
                aimbot.general.weapons:SetInvisible(1)
                for v = 1,#aimbot.weapon do
                    aimbot.weapon[weapons[v]:lower()].enable:SetInvisible(1)
                    for dmg = 1,#aimbot.weapon[weapons[v]:lower()].dmg do
                        aimbot.weapon[weapons[v]:lower()].dmg[dmg]:SetInvisible(1)
                    end
                    for hc = 1,#aimbot.weapon[weapons[v]:lower()].hc do
                        aimbot.weapon[weapons[v]:lower()].hc[hc]:SetInvisible(1)
                    end
                    aimbot.weapon[weapons[v]:lower()].disaw:SetInvisible(1)
                end
                if aimbot.general.enable:GetValue() then
                    aimbot.general.flonshot:SetInvisible(0)
                    aimbot.general.speedburst:SetInvisible(0)
                    aimbot.general.autopeek:SetInvisible(0)
                    aimbot.general.dmgkey1:SetInvisible(0)
                    aimbot.general.dmgkey2:SetInvisible(0)
                    aimbot.general.hckey:SetInvisible(0)
                    aimbot.general.weapons:SetInvisible(0)
                    aimbot.weapon[weapons[1]:lower()].enable:SetValue(1)
                    for v = 1,#aimbot.weapon do
                        if aimbot.general.weapons:GetValue() == v - 1 then
                            aimbot.weapon[weapons[v]:lower()].enable:SetInvisible(0)
                            if aimbot.weapon[weapons[v]:lower()].enable:GetValue() then
                                for dmg = 1,#aimbot.weapon[weapons[v]:lower()].dmg do
                                    aimbot.weapon[weapons[v]:lower()].dmg[dmg]:SetInvisible(0)
                                end
                                for hc = 1,#aimbot.weapon[weapons[v]:lower()].hc do
                                    aimbot.weapon[weapons[v]:lower()].hc[hc]:SetInvisible(0)
                                end
                                aimbot.weapon[weapons[v]:lower()].disaw:SetInvisible(0)
                            end
                        end
                    end
                end
            end
        end
    end

--

--Callbacks

    callbacks.Register("PostMove",function(cmd)

        ragebot_handle()

        speedburst()

        quickpeek(cmd)

        has_weapon_fire = false

        if aimbot.general.enable:GetValue() then
            if aimbot.general.flonshot:GetValue() then
                if fakelag_on_shots > globals.CurTime() then gui.SetValue("misc.fakelag.enable",0) else gui.SetValue("misc.fakelag.enable",1) end
            end
        end

    end)

    callbacks.Register("Draw",function()

        menu_handle()

        indicator_states()

        renderer.text(screen.x-10-renderer.text_size("@HKlizard",font.verdana13),10,{220,220,220,255},"XXxxxx.xx/","ls",font.verdana13)
        renderer.text(screen.x-10,10,{0,220,0,255},"@HKlizard","ls",font.verdana13)
        draw.Line(screen.x-10,15,screen.x-10-renderer.text_size("XXxxxx.xx/@HKlizard",font.verdana13),15,draw.Color(255,0,0,255))
        renderer.text(screen.x-10,25,{220,220,220,255},"East adaptive version "..version,"ls",font.verdana13)

        if aimbot.general.enable:GetValue() then

            local lplayer = entities.GetLocalPlayer()

            if not (lplayer and lplayer:IsAlive()) then
                return
            end

            if aimbot.general.autopeek:GetValue() ~= 0 then

                if lp_abs_origin == nil then lp_abs_origin = lplayer:GetAbsOrigin() end

                local r,g,b,a = colour.autopeek:GetValue()

                renderer.circle_3d(lp_abs_origin,15,{r,g,b,a},1,1)

            end
        end

    end)

    callbacks.Register("DrawESP",function(esp)

        draw_esp(esp)

    end)

    callbacks.Register("AimbotTarget",function(ent)
        if ent:GetIndex() == nil then
            aimbot_target = nil
        else
            aimbot_target = ent
        end
    end)

    callbacks.Register("FireGameEvent",function(event)

        play_hit_sound(event)

    end)

    client.AllowListener("player_hurt")

    --[[
        Hello!
        This passage comes from the coder(HKmlizard)
        Today is 4 January 2023, I made my script public.I will stop updating East.lua and this is the last version.
        Because current AW scripters do not often publish lua.
        For aimware 5.1.13. Although my code is trash, I hope you can like it.
        https://aimware.net/forum/user/470665
    ]]

--


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")