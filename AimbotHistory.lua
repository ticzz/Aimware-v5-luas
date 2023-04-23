local a=false; --lynx related
local b={}

local aimware_ref={
    aimware=gui.Reference("MENU"), 
    miscGeneral=gui.Reference("SETTINGS","Miscellaneous")
}

local location_x,location_y=200,245;
local title_text="Aimbot History"
local lynx_verify='lynx_'..title_text:lower():gsub(" ","_")..'_'
local h;
local i;
local j={}
local k={}
local l={}
local hitboxes={
    "Head",
    "Chest",
    "Stomach",
    "Hand",
    "Arm",
    "Leg",
    "Leg",
    "Neck"
}

hitboxes[0]="-"

local list_id=0;
local font=draw.CreateFont("smallest pixel-7",11,100)
local all_list_logs={}
local table_list_sizes={
    table_size=7,
    size_x=300,
    size_y=40}
local mouse_x,mouse_y,dragging_list,u,v;

local function make_checkbox(x,y,gui_groupbox,...)

    b[#b+1]={lynx_verify..x,_G['gui'][y](gui_groupbox,lynx_verify..x,...)}
end;

local function get_value_intable(x)

    for B=1,#b do 

        local C=b[B]

        if C[1]==lynx_verify..x then 

            return C[2]:GetValue()
        end 

    end 

end;

local function set_value_intable(x,E)

    for B=1,#b do 

        local C=b[B]

        if C[1]==lynx_verify..x then 

            return C[2]:SetValue(E)
        end 

    end

end;

local function clear_logs()

    list_id=0;
    all_list_logs={}
end;

local val_of_330=330;
local show_controller=gui.Checkbox(aimware_ref.miscGeneral,"aimbot_history","[bruh] "..title_text,false)
local gui_window_controller=gui.Window(lynx_verify.."tabs","[bruh] "..title_text,200,200,location_x,location_y)
local gui_groupbox=gui.Groupbox(gui_window_controller,"Settings",13,13,location_x-25,location_y-105)

make_checkbox("enable","Checkbox",gui_groupbox,"Show Aimbot History",true)
make_checkbox("gradient","Checkbox",gui_groupbox,"Show Topbar Gradient",true)
make_checkbox("drag","Checkbox",gui_groupbox,"Draggable",true)

gui.Button(gui_groupbox,"Clear History",function()

    clear_logs()
end)

local function tablesize_MAYBE(local_player_angle_z,local_player_angle_y,M,N)

    return mouse_x>=local_player_angle_z and mouse_x<=M and mouse_y>=local_player_angle_y and mouse_y<=N 
end;

local function drag_through()

    if input.IsButtonDown(1) then 

        mouse_x,mouse_y=input.GetMousePos()

        if dragging_list then 

            table_list_sizes.size_x=mouse_x-u;table_list_sizes.size_y=mouse_y-v 
        end;

        if tablesize_MAYBE(table_list_sizes.size_x,table_list_sizes.size_y,table_list_sizes.size_x+val_of_330,table_list_sizes.size_y+20) then 

            dragging_list=true;
            u=mouse_x-table_list_sizes.size_x;v=mouse_y-table_list_sizes.size_y 
        end 

    else 

        dragging_list=false 
    end 

end;

local function P(Q,local_player_angle_z,local_player_angle_y,text)

    if text then 

        local local_player_angle_y=local_player_angle_y+4;
        local local_angle_plus10=local_player_angle_z+10;
        local T=local_player_angle_y+15+Q*16;
        local rainbow_r,rainbow_b,rainbow_g=0,0,0;

        if text.hit==1 then 

            rainbow_r,rainbow_b,rainbow_g=94,230,75 
        elseif text.hit==0 then 

            rainbow_r,rainbow_b,rainbow_g=245,127,23 
        else 

            rainbow_r,rainbow_b,rainbow_g=118,171,255 
        end;

        draw.Color(rainbow_r,rainbow_b,rainbow_g,255)
        draw.FilledRect(local_player_angle_z,T,local_player_angle_z+2,local_player_angle_y+15)
        draw.SetFont(font)
        draw.Color(255,255,255,255)
        draw.Text(local_angle_plus10-3,T+1,text.id)
        draw.Text(local_angle_plus10+33,T+1,text.player)
        draw.Color(0,255,0,255)
        draw.Text(local_angle_plus10+116,T+1,text.dmg)
        draw.Color(255,255,255,255)
        draw.Text(local_angle_plus10+153,T+1,text.box)
        draw.Text(local_angle_plus10+209,T+1,text.bt)
        draw.Color(209,228,34,255)
        draw.Text(local_angle_plus10+271,T+1,text.rs)

        return Q+1 
    end 

end;

callbacks.Register("Draw","CA1E30C3431",function()

    gui_window_controller:SetActive(show_controller:GetValue() and aimware_ref.aimware:IsActive())

--[[    if not a then 

        a=true;
        lynx.load("99",b) -- errors due to no lynx.load
    end;]]

    mouse_x,mouse_y=input.GetMousePos()

    if not get_value_intable('enable') then 

        return 
    end;

    local local_player_angle_z,local_player_angle_y,X=table_list_sizes.size_x,table_list_sizes.size_y,0;
    local size_of_table=table_list_sizes.table_size;
    local Z=27+16*(#all_list_logs>size_of_table and size_of_table or#all_list_logs)
    local rainbow_r=math.floor(math.sin(globals.RealTime()*2)*127+128)
    local rainbow_b=math.floor(math.sin(globals.RealTime()*2+2)*127+128)
    local rainbow_g=math.floor(math.sin(globals.RealTime()*2+4)*127+128)

    draw.Color(22,20,26,100)
    draw.FilledRect(local_player_angle_z,local_player_angle_y,local_player_angle_z+val_of_330,local_player_angle_y+Z)
    draw.Color(16,22,29,160)
    draw.FilledRect(local_player_angle_z,local_player_angle_y,local_player_angle_z+val_of_330,local_player_angle_y+15)

    if get_value_intable('gradient') then 

        draw.Color(rainbow_r,rainbow_b,rainbow_g,160)
        draw.FilledRect(local_player_angle_z,local_player_angle_y,local_player_angle_z+val_of_330,local_player_angle_y+2)
    end;
-- table top row creation
    draw.Color(255,255,255,255)
    draw.SetFont(font)
    draw.Text(local_player_angle_z+7,local_player_angle_y+3,"ID")
    draw.Text(local_player_angle_z+8+35,local_player_angle_y+3,"PLAYER")
    draw.Text(local_player_angle_z+7+114,local_player_angle_y+3,"DMG")
    draw.Text(local_player_angle_z+10+153,local_player_angle_y+3,"HITBOX")
    draw.Text(local_player_angle_z+10+201,local_player_angle_y+3,"BACKTRACK")
    draw.Text(local_player_angle_z+10+271,local_player_angle_y+3,"REASON")

    if get_value_intable('drag')  then 

        drag_through()
    end;

    for B=1,table_list_sizes.table_size,1 do 

        X=P(X,local_player_angle_z,local_player_angle_y,all_list_logs[B])
    end;

    local _=0;
    local miss_reason="-"
    local a1=0;
    local a2=0;
    
    if l[i]and h~=nil then 

        for B=table_list_sizes.table_size,2,-1 do 

            all_list_logs[B]=all_list_logs[B-1]
        end;

        local a3=j[i]
        local user_of_attacked_MAYBE=a3.user:GetName() 
        local backtrack_broken=1/globals.TickInterval()/5;
        local local_player=entities.GetLocalPlayer()
        local local_player_angle_z,local_player_angle_y,local_player_angle_z=local_player:GetProp("m_angEyeAngles")
        local redundant,redundant,entity=engine.TraceLine(local_player_angle_z,local_player_angle_y,local_player_angle_z,h.x,h.y,h.gui_groupbox,1174421515)

        if entity~=nil and entity:GetIndex()==i:GetIndex()and not k[i] then 

            miss_reason="resolver"
        elseif k[i] then 

        else 

            miss_reason="spread"
        end;

        h=nil;
        k[i]=false;
        l[i]=false;
        j[i]=nil;
        i=nil;
        list_id=list_id+1;

        all_list_logs[1]={
            ["id"]=list_id,
            ["hit"]=_,
            ["player"]=string.sub(user_of_attacked_MAYBE,0,14),
            ["dmg"]=a1,
            ["bt"]=backtrack_broken,
            ["box"]=hitboxes[a2],["rs"]=miss_reason
        }

    end 

end)

callbacks.Register("FireGameEvent","C292FAC6791",function(aa)

    local ab=aa:GetName()
    local ac=aa:GetInt("userid")
    local ad=entities.GetByUserID(ac)
    local local_player=entities.GetLocalPlayer()
    local ae=local_player:GetIndex()
    local af=client.GetPlayerIndexByUserID(ac)

    if ab=="round_start"or(ab=='player_death'and(ad~=nil and af==ae)or i~=nil and ae==i:GetIndex()) then 

        i=nil 
    end;

    if ab=="round_start" then 

        clear_logs()
    end;

    if ab=="bullet_impact" then 

        if ae==af and i~=nil then 

            h={
                x=aa:GetFloat('x'),
                y=aa:GetFloat('y'),
                gui_groupbox=aa:GetFloat('gui_groupbox')
            }
            l[i]=true;
            j[i]={
                user=ad,
                hitgroup=aa:GetInt('hitgroup'),
                health=aa:GetInt('health'),
                dmg_health=aa:GetInt('dmg_health')
            }
        end 

    elseif ab=="weapon_fire" then 

        if ae==af then 
            h=nil 
        end

    elseif ab=="player_hurt" then 

        local ag=aa:GetInt("attacker")
        if client.GetPlayerIndexByUserID(ag)==ae and af~=ae then 

            if i~=nil then 

                k[i]=true;

                j[i]={
                    user=ad,
                    hitgroup=aa:GetInt('hitgroup'),
                    health=aa:GetInt('health'),
                    dmg_health=aa:GetInt('dmg_health')
                }
            end 
        end 
    end 
end)

callbacks.Register('AimbotTarget',"CC207A4ED2C",function(entity)
    i=entity 
end)