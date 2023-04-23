-- thank you for using my script
-- feel free to hit me up on https://discord.gg/6FWJDDm
local autor = "DaveLTC";

local ref = gui.Reference( "MISC", "Better Spam" );
local Group = gui.Groupbox(ref, "NameSpam", 15, 455, 295);
local checkbox_namespam = gui.Checkbox( Group, "Checkbox", "Enable",  false)
local speed_slider = gui.Slider( Group, "lua_slider", "Delay in Seconds", 10, 1, 60 );

local last_message = globals.TickCount();
local spammer_enable, spammer_speed = false, 22;

local function SayName()
	local Me = client.GetLocalPlayerIndex();
	local Name = client.GetPlayerNameByIndex(Me);
	client.ChatSay(Name);
end


function Spam()
	if (globals.TickCount() - last_message < 0) then
        last_message = 0;
    end;
	
	spammer_enable = checkbox_namespam:GetValue();
	spammer_speed = speed_slider:GetValue() *60;
    if spammer_enable == true and globals.TickCount() - last_message > (math.max(22, spammer_speed)) then
        SayName();
        last_message = globals.TickCount();
    end
end


callbacks.Register( "Draw", "Spam", Spam );