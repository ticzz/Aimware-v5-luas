
-- Menu GUI
local ghostz_tab = gui.Tab(gui.Reference("Settings"), "ghostzlua", "GhostZ's Lua")
local luascripts_groupbox = gui.Groupbox(ghostz_tab, "Lua Scripts")

-- Lua Scripts Groupboxes/Sliders
local antiaimfix_checkbox = gui.Checkbox(luascripts_groupbox, "antiaimfix", "Anti-Aim Fix", 0)
local noblood_checkbox = gui.Checkbox(luascripts_groupbox, "noblood", "No Blood Mode", 0)

-- Descriptions


-- Anti-Aim Fix by Eugen1763 (https://aimware.net/forum/user-120610.html)
local switch = true;

local function create_move(cmd)
    if not gui.GetValue( "rbot.master" ) then return end
    if gui.GetValue("ghostzlua.antiaimfix") and not input.IsButtonDown( "w" ) and not input.IsButtonDown( "a" ) and not input.IsButtonDown( "s" ) and not input.IsButtonDown( "d" ) and not input.IsButtonDown( "space" ) then 
        if switch == true then
            cmd.sidemove = 2;
            switch = false;
        elseif switch == false then
            cmd.sidemove = -2;
            switch = true;
        end
    end
end

callbacks.Register( "CreateMove", "create_move", create_move );



-- No Blood by ambien55 (https://aimware.net/forum/user-240129.html)
callbacks.Register("CreateMove", function()
    if noblood_checkbox:GetValue() and client.GetConVar("violence_hblood") ~= 0 then
        client.SetConVar("violence_hblood", 0, true)
    end
end)
















--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

