
local function Main()

   if entities.GetLocalPlayer() == nil or not entities.GetLocalPlayer():IsAlive() then
        return
    end

local hc = gui.GetValue("rbot.accuracy.weapon.asniper.hitchance")    
local mindmg = gui.GetValue("rbot.accuracy.weapon.asniper.mindmg")   
local fakewalkkey = gui.GetValue("rbot.accuracy.movement.fakewalkkey")

add.IndicatorForKeybox("Fake Duck", "rbot.antiaim.enable", 2, true, 112, 255, 0, 255, 255, 0, 0, 255)
add.IndicatorForKeybox("Slow Walk", "rbot.accuracy.movement.fakewalkkey", 2, true, 112, 255, 0, 255, 255, 0, 0, 255)
--add.IndicatorForKeybox("IzyWallbang", "walldmgkey", 2, true, 112, 255, 0, 255, 255, 0, 0,255)        		
        		
--add.IndicatorForKeybox("EZWallbang", "rbot_wallbang_key", 2, true, 112, 255, 0, 255, 255, 0, 0,255)        		

  
	
	
end

RunScript("drawInfo.lua")

callbacks.Register( "Draw", "Main", Main);

