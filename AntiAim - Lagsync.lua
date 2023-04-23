local inverted = false;
local switch = false;
function DrawUI()
    screenX,screenY = draw.GetScreenSize();
    window = gui.Window("aawindow","AA Window",screenX/2,screenY/2,250,800);
    
    groupboxyaw = gui.Groupbox(window,"Base AA",20,15,200,200);
    invert_key = gui.Keybox(groupboxyaw,"invert_key","Inverter Key",0);
    yawamount = gui.Slider(groupboxyaw,"yaw_offset","Yaw Offset",0,-180,180);
    fakeamount = gui.Slider(groupboxyaw,"fake_amount","Fake Amount (%)",100,0,100);
    
    groupboxlag = gui.Groupbox(window,"Lagsync",20,250,200,200);
    lagsyncbox = gui.Combobox(groupboxlag,"lagsync_type","Lagsync Type","Off","CT Auto","Lagsync V1","Lagsync V2","Lagsync V3","Lagsync V4","Custom");
    delayamount = gui.Slider(groupboxlag,"delay_amount","Delay Amount (ticks)",1,1,64);
    
    window:SetOpenKey(45);
    
    lscustom = gui.Groupbox(window,"Lagsync Builder",20,450,200,200);
    lscustomyaw1 = gui.Slider(lscustom,"yawoffset1","Yaw Offset 1",0,-180,180);
    lscustomyaw2 = gui.Slider(lscustom,"yawoffset2","Yaw Offset 2",0,-180,180);
    lscustomfake1 = gui.Slider(lscustom,"fakeoffset1","Fake Amount 1",0,0,100);
    lscustomfake2 = gui.Slider(lscustom,"fakeoffset2","Fake Amount 2",0,0,100);
    
    lscustom:SetInvisible(true);
end

function YawHandler()

    if yawamount:GetValue() > 0 then
        gui.SetValue("rbot.antiaim.base",yawamount:GetValue()-180);
    else
        gui.SetValue("rbot.antiaim.base",yawamount:GetValue()+180);
    end
    
    if not inverted then
        gui.SetValue("rbot.antiaim.base.lby",fakeamount:GetValue()/100*60*-1);
        gui.SetValue("rbot.antiaim.base.rotation",fakeamount:GetValue()/100*58);
    else
        gui.SetValue("rbot.antiaim.base.lby",fakeamount:GetValue()/100*60);
        gui.SetValue("rbot.antiaim.base.rotation",fakeamount:GetValue()/100*58*-1);
    end
    
    
end

function KeyPressHandler()
    if invert_key:GetValue() ~= 0 then
        if input.IsButtonPressed(invert_key:GetValue()) then
            inverted = not inverted;
        end
    end
end

function lagsync(cmd)
    if cmd.tick_count % delayamount:GetValue() == 0 then
        switch = not switch;
    end
        if lagsyncbox:GetValue() == 1 then
        
                if switch then
                    yawamount:SetValue(2);
                    fakeamount:SetValue(70);
                else
                    yawamount:SetValue(17);
                    fakeamount:SetValue(75);
                end

            elseif lagsyncbox:GetValue() == 2 then
            
                if switch then
                    yawamount:SetValue(30);
                    fakeamount:SetValue(70);
                else
                    yawamount:SetValue(25);
                    fakeamount:SetValue(65);
                end
        
            elseif lagsyncbox:GetValue() == 3 then
                if switch then
                    yawamount:SetValue(25);
                    fakeamount:SetValue(100);
                else
                    yawamount:SetValue(-15);
                    fakeamount:SetValue(100);
                end
        
            elseif lagsyncbox:GetValue() == 4 then
                if switch then
                    yawamount:SetValue(-25);
                    fakeamount:SetValue(70);
                else
                    yawamount:SetValue(15);
                    fakeamount:SetValue(65);
                end
                
            elseif lagsyncbox:GetValue() == 5 then
                if switch then
                    yawamount:SetValue(-20);
                    fakeamount:SetValue(40);
                else
                    yawamount:SetValue(24);
                    fakeamount:SetValue(100);
                end
            
            elseif lagsyncbox:GetValue() == 6 then
                if switch then
                    yawamount:SetValue(lscustomyaw1:GetValue());
                    fakeamount:SetValue(lscustomfake1:GetValue());
                else
                    yawamount:SetValue(lscustomyaw2:GetValue());
                    fakeamount:SetValue(lscustomfake2:GetValue());
                end
        end
        
end

function GUIHandler()
    
    if lagsyncbox:GetValue() == 6 then
        lscustom:SetInvisible(false);
        window:SetHeight(800);
    else
        lscustom:SetInvisible(true);
        window:SetHeight(450);
    end
    
end

DrawUI();
callbacks.Register("CreateMove",lagsync);
callbacks.Register("Draw",YawHandler);
callbacks.Register("Draw",KeyPressHandler);
callbacks.Register("Draw",GUIHandler);