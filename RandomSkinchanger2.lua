-- indexes of last paintkit available for each weapon
-- this may change after new skins are introduced to the game
ak47 = gs_ak47_nibbler, cu_ak47_aztec
aug = 22
awp = 24
bizon = 24
cz75a = 21
deagle = 24
elite = 21
famas = 18
fiveseven = 24
g3sg1 = 20
galilar = 22
glock = 26
hkp2000 = 21
m249 = 10
m4a1 = 26
m4a1_silencer = 23
mac10 = 24
mag7 = 20
mp5sd = 3
mp7 = 22
mp9 = 22
negev = 13
nova = 25
p250 = 31
p90 = 24
revolver = 8
sawedoff = 24
scar20 = 17
sg556 = 20 -- sg553
ssg08 = 16
tec9 = 26
ump45 = 23
usp_silencer = 21
xm1014 = 21
 
function main(event)
 
    -- if skinchanger is disabled, dont do anything
    if (gui.GetValue("esp.skins.enable") == 0) then

  -- on round start
    if (event:GetName() == 'round_start') then
   
        -- shuffle paintkits
        gui.SetValue("skin.add weapon_ak47", math.random(0, ak47))
        gui.SetValue("skin_aug_paintkit", math.random(0, aug))
        gui.SetValue("skin_awp_paintkit", math.random(0, awp))
        gui.SetValue("skin_bizon_paintkit", math.random(0, bizon))
        gui.SetValue("skin_cz75a_paintkit", math.random(0, cz75a))
        gui.SetValue("skin_deagle_paintkit", math.random(0, deagle))
        gui.SetValue("skin_elite_paintkit", math.random(0, elite))
        gui.SetValue("skin_famas_paintkit", math.random(0, famas))
        gui.SetValue("skin_fiveseven_paintkit", math.random(0, fiveseven))
        gui.SetValue("skin_g3sg1_paintkit", math.random(0, g3sg1))
        gui.SetValue("skin_galilar_paintkit", math.random(0, galilar))
        gui.SetValue("skin_glock_paintkit", math.random(0, glock))
        gui.SetValue("skin_hkp2000_paintkit", math.random(0, hkp2000))
        gui.SetValue("skin_m249_paintkit", math.random(0, m249))
        gui.SetValue("skin_m4a1_paintkit", math.random(0, m4a1))
        gui.SetValue("skin_m4a1_silencer_paintkit", math.random(0, m4a1_silencer))
        gui.SetValue("skin_mac10_paintkit", math.random(0, mac10))
        gui.SetValue("skin_mag7_paintkit", math.random(0, mag7))
        gui.SetValue("skin_mp5sd_paintkit", math.random(0, mp5sd))
        gui.SetValue("skin_mp7_paintkit", math.random(0, mp7))
        gui.SetValue("skin_mp9_paintkit", math.random(0, mp9))
        gui.SetValue("skin_negev_paintkit", math.random(0, negev))
        gui.SetValue("skin_nova_paintkit", math.random(0, nova))
        gui.SetValue("skin_p250_paintkit", math.random(0, p250))
        gui.SetValue("skin_p90_paintkit", math.random(0, p90))
        gui.SetValue("skin_revolver_paintkit", math.random(0, revolver))
        gui.SetValue("skin_sawedoff_paintkit", math.random(0, sawedoff))
        gui.SetValue("skin_scar20_paintkit", math.random(0, scar20))
        gui.SetValue("skin_sg556_paintkit", math.random(0, sg556))
        gui.SetValue("skin_ssg08_paintkit", math.random(0, ssg08))
        gui.SetValue("skin_tec9_paintkit", math.random(0, tec9))
        gui.SetValue("skin_ump45_paintkit", math.random(0, ump45))
        gui.SetValue("skin_usp_silencer_paintkit", math.random(0, usp_silencer))
        gui.SetValue("skin_xm1014_paintkit", math.random(0, xm1014))
       
        -- apply changes
        client.Command('cl_fullupdate', true)
    end
end
end

client.AllowListener('round_start')
callbacks.Register('FireGameEvent', 'random_skins', main)