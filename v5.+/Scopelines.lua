
local function rect(x, y, w, h, col)
    draw.Color(col[1], col[2], col[3], col[4]);
    draw.FilledRect(x, y, x + w, y + h);
end

local function gradientH(x1, y1, x2, y2,col1, left)
    local w = x2 - x1
    local h = y2 - y1
 
    for i = 0, w do
        local a = (i / w) * col1[4]
        local r, g, b = col1[1], col1[2], col1[3], col1[4];
        draw.Color(r, g, b, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end

local function gradientV( x, y, w, h, col1,down )

    local r, g, b ,a= col1[1], col1[2], col1[3], col1[4];
    for i = 1, h do
        local a = i / h * col1[4];
        if down then
            rect(x, y + i,w, 1, { r, g, b, a });
        else
            rect(x, y - i,w, 1, { r, g, b, a });
        end
    end
end

local function draw_GradientRect(x, y, w, h, dir, col1, col2)

    local r, g, b, a= col1[1], col1[2], col1[3], col1[4]; 
    local r2, g2, b2, a2= col2[1], col2[2], col2[3], col2[4]; 
    if dir == 0  then   
    gradientV(x, y, w, h, {r2, g2, b2, a2} , true)
    gradientV(x, y + h, w, h, {r, g, b, a} , false)
    elseif dir == 1  then
    gradientH(x, y, w + x, h + y, {r, g, b ,a} , true)
    gradientH(x, y, w + x, h + y, {r2, g2, b2 ,a2} , false)
    elseif dir ~= 1 or 0 then
        print("GradientRect:Unexpected characters '"..dir.."' (Please use it 0 or 1)")
    end

end
local alpha = 0
function drawshit()
    local localplayer = entities.GetLocalPlayer()
     local is_scoped = localplayer:GetPropBool("m_bIsScoped")

     local multiplier = (1.0 / ( overlay_fade:GetValue() /1000)) * globals.FrameTime()
  
      -- Health check to see if you are alive
      if is_scoped then
          if alpha < 1.0 then
              alpha = alpha + multiplier
          end
      else
          if alpha > 0.0 then
              alpha = alpha - multiplier
          end
      end
  
      -- clamp alpha not to go out of bounds
      if alpha >= 1.0 then
          alpha = 1
      end
     
      if alpha <= 0.0 then
          alpha = 0
          return 
      end
	 


local width, height = draw.GetScreenSize()
local screen_centerx, screen_centery = width / 2, height / 2

	local r,g,b,a = cpicker:GetValue()
	local thirdperson = gui.GetValue("esp.local.thirdperson")
	
    if not cscope:GetValue() then return end
    if is_scoped == true then
	
		client.SetConVar("r_drawvgui", 0, true);
		
		if cfovscope:GetValue() and not thirdperson then

       	 client.SetConVar("fov_cs_debug", 90, true);
		else
			client.SetConVar("fov_cs_debug", 0, true);
		end

        local scope_width = scope_width:GetValue()
        local scope_height = scope_height:GetValue()

        draw_GradientRect(screen_centerx, screen_centery - scope_height - (scope_padding:GetValue() - 1) , 1, scope_height * alpha, 0, { 0,0,0,0}, {r, g, b, a * alpha})-- top
        draw_GradientRect(screen_centerx, screen_centery + (scope_height * ( 1.0 - alpha )) + scope_padding:GetValue() , 1, scope_height - ( scope_height * ( 1.0 - alpha )) , 0, {r, g, b, a * alpha}, { 0,0,0,0})-- bottom

        draw_GradientRect(screen_centerx - scope_width - (scope_padding:GetValue() - 1),  screen_centery, scope_width * alpha, 1, 1, {r, g, b, a * alpha}, {0, 0, 0, 0}) -- left
        draw_GradientRect(screen_centerx + scope_padding:GetValue() + (scope_width * ( 1.0 - alpha )), screen_centery,  scope_width - ( scope_width * ( 1.0 - alpha ) ), 1, 1, { 0,0,0,0}, {r, g, b, a * alpha}) -- right


	
	else
	    client.SetConVar("r_drawvgui", 1, true);
        client.SetConVar("fov_cs_debug", 0, true);

    end
end

function UI()
    cscope = gui.Checkbox(gui.Reference("Visuals","Overlay", "Weapon"), "cscope", "Custom Scope Overlay", true)
	cfovscope = gui.Checkbox(gui.Reference("Visuals","Overlay", "Weapon"), "cfovscope", "Override FOV while scoped", false)
    cpicker = gui.ColorPicker(gui.Reference("Visuals","Overlay", "Weapon"), "cpicker", "Overlay Color", 255, 255, 255, 255)

	scope_padding = gui.Slider( gui.Reference("Visuals","Overlay", "Weapon"), "scope_padding", "scope_padding", 10, 0, 500 )
	scope_width = gui.Slider( gui.Reference("Visuals","Overlay", "Weapon"), "scope_width", "scope_width", 50, 0, 500 )
	scope_height = gui.Slider( gui.Reference("Visuals","Overlay", "Weapon"), "scope_height", "scope_height", 50, 0, 500 )
	overlay_fade = gui.Slider( gui.Reference("Visuals","Overlay", "Weapon"), "overlay_fade", "overlay_fade", 150, 0, 1000 )
	
	gui.SetValue('esp.other.noscope', false)
 	gui.SetValue('esp.other.noscopeoverlay', false)
 
	
end
UI();

callbacks.Register( "Draw", "drawinshit", drawshit );