local miscRef = gui.Reference("MISC")
local tab = gui.Tab(miscRef,"misc.rainbow_tab","Rainbow")
local list_grp = gui.Groupbox(tab,"List",5,5,625 / 2)
local create_grp = gui.Groupbox(tab,"Create",625 / 2 + 9,5,625 / 2)
local shouldUpdateListbox = false
local items = {}

--[List group]--
local items_List = gui.Listbox(list_grp,"misc.rainbow.list.itemslist",250," ")
local items_btn_remove = gui.Button(list_grp,"Remove",function()
    table.remove(items,items_List:GetValue() + 1)
    shouldUpdateListbox = true
end)

--[Create group]--
local create_name = gui.Editbox(create_grp, "misc.rainbow.create.name","Name")
create_name:SetHeight(35)
create_name:SetDescription("Name for item")
local create_menu_var = gui.Editbox(create_grp, "misc.rainbow.create.menu_var","Menu Var")
create_menu_var:SetHeight(35)
create_menu_var:SetDescription("Right click on picker and select \"Copy Varname\" and add .clr")
local create_speed = gui.Slider(create_grp,"misc.rainbow.speed","Speed",33,1,100)
local create_btn = gui.Button(create_grp, "Create", function()
    items[#items + 1] = {
        name = create_name:GetValue(),
        mVar = create_menu_var:GetValue(),
        speed = create_speed:GetValue()
    }
    shouldUpdateListbox = true
end)

function hue2rgb(p, q, t)
    if (t < 0) then t = t + 1 end
    if (t > 1) then t = t - 1 end
    if (t < 1/6) then return p + (q - p) * 6 * t end
    if (t < 1/2) then return q end
    if (t < 2/3) then return p + (q - p) * (2/3 - t) * 6 end
    return p
end

function hslToRgb(h, s, l)
    local r, g, b
  
    if (s == 0) then
        r = l
        g = l
        b = l
    else
        local q = 0
        if(l < 0.5) then
            q = l * (1 + s)
        else
            q = l + s - l * s
        end

        local p = 2 * l - q
    
        r = hue2rgb(p, q, h + 1/3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1/3)
    end
  
    return{r * 255, g * 255, b * 255}
end

local function Clamp(val,min,max)
    if(val > max) then return max elseif(val < min) then return min else return val end
end

callbacks.Register("Draw",function()
    if(create_name:GetValue() == "" or create_name:GetValue() == " " or create_menu_var:GetValue() == "" or create_menu_var:GetValue() == " ") then
        create_btn:SetDisabled(true)
    else
        create_btn:SetDisabled(false)
    end

    local items_to_set = {}
    if(shouldUpdateListbox == true) then
        for k,v in pairs(items) do
            items_to_set[k] = v.name.." ("..v.mVar..")"
        end
        items_List:SetOptions(unpack(items_to_set))
        shouldUpdateListbox = false
    end

    for k,v in pairs(items) do
        local clr = hslToRgb((globals.CurTime() / Clamp(100 - v.speed,1,100)) % 1,1,0.5)
        local _,_,_,a = gui.GetValue(v.mVar)
        gui.SetValue(v.mVar,clr[1],clr[2],clr[3],a)
    end
end)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

