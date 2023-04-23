local a,b,c,d,e,f=1050,660,500,5,300,60;
local g=draw.CreateFont("Verdana",18,700)
local h=gui.Reference("Misc","General","Extra")
local i=gui.Checkbox(h,"_compact_speclist_check","Compact Spectator List",false)
i:SetDescription("See who is spectating you. Upper right side of the screen.")
local i2=gui.Editbox( h, "_compact_speclist.font.name", "Font Name" )
i2:SetDescription("Type in the Name of the font u want to use")
local j=gui.Slider(h,"_compact_speclist.font.size.slider","Font Size",13,5,25)
j:SetDescription("Choose a font size.")
local k=gui.Button(h,"Apply Font",function()g=draw.CreateFont(i2:GetValue(),j:GetValue(),1200)end)
local l=gui.ColorPicker(i,"_starlordaiden_colorpicker","Color",255,255,255,255)k:SetWidth(265)
local function m()
local n={}
local o=entities.GetLocalPlayer()
if i:GetValue()then 
if o~=nil then 
local p=entities.FindByClass("CCSPlayer")

for q=1,#p do 
local p=p[q]
if p~=o and p:GetHealth()<=0 then 
local r=p:GetName()
if p:GetPropEntity("m_hObserverTarget")~=nil then 
local s=p:GetIndex()
if r~="GOTV" and s~=1 then 
local t=p:GetPropEntity("m_hObserverTarget")
if t:IsPlayer()then 
local u=t:GetIndex()
local v=client.GetLocalPlayerIndex()
if o:IsAlive()then 
if u==v then 
table.insert(n,p)
end end end end end end end end end;
return n end;
local function w(n)
local x=false;
for y,p in pairs(n)do 
x=true;
draw.SetFont(g)
draw.Color(l:GetValue())
draw.Text(a-23,b-550-120+y*12,p:GetName())end end;
local function z(A)
local B,C=draw.GetTextSize(keytext)
local D=5+A*15;
local f=f+A*15 
end;
callbacks.Register("Draw",function()
local n=m()z(#n)w(n)
end)














--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

