local c_main = { }

function c_main.new( )
   return {
      bullet_impacts = { },
      hitmarker_impacts = { },
      velocity_graph = { },
      trail_points = { },
      active_weapon = { },
      chat_messages = { "", "" },
      game_rules = { },
      is_typing = false,
      message = ""
   }
end

local c_entity = { }

function c_entity.new( )
   return {
      local_player = nil,

      velocity_2d = function( self )
         local x, y, z = self.local_player:GetPropVector( "localdata", "m_vecVelocity[0]" )

         return math.sqrt( x * x + y * y )
      end
   }
end

local c_menu = { }

function c_menu.new( )
   return {
      window, groupbox, hitmarkers, velocity_graph, trail, custom_hud, autobuy = nil, nil, nil, nil, nil, nil, { primary = nil, secondary = nil, gear = nil, list = { } },

      setup = function( self )
         self.window = gui.Window( "my_lua", "My Lua", 250, 500, 300, 300 )
         self.groupbox = gui.Groupbox( self.window, "My Lua", 15, 15, 270, 243 )
         self.hitmarkers = gui.Checkbox( self.groupbox, "hitmarkers", "Hitmarkers", 1 )
         self.velocity_graph = gui.Checkbox( self.groupbox, "velocity_graph", "Velocity Graph", 1 )
         self.trail = gui.Checkbox( self.groupbox, "trail", "Trail", 1 )
         self.custom_hud = gui.Checkbox( self.groupbox, "custom_hud", "Custom Hud", 1 )
         self.autobuy = {
            primary = gui.Combobox( self.groupbox, "primary_weapons", "Primary Weapons", "", "ak47", "galilar", "ssg08", "sg556", "awp", "g3sg1" ),
            secondary = gui.Combobox( self.groupbox, "secondary_weapons", "Secondary Weapons", "", "glock", "elite", "p250", "tec9", "deagle" ),
            gear = gui.Checkbox( self.groupbox, "gear", "Buy Gear", 1 ),
            list = {
               primary = { "", "ak47", "galilar", "ssg08", "sg556", "awp", "g3sg1" },
               secondary = { "", "glock", "elite", "p250", "tec9", "deagle" }
            }
         }
      end,

      handle = function( self )
         self.window:SetActive( gui.Reference( "MENU" ):IsActive( ) )
      end
   }
end

local c_fonts = { }

function c_fonts.new( )
   return {
      main = draw.CreateFont( "Verdana", 12, 700 )
   }
end

local c_render = { }

function c_render.new( )
   return {
      screen_x, screen_y, mouse_x, mouse_y = nil, nil, nil, nil,

      line = function( self, x1, y1, x2, y2, r, g, b, a )
         draw.Color( r, g, b, a )
         draw.Line( x1, y1, x2, y2 )
      end,

      filled_rect = function( self, x1, y1, x2, y2, r, g, b, a )
         draw.Color( r, g, b, a )
         draw.FilledRect( x1, y1, x2, y2 )
      end,

      outlined_rect = function( self, x1, y1, x2, y2, r, g, b, a )
         draw.Color( r, g, b, a )
         draw.OutlinedRect( x1, y1, x2, y2 )
      end,

      rounded_rect = function( self, x1, y1, x2, y2, r, g, b, a )
         draw.Color( r, g, b, a )
         draw.RoundedRect( x1, y1, x2, y2 )
      end,

      rounded_rect_filled = function( self, x1, y1, x2, y2, r, g, b, a )
         draw.Color( r, g, b, a )
         draw.RoundedRectFill( x1, y1, x2, y2 )
      end,

      triangle = function( self, x1, y1, x2, y2, x3, y3, r, g, b, a )
         draw.Color( r, g, b, a )
         draw.Triangle( x1, y1, x2, y2, x3, y3 )
      end,

      text = function( self, x, y, string, font, centered, r, g, b, a )
         draw.Color( r, g, b, a )
         draw.SetFont( font )

         if ( centered == true ) then
            local w, h = draw.GetTextSize( string )
            draw.Text( x - w / 2, y - h / 2, string )
         else
            draw.Text( x, y, string )
         end
      end,

      text_shadow = function( self, x, y, string, r, g, b, a )
         draw.Color( r, g, b, a )
         draw.TextShadow( x, y, string )
      end,
   }
end

local c_game_events = { }

function c_game_events.new( )
   return {
      "server_spawn",
      "game_start",
      "round_prestart",
      "round_start",
      "round_freeze_end",
      "bomb_planted",
      "player_hurt",
      "bullet_impact",
      "player_say"
   }
end

local main, entity, menu, fonts, render, game_events = c_main.new( ), c_entity:new( ), c_menu:new( ), c_fonts.new( ), c_render.new( ), c_game_events.new( )

menu:setup( )

function main.server_spawn_listener( event )
   if ( event:GetName( ) == "server_spawn" ) then
      -- print( event:GetString( "hostname" ) .. " - " .. event:GetString( "address" ) .. " - " .. event:GetInt( "port" ) )

      if ( event:GetString( "hostname" ) == "Counter-Strike: Global Offensive" ) then
         main.game_rules.is_valve_server = true
         main.game_rules.server_address = "valve"
      else
         main.game_rules.is_valve_server = false
         main.game_rules.server_address = event:GetString( "address" )
      end
   end
end

function main.game_start_listener( event )
   if ( event:GetName( ) == "game_start" ) then

   end
end

function main.round_prestart_listener( event )
   if ( event:GetName( ) == "round_prestart" ) then
      client.Command( "buy " .. menu.autobuy.list.primary[menu.autobuy.primary:GetValue( ) + 1], true )
      client.Command( "buy " .. menu.autobuy.list.secondary[menu.autobuy.secondary:GetValue( ) + 1], true )

      if ( menu.autobuy.gear:GetValue( ) == true ) then
         client.Command( "buy vest; buy vesthelm; buy taser; buy defuser; buy molotov; buy hegrenade; buy smokegrenade", true )
      end
   end
end

function main.round_start_listener( event )
   if ( event:GetName( ) == "round_start" ) then
      main.game_rules.round_time = event:GetInt( "timelimit" )
      main.game_rules.freeze_time = true
   end
end

function main.round_freeze_end_listener( event )
   if ( event:GetName( ) == "round_freeze_end" ) then
      main.game_rules.freeze_time = false
      main.game_rules.creation_time = globals.CurTime( )
   end
end

function main.bomb_planted_listener( event )
   if ( event:GetName( ) == "bomb_planted" ) then
      main.game_rules.round_time = math.floor( client.GetConVar( "mp_c4timer" ) )
      main.game_rules.creation_time = globals.CurTime( )
   end
end

function main.player_hurt_listener( event )
   if ( event:GetName( ) == "player_hurt" ) then
      local user_id = event:GetInt( "userid" )
      local attacker_id = event:GetInt( "attacker" )

      local local_player_index = client.GetLocalPlayerIndex( )
      local entity_attacker_index = client.GetPlayerIndexByUserID( attacker_id )
      local hurt_entity = entities.GetByIndex( client.GetPlayerIndexByUserID( user_id ) )

      if ( local_player_index == entity_attacker_index and hurt_entity ~= nil and hurt_entity:IsAlive( ) ) then
         local closest_impact = -1
         local best_impact = { }

         for i = #main.bullet_impacts, 1, -1 do
            if ( main.bullet_impacts[i] ~= nil ) then
               local distance = vector.Distance( main.bullet_impacts[i].x, main.bullet_impacts[i].y, main.bullet_impacts[i].z, hurt_entity:GetAbsOrigin( ) )

               if ( closest_impact == -1 or distance < closest_impact ) then
                  closest_impact = distance

                  best_impact = {
                     x = main.bullet_impacts[i].x,
                     y = main.bullet_impacts[i].y,
                     z = main.bullet_impacts[i].z
                  }
               end

               table.remove( main.bullet_impacts, i )
            end
         end

         main.hitmarker_impacts[#main.hitmarker_impacts + 1] = {
            x = best_impact.x,
            y = best_impact.y,
            z = best_impact.z,
            damage = event:GetInt( "dmg_health" ),
            creation_time = globals.CurTime( )
         }
      end
   end
end

function main.bullet_impact_listener( event )
   if ( event:GetName( ) == "bullet_impact" ) then
      local user_id = event:GetInt( "userid" )

      local local_player_index = client.GetLocalPlayerIndex( )
      local entity_shooting_index = client.GetPlayerIndexByUserID( user_id )

      if ( local_player_index == entity_shooting_index ) then
         main.bullet_impacts[#main.bullet_impacts + 1] = {
            x = event:GetFloat( "x" ),
            y = event:GetFloat( "y" ),
            z = event:GetFloat( "z" ),
            creation_time = globals.CurTime( )
         }
      end
   end
end

function main.player_say_listener( event )
   if ( event:GetName( ) == "player_say" ) then
      local user_id = event:GetInt( "userid" )

      local entity_chatting = entities.GetByUserID( user_id )

      if ( entity_chatting ~= nil ) then
         main.chat_messages[#main.chat_messages + 1] = entity_chatting:GetName( ) .. ": " ..  event:GetString( "text" )
      end
   end
end

function main.draw_bullet_impacts( )
   if ( menu.hitmarkers:GetValue( ) == false ) then
      return
   end

   for i = #main.hitmarker_impacts, 1, -1 do
      if ( main.hitmarker_impacts[i] ~= nil and main.hitmarker_impacts[i].z ~= nil --[[i have no idea why this happens]] ) then
         main.hitmarker_impacts[i].z = main.hitmarker_impacts[i].z + 0.25

         local screen_x, screen_y = client.WorldToScreen( main.hitmarker_impacts[i].x, main.hitmarker_impacts[i].y, main.hitmarker_impacts[i].z )

         if ( screen_x ~= nil and screen_y ~= nil ) then
            render:text( screen_x, screen_y, main.hitmarker_impacts[i].damage, fonts.main, true, 255, 255, 255, 255 )

            if ( globals.CurTime( ) > main.hitmarker_impacts[i].creation_time + 2 ) then
               table.remove( main.hitmarker_impacts, i )
            end
         end
      end
   end
end

function main.draw_local_velocity( )
   if ( entity.local_player == nil or entity.local_player:IsAlive( ) == false or menu.velocity_graph:GetValue( ) == false ) then
      main.velocity_graph = { }
      return
   end

   local velocity_2d = entity:velocity_2d( )

   local size, height = 200, 0.3

   main.velocity_graph[#main.velocity_graph + 1] = {
      x = render.screen_x / 2 - size + ( #main.velocity_graph * 1 ),
      y = render.screen_y - 50 - ( velocity_2d * height ),
      r = math.sin( globals.RealTime( ) / 3 --[[speed]] * 4 ) * 127 + 128,
      g = math.sin( globals.RealTime( ) / 3 --[[speed]] * 4 + 2 ) * 127 + 128,
      b = math.sin( globals.RealTime( ) / 3 --[[speed]] * 4 + 4 ) * 127 + 128
   }

   for i = #main.velocity_graph, 1, -1 do
      if ( main.velocity_graph[i] ~= nil ) then
         if ( main.velocity_graph[i - 1] ~= nil ) then
            render:line( main.velocity_graph[i - 1].x, main.velocity_graph[i - 1].y, main.velocity_graph[i].x, main.velocity_graph[i].y, main.velocity_graph[i].r, main.velocity_graph[i].g, main.velocity_graph[i].b, 255 )
         end

         if ( #main.velocity_graph > size * 2 ) then
            main.velocity_graph[i].x = main.velocity_graph[i].x - 1
         end

         if ( main.velocity_graph[i].x < render.screen_x / 2 - size ) then
            table.remove( main.velocity_graph, i )
         end
      end
   end
end

function main.draw_local_trail( )
   if ( entity.local_player == nil or entity.local_player:IsAlive( ) == false or menu.trail:GetValue( ) == false ) then
      main.trail_points = { }
      return
   end

   local origin_x, origin_y, origin_z = entity.local_player:GetAbsOrigin( )

   main.trail_points[#main.trail_points + 1] = {
      x = origin_x,
      y = origin_y,
      z = origin_z,
      r = math.sin( globals.RealTime( ) / 3 --[[speed]] * 4 ) * 127 + 128,
      g = math.sin( globals.RealTime( ) / 3 --[[speed]] * 4 + 2 ) * 127 + 128,
      b = math.sin( globals.RealTime( ) / 3 --[[speed]] * 4 + 4 ) * 127 + 128,
      creation_time = globals.CurTime( )
   }

   for i = #main.trail_points, 1, -1 do
      if ( main.trail_points[i] ~= nil ) then
         if ( main.trail_points[i - 1] ~= nil ) then
            local screen_x, screen_y = client.WorldToScreen( main.trail_points[i].x, main.trail_points[i].y, main.trail_points[i].z )
            local next_screen_x, next_screen_y = client.WorldToScreen( main.trail_points[i - 1].x, main.trail_points[i - 1].y, main.trail_points[i - 1].z )

            if ( screen_x ~= nil and screen_y ~= nil and next_screen_x ~= nil and next_screen_y ~= nil ) then
               render:line( next_screen_x, next_screen_y, screen_x, screen_y, main.trail_points[i].r, main.trail_points[i].g, main.trail_points[i].b, 255 )
            end
         end

         if ( globals.CurTime( ) > main.trail_points[i].creation_time + 0.5 ) then
            table.remove( main.trail_points, i )
         end
      end
   end
end

function main.games_rules_proxy( )
   -- local game_rules = entities.FindByClass( "CCSGameRulesProxy" )[1] -- broken atm
   --
   -- if ( game_rules ~= nil ) then
      -- main.game_rules = {
      --    is_valve_server = game_rules:GetPropBool( "cs_gamerules_data", "m_bIsValveDS" ),
      --    round_time = game_rules:GetPropInt( "cs_gamerules_data", "m_iRoundTime" )
      -- }
      -- print( game_rules:GetPropBool( "cs_gamerules_data", "m_bIsValveDS" ) )
      -- print( game_rules:GetPropBool( "cs_gamerules_data", "m_iRoundTime" ) )
   -- end
end

function main.custom_hud( )
   if ( menu.custom_hud:GetValue( ) == false ) then
      client.SetConVar( "cl_draw_only_deathnotices", 0, true )
      return
   end

   client.SetConVar( "cl_draw_only_deathnotices", 1, true )

   if ( entity.local_player == nil ) then
      return
   end

   -- CUSTOM CHAT
   for i = #main.chat_messages, 1, -1 do
      if ( main.chat_messages[i] ~= nil ) then
         if ( i > 3 or #main.chat_messages < 10 ) then
            render:text( 5, render.screen_y - 20 - 15 * ( ( #main.chat_messages + 1 ) - i ) , main.chat_messages[i], fonts.main, false, 255, 255, 255, 255 )
         else
            render:text( 5, render.screen_y - 20 - 15 * ( ( #main.chat_messages + 1 ) - i ) , main.chat_messages[i], fonts.main, false, 255, 255, 255, 255 * ( 1 - ( 4 - i ) / 3 ) )
         end

         if ( #main.chat_messages > 10 ) then
            table.remove( main.chat_messages, 1 )
         end
      end
   end

   render:outlined_rect( 5, render.screen_y - 20, 200, render.screen_y - 5, 255, 255, 255, 255 )

   if ( render.mouse_x >= 5 and render.mouse_x <= 200 and render.mouse_y >= render.screen_y - 20 and render.mouse_y <= render.screen_y - 5 ) then
      if ( input.IsButtonDown( 0x01 ) ) then -- left mouse
         main.is_typing = true
      end
   end

   if ( main.is_typing == true ) then
      if ( input.IsButtonDown( 0x0D ) ) then -- enter
         main.is_typing = false
         client.ChatSay( main.message )
         main.message = ""
      end

      if ( input.IsButtonDown( 0x1B ) ) then -- esc
         main.is_typing = false
         main.message = ""
      end

      if ( input.IsButtonPressed( 0x08 ) ) then -- backspace
         main.message = string.sub( main.message, 1, -2 )
      end

      if ( input.IsButtonPressed( 0x20 ) ) then -- spacebar
         main.message = main.message .. " "
      end

      for i = 48, 90 do -- all numbers and characters
         if ( input.IsButtonPressed( i ) ) then
            main.message = main.message .. string.char( i ):lower( )
         end
      end

      render:text( 7, render.screen_y - 19, main.message, fonts.main, false, 255, 255, 255, 255 )
   else
      render:text( 7, render.screen_y - 19 , "text...", fonts.main, false, 255, 255, 255, 255 )
   end

   if ( main.is_typing == false and input.IsButtonDown( 0x59 ) --[["y"]] ) then
      main.is_typing = true
   end

   -- CUSTOM ROUND TIME
   if ( main.game_rules.round_time ~= nil and main.game_rules.freeze_time == false ) then
      if ( main.game_rules.creation_time <= globals.CurTime( ) - 1 ) then
         main.game_rules.round_time = main.game_rules.round_time - 1
         main.game_rules.creation_time = globals.CurTime( )
      end

      local round_time = string.format( "%02d", math.floor( main.game_rules.round_time / 60 ) )..":".. string.format( "%02d", ( main.game_rules.round_time % 60 ) )

      render:text( render.screen_x / 2, 15, round_time, fonts.main, true, 255, 255, 255, 255 )
   elseif ( main.game_rules.freeze_time == true ) then
      render:text( render.screen_x / 2, 15, "freeze", fonts.main, true, 255, 255, 255, 255 )
   end

   -- CUSTOM ROUND COUNTER
   local terrorists = entities.FindByClass( "CTeam" )[3]
   local counter_terrorists = entities.FindByClass( "CTeam" )[4]

   if ( terrorists ~= nil and counter_terrorists ~= nil ) then
      local t_wins, ct_wins = terrorists:GetPropInt( "m_scoreTotal" ), counter_terrorists:GetPropInt( "m_scoreTotal" )

      render:text( render.screen_x / 2 + 25, 15, t_wins, fonts.main, true, 220, 20, 60, 255 )
      render:text( render.screen_x / 2 - 25, 15, ct_wins, fonts.main, true, 0, 191, 255, 255 )
   end

   if ( main.game_rules.server_address ~= nil ) then
      render:text( 5, 5, "server: " .. main.game_rules.server_address, fonts.main, false, 255, 255, 255, 255 )
   end

   local terrorists_alive, counter_terrorists_alive = 0, 0

   -- CUSTOM TEAM ALIVE COUNTER
   local entities = entities.FindByClass( "CCSPlayer" )

   for i = 1, #entities do
      if ( entities[i] ~= nil and entities[i]:IsAlive( ) ) then
         if ( entities[i]:GetPropInt( "m_iTeamNum" ) == 2 ) then
            terrorists_alive = terrorists_alive + 1
         else
            counter_terrorists_alive = counter_terrorists_alive + 1
         end
      end
   end

   if ( terrorists_alive ~= nil and counter_terrorists_alive ~= nil ) then
      render:text( 5, render.screen_y / 2 - 7.5, "visible terrorists alive: " .. terrorists_alive, fonts.main, false, 255, 255, 255, 255 )
      render:text( 5, render.screen_y / 2 + 7.5, "visible counter terrorists alive: " .. counter_terrorists_alive, fonts.main, false, 255, 255, 255, 255 )
   end

   if ( entity.local_player:IsAlive( ) == false ) then
      return
   end

   -- CUSTOM LOCAL INFO
   local health = entity.local_player:GetHealth( )

   render:text( render.screen_x / 2 - 50, render.screen_y - 35, "health: " .. health, fonts.main, true, 255 - ( health * 2.55 ), health * 2.55, 0, 255 )

   local armor = entity.local_player:GetPropInt( "m_ArmorValue" )

   render:text( render.screen_x / 2 + 50, render.screen_y - 35, "armor: " .. armor, fonts.main, true, 255, 255, 255, 255 )

   local velocity_2d = entity:velocity_2d( )

   render:text( render.screen_x / 2, render.screen_y - 20, "speed: " .. math.floor( velocity_2d ), fonts.main, true, 255, 255, 255, 255 )

   --CUSTOM LOCAL WEAPONS
   local weapons = { }

   for i = 0, 63 do
      local entity = entity.local_player:GetPropEntity( "m_hMyWeapons", "00" .. i )

      if ( entity ~= nil ) then
         weapons[#weapons + 1] = entity:GetName( )
      end
   end

   local active_weapon = entity.local_player:GetPropEntity( "m_hActiveWeapon" )

   if ( active_weapon ~= nil and main.active_weapon ~= nil ) then
      if ( main.active_weapon.name ~= active_weapon:GetName( ) ) then
         main.active_weapon = {
            name = active_weapon:GetName( ),
            alpha = 0,
            creation_time = globals.CurTime( )
         }
      end
   end

   if ( main.active_weapon ~= nil ) then
      local alpha_speed = 1.5
      if ( globals.CurTime( ) < main.active_weapon.creation_time + alpha_speed ) then
         if ( main.active_weapon.creation_time + alpha_speed - globals.CurTime( ) > alpha_speed / 2 ) then
            main.active_weapon.alpha = 255 * ( alpha_speed / ( main.active_weapon.creation_time + alpha_speed - globals.CurTime( ) ) - 1 )
         else
            main.active_weapon.alpha = 255 * ( main.active_weapon.creation_time + alpha_speed - globals.CurTime( ) ) / ( alpha_speed / 2 )
         end

         render:text( render.screen_x / 2, render.screen_y / 2 - 20 , main.active_weapon.name, fonts.main, true, 255, 255, 255, main.active_weapon.alpha )
      end
   end

   for i = 1, #weapons do
      if ( weapons[i] ~= nil ) then
         local text_w, text_h = draw.GetTextSize( weapons[i] )

         if ( weapons[i] == main.active_weapon.name ) then
            render:text( render.screen_x - text_w - 5, render.screen_y - 15 * i , weapons[i], fonts.main, false, 255, 0, 0, 255 )
         else
            render:text( render.screen_x - text_w - 5, render.screen_y - 15 * i , weapons[i], fonts.main, false, 255, 255, 255, 255 )
         end
      end
   end
end

function main.user_message_callback( message )
   if ( main.game_rules.is_valve_server == false ) then
      return
   end

   if ( message:GetID() == 6 ) then
      local index = message:GetInt( 1 )
      local message = message:GetString( 4, 1 )

      local name = client.GetPlayerNameByIndex( index )

      main.chat_messages[#main.chat_messages + 1] = name .. ": " ..  message
    end
end

for i = 1, #game_events do
   if ( game_events[i] ~= nil ) then
      client.AllowListener( game_events[i] )
   end
end

callbacks.Register( "FireGameEvent", function( event )
   main.server_spawn_listener( event )
   main.game_start_listener( event )
   main.round_prestart_listener( event )
   main.round_start_listener( event )
   main.round_freeze_end_listener( event )
   main.bomb_planted_listener( event )
   main.player_hurt_listener( event )
   main.bullet_impact_listener( event )
   main.player_say_listener( event )
end )

callbacks.Register( "Draw", function( )
   entity.local_player = entities.GetLocalPlayer( )
   render.screen_x, render.screen_y = draw.GetScreenSize( )
   render.mouse_x, render.mouse_y = input.GetMousePos( )

   menu:handle( )
   main.draw_bullet_impacts( )
   main.draw_local_velocity( )
   main.draw_local_trail( )
   main.games_rules_proxy( )
   main.custom_hud( )
end )

callbacks.Register( "DispatchUserMessage", function( message )
   main.user_message_callback( message )
end )

callbacks.Register( "CreateMove", function( cmd )
   if ( main.is_typing == true ) then -- xd
      cmd:SetForwardMove( 0 )
      cmd:SetSideMove( 0 )

      cmd:SetButtons( cmd:GetButtons( ) & ~( 1 << 1 ) ) -- in jump
      cmd:SetButtons( cmd:GetButtons( ) & ~( 1 << 5 ) ) -- in use
   end
end )







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

