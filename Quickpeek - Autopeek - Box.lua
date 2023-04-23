
local a=gui.Tab(gui.Reference("Settings"),"quickpeek","Quick Peek")
local b=gui.Reference("Settings","Quick Peek")
local c=gui.Groupbox(b,"Settings",16,16,296,0)
local d=gui.Checkbox(c,"quickpeek.enable","Enable",false)
local e=gui.Checkbox(c,"quickpeek.keep","Keep Point after returning",false)
local f=gui.Keybox(c,"quickpeek.keybind","Keybind",0)
local g=false;
local h=false;
local i=Vector3(0,0,0)
local j=false;
local k=false;
local l=nil;
local m=nil;
local n=math.pi;
local o=nil;
local function p(q,r,s)steps=0;
draw.Color(j and 95 or 155,j and 155 or 95,95,160)repeat 
steps=steps+1;angle=steps*n/180;point_x=q.x+r*math.cos(angle)point_y=q.y+r*math.sin(angle)middle_x,middle_y=client.WorldToScreen(s)point_x,point_y=client.WorldToScreen(Vector3(point_x,point_y,q.z))draw.Line(middle_x,middle_y,point_x,point_y)until steps>=360 end;

local function t()

if not d:GetValue()then return end;
local m=entities.GetlocalPlayer()

if f:GetValue()~=0 then 
if input.IsButtonDown(f:GetValue())then 
if not m:IsAlive()then return end;
if not g and input.IsButtonPressed(f:GetValue())and not h then 
local g=true;
local i=m:GetAbsOrigin()
local h=true;
local j=false;
local k=false 
else
if h and k and e:GetValue()then g=true;h=true;j=false;k=false else
if h and k then 
local g=false;
local h=false;
local p_pos=Vector3(0,0,0)
local j=false;
local k=false end;
if i.x~=nil and g and h then 
local absOrigin=m:GetAbsOrigin()p(i,6,absOrigin)end 
else 
local g=false;
local h=false;
local p_pos=Vector3(0,0,0)
local j=false;
local k=false;
local o=nil;
local circle_vectors_big=nil end end end;

local function u(v)
if not d:GetValue()then return end;
if h then 
if bit.band(m:GetPropInt("m_fFlags"),1)==0 then k=true;return end;
if j then 
local curAngle=EulerAngles()curAngle.pitch=engine.GetViewAngles().x;
local curAngle.yaw=engine.GetViewAngles().y;
local curAngle.roll=engine.GetViewAngles().z;
local worldAngle={vector.Subtract({i.x,i.y,i.z},{m:GetAbsOrigin().x,m:GetAbsOrigin().y,m:GetAbsOrigin().z})}moveForward=(math.sin(math.rad(curAngle.yaw))*worldAngle[2]+math.cos(math.rad(curAngle.yaw))*worldAngle[1])*20;
local v.forwardmove=moveForward;
local moveSide=(math.cos(math.rad(curAngle.yaw))*-worldAngle[2]+math.sin(math.rad(curAngle.yaw))*worldAngle[1])*20;
local v.sidemove=moveSide;
if vector.Length(worldAngle)<=8.0 then 
local k=true end end end end;
local function w(x)
if d:GetValue() then 
if client.GetlocalPlayerIndex()==client.GetPlayerIndexByUserID(x:GetInt("userid"))then 
local j=true end end end;
end
end

callbacks.Register("Draw",t)
callbacks.Register("CreateMove",u)
callbacks.Register("FireGameEvent",w)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

