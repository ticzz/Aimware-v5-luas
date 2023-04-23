--[[shitty movement lua made for breezetix (breezysticks)
made by naz#6660]]--

local ui_keybox = gui.Keybox(gui.Reference( "MISC","Movement", "Jump"),"msc_movement_edge", "eggbog", 0 )
local ui_checkbox = gui.Checkbox( gui.Reference("MISC","Movement", "Jump"),"misc.autojumpbug.scroll", "Fake Scroll On Jump-bug Fail", false)
local main_font = draw.CreateFont("Verdana", 26)
local combo = gui.Combobox(gui.Reference( "MISC","Movement", "Jump"), 'msc_edgejump_vars','Long Jump Type','Normal', 'LJ Bind -forward', 'LJ Bind -back', 'LJ Bind -moveleft', 'LJ Bind -moveright')
local ljbind = gui.Checkbox(gui.Reference( "MISC","Movement", "Jump"), "lj_bind", "LJ Bind Edge Jump", false)
local ui_checkbox = gui.Checkbox(gui.Reference( "Visuals", "Other", "Extra"), "lj_bind_status", "LJ Bind Status", false)
local velocityInd = gui.Checkbox(gui.Reference( "MISC","Movement", "Jump"), "lj_bind", "Velocity indicatoooooor", false)
local posSlider = gui.Slider(gui.Reference("MISC","Movement", "Jump"), "pos1", "vel pos x", 940,0,1920)
local posSlider2 = gui.Slider(gui.Reference("MISC","Movement", "Jump"), "pos2", "vel pos y", 1000,0,1080)
local jumpshotcb = gui.Checkbox(gui.Reference( "MISC","Movement", "Jump"), "jsshit", "jumpshot shit", false);
local gslider = gui.Slider(gui.Reference("MISC","Movement", "Jump"), "groundhc", "hit chance on ground", 40,0,100)
local aslider = gui.Slider(gui.Reference("MISC","Movement", "Jump"), "airhc", "hit chance in air", 0,0,100)
ui_keybox:******" )
ui_checkbox:****** will)")
ljbind:SetDescription("Jump further with a few more units of jump hight.")
jumpshotcb:SetDescription("Self explanitory")

local function get_local_player( )

 local player = entities.GetLocalPlayer( )
 
 if player == nil then return end
 
 if ( not player:IsAlive( ) ) then
 
 player = player:GetPropEntity( "m_hObserverTarget" )
 
 end
 
 return player
 
end

local function EDGEBUG_CREATEMOVE( UserCmd )

 local flags = get_local_player():GetPropInt( "m_fFlags" )
 
 if flags == nil then return end
 
    local onground = bit.band(flags, 1) ~= 0

 if ui_keybox:GetValue() == 0 then return end
 
 if onground and input.IsButtonDown( ui_keybox:GetValue( ) ) then 

 UserCmd:SetButtons( 4 )
 return 

    end
end

ui_checkbox:****** will)" )

local function get_local_player( )

    local player = entities.GetLocalPlayer( )
    
    if player == nil then return end
    
    if ( not player:IsAlive( ) ) then
        
        player = player:GetPropEntity( "m_hObserverTarget" )
        
    end
    
    return player
    
end

local function JUMPBUG_SCROLL( UserCmd )

    local flags = get_local_player():GetPropInt( "m_fFlags" )
    
    if flags == nil then return end

    local onground = bit.band( flags, 1 ) ~= 0
    
    if onground and input.IsButtonDown( gui.GetValue("misc.autojumpbug" ) )then

        UserCmd:SetButtons( 4 )
    else
        return    

    end
end


local edgejump = gui.GetValue("misc.edgejump");
callbacks.Register("CreateMove", function(cmd)
 
    if (ljbind:GetValue() ~= true) then
        return
    end
    local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end
 
    local onground = bit.band(flags, 1) ~= 0

 
    if (not onground and input.IsButtonDown(edgejump)) then
      cmd:SetButtons( 86 )
         if (combo:GetValue() == 0) then
         return;
      end
         if (combo:GetValue() == 1) then
         client.Command("-forward", true)
       end
 
      if (combo:GetValue() == 2) then
         client.Command("-back", true)
      end
         if (combo:GetValue() == 3) then
         client.Command("-moveright", true)
       end
         if (combo:GetValue() == 4) then
         client.Command("-moveleft", true)
      end
      return 
 end

end)

callbacks.Register("Draw", function()
   local x, y = draw.GetScreenSize( )
   local centerX = x / 2
   local lp = entities.GetLocalPlayer()
   local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags") 
      if flags == nil then return end
      local onground = bit.band(flags, 1) ~= 0
      draw.SetFont(main_font)
      if  edgejump ~= 0 and input.IsButtonDown(edgejump)  then
      draw.Color(255, 255, 255, 255)
      draw.Text( centerX , y - 150, "lj")
   end
      if (onground) then return
   end 
      if  edgejump ~= 0 and input.IsButtonDown(edgejump)  then
      draw.Color(30, 255, 109)
      draw.Text( centerX , y - 150, "lj")
   end
end)


   function round(num, numDecimalPlaces)
      local mult = 10^(numDecimalPlaces or 0)
      if not entities.GetLocalPlayer() then return end
     if not entities.GetLocalPlayer():IsAlive() then return end
      return math.floor(num * mult + 0.5) / mult
  end


  local function veloc()
   local VelocityX = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" )
   local VelocityY = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" )
   local VelocityZ = entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[2]" )
   local speed = math.sqrt(VelocityX^2 + VelocityY^2)
   draw.Color(200, 30, 30, 255)
   font = draw.CreateFont("Bahnschrift", 30)
   draw.SetFont(font)
   if velocityInd:GetValue() == true then
   draw.Text(gui.GetValue("misc.pos1"), gui.GetValue("misc.pos2"), round(speed, 0))
   end
 end

local function jumpshot()
   local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
   if flags == nil then return end
   local onground = bit.band(flags, 1) ~= 0
   if (not onground and jumpshotcb:GetValue() == true) then
      gui.SetValue("rbot.hitscan.accuracy.shared.hitchance", gui.GetValue("misc.airhc"))
   else
      gui.SetValue("rbot.hitscan.accuracy.shared.hitchance", gui.GetValue("misc.groundhc"))
   end
end

callbacks.Register("CreateMove", jumpshot)
callbacks.Register("CreateMove", EDGEBUG_CREATEMOVE)
callbacks.Register("Draw", "EDGEBUG", DRAW_STATUS)
callbacks.Register("CreateMove", JUMPBUG_SCROLL)
callbacks.Register("Draw", veloc)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

