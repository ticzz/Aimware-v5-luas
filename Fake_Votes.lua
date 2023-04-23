local silentname = 0
local windowmade = 0
local windowactive = 0
local shoulddc = 0
local timer = 0
local curtime = globals.CurTime()
local msgtype, weapon, rarity, text, box1, box2, box3, box4, slider, enable, enabletype, useownname, bantext, bandisc, faketext, fakekicktext, kickself
local origName = "Something broke"
 
local function getOriginalName()
 
    origName = client.GetConVar("Name")
 
end
 
getOriginalName()
 
local function table_contains(tbl, item)
    for i=1, #tbl do
        if tbl[i] == item then
            return true
        end
    end
    return false
end
 
local function setName(name)
    client.SetConVar("name", name);
end
 
local knives = {
    "Bayonet", "Bowie Knife", "Butterfly Knife",
    "Falchion Knife", "Flip Knife", "GutKnife",
    "Huntsman Knife", "Karambit", "M9 Bayonet", "Navaja",
    "Shadow Daggers", "Stiletto", "Talon", "Ursus"
}
 
local weaponsTable = {
    "Bayonet", "Bowie Knife", "Butterfly Knife", "Falchion Knife",
    "Flip Knife", "GutKnife", "Huntsman Knife", "Karambit",
    "M9 Bayonet", "Navaja", "Shadow Daggers", "Stiletto",
    "Talon", "Ursus", "AWP", "AK-47", "Desert Eagle",
    "Glock-18", "M4A4", "M4A1-S", "USP-S"
}
 
local team_colors = {
   "\x01",
   "\x09",
   "\x0B"
}
 
local rarity_colors = {
   "\x0B",
   "\x0C",
   "\x03",
   "\x0E",
   "\x07",
   "\x10"
}
 
local type_messages = {
    " has opened a container and found:",
    " received in a trade:"
}
 
	local ref = gui.Reference("MISC")
	local trolltab = gui.Tab(ref, "fake.name.tab", "Fake Names")
    local grp1 = gui.Groupbox(trolltab, "Main", 16,16,190,105)
        enable = gui.Checkbox(grp1, enable, "Enable", 0)
        enabletype = gui.Combobox(grp1, enabletype, "Active Type", "Fake Skin", "Fake Ban", "Fake Vote", "Fake Kick")
    local grp2 = gui.Groupbox(trolltab, "Set Name", 16,170,190,105)
        local resetbutton = gui.Button(grp2, "Reset Name", function()
       
        if enable:GetValue() then
                setName(origName)
            end
        end)
    local grp3 = gui.Groupbox(trolltab, "Fake Skin", 428,16,190,315)
        msgtype = gui.Combobox(grp3, msgtype, "Message Type", "Unbox", "Trade")
        weapon = gui.Combobox(grp3, weapon, "Weapon", "Bayonet", "Bowie Knife", "Butterfly Knife", "Falchion Knife",
            "Flip Knife", "GutKnife", "Huntsman Knife", "Karambit",
            "M9 Bayonet", "Navaja", "Shadow Daggers", "Stiletto",
            "Talon", "Ursus", "AWP", "AK-47", "Desert Eagle",
            "Glock-18", "M4A4", "M4A1-S", "USP-S")
        rarity = gui.Combobox(grp3, rarity, "Rarity/Color", "Industrial (LightBlue)", "Mil spec (DarkBlue)", "Restricted (Pruple)", "Classified (PinkishPurple)", "Covert (Red)", "Contraband (Orangeish)" )
        gui.Text(grp3, "Skin Name")
        text = gui.Editbox(grp3, text, "")
        local multibox = gui.Multibox( grp3, "Modifiers")
            box1 = gui.Checkbox(multibox, check1, "Auto-Disconnect", 0)
            box2 = gui.Checkbox(multibox, check2, "StatTrak Weapon", 0)
            box3 = gui.Checkbox(multibox, check3, "White Name Color", 0)
            box4 = gui.Checkbox(multibox, check4, "Use Custom Gap Value", 0)
        slider = gui.Slider(grp3, slider, "Gap Value", 1, 1, 35)
       
    local grp4 = gui.Groupbox(trolltab, "Fake Ban", 222,318,190,125)
        gui.Text(grp4, "Banned Player Name")
        bantext = gui.Editbox(grp4,bantext, "")
        useownname = gui.Checkbox(grp4, ownname, "Use Own Name Instead", 1)
        bandisc = gui.Checkbox(grp4, bandisc, "Auto-Disconnect", 0)
       
    local grp5 = gui.Groupbox(trolltab, "Fake Vote", 222,185,190,80)
        gui.Text(grp5, "Vote Text")
        faketext = gui.Editbox(grp5,faketext, "")
       
    local grp6 = gui.Groupbox(trolltab, "Fake Kick", 222,16,190,110)
        gui.Text(grp6, "Player Name")
        fakekicktext = gui.Editbox(grp6,fakekicktext, "")
        kickself = gui.Checkbox(grp6, kickself, "Use Own Name Instead", 1)
       
       
       
        local button = gui.Button(grp2, "Set Name", function()
    if enable:GetValue() then
        if enabletype:GetValue() == 0 then
        local local_player  = entities.GetLocalPlayer()
        if local_player ~= nil then
            local itemn = weapon:GetValue() + 1
            local item          = weaponsTable[itemn]
            local weapon_name   = table_contains(knives, item) and "★ " or ""
            weapon_name         = box2:GetValue() and weapon_name .. "StatTrak™ " .. item or weapon_name .. item
            local team_color    = nil
            local rarn = rarity:GetValue() + 1
            local rarity_color  = rarity_colors[rarn]
            local msgn = msgtype:GetValue() + 1
            local message       = type_messages[msgn]
            local skinname      = text:GetValue()
            if box3:GetValue() then team_color = "\x01" else team_color = team_colors[local_player:GetTeamNumber()] end
            local char = ""
            local char2 = ""
            local number = slider:GetValue()
            local name = string.len("" .. origName .. "" .. message .. "" .. weapon_name .. "" .. skinname .. "")
            print("Total name length: " .. name)
 
            if name == 25 then char = "" for _ = 1, 19 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 26 then char = "" for _ = 1, 19 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 27 then char = "" for _ = 1, 19 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 28 then char = "" for _ = 1, 18 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 29 then char = "" for _ = 1, 18 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 30 then char = "" for _ = 1, 18 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 31 then char = "" for _ = 1, 17 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 32 then char = "" for _ = 1, 17 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 33 then char = "" for _ = 1, 16 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 34 then char = "" for _ = 1, 16 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 35 then char = "" for _ = 1, 15 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 36 then char = "" for _ = 1, 15 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 37 then char = "" for _ = 1, 14 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 38 then char = "" for _ = 1, 14 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 39 then char = "" for _ = 1, 13 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 40 then char = "" for _ = 1, 12 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 41 then char = "" for _ = 1, 12 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 👌 "
            elseif name == 42 then char = "" for _ = 1, 11 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 43 then char = "" for _ = 1, 10 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 44 then char = "" for _ = 1,  9 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 45 then char = "" for _ = 1,  9 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 46 then char = "" for _ = 1,  9 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 47 then char = "" for _ = 1,  9 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 48 then char = "" for _ = 1,  8 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 49 then char = "" for _ = 1,  8 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 50 then char = "" for _ = 1,  7 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 51 then char = "" for _ = 1,  7 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 52 then char = "" for _ = 1,  6 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 53 then char = "" for _ = 1,  5 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 54 then char = "" for _ = 1,  5 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 55 then char = "" for _ = 1,  4 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 👌 "
            elseif name == 56 then char = "" for _ = 1,  4 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 "
            elseif name == 57 then char = "" for _ = 1,  3 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 "
            elseif name == 58 then char = "" for _ = 1,  2 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 "
            elseif name == 59 then char = "" for _ = 1,  2 do char = char .. "ᅠ" end char2 = "" char2 = " 👌 👌 👌 "
            elseif name == 60 then char = "ᅠᅠ" char2 = "" char2 = " 👌 👌 "
            elseif name == 61 then char = "ᅠ" char2 = "" char2 = " 👌 👌 "
            elseif name == 62 then char = "" char2 = "" char2 = " 👌 👌 "
            elseif name == 63 then char = "" char2 = "" char2 = " 👌 👌 "
            elseif name == 64 then char = "" char2 = "" char2 = " 👌 👌 "
            elseif name == 65 then char = "" char2 = "" char2 = " "
            elseif name == 66 then char = "" char2 = "" char2 = " "
            elseif name  > 66 then char = "" char2 = "" print("Values above 66 Don't work properly.")
            end
               
            if table_contains(knives, weapon:GetValue()) then state = 1 else state = nil end
            if state == 1 then for _ = 1, 2 do char = char .. "ᅠ" end end
               
            if box1:GetValue() then state = 2 end
            if state == 2 then char2 = "" for _ = 1, 6 do char = char .. "ᅠ" end end  
 
            if box2:GetValue() then state = 3 end
            if state == 3 then for _ = 1, 3 do char = char .. "ᅠ" end end
 
            if box4:GetValue() then state = 4 end
            if state == 4 then char = "" for _ = 1, number do char = char .. "ᅠ" end end
 
                if box1:GetValue() then
                    setName("👌" .. team_color .. "" .. origName .. "\x01" .. message .. "" .. rarity_color .. " " .. weapon_name .. " | " .. skinname .. "\n" .. char ..  "👌 \x01")
                    shoulddc = 1
                else
                    setName("👌" .. team_color .. "" .. origName .. "\x01" .. message .. "" .. rarity_color .. " " .. weapon_name .. " | " .. skinname .. "\n" .. char ..  "" .. char2 .. "\x01You")
                end
        end
       
        elseif enabletype:GetValue() == 1 then
            local name = 0
            if useownname:GetValue() then
                name = string.len(origName)
            else
                name = string.len(bantext:GetValue())
            end
            local meme = ""
            if(name < 2) and (name > 0)  then
                    meme =" 👌 👌 👌 👌 👌 👌 👌 👌 👌 👌 👌 👌 "
            elseif(name < 3) and (name > 1)  then
                    meme =" 👌 👌 👌 👌 👌 👌 👌 👌 👌 👌 👌 "
            elseif(name < 4) and (name > 2)  then
                    meme =" 👌 👌 👌 👌 👌 👌 👌 👌 👌 👌 "
            elseif(name < 5) and (name > 3)  then
                    meme =" 👌 👌 👌 👌 👌 👌 👌 👌 👌 "
            elseif(name < 6) and (name > 4)  then
                    meme =" 👌 👌 👌 👌 👌 👌 👌 👌 "
            elseif(name < 7) and (name > 5)  then
                    meme =" 👌 👌 👌 👌 👌 👌 👌 "
            elseif(name < 8) and (name > 6)  then
                    meme =" 👌 👌 👌 👌 👌 👌 "
            elseif(name < 9) and (name > 7)  then
                    meme =" 👌 👌 👌 👌 👌 "
            elseif(name < 10) and (name > 8) then
                    meme =" 👌 👌 👌 👌 "
            elseif(name < 99) and (name > 9) then
                    print("Names above 9 characters don't work properly")
            end
            if bandisc:GetValue() then  
                if useownname:GetValue() then
                    setName(" \x07" .. origName .. " has been permanently banned from official CS:GO servers." .. meme .. "\x01 👌 ")
                    shoulddc = 1
                else
                    setName(" \x07" .. bantext:GetValue() .. " has been permanently banned from official CS:GO servers." .. meme .. "\x01 👌 ")
                    shoulddc = 1
                end
            else
                if useownname:GetValue() then
                setName(" \x07" .. origName .. " has been permanently banned from official CS:GO servers." .. meme .. "\x01You");
                else
                setName(" \x07" .. bantext:GetValue() .. " has been permanently banned from official CS:GO servers." .. meme .. "\x01You");
                end
            end
       
        elseif enabletype:GetValue() == 2 then
       
            local currentName = ''
            local tempName = ''
            for _ = 1, 28 do
                tempName = tempName .. "\n";
            end
           
            tempName = tempName .. faketext:GetValue();
           
            for _ = 1, 60 do
                tempName = tempName .. "\n";
            end
           
            currentName = tempName;
            setName(currentName);
       
        elseif enabletype:GetValue() == 3 then
       
            if kickself:GetValue() then
           
                local currentName = ''
                local tempName = ''
                for _ = 1, 28 do
                    tempName = tempName .. "\n";
                end
               
                tempName = tempName .. "Kick player: " .. origName .. "?";
               
                for _ = 1, 60 do
                    tempName = tempName .. "\n";
                end
               
                currentName = tempName;
                setName(currentName);
 
            else
           
                local currentName = ''
                local tempName = ''
                for _ = 1, 28 do
                    tempName = tempName .. "\n";
                end
               
                tempName = tempName .. "Kick player: " .. fakekicktext:GetValue() .. "?";
               
                for _ = 1, 60 do
                    tempName = tempName .. "\n";
                end
               
                currentName = tempName;
                setName(currentName);
           
            end
           
        end
    end
end)
 
local function disconnectshit()
    if shoulddc == 1 then
        timer = globals.CurTime()
        shoulddc = 2
    end
    if shoulddc == 2 and globals.CurTime() >= timer + 0.8 then
        client.Command("disconnect", true)
        shoulddc = 3
    end
    if shoulddc == 3 and globals.CurTime() >= timer + 3.6 then
        client.Command("name" .. origName, true)
        print("Automatically disconnected from the server after setting name.")
        shoulddc = 0
    end
end
 
callbacks.Register("Draw",disconnectshit)
 
local function makenamesilent()
	local lp = entities.GetLocalPlayer()
	if silentname == 0 and lp ~= nil and enable:GetValue() then
		setName("\n\xAD\xAD\xAD\xAD")
		curtime = globals.CurTime()
		silentname = 1
	end
	if silentname == 1 and globals.CurTime() >= curtime + 0.1 then
		setName(origName)
		silentname = 2
	end

	if lp == nil then
		silentname = 0
	end
end
 
callbacks.Register("Draw",makenamesilent)