local guiRef1 = gui.Reference( "Ragebot", "Accuracy", "Movement" )
local enable = gui.Checkbox( guiRef1, "fakewalk", "Activate Fakewalk", false )
enable:SetDescription("Use Fakewalk instead of Slowwalk");
local fakewalkgroupbox = gui.Groupbox(gui.Reference( "Ragebot", "Accuracy", "Movement" ), "Fakewalk Settings")
local fakewalkkey = gui.Keybox(fakewalkgroupbox, "fakewalkkey", "Fakewalkkey", 0)
fakewalkkey:SetDescription("Start Fakewalking when holding down this Key");

local function activationCheck()
    if not enable:GetValue() then
            fakewalkgroupbox:SetInvisible(true);
			fakewalkgroupbox:SetDisabled(true);
        else
            fakewalkgroupbox:SetInvisible(false);
			fakewalkgroupbox:SetDisabled(false)
    end
end

local function createMoveHook(cmd)
	
	if fakewalkkey:GetValue() == nil or 0 then return end


		if input.IsButtonDown( "a" ) and input.IsButtonDown( fakewalkkey:GetValue() ) and not input.IsButtonDown( "d" ) then
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sidemove = -55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.sidemove = 0
            cmd.sendpacket = true
            cmd.sidemove = 0
            cmd.sendpacket = false
            cmd.sidemove = -55
        end
        if input.IsButtonDown( "d" ) and input.IsButtonDown( fakewalkkey:GetValue() ) and not input.IsButtonDown( "a" ) then
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sidemove = 55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.sidemove = 0
            cmd.sendpacket = true
            cmd.sidemove = 0
            cmd.sendpacket = false
            cmd.sidemove = 55
        end
        if input.IsButtonDown( "s" ) and input.IsButtonDown( fakewalkkey:GetValue() ) and not input.IsButtonDown( "w" ) then
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.forwardmove = -55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.forwardmove = 0
            cmd.sendpacket = true
            cmd.forwardmove = 0
            cmd.sendpacket = false
            cmd.forwardmove = -55
        end
        if input.IsButtonDown( "w" ) and input.IsButtonDown( fakewalkkey:GetValue() ) and not input.IsButtonDown( "s" ) then
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.forwardmove = 55
            cmd.sendpacket = false
            cmd.sendpacket = false
            cmd.forwardmove = 0
            cmd.sendpacket = true
            cmd.forwardmove = 0
            cmd.sendpacket = false
            cmd.forwardmove = 55
        end
	end

callbacks.Register( "Draw", activationCheck );
callbacks.Register("CreateMove", createMoveHook)