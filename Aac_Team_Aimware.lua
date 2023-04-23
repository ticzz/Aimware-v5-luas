local I1iI1llIlIIll1i11iI = assert
local l11IIIlilIlI1iil1Il = select
local liiIi111lI1illllIlI = tonumber
local lIliliil1Iil1ii1iiI = unpack
local iilliIiI11IlIi1i1i1 = pcall
local lIl1IlIlIl1lI11IlI1ll = setfenv
local lIlIi1Illl1iillll1ill = setmetatable
local iiI1l111I11liiilI1i = type
local lIlI1IiIiiIIiI11111li = getfenv
local l11lIiIIIiIiil1iI11 = tostring
local lIi1i111li1li1illil = error
local lIl11Il1lllIlIiIIiI = string.sub
local IlIIiI1II1i1iiii1ll = string.byte
local ll1Ii1lI1iIllIlIIi1 = string.char
local lIlI1il1I1i1IIiIi1IIi = string.rep
local Ii1liIl1i11I11I1Iil = string.gsub
local i1I11IIi1Ii1iiIiiiI = string.match
local lIl11Il1IIl1ll11ilIll = table.insert
local IIil1IiilI1ilII1lii = IlIIiI1II1i1iiii1ll(")", 1)
local li1li1ii111IIlII1lI, lIlillI11I1IIi11iili1 = #{ 5286 }, #{ 4938, 5135, 6920, 4394, 914, 6941, 2435, 5095, 895, 201, 326, 1028, 5503, 2970, 1739, 1889, 6026, 1347, 199, 1875, 2277, 3390 } + IIil1IiilI1ilII1lii + 131008
local function Ill1lII1lIIllIll1I()
    return (function(IlIIIlIlIIlIIIIlll, lIllIIlllIlII, IIIIIIlIlllIIlll)
        local llIlIlIIllIllllIlllIIII = string.char;
        local IIllIlllIlll = string.sub;
        local IIIllIIIlIIIlI = table.concat;
        local llllllIllIIIIIIIlIIII = math.ldexp;
        local lllIIlIlIIllIlIllIIII = getfenv or function()
            return _ENV
        end;
        local IIIllIlllIllI = select;
        local lIIlIlIIll = unpack or table.unpack;
        local llIlIlllIllI = tonumber;
        local function lIllIlIlllllIIIII(IlIIIlIlIIlIIIIlll)
            local IllIIIIIIIllllllIII, IIllllIIII, IlIlIIIlIllIllllIIIl = "", "", {}
            local IIllIIlII = 256;
            local lIIlIlIIll = {}
            for llllIIIIIIllIIIlIlIllIlII = 0, IIllIIlII - 1 do
                lIIlIlIIll[llllIIIIIIllIIIlIlIllIlII] = llIlIlIIllIllllIlllIIII(llllIIIIIIllIIIlIlIllIlII)
            end ;
            local llllIIIIIIllIIIlIlIllIlII = 1;
            local function llllIllllIlIlI()
                local IllIIIIIIIllllllIII = llIlIlllIllI(IIllIlllIlll(IlIIIlIlIIlIIIIlll, llllIIIIIIllIIIlIlIllIlII, llllIIIIIIllIIIlIlIllIlII), 36)
                llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII + 1;
                local IIllllIIII = llIlIlllIllI(IIllIlllIlll(IlIIIlIlIIlIIIIlll, llllIIIIIIllIIIlIlIllIlII, llllIIIIIIllIIIlIlIllIlII + IllIIIIIIIllllllIII - 1), 36)
                llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII + IllIIIIIIIllllllIII;
                return IIllllIIII
            end;
            IllIIIIIIIllllllIII = llIlIlIIllIllllIlllIIII(llllIllllIlIlI())
            IlIlIIIlIllIllllIIIl[1] = IllIIIIIIIllllllIII;
            while llllIIIIIIllIIIlIlIllIlII < #IlIIIlIlIIlIIIIlll do
                local llllIIIIIIllIIIlIlIllIlII = llllIllllIlIlI()
                if lIIlIlIIll[llllIIIIIIllIIIlIlIllIlII] then
                    IIllllIIII = lIIlIlIIll[llllIIIIIIllIIIlIlIllIlII]
                else
                    IIllllIIII = IllIIIIIIIllllllIII .. IIllIlllIlll(IllIIIIIIIllllllIII, 1, 1)
                end ;
                lIIlIlIIll[IIllIIlII] = IllIIIIIIIllllllIII .. IIllIlllIlll(IIllllIIII, 1, 1)
                IlIlIIIlIllIllllIIIl[#IlIlIIIlIllIllllIIIl + 1], IllIIIIIIIllllllIII, IIllIIlII = IIllllIIII, IIllllIIII, IIllIIlII + 1
            end ;
            return table.concat(IlIlIIIlIllIllllIIIl)
        end;
        local llIlIlllIllI = lIllIlIlllllIIIII('1K1J2751H1L2751J23423J23E23A23H22V1H1U27922C23A22V21V23J23622Y23A22P22I23H23923G1H1G27923822U23E27X27921Z23623527727921W23E23H23B23G22S1H1N27923F22V22V22R28327527K22V1A2791121R2791I27921F1V2792761J28T1J28W28W2751L1Y1J1H28V29427518290279131Z29D29B29B29328W27Y27528Y29D28W28H29329B29P1J2981J27Y29529D1J29F2752961J29I29A1J28H27Y29V2A028X28Z29L1J1M29228U27Y29X29Z28H29B2A22A427929B2752A927Y2AK29U2AM29Y2AG2AF27Y27429328H2782972992AK2A12A32A52AF2AW29J28H2742AK1J1529C27928H27529X28827522U23H22R23623423C1H27427521S22V23A23623I22I22F1I1P2901E2A328S2912A727929X29G2BQ29G2BG2A321I2AA2CK21N2CF29B1Z21C29K2BG28H28W2AV2752BN2A62CN2751R2AU28Z27521Z2C623I21F22A22I22M21W22A21T22E2C127921J2121Z21F22N22U23628N1J2802822CM2DC22Z27G2D427A22P2BY23C23A23B21F23522Y21F22O22V2E722Y21C2112122171Z2DN2C327L21V23G22O2232CK1J24Z23122B2EO1J21S2EQ2ES2221927921H21E2AA1029S2AB112792FB2961S2CO2CL2D62AJ2CF2FE2B22D22CJ2FP2922752AC28X2FU2AB2FY2792BC2CG2B22BL2902B82AA21F2752AZ2B22FO2742C22902AK27428W2G82FM28H2D82GC1J2GE2G02GO2CF2AF2FQ2FI2EV1J122FZ2CN2AK2CI2972AA29G27Y2B92902GW2902A72CK2D21H1D28X21F2HH2HI2HJ2HK2HH2DC2C72DF2DH2DJ2DL1H1C2HG2HL2HW2HX21F2DP2DR2DT2362E421H21G29D2BD29T2FO2AF2I927928Z2FH2B229G1W2GR2902FO2D82FQ2751Q2H42902CC2GW1O2GZ2ID2FM29G2782DA2902H72792FI2J227521K2IJ2CN2D82H21J2IP2IN1J2IS2CN2IU2CM2IW2G42792IZ2CN2J529G2A72J22HD21J28I28K22R22O21521O21O22S2K221P23622P2BX23421P23E23G21O23J2DU21O2EF2DD23E23B21P22V2E21H2A71Z2CC2752F82BP2FC1N2IA2D02922JU2AI2KT2L02752FI2JE2G12D62KX29G29B2JJ2912FL2CU290');
        local llllIIIIIIllIIIlIlIllIlII = (bit or bit32);
        local IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII and llllIIIIIIllIIIlIlIllIlII.bxor or function(llllIIIIIIllIIIlIlIllIlII, IllIIIIIIIllllllIII)
            local IIllllIIII, IlIlIIIlIllIllllIIIl, IIllIlllIlll = 1, 0, 10
            while llllIIIIIIllIIIlIlIllIlII > 0 and IllIIIIIIIllllllIII > 0 do
                local lIIlIlIIll, IIllIlllIlll = llllIIIIIIllIIIlIlIllIlII % 2, IllIIIIIIIllllllIII % 2
                if lIIlIlIIll ~= IIllIlllIlll then
                    IlIlIIIlIllIllllIIIl = IlIlIIIlIllIllllIIIl + IIllllIIII
                end
                llllIIIIIIllIIIlIlIllIlII, IllIIIIIIIllllllIII, IIllllIIII = (llllIIIIIIllIIIlIlIllIlII - lIIlIlIIll) / 2, (IllIIIIIIIllllllIII - IIllIlllIlll) / 2, IIllllIIII * 2
            end
            if llllIIIIIIllIIIlIlIllIlII < IllIIIIIIIllllllIII then
                llllIIIIIIllIIIlIlIllIlII = IllIIIIIIIllllllIII
            end
            while llllIIIIIIllIIIlIlIllIlII > 0 do
                local IllIIIIIIIllllllIII = llllIIIIIIllIIIlIlIllIlII % 2
                if IllIIIIIIIllllllIII > 0 then
                    IlIlIIIlIllIllllIIIl = IlIlIIIlIllIllllIIIl + IIllllIIII
                end
                llllIIIIIIllIIIlIlIllIlII, IIllllIIII = (llllIIIIIIllIIIlIlIllIlII - IllIIIIIIIllllllIII) / 2, IIllllIIII * 2
            end
            return IlIlIIIlIllIllllIIIl
        end
        local function IIllllIIII(IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII, IIllllIIII)
            if IIllllIIII then
                local llllIIIIIIllIIIlIlIllIlII = (IllIIIIIIIllllllIII / 2 ^ (llllIIIIIIllIIIlIlIllIlII - 1)) % 2 ^ ((IIllllIIII - 1) - (llllIIIIIIllIIIlIlIllIlII - 1) + 1);
                return llllIIIIIIllIIIlIlIllIlII - llllIIIIIIllIIIlIlIllIlII % 1;
            else
                local llllIIIIIIllIIIlIlIllIlII = 2 ^ (llllIIIIIIllIIIlIlIllIlII - 1);
                return (IllIIIIIIIllllllIII % (llllIIIIIIllIIIlIlIllIlII + llllIIIIIIllIIIlIlIllIlII) >= llllIIIIIIllIIIlIlIllIlII) and 1 or 0;
            end ;
        end;
        local llllIIIIIIllIIIlIlIllIlII = 1;
        local function IllIIIIIIIllllllIII()
            local IllIIIIIIIllllllIII, IIllllIIII, lIIlIlIIll, IIllIlllIlll = IlIIIlIlIIlIIIIlll(llIlIlllIllI, llllIIIIIIllIIIlIlIllIlII, llllIIIIIIllIIIlIlIllIlII + 3);
            IllIIIIIIIllllllIII = IlIlIIIlIllIllllIIIl(IllIIIIIIIllllllIII, 19)
            IIllllIIII = IlIlIIIlIllIllllIIIl(IIllllIIII, 19)
            lIIlIlIIll = IlIlIIIlIllIllllIIIl(lIIlIlIIll, 19)
            IIllIlllIlll = IlIlIIIlIllIllllIIIl(IIllIlllIlll, 19)
            llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII + 4;
            return (IIllIlllIlll * 16777216) + (lIIlIlIIll * 65536) + (IIllllIIII * 256) + IllIIIIIIIllllllIII;
        end;
        local function llllIllllIlIlI()
            local IllIIIIIIIllllllIII = IlIlIIIlIllIllllIIIl(IlIIIlIlIIlIIIIlll(llIlIlllIllI, llllIIIIIIllIIIlIlIllIlII, llllIIIIIIllIIIlIlIllIlII), 19);
            llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII + 1;
            return IllIIIIIIIllllllIII;
        end;
        local function IIllIIlII()
            local IllIIIIIIIllllllIII, IIllllIIII = IlIIIlIlIIlIIIIlll(llIlIlllIllI, llllIIIIIIllIIIlIlIllIlII, llllIIIIIIllIIIlIlIllIlII + 2);
            IllIIIIIIIllllllIII = IlIlIIIlIllIllllIIIl(IllIIIIIIIllllllIII, 19)
            IIllllIIII = IlIlIIIlIllIllllIIIl(IIllllIIII, 19)
            llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII + 2;
            return (IIllllIIII * 256) + IllIIIIIIIllllllIII;
        end;
        local function llllllllllIIIIlI()
            local IlIlIIIlIllIllllIIIl = IllIIIIIIIllllllIII();
            local llllIIIIIIllIIIlIlIllIlII = IllIIIIIIIllllllIII();
            local IIllIlllIlll = 1;
            local IlIlIIIlIllIllllIIIl = (IIllllIIII(llllIIIIIIllIIIlIlIllIlII, 1, 20) * (2 ^ 32)) + IlIlIIIlIllIllllIIIl;
            local IllIIIIIIIllllllIII = IIllllIIII(llllIIIIIIllIIIlIlIllIlII, 21, 31);
            local llllIIIIIIllIIIlIlIllIlII = ((-1) ^ IIllllIIII(llllIIIIIIllIIIlIlIllIlII, 32));
            if (IllIIIIIIIllllllIII == 0) then
                if (IlIlIIIlIllIllllIIIl == 0) then
                    return llllIIIIIIllIIIlIlIllIlII * 0;
                else
                    IllIIIIIIIllllllIII = 1;
                    IIllIlllIlll = 0;
                end ;
            elseif (IllIIIIIIIllllllIII == 2047) then
                return (IlIlIIIlIllIllllIIIl == 0) and (llllIIIIIIllIIIlIlIllIlII * (1 / 0)) or (llllIIIIIIllIIIlIlIllIlII * (0 / 0));
            end ;
            return llllllIllIIIIIIIlIIII(llllIIIIIIllIIIlIlIllIlII, IllIIIIIIIllllllIII - 1023) * (IIllIlllIlll + (IlIlIIIlIllIllllIIIl / (2 ^ 52)));
        end;
        local lIllIlIlllllIIIII = IllIIIIIIIllllllIII;
        local function llllllIllIIIIIIIlIIII(IllIIIIIIIllllllIII)
            local IIllllIIII;
            if (not IllIIIIIIIllllllIII) then
                IllIIIIIIIllllllIII = lIllIlIlllllIIIII();
                if (IllIIIIIIIllllllIII == 0) then
                    return '';
                end ;
            end ;
            IIllllIIII = IIllIlllIlll(llIlIlllIllI, llllIIIIIIllIIIlIlIllIlII, llllIIIIIIllIIIlIlIllIlII + IllIIIIIIIllllllIII - 1);
            llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII + IllIIIIIIIllllllIII;
            local IllIIIIIIIllllllIII = {}
            for llllIIIIIIllIIIlIlIllIlII = 1, #IIllllIIII do
                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII] = llIlIlIIllIllllIlllIIII(IlIlIIIlIllIllllIIIl(IlIIIlIlIIlIIIIlll(IIllIlllIlll(IIllllIIII, llllIIIIIIllIIIlIlIllIlII, llllIIIIIIllIIIlIlIllIlII)), 19))
            end
            return IIIllIIIlIIIlI(IllIIIIIIIllllllIII);
        end;
        local llllIIIIIIllIIIlIlIllIlII = IllIIIIIIIllllllIII;
        local function IIIllIIIlIIIlI(...)
            return { ... }, IIIllIlllIllI('#', ...)
        end
        local function llIlIlIIllIllllIlllIIII()
            local IlIIIlIlIIlIIIIlll = {};
            local lIllIlIlllllIIIII = {};
            local llllIIIIIIllIIIlIlIllIlII = {};
            local llIlIlllIllI = { [#{ { 24; 199; 264; 313 }; "1 + 1 = 111"; }] = lIllIlIlllllIIIII, [#{ "1 + 1 = 111"; { 357; 467; 897; 288 }; "1 + 1 = 111"; }] = nil, [#{ { 568; 222; 260; 93 }; "1 + 1 = 111"; { 997; 935; 274; 649 }; "1 + 1 = 111"; }] = llllIIIIIIllIIIlIlIllIlII, [#{ { 61; 162; 363; 513 }; }] = IlIIIlIlIIlIIIIlll, };
            local llllIIIIIIllIIIlIlIllIlII = IllIIIIIIIllllllIII()
            local IlIlIIIlIllIllllIIIl = {}
            for IIllllIIII = 1, llllIIIIIIllIIIlIlIllIlII do
                local IllIIIIIIIllllllIII = llllIllllIlIlI();
                local llllIIIIIIllIIIlIlIllIlII;
                if (IllIIIIIIIllllllIII == 0) then
                    llllIIIIIIllIIIlIlIllIlII = (llllIllllIlIlI() ~= 0);
                elseif (IllIIIIIIIllllllIII == 3) then
                    llllIIIIIIllIIIlIlIllIlII = llllllllllIIIIlI();
                elseif (IllIIIIIIIllllllIII == 2) then
                    llllIIIIIIllIIIlIlIllIlII = llllllIllIIIIIIIlIIII();
                end ;
                IlIlIIIlIllIllllIIIl[IIllllIIII] = llllIIIIIIllIIIlIlIllIlII;
            end ;
            for llIlIlllIllI = 1, IllIIIIIIIllllllIII() do
                local llllIIIIIIllIIIlIlIllIlII = llllIllllIlIlI();
                if (IIllllIIII(llllIIIIIIllIIIlIlIllIlII, 1, 1) == 0) then
                    local IIllIlllIlll = IIllllIIII(llllIIIIIIllIIIlIlIllIlII, 2, 3);
                    local lIIlIlIIll = IIllllIIII(llllIIIIIIllIIIlIlIllIlII, 4, 6);
                    local llllIIIIIIllIIIlIlIllIlII = { IIllIIlII(), IIllIIlII(), nil, nil };
                    if (IIllIlllIlll == 0) then
                        llllIIIIIIllIIIlIlIllIlII[#("JFk")] = IIllIIlII();
                        llllIIIIIIllIIIlIlIllIlII[#("3RxG")] = IIllIIlII();
                    elseif (IIllIlllIlll == 1) then
                        llllIIIIIIllIIIlIlIllIlII[#{ { 802; 542; 934; 198 }; "1 + 1 = 111"; { 778; 458; 931; 624 }; }] = IllIIIIIIIllllllIII();
                    elseif (IIllIlllIlll == 2) then
                        llllIIIIIIllIIIlIlIllIlII[#("s8o")] = IllIIIIIIIllllllIII() - (2 ^ 16)
                    elseif (IIllIlllIlll == 3) then
                        llllIIIIIIllIIIlIlIllIlII[#("Orr")] = IllIIIIIIIllllllIII() - (2 ^ 16)
                        llllIIIIIIllIIIlIlIllIlII[#("5vOC")] = IIllIIlII();
                    end ;
                    if (IIllllIIII(lIIlIlIIll, 1, 1) == 1) then
                        llllIIIIIIllIIIlIlIllIlII[#("Ez")] = IlIlIIIlIllIllllIIIl[llllIIIIIIllIIIlIlIllIlII[#("4J")]]
                    end
                    if (IIllllIIII(lIIlIlIIll, 2, 2) == 1) then
                        llllIIIIIIllIIIlIlIllIlII[#{ { 509; 396; 509; 143 }; "1 + 1 = 111"; { 488; 848; 863; 443 }; }] = IlIlIIIlIllIllllIIIl[llllIIIIIIllIIIlIlIllIlII[#("5oi")]]
                    end
                    if (IIllllIIII(lIIlIlIIll, 3, 3) == 1) then
                        llllIIIIIIllIIIlIlIllIlII[#("1ar0")] = IlIlIIIlIllIllllIIIl[llllIIIIIIllIIIlIlIllIlII[#("zPWs")]]
                    end
                    IlIIIlIlIIlIIIIlll[llIlIlllIllI] = llllIIIIIIllIIIlIlIllIlII;
                end
            end ;
            llIlIlllIllI[3] = llllIllllIlIlI();
            for llllIIIIIIllIIIlIlIllIlII = 1, IllIIIIIIIllllllIII() do
                lIllIlIlllllIIIII[llllIIIIIIllIIIlIlIllIlII - 1] = llIlIlIIllIllllIlllIIII();
            end ;
            return llIlIlllIllI;
        end;
        local function lIllIlIlllllIIIII(llllIIIIIIllIIIlIlIllIlII, llIlIlllIllI, IlIIIlIlIIlIIIIlll)
            llllIIIIIIllIIIlIlIllIlII = (llllIIIIIIllIIIlIlIllIlII == true and llIlIlIIllIllllIlllIIII()) or llllIIIIIIllIIIlIlIllIlII;
            return (function(...)
                local IIllIlllIlll = llllIIIIIIllIIIlIlIllIlII[1];
                local IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[3];
                local llllllIllIIIIIIIlIIII = llllIIIIIIllIIIlIlIllIlII[2];
                local IIIllIIIlIIIlI = IIIllIIIlIIIlI
                local IIllllIIII = 1;
                local IIllIIlII = -1;
                local llIlIlIIllIllllIlllIIII = {};
                local llllllllllIIIIlI = { ... };
                local IIIllIlllIllI = IIIllIlllIllI('#', ...) - 1;
                local llllIllllIlIlI = {};
                local IllIIIIIIIllllllIII = {};
                for llllIIIIIIllIIIlIlIllIlII = 0, IIIllIlllIllI do
                    if (llllIIIIIIllIIIlIlIllIlII >= IlIlIIIlIllIllllIIIl) then
                        llIlIlIIllIllllIlllIIII[llllIIIIIIllIIIlIlIllIlII - IlIlIIIlIllIllllIIIl] = llllllllllIIIIlI[llllIIIIIIllIIIlIlIllIlII + 1];
                    else
                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII] = llllllllllIIIIlI[llllIIIIIIllIIIlIlIllIlII + #{ { 939; 894; 54; 547 }; }];
                    end ;
                end ;
                local IIIllIlllIllI = IIIllIlllIllI - IlIlIIIlIllIllllIIIl + 1
                local llllIIIIIIllIIIlIlIllIlII;
                local IlIlIIIlIllIllllIIIl;
                while true do
                    llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                    IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("j")];
                    if IlIlIIIlIllIllllIIIl <= #("B0xJ4xHM3xqRzrI3CxZoS8HfM") then
                        if IlIlIIIlIllIllllIIIl <= #("FO113s6bU7Te") then
                            if IlIlIIIlIllIllllIIIl <= #("OPSsj") then
                                if IlIlIIIlIllIllllIIIl <= #("ml") then
                                    if IlIlIIIlIllIllllIIIl <= #("") then
                                        local IIllIIlII;
                                        local IlIlIIIlIllIllllIIIl;
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("nc")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("BdF")]];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Tn")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("R4D")]];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("OO")]] = llllIIIIIIllIIIlIlIllIlII[#("Jku")];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("ao")]
                                        IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl] = IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl](lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl + 1, llllIIIIIIllIIIlIlIllIlII[#{ { 380; 836; 857; 501 }; { 550; 792; 176; 288 }; { 643; 131; 682; 823 }; }]))
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("vp")]] = IlIIIlIlIIlIIIIlll[llllIIIIIIllIIIlIlIllIlII[#("xTG")]];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#{ { 217; 554; 604; 958 }; "1 + 1 = 111"; }]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("GNx")]][llllIIIIIIllIIIlIlIllIlII[#("6kI5")]];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("x9")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Wdr")]];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("A4")]] = llllIIIIIIllIIIlIlIllIlII[#("3jR")];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("2B")]
                                        IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl] = IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl](lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl + 1, llllIIIIIIllIIIlIlIllIlII[#("vZN")]))
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; { 226; 462; 39; 480 }; }];
                                        IIllIIlII = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("cLG")]];
                                        IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl + 1] = IIllIIlII;
                                        IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl] = IIllIIlII[llllIIIIIIllIIIlIlIllIlII[#("z7DA")]];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("77")]] = llllIIIIIIllIIIlIlIllIlII[#("FzX")];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("l1")]
                                        IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl](lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl + 1, llllIIIIIIllIIIlIlIllIlII[#("6lr")]))
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("YW")];
                                        IIllIIlII = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("JGy")]];
                                        IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl + 1] = IIllIIlII;
                                        IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl] = IIllIIlII[llllIIIIIIllIIIlIlIllIlII[#("R2qK")]];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("DW")]] = llllIIIIIIllIIIlIlIllIlII[#("T9Z")];
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("Mj")]
                                        IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl](lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl + 1, llllIIIIIIllIIIlIlIllIlII[#("QNG")]))
                                        IIllllIIII = IIllllIIII + 1;
                                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                        do
                                            return IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Yk")]]
                                        end
                                    elseif IlIlIIIlIllIllllIIIl > #("m") then
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("HE")]] = {};
                                    else
                                        local IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("QI")]
                                        IllIIIIIIIllllllIII[IIllllIIII](lIIlIlIIll(IllIIIIIIIllllllIII, IIllllIIII + 1, llllIIIIIIllIIIlIlIllIlII[#("Mt6")]))
                                    end ;
                                elseif IlIlIIIlIllIllllIIIl <= #("AOu") then
                                    do
                                        return
                                    end ;
                                elseif IlIlIIIlIllIllllIIIl == #("Dsq6") then
                                    do
                                        return IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("bX")]]
                                    end
                                else
                                    local IlIlIIIlIllIllllIIIl;
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("U1")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("DaT")]];
                                    IIllllIIII = IIllllIIII + 1;
                                    llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("zC")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Bhq")]];
                                    IIllllIIII = IIllllIIII + 1;
                                    llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                    IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("Mc")];
                                    do
                                        return IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl](lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl + 1, llllIIIIIIllIIIlIlIllIlII[#("mhN")]))
                                    end ;
                                    IIllllIIII = IIllllIIII + 1;
                                    llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                    IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("tk")];
                                    do
                                        return lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl, IIllIIlII)
                                    end ;
                                    IIllllIIII = IIllllIIII + 1;
                                    llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                    do
                                        return
                                    end ;
                                end ;
                            elseif IlIlIIIlIllIllllIIIl <= #("12VbD8Uy") then
                                if IlIlIIIlIllIllllIIIl <= #("Kkx2lJ") then
                                    local IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("sk")];
                                    do
                                        return IllIIIIIIIllllllIII[IIllllIIII](lIIlIlIIll(IllIIIIIIIllllllIII, IIllllIIII + 1, llllIIIIIIllIIIlIlIllIlII[#("Z35")]))
                                    end ;
                                elseif IlIlIIIlIllIllllIIIl > #{ { 304; 222; 326; 159 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 941; 194; 473; 953 }; "1 + 1 = 111"; "1 + 1 = 111"; } then
                                    if (IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("u4")]] == llllIIIIIIllIIIlIlIllIlII[#("mSRn")]) then
                                        IIllllIIII = IIllllIIII + 1;
                                    else
                                        IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("WRK")];
                                    end ;
                                else
                                    local IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("lX")];
                                    local IlIlIIIlIllIllllIIIl = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("WFM")]];
                                    IllIIIIIIIllllllIII[IIllllIIII + 1] = IlIlIIIlIllIllllIIIl;
                                    IllIIIIIIIllllllIII[IIllllIIII] = IlIlIIIlIllIllllIIIl[llllIIIIIIllIIIlIlIllIlII[#("xs3E")]];
                                end ;
                            elseif IlIlIIIlIllIllllIIIl <= #("5DOLDqPChH") then
                                if IlIlIIIlIllIllllIIIl == #("W7qQZDYzX") then
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Ve")]] = {};
                                else
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("HP")]][llllIIIIIIllIIIlIlIllIlII[#("9Zl")]] = llllIIIIIIllIIIlIlIllIlII[#("sKsM")];
                                end ;
                            elseif IlIlIIIlIllIllllIIIl > #{ "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 349; 618; 250; 912 }; "1 + 1 = 111"; { 313; 94; 906; 653 }; { 889; 519; 813; 908 }; { 297; 724; 459; 294 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; } then
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("bq")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("e2W")]][llllIIIIIIllIIIlIlIllIlII[#("TBtO")]];
                            else
                                local llIlIlIIllIllllIlllIIII = llllllIllIIIIIIIlIIII[llllIIIIIIllIIIlIlIllIlII[#("Dya")]];
                                local IIllIIlII;
                                local IlIlIIIlIllIllllIIIl = {};
                                IIllIIlII = IIIIIIlIlllIIlll({}, { __index = function(IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII)
                                    local llllIIIIIIllIIIlIlIllIlII = IlIlIIIlIllIllllIIIl[llllIIIIIIllIIIlIlIllIlII];
                                    return llllIIIIIIllIIIlIlIllIlII[1][llllIIIIIIllIIIlIlIllIlII[2]];
                                end, __newindex = function(IIllllIIII, llllIIIIIIllIIIlIlIllIlII, IllIIIIIIIllllllIII)
                                    local llllIIIIIIllIIIlIlIllIlII = IlIlIIIlIllIllllIIIl[llllIIIIIIllIIIlIlIllIlII]
                                    llllIIIIIIllIIIlIlIllIlII[1][llllIIIIIIllIIIlIlIllIlII[2]] = IllIIIIIIIllllllIII;
                                end; });
                                for lIIlIlIIll = 1, llllIIIIIIllIIIlIlIllIlII[#("TiBj")] do
                                    IIllllIIII = IIllllIIII + 1;
                                    local llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                    if llllIIIIIIllIIIlIlIllIlII[#{ { 543; 104; 694; 806 }; }] == 27 then
                                        IlIlIIIlIllIllllIIIl[lIIlIlIIll - 1] = { IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII[#("Ctj")] };
                                    else
                                        IlIlIIIlIllIllllIIIl[lIIlIlIIll - 1] = { llIlIlllIllI, llllIIIIIIllIIIlIlIllIlII[#("pMa")] };
                                    end ;
                                    llllIllllIlIlI[#llllIllllIlIlI + 1] = IlIlIIIlIllIllllIIIl;
                                end ;
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("fj")]] = lIllIlIlllllIIIII(llIlIlIIllIllllIlllIIII, IIllIIlII, IlIIIlIlIIlIIIIlll);
                            end ;
                        elseif IlIlIIIlIllIllllIIIl <= #("ggati4q5TpvyWczRD6") then
                            if IlIlIIIlIllIllllIIIl <= #("iDMv4kZ4FTDKsEk") then
                                if IlIlIIIlIllIllllIIIl <= #("kPFt3h2ttme9F") then
                                    local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; { 858; 512; 189; 21 }; }]
                                    local IlIlIIIlIllIllllIIIl, IIllllIIII = IIIllIIIlIIIlI(IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII](IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII + 1]))
                                    IIllIIlII = IIllllIIII + llllIIIIIIllIIIlIlIllIlII - 1
                                    local IIllllIIII = 0;
                                    for llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII, IIllIIlII do
                                        IIllllIIII = IIllllIIII + 1;
                                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII] = IlIlIIIlIllIllllIIIl[IIllllIIII];
                                    end ;
                                elseif IlIlIIIlIllIllllIIIl == #("oGLqkiEVgjs9Wm") then
                                    IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("xS8")];
                                else
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("7e")]] = llIlIlllIllI[llllIIIIIIllIIIlIlIllIlII[#("R52")]];
                                end ;
                            elseif IlIlIIIlIllIllllIIIl <= #("Pc4Mlob7NcaLrbRf") then
                                local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#("ha")];
                                do
                                    return lIIlIlIIll(IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII, IIllIIlII)
                                end ;
                            elseif IlIlIIIlIllIllllIIIl > #("AhE69ctbxAJva4vQd") then
                                IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("UKO")];
                            else
                                local IlIlIIIlIllIllllIIIl;
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("HE")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("zy8")]];
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; "1 + 1 = 111"; }]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("51R")]];
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("7u")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("vCO")]];
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("vZ")];
                                do
                                    return IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl](lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl + 1, llllIIIIIIllIIIlIlIllIlII[#("2ai")]))
                                end ;
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("y8")];
                                do
                                    return lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl, IIllIIlII)
                                end ;
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                do
                                    return
                                end ;
                            end ;
                        elseif IlIlIIIlIllIllllIIIl <= #("kkxtimJ7ojImTzdDKPStP") then
                            if IlIlIIIlIllIllllIIIl <= #{ "1 + 1 = 111"; "1 + 1 = 111"; { 195; 954; 267; 596 }; { 447; 89; 240; 830 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 420; 770; 565; 206 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 614; 734; 865; 16 }; "1 + 1 = 111"; { 336; 870; 233; 492 }; { 286; 771; 32; 99 }; "1 + 1 = 111"; "1 + 1 = 111"; } then
                                local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#("H1")];
                                local IIllllIIII = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII];
                                for llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII + 1, IIllIIlII do
                                    lIllIIlllIlII(IIllllIIII, IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII])
                                end ;
                            elseif IlIlIIIlIllIllllIIIl == #{ { 518; 744; 492; 342 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 784; 938; 748; 536 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 86; 791; 967; 509 }; { 771; 682; 777; 959 }; { 556; 644; 387; 948 }; { 810; 344; 463; 923 }; "1 + 1 = 111"; "1 + 1 = 111"; { 269; 73; 536; 80 }; "1 + 1 = 111"; "1 + 1 = 111"; { 167; 622; 313; 91 }; { 666; 243; 424; 851 }; } then
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("9K")]] = IlIIIlIlIIlIIIIlll[llllIIIIIIllIIIlIlIllIlII[#("Ihh")]];
                            else
                                local IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("0o")]
                                IllIIIIIIIllllllIII[IIllllIIII](lIIlIlIIll(IllIIIIIIIllllllIII, IIllllIIII + 1, llllIIIIIIllIIIlIlIllIlII[#("Fa9")]))
                            end ;
                        elseif IlIlIIIlIllIllllIIIl <= #("fFN7x2i9FQB5NmCfOistfY7") then
                            if IlIlIIIlIllIllllIIIl == #("FxvuQKOHBRSO1msrjIZaHY") then
                                do
                                    return
                                end ;
                            else
                                local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; { 758; 51; 880; 509 }; }];
                                IIllIIlII = llllIIIIIIllIIIlIlIllIlII + IIIllIlllIllI - 1;
                                for IIllllIIII = llllIIIIIIllIIIlIlIllIlII, IIllIIlII do
                                    local llllIIIIIIllIIIlIlIllIlII = llIlIlIIllIllllIlllIIII[IIllllIIII - llllIIIIIIllIIIlIlIllIlII];
                                    IllIIIIIIIllllllIII[IIllllIIII] = llllIIIIIIllIIIlIlIllIlII;
                                end ;
                            end ;
                        elseif IlIlIIIlIllIllllIIIl > #("8iR1lBNoqIQDaGXt4c3F5FXo") then
                            local IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("Ax")]
                            IllIIIIIIIllllllIII[IIllllIIII] = IllIIIIIIIllllllIII[IIllllIIII](lIIlIlIIll(IllIIIIIIIllllllIII, IIllllIIII + 1, llllIIIIIIllIIIlIlIllIlII[#("1yR")]))
                        else
                            local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#("2e")];
                            IIllIIlII = llllIIIIIIllIIIlIlIllIlII + IIIllIlllIllI - 1;
                            for IIllllIIII = llllIIIIIIllIIIlIlIllIlII, IIllIIlII do
                                local llllIIIIIIllIIIlIlIllIlII = llIlIlIIllIllllIlllIIII[IIllllIIII - llllIIIIIIllIIIlIlIllIlII];
                                IllIIIIIIIllllllIII[IIllllIIII] = llllIIIIIIllIIIlIlIllIlII;
                            end ;
                        end ;
                    elseif IlIlIIIlIllIllllIIIl <= #("ZajH97ARaym8TCgXDBflUsVvo48NsBEuDAvBDR") then
                        if IlIlIIIlIllIllllIIIl <= #("LpVahLulKXRDdSdRHoXse9XyJ42GsgP") then
                            if IlIlIIIlIllIllllIIIl <= #("VjF68rOV4TyZM8ANzSYlQzmLCyBn") then
                                if IlIlIIIlIllIllllIIIl <= #("Y2EhxR4mhToLczvL7VLEpgLrEO") then
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Oo")]] = llllIIIIIIllIIIlIlIllIlII[#("a0B")];
                                elseif IlIlIIIlIllIllllIIIl == #("63EK1Acf04SpqGAr8KKO90aFMZT") then
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("pA")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("TcG")]];
                                else
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("qd")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; }]];
                                end ;
                            elseif IlIlIIIlIllIllllIIIl <= #("SrlNSu7sNiyl9sGRpGu8ZYMS4axg3") then
                                local llllIllllIlIlI;
                                local lIIlIlIIll;
                                local IlIlIIIlIllIllllIIIl;
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("XT")]] = llIlIlllIllI[llllIIIIIIllIIIlIlIllIlII[#("5Qp")]];
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("dm")]] = IlIIIlIlIIlIIIIlll[llllIIIIIIllIIIlIlIllIlII[#("eH4")]];
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; "1 + 1 = 111"; }]] = {};
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("Hh")];
                                IIllIIlII = IlIlIIIlIllIllllIIIl + IIIllIlllIllI - 1;
                                for llllIIIIIIllIIIlIlIllIlII = IlIlIIIlIllIllllIIIl, IIllIIlII do
                                    lIIlIlIIll = llIlIlIIllIllllIlllIIII[llllIIIIIIllIIIlIlIllIlII - IlIlIIIlIllIllllIIIl];
                                    IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII] = lIIlIlIIll;
                                end ;
                                IIllllIIII = IIllllIIII + 1;
                                llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("uQ")];
                                llllIllllIlIlI = IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl];
                                for llllIIIIIIllIIIlIlIllIlII = IlIlIIIlIllIllllIIIl + 1, IIllIIlII do
                                    lIllIIlllIlII(llllIllllIlIlI, IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII])
                                end ;
                            elseif IlIlIIIlIllIllllIIIl == #("8bQJyISeH5IhO0mzOQtspfFUO3QETR") then
                                local IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("9W")]
                                IllIIIIIIIllllllIII[IIllllIIII] = IllIIIIIIIllllllIII[IIllllIIII](lIIlIlIIll(IllIIIIIIIllllllIII, IIllllIIII + 1, llllIIIIIIllIIIlIlIllIlII[#("WAx")]))
                            else
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("nI")]] = llIlIlllIllI[llllIIIIIIllIIIlIlIllIlII[#("DED")]];
                            end ;
                        elseif IlIlIIIlIllIllllIIIl <= #("0zOkvFA589k8zBSkWFGxQWLT2H65E2nv07") then
                            if IlIlIIIlIllIllllIIIl <= #("SaP03oVvtegft6T48mureY4sZJFCgVZi") then
                                do
                                    return IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("XE")]]
                                end
                            elseif IlIlIIIlIllIllllIIIl == #("T9jgPMh5BqPVBM8V7oiFPN3fvauTspIo8") then
                                if (IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("mU")]] == llllIIIIIIllIIIlIlIllIlII[#{ { 436; 294; 980; 752 }; { 631; 314; 763; 33 }; "1 + 1 = 111"; { 978; 419; 290; 185 }; }]) then
                                    IIllllIIII = IIllllIIII + 1;
                                else
                                    IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("yRU")];
                                end ;
                            else
                                if (IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("mr")]] ~= llllIIIIIIllIIIlIlIllIlII[#("8TSv")]) then
                                    IIllllIIII = IIllllIIII + 1;
                                else
                                    IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("jIs")];
                                end ;
                            end ;
                        elseif IlIlIIIlIllIllllIIIl <= #("K6JXtLmxNIpIz6GQiHROWggeUPryMkTAXXcc") then
                            if IlIlIIIlIllIllllIIIl == #("j5Hrs9v0YMznNhbIt2DZEcPsZUCZZVM3EE8") then
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("xT")]][llllIIIIIIllIIIlIlIllIlII[#("aVS")]] = llllIIIIIIllIIIlIlIllIlII[#("R8JF")];
                            else
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("0d")]] = llllIIIIIIllIIIlIlIllIlII[#("Eeg")];
                            end ;
                        elseif IlIlIIIlIllIllllIIIl == #("jxDgVo6c2k9dR2D4JmShpnDIHGadaFTiizy7z") then
                            local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#("Rr")]
                            local IlIlIIIlIllIllllIIIl, IIllllIIII = IIIllIIIlIIIlI(IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII](IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII + 1]))
                            IIllIIlII = IIllllIIII + llllIIIIIIllIIIlIlIllIlII - 1
                            local IIllllIIII = 0;
                            for llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII, IIllIIlII do
                                IIllllIIII = IIllllIIII + 1;
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII] = IlIlIIIlIllIllllIIIl[IIllllIIII];
                            end ;
                        else
                            local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#("ar")]
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII](lIIlIlIIll(IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII + 1, IIllIIlII))
                        end ;
                    elseif IlIlIIIlIllIllllIIIl <= #("epgMAOVzh7rRtrW1v545Kon2byB05rEGGmhCaOXYXizc") then
                        if IlIlIIIlIllIllllIIIl <= #("tlCxrdDdEWZcnKcn4DZEWkgjt0ShghB0kgSm8EOoa") then
                            if IlIlIIIlIllIllllIIIl <= #("cArAXdVK2PKJ9iescBvu7vv91h20pBZLDtiR14d") then
                                if (IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Nu")]] ~= llllIIIIIIllIIIlIlIllIlII[#("Oqe5")]) then
                                    IIllllIIII = IIllllIIII + 1;
                                else
                                    IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; { 741; 400; 898; 902 }; "1 + 1 = 111"; }];
                                end ;
                            elseif IlIlIIIlIllIllllIIIl > #("xGpWqMgKiPBm2PGQesIQk4uBZ8fQ9yChyR8BgJTo") then
                                local IIllllIIII = llllIIIIIIllIIIlIlIllIlII[#("xs")];
                                do
                                    return IllIIIIIIIllllllIII[IIllllIIII](lIIlIlIIll(IllIIIIIIIllllllIII, IIllllIIII + 1, llllIIIIIIllIIIlIlIllIlII[#("Vfm")]))
                                end ;
                            else
                                local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#("up")]
                                IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII](lIIlIlIIll(IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII + 1, IIllIIlII))
                            end ;
                        elseif IlIlIIIlIllIllllIIIl <= #{ "1 + 1 = 111"; { 762; 946; 345; 826 }; "1 + 1 = 111"; { 863; 455; 731; 18 }; "1 + 1 = 111"; { 566; 857; 108; 441 }; { 509; 561; 389; 810 }; { 689; 500; 710; 64 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 632; 885; 827; 967 }; { 563; 654; 768; 873 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 275; 65; 726; 277 }; "1 + 1 = 111"; "1 + 1 = 111"; { 273; 903; 564; 61 }; "1 + 1 = 111"; { 830; 49; 103; 226 }; { 764; 315; 154; 872 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 953; 878; 143; 54 }; { 287; 492; 316; 833 }; "1 + 1 = 111"; { 232; 282; 640; 987 }; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; "1 + 1 = 111"; { 828; 216; 494; 919 }; } then
                            local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#("4d")];
                            local IIllllIIII = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII];
                            for llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII + 1, IIllIIlII do
                                lIllIIlllIlII(IIllllIIII, IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII])
                            end ;
                        elseif IlIlIIIlIllIllllIIIl == #("V3WanGprNCSKS7vRXHgT2f9cRKqByTboHc9uHY6kZs2") then
                            local IlIlIIIlIllIllllIIIl;
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("79")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Dax")]];
                            IIllllIIII = IIllllIIII + 1;
                            llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("J0")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("DZB")]];
                            IIllllIIII = IIllllIIII + 1;
                            llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("v5")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("KhQ")]];
                            IIllllIIII = IIllllIIII + 1;
                            llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Vk")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("X8o")]];
                            IIllllIIII = IIllllIIII + 1;
                            llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("3F")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("xU3")]];
                            IIllllIIII = IIllllIIII + 1;
                            llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Us")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Yfn")]];
                            IIllllIIII = IIllllIIII + 1;
                            llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                            IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("9m")];
                            do
                                return IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl](lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl + 1, llllIIIIIIllIIIlIlIllIlII[#("tx9")]))
                            end ;
                            IIllllIIII = IIllllIIII + 1;
                            llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                            IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("bk")];
                            do
                                return lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl, IIllIIlII)
                            end ;
                            IIllllIIII = IIllllIIII + 1;
                            llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                            do
                                return
                            end ;
                        else
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Y0")]] = IlIIIlIlIIlIIIIlll[llllIIIIIIllIIIlIlIllIlII[#("oPN")]];
                        end ;
                    elseif IlIlIIIlIllIllllIIIl <= #("LfkozUATkjOQ3TsNpZ34BEcP8bj9K54Kn2CMAbbOtrdyztB") then
                        if IlIlIIIlIllIllllIIIl <= #("Fs5aA8QhcFpyKAiopeCbrQnnXoLiAPqPKuFqa3koluK5V") then
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("l2")]][llllIIIIIIllIIIlIlIllIlII[#("EAe")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#{ { 888; 238; 462; 297 }; "1 + 1 = 111"; { 680; 188; 54; 512 }; "1 + 1 = 111"; }]];
                        elseif IlIlIIIlIllIllllIIIl > #("d3jZit1AHYfRmkyISyoLYo51ov4nZ7gsCjkR9LG6YjYQls") then
                            local IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#{ { 784; 616; 516; 34 }; "1 + 1 = 111"; }];
                            local IIllllIIII = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("kSb")]];
                            IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl + 1] = IIllllIIII;
                            IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl] = IIllllIIII[llllIIIIIIllIIIlIlIllIlII[#("pJN6")]];
                        else
                            local llllIIIIIIllIIIlIlIllIlII = llllIIIIIIllIIIlIlIllIlII[#("a2")];
                            do
                                return lIIlIlIIll(IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII, IIllIIlII)
                            end ;
                        end ;
                    elseif IlIlIIIlIllIllllIIIl <= #("a1OMmQkZZ8rKXAOKKSXod9RJh1rXOBoQ5P4vlu3MrtvTRaTHk") then
                        if IlIlIIIlIllIllllIIIl > #("o8ydNakeFuzylyTMOiGrypYl7TN71giUNemqr1b3lgZJm4i8") then
                            local IIllIIlII = llllllIllIIIIIIIlIIII[llllIIIIIIllIIIlIlIllIlII[#("uDp")]];
                            local lIIlIlIIll;
                            local IlIlIIIlIllIllllIIIl = {};
                            lIIlIlIIll = IIIIIIlIlllIIlll({}, { __index = function(IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII)
                                local llllIIIIIIllIIIlIlIllIlII = IlIlIIIlIllIllllIIIl[llllIIIIIIllIIIlIlIllIlII];
                                return llllIIIIIIllIIIlIlIllIlII[1][llllIIIIIIllIIIlIlIllIlII[2]];
                            end, __newindex = function(IIllllIIII, llllIIIIIIllIIIlIlIllIlII, IllIIIIIIIllllllIII)
                                local llllIIIIIIllIIIlIlIllIlII = IlIlIIIlIllIllllIIIl[llllIIIIIIllIIIlIlIllIlII]
                                llllIIIIIIllIIIlIlIllIlII[1][llllIIIIIIllIIIlIlIllIlII[2]] = IllIIIIIIIllllllIII;
                            end; });
                            for lIIlIlIIll = 1, llllIIIIIIllIIIlIlIllIlII[#("eqHl")] do
                                IIllllIIII = IIllllIIII + 1;
                                local llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                                if llllIIIIIIllIIIlIlIllIlII[#("U")] == 27 then
                                    IlIlIIIlIllIllllIIIl[lIIlIlIIll - 1] = { IllIIIIIIIllllllIII, llllIIIIIIllIIIlIlIllIlII[#("zCn")] };
                                else
                                    IlIlIIIlIllIllllIIIl[lIIlIlIIll - 1] = { llIlIlllIllI, llllIIIIIIllIIIlIlIllIlII[#("E1B")] };
                                end ;
                                llllIllllIlIlI[#llllIllllIlIlI + 1] = IlIlIIIlIllIllllIIIl;
                            end ;
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; "1 + 1 = 111"; }]] = lIllIlIlllllIIIII(IIllIIlII, lIIlIlIIll, IlIIIlIlIIlIIIIlll);
                        else
                            IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("eP")]][llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; { 948; 760; 654; 360 }; "1 + 1 = 111"; }]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Eed0")]];
                        end ;
                    elseif IlIlIIIlIllIllllIIIl == #("evKb2l9kmg3ymnzmOUglCuXgMfqAp8dLP8WVITU2ngfVhF93Bv") then
                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Y1")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("XPq")]][llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; { 103; 377; 645; 814 }; { 660; 966; 316; 295 }; { 293; 127; 39; 54 }; }]];
                    else
                        local IlIlIIIlIllIllllIIIl;
                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("JD")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("ZQa")]];
                        IIllllIIII = IIllllIIII + 1;
                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("4K")]] = llllIIIIIIllIIIlIlIllIlII[#("Fyj")];
                        IIllllIIII = IIllllIIII + 1;
                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("i4")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("3em")]];
                        IIllllIIII = IIllllIIII + 1;
                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("q6")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("SS7")]];
                        IIllllIIII = IIllllIIII + 1;
                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("gV")]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("Z1s")]];
                        IIllllIIII = IIllllIIII + 1;
                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                        IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#{ { 152; 507; 975; 725 }; "1 + 1 = 111"; }]] = IllIIIIIIIllllllIII[llllIIIIIIllIIIlIlIllIlII[#("jvp")]];
                        IIllllIIII = IIllllIIII + 1;
                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                        IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#{ "1 + 1 = 111"; { 717; 697; 492; 247 }; }];
                        do
                            return IllIIIIIIIllllllIII[IlIlIIIlIllIllllIIIl](lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl + 1, llllIIIIIIllIIIlIlIllIlII[#("nMg")]))
                        end ;
                        IIllllIIII = IIllllIIII + 1;
                        llllIIIIIIllIIIlIlIllIlII = IIllIlllIlll[IIllllIIII];
                        IlIlIIIlIllIllllIIIl = llllIIIIIIllIIIlIlIllIlII[#("S3")];
                        do
                            return lIIlIlIIll(IllIIIIIIIllllllIII, IlIlIIIlIllIllllIIIl, IIllIIlII)
                        end ;
                    end ;
                    IIllllIIII = IIllllIIII + 1;
                end ;
            end);
        end;
        return lIllIlIlllllIIIII(true, {}, lllIIlIlIIllIlIllIIII())();
    end)(string.byte, table.insert, setmetatable);
end;
Ill1lII1lIIllIll1I();
local l1IllI1l111I1iill1I = {}
local IiiIlI1Iili1II11iI1 = 1
local lIlilii1iiilII11Ili1l, iiiiII1lIlIiI1lI1l1
local function lIli1l1IIii1IiliI1iil(lIliIlIi1lIlIll1I1III, lIllIliiiIIIlliI1I1il)
    local lIli1i1lI1iliiI1111i1
    lIliIlIi1lIlIll1I1III = Ii1liIl1i11I11I1Iil(lIl11Il1lllIlIiIIiI(lIliIlIi1lIlIll1I1III, 5), "..", function(IlliI1iiili1iiiiIIl)
        if IlIIiI1II1i1iiii1ll(IlliI1iiili1iiiiIIl, 2) == 72 then
            lIli1i1lI1iliiI1111i1 = liiIi111lI1illllIlI(lIl11Il1lllIlIiIIiI(IlliI1iiili1iiiiIIl, 1, 1))
            return ""
        else
            local iIiiIlliI1ll1IlII1l = ll1Ii1lI1iIllIlIIi1(liiIi111lI1illllIlI(IlliI1iiili1iiiiIIl, 16))
            if lIli1i1lI1iliiI1111i1 then
                local Ill1llIlIl1i1ii1lIi = lIlI1il1I1i1IIiIi1IIi(iIiiIlliI1ll1IlII1l, lIli1i1lI1iliiI1111i1)
                lIli1i1lI1iliiI1111i1 = nil
                return Ill1llIlIl1i1ii1lIi
            else
                return iIiiIlliI1ll1IlII1l
            end
        end
    end)
    local function lIlIil1lIiliIiIlll1II()
        local lIlI1Il1111lliI1IliIl = IlIIiI1II1i1iiii1ll(lIliIlIi1lIlIll1I1III, IiiIlI1Iili1II11iI1, IiiIlI1Iili1II11iI1)
        IiiIlI1Iili1II11iI1 = IiiIlI1Iili1II11iI1 + 1
        return lIlI1Il1111lliI1IliIl
    end
    local function lIl1liii1liIIllIi1lIi()
        local lIlI1Il1111lliI1IliIl, iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi, IIiI1IlI1III1iiI111 = IlIIiI1II1i1iiii1ll(lIliIlIi1lIlIll1I1III, IiiIlI1Iili1II11iI1, IiiIlI1Iili1II11iI1 + 3)
        IiiIlI1Iili1II11iI1 = IiiIlI1Iili1II11iI1 + 4
        return IIiI1IlI1III1iiI111 * 16777216 + Ill1llIlIl1i1ii1lIi * 65536 + iIiiIlliI1ll1IlII1l * 256 + lIlI1Il1111lliI1IliIl
    end
    local function III1I1l1IIiI1liiI1l(lllIillil1Illl11lll, iI11liiiIill1Ii1Il1, IiilIi1iII1l1i1lIIi)
        if IiilIi1iII1l1i1lIIi then
            local ilIi11IlIi1IiliIilI, iIliIIlIIiiII1Iiill = 0, 0
            for ilI1iIIIl1iilII1iI1 = iI11liiiIill1Ii1Il1, IiilIi1iII1l1i1lIIi do
                ilIi11IlIi1IiliIilI = ilIi11IlIi1IiliIilI + 2 ^ iIliIIlIIiiII1Iiill * III1I1l1IIiI1liiI1l(lllIillil1Illl11lll, ilI1iIIIl1iilII1iI1)
                iIliIIlIIiiII1Iiill = iIliIIlIIiiII1Iiill + 1
            end
            return ilIi11IlIi1IiliIilI
        else
            local ilIl1l1li11ll11l11l = 2 ^ (iI11liiiIill1Ii1Il1 - 1)
            return ilIl1l1li11ll11l11l <= lllIillil1Illl11lll % (ilIl1l1li11ll11l11l + ilIl1l1li11ll11l11l) and 1 or 0
        end
    end
    local function I1llli1i1lIli1llIii()
        local lIlI1Il1111lliI1IliIl, iIiiIlliI1ll1IlII1l = lIl1liii1liIIllIi1lIi(), lIl1liii1liIIllIi1lIi()
        if lIlI1Il1111lliI1IliIl == 0 and iIiiIlliI1ll1IlII1l == 0 then
            return 0
        end
        return (-2 * III1I1l1IIiI1liiI1l(iIiiIlliI1ll1IlII1l, 32) + 1) * 2 ^ (III1I1l1IIiI1liiI1l(iIiiIlliI1ll1IlII1l, 21, 31) - 1023) * ((III1I1l1IIiI1liiI1l(iIiiIlliI1ll1IlII1l, 1, 20) * 4294967296 + lIlI1Il1111lliI1IliIl) / 4503599627370496 + 1)
    end
    local il11ill1IIiiliIlllI = bit or bit32
    local liIlIillIIl1IIllIIi = il11ill1IIiiliIlllI and il11ill1IIiiliIlllI.bxor or function(lIlI1Il1111lliI1IliIl, iIiiIlliI1ll1IlII1l)
        local lIliili1lil1l1iIiliII = 1
        local Ill1llIlIl1i1ii1lIi = 0
        while lIlI1Il1111lliI1IliIl > 0 and iIiiIlliI1ll1IlII1l > 0 do
            local lIl1lliIllil1ili1IIi1 = lIlI1Il1111lliI1IliIl % 2
            local iiiliIIil11liIIliIl = iIiiIlliI1ll1IlII1l % 2
            if lIl1lliIllil1ili1IIi1 ~= iiiliIIil11liIIliIl then
                Ill1llIlIl1i1ii1lIi = Ill1llIlIl1i1ii1lIi + lIliili1lil1l1iIiliII
            end
            lIlI1Il1111lliI1IliIl = (lIlI1Il1111lliI1IliIl - lIl1lliIllil1ili1IIi1) / 2
            iIiiIlliI1ll1IlII1l = (iIiiIlliI1ll1IlII1l - iiiliIIil11liIIliIl) / 2
            lIliili1lil1l1iIiliII = lIliili1lil1l1iIiliII * 2
        end
        if lIlI1Il1111lliI1IliIl < iIiiIlliI1ll1IlII1l then
            lIlI1Il1111lliI1IliIl = iIiiIlliI1ll1IlII1l
        end
        while lIlI1Il1111lliI1IliIl > 0 do
            local lIl1lliIllil1ili1IIi1 = lIlI1Il1111lliI1IliIl % 2
            if lIl1lliIllil1ili1IIi1 > 0 then
                Ill1llIlIl1i1ii1lIi = Ill1llIlIl1i1ii1lIi + lIliili1lil1l1iIiliII
            end
            lIlI1Il1111lliI1IliIl = (lIlI1Il1111lliI1IliIl - lIl1lliIllil1ili1IIi1) / 2
            lIliili1lil1l1iIiliII = lIliili1lil1l1iIiliII * 2
        end
        return Ill1llIlIl1i1ii1lIi
    end
    local function lIl1ili1Ili1lIIiIIlll(lIl1il1IiIli1I1lIiiil)
        local iIlIII1ii1lIiI1i1II = { IlIIiI1II1i1iiii1ll(lIliIlIi1lIlIll1I1III, IiiIlI1Iili1II11iI1, IiiIlI1Iili1II11iI1 + 3) }
        IiiIlI1Iili1II11iI1 = IiiIlI1Iili1II11iI1 + 4
        local lIlI1Il1111lliI1IliIl = liIlIillIIl1IIllIIi(iIlIII1ii1lIiI1i1II[1], iiiiII1lIlIiI1lI1l1)
        local iIiiIlliI1ll1IlII1l = liIlIillIIl1IIllIIi(iIlIII1ii1lIiI1i1II[2], iiiiII1lIlIiI1lI1l1)
        local Ill1llIlIl1i1ii1lIi = liIlIillIIl1IIllIIi(iIlIII1ii1lIiI1i1II[3], iiiiII1lIlIiI1lI1l1)
        local IIiI1IlI1III1iiI111 = liIlIillIIl1IIllIIi(iIlIII1ii1lIiI1i1II[4], iiiiII1lIlIiI1lI1l1)
        iiiiII1lIlIiI1lI1l1 = (185 * iiiiII1lIlIiI1lI1l1 + lIl1il1IiIli1I1lIiiil) % 256
        return IIiI1IlI1III1iiI111 * 16777216 + Ill1llIlIl1i1ii1lIi * 65536 + iIiiIlliI1ll1IlII1l * 256 + lIlI1Il1111lliI1IliIl
    end
    local function Ill11111iI1IIliilil(I11l11lI1lli1I11ilI)
        local iI1III1iII1l1IIi1li = lIl1liii1liIIllIi1lIi()
        local l1I1IiI1ilililI11Il = ""
        for ilI1iIIIl1iilII1iI1 = li1li1ii111IIlII1lI, iI1III1iII1l1IIi1li do
            l1I1IiI1ilililI11Il = l1I1IiI1ilililI11Il .. ll1Ii1lI1iIllIlIIi1(liIlIillIIl1IIllIIi(IlIIiI1II1i1iiii1ll(lIliIlIi1lIlIll1I1III, IiiIlI1Iili1II11iI1 + ilI1iIIIl1iilII1iI1 - 1), lIlilii1iiilII11Ili1l))
            lIlilii1iiilII11Ili1l = (I11l11lI1lli1I11ilI * lIlilii1iiilII11Ili1l + 125) % 256
        end
        IiiIlI1Iili1II11iI1 = IiiIlI1Iili1II11iI1 + iI1III1iII1l1IIi1li
        return l1I1IiI1ilililI11Il
    end
    lIlilii1iiilII11Ili1l = lIlIil1lIiliIiIlll1II()
    iiiiII1lIlIiI1lI1l1 = lIlIil1lIiliIiIlll1II()
    local iiIl1IlIiIlII11iII1 = {}
    for ilI1iIIIl1iilII1iI1 = li1li1ii111IIlII1lI, lIlIil1lIiliIiIlll1II() do
        local lIlli11lIli11lI11I1il = lIlIil1lIiliIiIlll1II()
        local lIlli1iII1ilI1lI1l11i = (ilI1iIIIl1iilII1iI1 - 1) * 2
        iiIl1IlIiIlII11iII1[lIlli1iII1ilI1lI1l11i] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, 1, 4)
        iiIl1IlIiIlII11iII1[lIlli1iII1ilI1lI1l11i + 1] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, 5, 8)
    end
    local function lllliIiIIIiIiIlI1ii()
        local illIIi11ii1l111111I = { nil, nil, {}, {}, {}, nil, {} }
        lIlIil1lIiliIiIlll1II()
        local Ii11lIlIIii111l1III = lIl1liii1liIIllIi1lIi() - (#{ 359, 1328, 2630, 6805, 5638, 1942, 1913, 6705, 5257, 6492, 1332, 962, 2697, 5084, 6096, 2426, 2118, 4896, 1003, 2034, 5589 } + IIil1IiilI1ilII1lii + 133713)
        local II1IliII1lI1liii1ll = lIlIil1lIiliIiIlll1II()
        for ilI1iIIIl1iilII1iI1 = li1li1ii111IIlII1lI, Ii11lIlIIii111l1III do
            local ilIIIliIiIiIl1IlIli = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }
            local lIlli11lIli11lI11I1il = lIl1ili1Ili1lIIiIIlll(II1IliII1lI1liii1ll)
            ilIIIliIiIiIl1IlIli[36160] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, #{ 2528 }, #{ 4706, 4496, 4712, 553, 4149, 1419, 2968, 3543, 4774 })
            ilIIIliIiIiIl1IlIli[8] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, #{ 2623, 1649, 710, 1180, 4244, 6148, 665, 3586, 4432, 1689, 6181, 3351, 4314, 3109, 6899, 6031, 6800, 2473, 4141 }, #{ 6099, 255, 5950, 756, 3999, 4160, 1974, 5539, 1896, 4594, 4084, 1121, 1625, 450, 3440, 6777, 2036, 3020, 788, 5065, 4135, 5076 } + IIil1IiilI1ilII1lii + -37)
            ilIIIliIiIiIl1IlIli[7] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, #{ 5496 }, #{ 5991, 5284, 1614, 128, 4175, 5856, 1459, 3809, 2986 })
            ilIIIliIiIiIl1IlIli[6] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, #{ 5194, 5414, 6443, 6403, 2942, 4034, 965, 1417, 6342, 2394 }, #{ 620, 2687, 3205, 3229, 2614, 4225, 6273, 1471, 818, 5130, 2061, 6664, 3322, 2997, 288, 4007, 4270, 5469 })
            ilIIIliIiIiIl1IlIli[3] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, #{ 4397, 4014, 1937, 4877, 2531, 3293, 5892, 2588, 500, 1321, 4171, 6105, 643, 5324, 6336, 4185, 4751, 2796, 6325, 986 } + IIil1IiilI1ilII1lii + -34, #{ 36, 958, 4907, 800, 236, 6435, 727, 3313, 1468, 3568, 1204, 2570, 1465, 453, 3376, 2522, 6492, 6741, 2976, 3576, 2783, 1558, 5300, 3436 } + IIil1IiilI1ilII1lii + -33)
            ilIIIliIiIiIl1IlIli[9] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, #{ 3052 }, #{ 6938, 5176, 6560, 3713, 3, 5440, 1584, 1205, 2937, 4506, 2610, 982, 1866, 6036, 3973, 3972, 2626, 2800 })
            ilIIIliIiIiIl1IlIli[126782] = III1I1l1IIiI1liiI1l(lIlli11lIli11lI11I1il, #{ 2395, 3126, 796, 6425, 788, 2477, 885, 6367, 5052, 6417 }, #{ 1522, 2695, 5409, 347, 2802, 855, 146, 390, 5584, 3820, 997, 3968, 2587, 3313, 4028, 6560, 393, 4525 })
            illIIi11ii1l111111I[5][ilI1iIIIl1iilII1iI1] = ilIIIliIiIiIl1IlIli
        end
        lIl1liii1liIIllIi1lIi()
        illIIi11ii1l111111I[6] = lIlIil1lIiliIiIlll1II()
        illIIi11ii1l111111I[1] = lIlIil1lIiliIiIlll1II()
        lIl1liii1liIIllIi1lIi()
        local I1l11IiIii1ill1i1Il = lIl1liii1liIIllIi1lIi()
        for ilI1iIIIl1iilII1iI1 = li1li1ii111IIlII1lI, I1l11IiIii1ill1i1Il do
            illIIi11ii1l111111I[4][ilI1iIIIl1iilII1iI1 - li1li1ii111IIlII1lI] = lllliIiIIIiIiIlI1ii()
        end
        local I1l11IiIii1ill1i1Il = lIl1liii1liIIllIi1lIi()
        for ilI1iIIIl1iilII1iI1 = li1li1ii111IIlII1lI, I1l11IiIii1ill1i1Il do
            illIIi11ii1l111111I[7][ilI1iIIIl1iilII1iI1] = lIl1liii1liIIllIi1lIi()
        end
        lIlIil1lIiliIiIlll1II()
        local I1l11IiIii1ill1i1Il = lIl1liii1liIIllIi1lIi() - (#{ 1461, 6218, 6791, 60, 5978, 5154, 2869, 1478, 4590, 2586, 5231, 15, 4523, 3477, 179, 6764, 2208, 2930, 685, 5851 } + IIil1IiilI1ilII1lii + 133697)
        local ii1ll11liiIl1iliiil = lIlIil1lIiliIiIlll1II()
        for ilI1iIIIl1iilII1iI1 = li1li1ii111IIlII1lI, I1l11IiIii1ill1i1Il do
            local i1iiIii1lIII11i1i11
            local iiI1l111I11liiilI1i = lIlIil1lIiliIiIlll1II()
            if iiI1l111I11liiilI1i == #{ 4124, 2536, 5180, 4218, 5292, 6185, 3897, 5224, 1668, 5659, 4612, 170, 5408, 5977, 4859, 4366, 2236, 4095, 2907, 6636, 2185, 4736, 4648, 4093 } + IIil1IiilI1ilII1lii + 0 then
                i1iiIii1lIII11i1i11 = I1llli1i1lIli1llIii() + I1llli1i1lIli1llIii()
            end
            if iiI1l111I11liiilI1i == #{ 1831, 5826, 4673, 924, 5858, 6697, 5600, 1353, 5068, 4142, 1593, 6284, 790, 5176, 3537, 5454, 3601, 5215, 1893, 5382, 1504, 5857, 5836, 4542 } + IIil1IiilI1ilII1lii + 144 then
                i1iiIii1lIII11i1i11 = lIlIil1lIiliIiIlll1II()
            end
            if iiI1l111I11liiilI1i == #{ 612, 5443, 5207, 2595, 4489, 6386, 3721, 1629, 4300, 2205, 5497, 6751, 2101, 6102, 1204, 4665, 4002, 6101, 1727, 5556, 3564, 3650, 285 } + IIil1IiilI1ilII1lii + 9 then
                i1iiIii1lIII11i1i11 = #{ 5656, 6397, 3627, 383, 1819, 6552, 6785, 4038, 3701, 3864, 4053, 4499, 304, 1062, 1628, 515, 6053, 6509, 4527, 5845, 792, 6923 } + IIil1IiilI1ilII1lii + 55780 == #{ 5004, 3583, 2680, 3411, 3091, 597, 5269, 1356, 2369, 727, 159, 508, 6157, 3633, 433, 2855, 4617, 1334, 2833, 6062, 1786, 1096, 644, 6893 } + IIil1IiilI1ilII1lii + 100222
            end
            if iiI1l111I11liiilI1i == #{ 6187, 1316, 3703, 1412, 1086, 4380, 1087, 106, 2762, 1283, 5344, 2572, 2128, 2111, 3794, 1716, 1332, 5466, 4903, 4540, 5832, 4991, 4415 } + IIil1IiilI1ilII1lii + 143 then
                i1iiIii1lIII11i1i11 = I1llli1i1lIli1llIii()
            end
            if iiI1l111I11liiilI1i == #{ 2152, 748, 122, 4376, 4086, 6832, 1764, 5737, 5871, 6729, 454, 1437, 2262, 3147, 4060, 1848, 1471, 467, 3200, 6003, 1193, 4076 } + IIil1IiilI1ilII1lii + -18 then
                i1iiIii1lIII11i1i11 = lIl11Il1lllIlIiIIiI(Ill11111iI1IIliilil(ii1ll11liiIl1iliiil), #{ 2596, 5562, 6272 })
            end
            if iiI1l111I11liiilI1i == #{ 1818, 4405, 1249, 429, 5822, 1757, 6759, 3464, 27, 3782, 4659, 2283, 6735, 2422, 1917, 5404, 3897, 3263, 1813, 6643 } + IIil1IiilI1ilII1lii + 144 then
                i1iiIii1lIII11i1i11 = lIl11Il1lllIlIiIIiI(Ill11111iI1IIliilil(#{ 4190, 5346, 4740, 1294, 6134, 6555, 2153, 3105, 6094, 6487, 6602, 6449, 6949, 6346, 6216, 641, 4147, 5875, 323, 5846, 5666 } + IIil1IiilI1ilII1lii + 58), #{ 5925, 4296, 1631, 2548 })
            end
            if iiI1l111I11liiilI1i == #{ 1146, 453, 2659, 4335, 1462, 4474, 2192, 217, 6352, 4384, 5658, 6164, 4596, 5428, 4791, 859, 2381, 5661, 6194, 1569 } + IIil1IiilI1ilII1lii + 19 then
                i1iiIii1lIII11i1i11 = I1llli1i1lIli1llIii()
            end
            if iiI1l111I11liiilI1i == #{ 590, 6024, 2083, 6520, 5920, 2205, 3586, 5296, 2176, 102, 3900, 3153, 5630, 6655, 689, 2591, 4225, 2091, 3062, 874, 2294 } + IIil1IiilI1ilII1lii + 137 then
                i1iiIii1lIII11i1i11 = #{ 384, 6522, 30, 3820, 2127, 6556, 4238, 4899, 2365, 2150, 6803, 5105, 242, 4356, 1609, 5866, 6284, 296, 2816, 4029 } + IIil1IiilI1ilII1lii + 98439 == #{ 384, 6522, 30, 3820, 2127, 6556, 4238, 4899, 2365, 2150, 6803, 5105, 242, 4356, 1609, 5866, 6284, 296, 2816, 4029 } + IIil1IiilI1ilII1lii + 98439
            end
            if iiI1l111I11liiilI1i == #{ 6259, 930, 1127, 6535, 3985, 1033, 1078, 3808, 3021, 5932, 5857, 2298, 830, 3270, 514, 5124, 2751, 4230, 6103, 276 } + IIil1IiilI1ilII1lii + 69 then
                i1iiIii1lIII11i1i11 = I1llli1i1lIli1llIii()
            end
            illIIi11ii1l111111I[3][ilI1iIIIl1iilII1iI1 - li1li1ii111IIlII1lI] = i1iiIii1lIII11i1i11
        end
        for ilI1iIIIl1iilII1iI1 = li1li1ii111IIlII1lI, Ii11lIlIIii111l1III do
            local ilIIIliIiIiIl1IlIli = illIIi11ii1l111111I[5][ilI1iIIIl1iilII1iI1]
            local lIl1ili1l1lIl1IlI1Ii1 = iiIl1IlIiIlII11iII1[ilIIIliIiIiIl1IlIli[3]]
            if lIl1ili1l1lIl1IlI1Ii1 == #{ 3033, 5184, 2090, 388 } then
                ilIIIliIiIiIl1IlIli[5] = illIIi11ii1l111111I[3][ilIIIliIiIiIl1IlIli[9]]
            end
            if lIl1ili1l1lIl1IlI1Ii1 == #{ 2900 } and 255 < ilIIIliIiIiIl1IlIli[7] then
                ilIIIliIiIiIl1IlIli[1] = true
                ilIIIliIiIiIl1IlIli[10] = illIIi11ii1l111111I[3][ilIIIliIiIiIl1IlIli[7] - 256]
            end
            if lIl1ili1l1lIl1IlI1Ii1 == #{ 1179, 6408 } and 255 < ilIIIliIiIiIl1IlIli[6] then
                ilIIIliIiIiIl1IlIli[2] = true
                ilIIIliIiIiIl1IlIli[4] = illIIi11ii1l111111I[3][ilIIIliIiIiIl1IlIli[6] - 256]
            end
            if lIl1ili1l1lIl1IlI1Ii1 == #{ 5469, 1693, 1221 } then
                if 255 < ilIIIliIiIiIl1IlIli[7] then
                    ilIIIliIiIiIl1IlIli[1] = true
                    ilIIIliIiIiIl1IlIli[10] = illIIi11ii1l111111I[3][ilIIIliIiIiIl1IlIli[7] - 256]
                end
                if 255 < ilIIIliIiIiIl1IlIli[6] then
                    ilIIIliIiIiIl1IlIli[2] = true
                    ilIIIliIiIiIl1IlIli[4] = illIIi11ii1l111111I[3][ilIIIliIiIiIl1IlIli[6] - 256]
                end
            end
        end
        lIlIil1lIiliIiIlll1II()
        illIIi11ii1l111111I[2] = lIlIil1lIiliIiIlll1II()
        lIl1liii1liIIllIi1lIi()
        return illIIi11ii1l111111I
    end
    local function liilI1i1ililii1lll1(illIIi11ii1l111111I, lIllIliiiIIIlliI1I1il, lIlli1iii11iliiiiiIII)
        local iIIll1l1lilIi1lIIil, i1li1lI1i11l11iIi1i = 31, 11
        local I1iII111l1iiIIll1lI = illIIi11ii1l111111I[5]
        local llI1I1ilii1lliIilii = 1
        local IlllI1l1iiI1lllll1i = illIIi11ii1l111111I[4]
        local lIlIl1Ii1IIi1IiiI1iIi = illIIi11ii1l111111I[6]
        local IiIi1IIilIli1IiillI = illIIi11ii1l111111I[2]
        local Ii1IiIiIiIIl1iliili = 3
        local iiiIlIiI11il1Il1l11 = illIIi11ii1l111111I[7]
        local Ililil1i1II1iiI1li1 = 7
        local function Ii11I1lIlI1l1I11IIi(...)
            local l1iIl1iIII1liiIll11 = 0
            local lIllIIilil11llIIlIIii = { lIliliil1Iil1ii1iiI({}, 1, IiIi1IIilIli1IiillI) }
            local lI11illliiiIll1I11i = 1
            local li1ll1lliillIi1l1II = {}
            local IllI1iliII11iiiI111 = {}
            local lIllIliiiIIIlliI1I1il = lIlI1IiIiiIIiI11111li()
            local lIlliI1i11illiiIIIiIl = { ... }
            local iII1lIil1i1lill1l1I = #lIlliI1i11illiiIIIiIl - 1
            for ilI1iIIIl1iilII1iI1 = 0, iII1lIil1i1lill1l1I do
                if ilI1iIIIl1iilII1iI1 < lIlIl1Ii1IIi1IiiI1iIi then
                    lIllIIilil11llIIlIIii[ilI1iIIIl1iilII1iI1] = lIlliI1i11illiiIIIiIl[ilI1iIIIl1iilII1iI1 + 1]
                end
            end
            local function lIlIiliIilIiIIli1IiIi(...)
                local Ill1llIlIl1i1ii1lIi = l11IIIlilIlI1iil1Il("#", ...)
                local l1Ill1iIil1I11IIiII = { ... }
                return Ill1llIlIl1i1ii1lIi, l1Ill1iIil1I11IIiII
            end
            local function illlII1l11Ii1l11ill()
                while true do
                    local lIli1I1l111llliii11iI = I1iII111l1iiIIll1lI[lI11illliiiIll1I11i]
                    local i1l1II1li1llIlIIl1i = lIli1I1l111llliii11iI[3]
                    lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                    if i1l1II1li1llIlIIl1i >= 18 then
                        if i1l1II1li1llIlIIl1i >= 27 then
                            if i1l1II1li1llIlIIl1i >= 31 then
                                if i1l1II1li1llIlIIl1i >= 33 then
                                    if i1l1II1li1llIlIIl1i >= 34 then
                                        if i1l1II1li1llIlIIl1i ~= 35 then
                                            lIllIliiiIIIlliI1I1il[lIli1I1l111llliii11iI[5]] = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]]
                                        else
                                            local I1I1iii1III1I111i1I = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                            for ilI1iIIIl1iilII1iI1 = lIli1I1l111llliii11iI[7] + 1, lIli1I1l111llliii11iI[6] do
                                                I1I1iii1III1I111i1I = I1I1iii1III1I111i1I .. lIllIIilil11llIIlIIii[ilI1iIIIl1iilII1iI1]
                                            end
                                            lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = I1I1iii1III1I111i1I
                                        end
                                    else
                                        lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = { lIliliil1Iil1ii1iiI(l1IllI1l111I1iill1I, 1, lIli1I1l111llliii11iI[7] == 0 and 255 or lIli1I1l111llliii11iI[7]) }
                                    end
                                elseif i1l1II1li1llIlIIl1i ~= 32 then
                                    if lIli1I1l111llliii11iI[6] == 191 then
                                        lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                        I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 3, [8] = (lIli1I1l111llliii11iI[8] - 232) % 256, [7] = (lIli1I1l111llliii11iI[7] - 232) % 256 }
                                    else
                                        lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                    end
                                else
                                    local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                                    if lIli1I1l111llliii11iI[1] then
                                        iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                                    else
                                        iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                    end
                                    if lIli1I1l111llliii11iI[2] then
                                        Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                    else
                                        Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                    end
                                    lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = iIiiIlliI1ll1IlII1l - Ill1llIlIl1i1ii1lIi
                                end
                            elseif i1l1II1li1llIlIIl1i < 29 then
                                if i1l1II1li1llIlIIl1i ~= 28 then
                                    local il1i1i1iiil1IlliiI1 = lIli1I1l111llliii11iI[8]
                                    local lIlli1iII1ilI1lI1l11i = il1i1i1iiil1IlliiI1 + 2
                                    local I1I1iii1III1I111i1I = { lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1](lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 1], lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 2]) }
                                    for ilI1iIIIl1iilII1iI1 = 1, lIli1I1l111llliii11iI[6] do
                                        lIllIIilil11llIIlIIii[lIlli1iII1ilI1lI1l11i + ilI1iIIIl1iilII1iI1] = I1I1iii1III1I111i1I[ilI1iIIIl1iilII1iI1]
                                    end
                                    if lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 3] ~= nil then
                                        lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 2] = lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 3]
                                    else
                                        lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                                    end
                                else
                                    local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                                    if lIli1I1l111llliii11iI[1] then
                                        iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                                    else
                                        iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                    end
                                    if lIli1I1l111llliii11iI[2] then
                                        Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                    else
                                        Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                    end
                                    lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = iIiiIlliI1ll1IlII1l / Ill1llIlIl1i1ii1lIi
                                end
                            elseif i1l1II1li1llIlIIl1i ~= 30 then
                                lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = lIllIliiiIIIlliI1I1il[lIli1I1l111llliii11iI[5]]
                            else
                                local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                                if lIli1I1l111llliii11iI[1] then
                                    iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                                else
                                    iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                end
                                if lIli1I1l111llliii11iI[2] then
                                    Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                else
                                    Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                end
                                lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = iIiiIlliI1ll1IlII1l * Ill1llIlIl1i1ii1lIi
                            end
                        elseif i1l1II1li1llIlIIl1i < 22 then
                            if i1l1II1li1llIlIIl1i >= 20 then
                                if i1l1II1li1llIlIIl1i == 21 then
                                    local il1i1i1iiil1IlliiI1 = lIli1I1l111llliii11iI[8]
                                    local lIlliI1i11illiiIIIiIl = lIli1I1l111llliii11iI[7]
                                    local lIlIilIiiI11l1I1iIIl1 = lIli1I1l111llliii11iI[6]
                                    local lIl11i11Il1lIllIilI1l, I1Ii1I1I1IiiIl1lIii, illlII1l11Ii1l11ill
                                    if lIlliI1i11illiiIIIiIl ~= 1 then
                                        if lIlliI1i11illiiIIIiIl ~= 0 then
                                            I1Ii1I1I1IiiIl1lIii = il1i1i1iiil1IlliiI1 + lIlliI1i11illiiIIIiIl - 1
                                        else
                                            I1Ii1I1I1IiiIl1lIii = l1iIl1iIII1liiIll11
                                        end
                                        I1Ii1I1I1IiiIl1lIii, lIl11i11Il1lIllIilI1l = lIlIiliIilIiIIli1IiIi(lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1](lIliliil1Iil1ii1iiI(lIllIIilil11llIIlIIii, il1i1i1iiil1IlliiI1 + 1, I1Ii1I1I1IiiIl1lIii)))
                                    else
                                        I1Ii1I1I1IiiIl1lIii, lIl11i11Il1lIllIilI1l = lIlIiliIilIiIIli1IiIi(lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1]())
                                    end
                                    if lIlIilIiiI11l1I1iIIl1 ~= 1 then
                                        if lIlIilIiiI11l1I1iIIl1 ~= 0 then
                                            I1Ii1I1I1IiiIl1lIii = il1i1i1iiil1IlliiI1 + lIlIilIiiI11l1I1iIIl1 - 2
                                            l1iIl1iIII1liiIll11 = I1Ii1I1I1IiiIl1lIii + 1
                                        else
                                            I1Ii1I1I1IiiIl1lIii = I1Ii1I1I1IiiIl1lIii + il1i1i1iiil1IlliiI1 - 1
                                            l1iIl1iIII1liiIll11 = I1Ii1I1I1IiiIl1lIii
                                        end
                                        illlII1l11Ii1l11ill = 0
                                        for ilI1iIIIl1iilII1iI1 = il1i1i1iiil1IlliiI1, I1Ii1I1I1IiiIl1lIii do
                                            illlII1l11Ii1l11ill = illlII1l11Ii1l11ill + 1
                                            lIllIIilil11llIIlIIii[ilI1iIIIl1iilII1iI1] = lIl11i11Il1lIllIilI1l[illlII1l11Ii1l11ill]
                                        end
                                    else
                                        l1iIl1iIII1liiIll11 = il1i1i1iiil1IlliiI1 - 1
                                    end
                                    for ilI1iIIIl1iilII1iI1 = l1iIl1iIII1liiIll11 + 1, IiIi1IIilIli1IiillI do
                                        lIllIIilil11llIIlIIii[ilI1iIIIl1iilII1iI1] = nil
                                    end
                                else
                                    local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                                    if lIli1I1l111llliii11iI[1] then
                                        iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                                    else
                                        iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                    end
                                    if lIli1I1l111llliii11iI[2] then
                                        Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                    else
                                        Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                    end
                                    if iIiiIlliI1ll1IlII1l == Ill1llIlIl1i1ii1lIi ~= (lIli1I1l111llliii11iI[8] ~= 0) then
                                        lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                                    end
                                end
                            elseif i1l1II1li1llIlIIl1i == 19 then
                                local lli11IilIiIlIi111ll = lIli1I1l111llliii11iI[7]
                                if not not lli11IilIiIlIi111ll == (lIli1I1l111llliii11iI[6] == 0) then
                                    lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                                else
                                    lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = lli11IilIiIlIi111ll
                                end
                            else
                                local lIlli1iII1ilI1lI1l11i = (lIli1I1l111llliii11iI[6] - 1) * 50
                                local lIlIiIIiiiI1iIl1IlIl1 = lIli1I1l111llliii11iI[7]
                                if lIlIiIIiiiI1iIl1IlIl1 == 0 then
                                    lIlIiIIiiiI1iIl1IlIl1 = l1iIl1iIII1liiIll11 - lIli1I1l111llliii11iI[8]
                                end
                                for ilI1iIIIl1iilII1iI1 = 1, lIlIiIIiiiI1iIl1IlIl1 do
                                    lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]][lIlli1iII1ilI1lI1l11i + ilI1iIIIl1iilII1iI1] = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8] + ilI1iIIIl1iilII1iI1]
                                end
                            end
                        elseif i1l1II1li1llIlIIl1i < 24 then
                            if i1l1II1li1llIlIIl1i ~= 23 then
                                local il1i1i1iiil1IlliiI1 = lIli1I1l111llliii11iI[8]
                                lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1] = I1iI1llIlIIll1i11iI(liiIi111lI1illllIlI(lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1]), "`for` initial value must be a number")
                                lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 1] = I1iI1llIlIIll1i11iI(liiIi111lI1illllIlI(lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 1]), "`for` limit value must be a number")
                                lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 2] = I1iI1llIlIIll1i11iI(liiIi111lI1illllIlI(lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 2]), "`for` step value must be a number")
                                lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1] = lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1] - lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 2]
                                lI11illliiiIll1I11i = lI11illliiiIll1I11i + (lIli1I1l111llliii11iI[9] - lIlillI11I1IIi11iili1)
                            else
                                local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                                if lIli1I1l111llliii11iI[1] then
                                    iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                                else
                                    iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                end
                                if lIli1I1l111llliii11iI[2] then
                                    Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                else
                                    Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                end
                                if iIiiIlliI1ll1IlII1l < Ill1llIlIl1i1ii1lIi ~= (lIli1I1l111llliii11iI[8] ~= 0) then
                                    lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                                end
                            end
                        elseif i1l1II1li1llIlIIl1i < 25 then
                            lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = -lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                        elseif i1l1II1li1llIlIIl1i == 26 then
                            if lIli1I1l111llliii11iI[6] == 227 then
                                lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 2, [8] = (lIli1I1l111llliii11iI[8] - 135) % 256, [7] = (lIli1I1l111llliii11iI[7] - 135) % 256 }
                            elseif lIli1I1l111llliii11iI[6] == 79 then
                                lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 14, [8] = (lIli1I1l111llliii11iI[8] - 132) % 256, [6] = (lIli1I1l111llliii11iI[7] - 132) % 256 }
                            elseif lIli1I1l111llliii11iI[6] == 40 then
                                lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 9, [8] = (lIli1I1l111llliii11iI[8] - 110) % 256, [7] = (lIli1I1l111llliii11iI[7] - 110) % 256 }
                            else
                                lIlli1iii11iliiiiiIII[lIli1I1l111llliii11iI[7]] = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]]
                            end
                        else
                            li1ll1lliillIi1l1II[lIllIIilil11llIIlIIii] = nil
                            local il1i1i1iiil1IlliiI1 = lIli1I1l111llliii11iI[8]
                            local lIlliI1i11illiiIIIiIl = lIli1I1l111llliii11iI[7]
                            local lIl11i11Il1lIllIilI1l, I1Ii1I1I1IiiIl1lIii
                            if lIlliI1i11illiiIIIiIl ~= 1 then
                                if lIlliI1i11illiiIIIiIl ~= 0 then
                                    I1Ii1I1I1IiiIl1lIii = il1i1i1iiil1IlliiI1 + lIlliI1i11illiiIIIiIl - 1
                                else
                                    I1Ii1I1I1IiiIl1lIii = l1iIl1iIII1liiIll11
                                end
                                I1Ii1I1I1IiiIl1lIii, lIl11i11Il1lIllIilI1l = lIlIiliIilIiIIli1IiIi(lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1](lIliliil1Iil1ii1iiI(lIllIIilil11llIIlIIii, il1i1i1iiil1IlliiI1 + 1, I1Ii1I1I1IiiIl1lIii)))
                            else
                                I1Ii1I1I1IiiIl1lIii, lIl11i11Il1lIllIilI1l = lIlIiliIilIiIIli1IiIi(lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1]())
                            end
                            lIllIIilil11llIIlIIii = lIl11i11Il1lIllIilI1l
                            return true, 1, I1Ii1I1I1IiiIl1lIii
                        end
                    elseif i1l1II1li1llIlIIl1i < 9 then
                        if i1l1II1li1llIlIIl1i >= 4 then
                            if i1l1II1li1llIlIIl1i >= 6 then
                                if i1l1II1li1llIlIIl1i >= 7 then
                                    if i1l1II1li1llIlIIl1i == 8 then
                                        local Ill1llIlIl1i1ii1lIi
                                        if lIli1I1l111llliii11iI[2] then
                                            Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                        else
                                            Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                        end
                                        lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]][Ill1llIlIl1i1ii1lIi]
                                    elseif lIli1I1l111llliii11iI[6] == 58 then
                                        lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                        I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 31, [8] = (lIli1I1l111llliii11iI[8] - 164) % 256, [7] = (lIli1I1l111llliii11iI[7] - 164) % 256 }
                                    elseif lIli1I1l111llliii11iI[6] == 232 then
                                        lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                        I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 11, [8] = (lIli1I1l111llliii11iI[8] - 67) % 256, [7] = (lIli1I1l111llliii11iI[7] - 67) % 256 }
                                    elseif lIli1I1l111llliii11iI[6] == 138 then
                                        lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                        I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 27, [8] = (lIli1I1l111llliii11iI[8] - 234) % 256, [6] = (lIli1I1l111llliii11iI[7] - 234) % 256 }
                                    else
                                        local il1i1i1iiil1IlliiI1 = lIli1I1l111llliii11iI[8]
                                        local I1l11IiIii1ill1i1Il = lIli1I1l111llliii11iI[7]
                                        local ilI1ll1iI1i11Il11ii = I1l11IiIii1ill1i1Il > 0 and I1l11IiIii1ill1i1Il - 1 or iII1lIil1i1lill1l1I - lIlIl1Ii1IIi1IiiI1iIi
                                        if ilI1ll1iI1i11Il11ii < 0 then
                                            ilI1ll1iI1i11Il11ii = -1
                                        end
                                        for ilI1iIIIl1iilII1iI1 = il1i1i1iiil1IlliiI1, il1i1i1iiil1IlliiI1 + ilI1ll1iI1i11Il11ii do
                                            lIllIIilil11llIIlIIii[ilI1iIIIl1iilII1iI1] = lIlliI1i11illiiIIIiIl[lIlIl1Ii1IIi1IiiI1iIi + (ilI1iIIIl1iilII1iI1 - il1i1i1iiil1IlliiI1) + 1]
                                        end
                                        if I1l11IiIii1ill1i1Il == 0 then
                                            l1iIl1iIII1liiIll11 = il1i1i1iiil1IlliiI1 + ilI1ll1iI1i11Il11ii
                                            for ilI1iIIIl1iilII1iI1 = l1iIl1iIII1liiIll11 + 1, IiIi1IIilIli1IiillI do
                                                lIllIIilil11llIIlIIii[ilI1iIIIl1iilII1iI1] = nil
                                            end
                                        end
                                    end
                                else
                                    local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                                    if lIli1I1l111llliii11iI[1] then
                                        iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                                    else
                                        iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                    end
                                    if lIli1I1l111llliii11iI[2] then
                                        Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                    else
                                        Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                    end
                                    lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]][iIiiIlliI1ll1IlII1l] = Ill1llIlIl1i1ii1lIi
                                end
                            elseif i1l1II1li1llIlIIl1i == 5 then
                                for ilI1iIIIl1iilII1iI1 = lIli1I1l111llliii11iI[8], lIli1I1l111llliii11iI[7] do
                                    lIllIIilil11llIIlIIii[ilI1iIIIl1iilII1iI1] = nil
                                end
                            else
                                local IllIIIliil1ilIl1I1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                local Ill1llIlIl1i1ii1lIi
                                if lIli1I1l111llliii11iI[2] then
                                    Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                else
                                    Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                end
                                lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8] + 1] = IllIIIliil1ilIl1I1l
                                lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = IllIIIliil1ilIl1I1l[Ill1llIlIl1i1ii1lIi]
                            end
                        elseif i1l1II1li1llIlIIl1i >= 2 then
                            if i1l1II1li1llIlIIl1i == 3 then
                                if lIli1I1l111llliii11iI[6] == 242 then
                                    lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                    I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 5, [8] = (lIli1I1l111llliii11iI[8] - 172) % 256, [7] = (lIli1I1l111llliii11iI[7] - 172) % 256 }
                                elseif lIli1I1l111llliii11iI[6] == 138 then
                                    lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                                    I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 26, [8] = (lIli1I1l111llliii11iI[8] - 21) % 256, [7] = (lIli1I1l111llliii11iI[7] - 21) % 256 }
                                else
                                    lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = not lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                end
                            else
                                lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = #lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                            end
                        elseif i1l1II1li1llIlIIl1i == 1 then
                            lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = lIli1I1l111llliii11iI[7] ~= 0
                            if lIli1I1l111llliii11iI[6] ~= 0 then
                                lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                            end
                        else
                            local il1i1i1iiil1IlliiI1 = lIli1I1l111llliii11iI[8]
                            local lIli1Il11ili11Iiil11i = lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 2]
                            local IiiIlI1Iili1II11iI1 = lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1] + lIli1Il11ili11Iiil11i
                            lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1] = IiiIlI1Iili1II11iI1
                            if lIli1Il11ili11Iiil11i > 0 then
                                if IiiIlI1Iili1II11iI1 <= lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 1] then
                                    lI11illliiiIll1I11i = lI11illliiiIll1I11i + (lIli1I1l111llliii11iI[9] - lIlillI11I1IIi11iili1)
                                    lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 3] = IiiIlI1Iili1II11iI1
                                end
                            elseif IiiIlI1Iili1II11iI1 >= lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 1] then
                                lI11illliiiIll1I11i = lI11illliiiIll1I11i + (lIli1I1l111llliii11iI[9] - lIlillI11I1IIi11iili1)
                                lIllIIilil11llIIlIIii[il1i1i1iiil1IlliiI1 + 3] = IiiIlI1Iili1II11iI1
                            end
                        end
                    elseif i1l1II1li1llIlIIl1i < 13 then
                        if i1l1II1li1llIlIIl1i < 11 then
                            if i1l1II1li1llIlIIl1i ~= 10 then
                                li1ll1lliillIi1l1II[lIllIIilil11llIIlIIii] = nil
                                local il1i1i1iiil1IlliiI1 = lIli1I1l111llliii11iI[8]
                                local l1liiliIII11IlliII1 = lIli1I1l111llliii11iI[7]
                                if l1liiliIII11IlliII1 == 1 then
                                    return true
                                end
                                local I1Ii1I1I1IiiIl1lIii = il1i1i1iiil1IlliiI1 + l1liiliIII11IlliII1 - 2
                                if l1liiliIII11IlliII1 == 0 then
                                    I1Ii1I1I1IiiIl1lIii = l1iIl1iIII1liiIll11
                                end
                                return true, il1i1i1iiil1IlliiI1, I1Ii1I1I1IiiIl1lIii
                            else
                                lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = lIli1I1l111llliii11iI[5]
                            end
                        elseif i1l1II1li1llIlIIl1i ~= 12 then
                            lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = lIlli1iii11iliiiiiIII[lIli1I1l111llliii11iI[7]]
                        else
                            local ilI1l1ii1l11Iliiiii = IlllI1l1iiI1lllll1i[lIli1I1l111llliii11iI[9]]
                            local lI1I11liiIi1liil1II = {}
                            if ilI1l1ii1l11Iliiiii[llI1I1ilii1lliIilii] > 0 then
                                do
                                    local lIllI1i1l1Il1ii1ili1i = {}
                                    lI1I11liiIi1liil1II = lIlIi1Illl1iillll1ill({}, { __index = function(l1Ill1iIil1I11IIiII, lIlll1lIlIII11111llil)
                                        local iIi1ili1IIiIi1li11l = lIllI1i1l1Il1ii1ili1i[lIlll1lIlIII11111llil]
                                        return iIi1ili1IIiIi1li11l[1][iIi1ili1IIiIi1li11l[2]]
                                    end, __newindex = function(l1Ill1iIil1I11IIiII, lIlll1lIlIII11111llil, lIll1iIliiIlIiiI1iiIl)
                                        local iIi1ili1IIiIi1li11l = lIllI1i1l1Il1ii1ili1i[lIlll1lIlIII11111llil]
                                        iIi1ili1IIiIi1li11l[1][iIi1ili1IIiIi1li11l[2]] = lIll1iIliiIlIiiI1iiIl
                                    end })
                                    for ilI1iIIIl1iilII1iI1 = 1, ilI1l1ii1l11Iliiiii[llI1I1ilii1lliIilii] do
                                        local lIlil1IIiIii1l11Ii1li = I1iII111l1iiIIll1lI[lI11illliiiIll1I11i]
                                        if lIlil1IIiIii1l11Ii1li[Ii1IiIiIiIIl1iliili] == iIIll1l1lilIi1lIIil then
                                            lIllI1i1l1Il1ii1ili1i[ilI1iIIIl1iilII1iI1 - 1] = { lIllIIilil11llIIlIIii, lIlil1IIiIii1l11Ii1li[Ililil1i1II1iiI1li1] }
                                        elseif lIlil1IIiIii1l11Ii1li[Ii1IiIiIiIIl1iliili] == i1li1lI1i11l11iIi1i then
                                            lIllI1i1l1Il1ii1ili1i[ilI1iIIIl1iilII1iI1 - 1] = { lIlli1iii11iliiiiiIII, lIlil1IIiIii1l11Ii1li[Ililil1i1II1iiI1li1] }
                                        end
                                        lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                                    end
                                    if not li1ll1lliillIi1l1II[lIllIIilil11llIIlIIii] then
                                        li1ll1lliillIi1l1II[lIllIIilil11llIIlIIii] = { lIllI1i1l1Il1ii1ili1i }
                                    else
                                        lIl11Il1IIl1ll11ilIll(li1ll1lliillIi1l1II[lIllIIilil11llIIlIIii], lIllI1i1l1Il1ii1ili1i)
                                    end
                                end
                            end
                            local lIlilII1ill11IlliiIii = liilI1i1ililii1lll1(ilI1l1ii1l11Iliiiii, lIllIliiiIIIlliI1I1il, lI1I11liiIi1liil1II)
                            lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = lIlilII1ill11IlliiIii
                        end
                    elseif i1l1II1li1llIlIIl1i >= 15 then
                        if i1l1II1li1llIlIIl1i >= 16 then
                            if i1l1II1li1llIlIIl1i ~= 17 then
                                local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                                if lIli1I1l111llliii11iI[1] then
                                    iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                                else
                                    iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                end
                                if lIli1I1l111llliii11iI[2] then
                                    Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                else
                                    Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                end
                                lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = iIiiIlliI1ll1IlII1l + Ill1llIlIl1i1ii1lIi
                            else
                                local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                                if lIli1I1l111llliii11iI[1] then
                                    iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                                else
                                    iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                                end
                                if lIli1I1l111llliii11iI[2] then
                                    Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                                else
                                    Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                                end
                                if iIiiIlliI1ll1IlII1l <= Ill1llIlIl1i1ii1lIi ~= (lIli1I1l111llliii11iI[8] ~= 0) then
                                    lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                                end
                            end
                        else
                            lI11illliiiIll1I11i = lI11illliiiIll1I11i + (lIli1I1l111llliii11iI[9] - lIlillI11I1IIi11iili1)
                        end
                    elseif i1l1II1li1llIlIIl1i == 14 then
                        if lIli1I1l111llliii11iI[7] == 73 then
                            lI11illliiiIll1I11i = lI11illliiiIll1I11i - 1
                            I1iII111l1iiIIll1lI[lI11illliiiIll1I11i] = { [3] = 24, [8] = (lIli1I1l111llliii11iI[8] - 25) % 256, [7] = (lIli1I1l111llliii11iI[6] - 25) % 256 }
                        elseif not not lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] == (lIli1I1l111llliii11iI[6] == 0) then
                            lI11illliiiIll1I11i = lI11illliiiIll1I11i + 1
                        end
                    else
                        local iIiiIlliI1ll1IlII1l, Ill1llIlIl1i1ii1lIi
                        if lIli1I1l111llliii11iI[1] then
                            iIiiIlliI1ll1IlII1l = lIli1I1l111llliii11iI[10]
                        else
                            iIiiIlliI1ll1IlII1l = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[7]]
                        end
                        if lIli1I1l111llliii11iI[2] then
                            Ill1llIlIl1i1ii1lIi = lIli1I1l111llliii11iI[4]
                        else
                            Ill1llIlIl1i1ii1lIi = lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[6]]
                        end
                        lIllIIilil11llIIlIIii[lIli1I1l111llliii11iI[8]] = iIiiIlliI1ll1IlII1l ^ Ill1llIlIl1i1ii1lIi
                    end
                end
            end
            local lIlIlIiIilI1li11Ii1I1, l1I1IiI1ilililI11Il, lIlilliIiIlIlIl1I1i, iiIiiiiii1II1liiIII = iilliIiI11IlIi1i1i1(illlII1l11Ii1l11ill)
            if lIlIlIiIilI1li11Ii1I1 then
                if lIlilliIiIlIlIl1I1i then
                    return lIliliil1Iil1ii1iiI(lIllIIilil11llIIlIIii, lIlilliIiIlIlIl1I1i, iiIiiiiii1II1liiIII)
                end
            else
                lIi1i111li1li1illil("Luraph Script:" .. (iiiIlIiI11il1Il1l11[lI11illliiiIll1I11i - 1] or "") .. ": " .. l11lIiIIIiIiil1iI11(l1I1IiI1ilililI11Il), 0)
            end
        end
        lIl1IlIlIl1lI11IlI1ll(Ii11I1lIlI1l1I11IIi, lIllIliiiIIIlliI1I1il)
        return Ii11I1lIlI1l1I11IIi
    end
    local Ill1I11I11I1i1llili = lllliIiIIIiIiIlI1ii()
    return liilI1i1ililii1lll1(Ill1I11I11I1i1llili, lIllIliiiIIIlliI1I1il)()
end
lIli1l1IIii1IiliI1iil("LPH!6A05122H00020302043000330003302H00432H030456960A02007D2H0507391B2H1A2A3H47773HCC443HE99DDF2HDE8A3HEBCFC3D3A90E2H003CF23242013H007BC30C02006D3H50243D2H3F1D2H8286F65E5B597F17141C60E3E9EBC105060A72C0C9CDE35B58482C01091725090A1E7EA2A9B187141C0468AFBBB389848E92FA0C1D152B6C604014C5D7EFED9E92B62HE6F3C9CF28240C507B6F5B511A163A6258737D736468581C99B7A7B5161A2E6E3A130117202C1458371F0319929EA2EA94B3A5BB7C7030044D771F7DAEA2E6D66E53395F2H347C40132F4B213E266A0EFAE3B3CB62782C503E257D0D362A7602C1C38F932H3C7048DAF387E92HAEFEDA3F05790B9880D4A8EFE9BDB9ACB2E69A100F57272H400810B191C1B93E3662B252732B5BAA88D4A096B5D59D1E3A5E1272573F7F6A4C20647E59297196BECA96B3B9EFF39390C814547D2155E8C2A2EAB49FFBB757560C1C2H217D55511E18662E03632BB698FCB06A452D6D654A2662C8E797CF735C2874EEEDB5BD2HCEAEBA5341296B1BD454BE3D0D6525D1D6B2862H2F4B5B7D6E02440AC549AF67563A7E9097F7C7BFCCC2B8D4D5A5D15958320E2H771F03760A064CCE0D8567EADEAEF6EEDBAFF385B0C898AB9DE1B5D5E262CAB8BBD7EB2H7418005A312F61D81266791A23570B82B8C0902H6519616F6E063E2H077773600A0E5CB77D0D16D2EE96C6686F1B3F2HC02HB4305D5B0D3286FAED724F3367BA8404AC2HD155D5737202222HB3CBC7D6B8B2E83581F9EA457AFA52D79713BF2H8C04889C9DE1CD2HFE828AE48B85DB10A4C0CFFCBD399540028A2A2HDF53DB9190E8C02H61E115A6F604A68337575C9BD850F0C18509AD2H8A1A8E2223A7732H9C18E808A3AF09B07A1611CD8B07A3A7E070C8054DD9655B128A3A256FF347A3A020F02HF17985B42H1CB66DA7CFCCA3E878C05915813DD29A02B2FEB72B9FE6AC0C84BEBD31ED2H1E926A3881953B4E84D0EF93DD49F56D22BA0AAFFF63D7E5B4149CD38125A9A1A22AF22H63F317DC626AD81BD181BAF9AA32821347DB6FECBC1C941849ED617C2E8606ACAF3BFFC774241F2H6DF519142HA81231FBA39091C464EC4711B539E1B61E9EABF35FDB5108B8203231AD612HBA26CEF0A149F772B8FCD383D97DF13D3AA26A2H3B9B4F3860B2303689C9E21942EA6A431FB3372HD464D0A4A501F52HC662B2AAF325A3D36C200798C569ED94CA7AE22H67D363D9D878882H69C11D643EE46E00BFF7D47F209008ED8D39A52H52EA56AAAB07FB2HE448901A419F111DA296C97213A73B4A2890002H55E951DFDE768E2HF74783C02A5ECC358DBDE63A5EE6763E5BE7735630F0187A1DD9352A62AA4A583FF317FCF044A02HC175B5CB2050C66FD7EBBC503884108CE525CDA2EA2EC2A8874FAF9BFC30D4EE8959A1666ADA3A2HEB539F6E26FA601AD9E1B21872B25AA4CF0BE73104CC2C67519D79C1F626DE34378B672H48F43C5A05CB55288EAAE57B17D33F610CC4242H19D51D7B7AC22A2H7BBB0F60209270EF496922EC824AAA305F93772H14C410E4E521B52H06C272F2B305E38A2C00477505C92D7B0ADA222HA773A31918D8482HA961DDBC6A44AED87F57140C60B048A0CD19E52H965AC62HEF239B17C0EA04A505116E7816C23E3C538B7B2H6CA43C2H9545E12EFEC83AE24353285C2CF4044839E5112H9A4ECA2H9B4F1F2H70A8F42H5D81D92HA242262H7F9BFB2H34DCB07201ED295226D60E90E317CB487896202H25D9A13H2AAF2HC7C342743C341581C9C5E0903E44B615ADCF33BE046098D36F31F58C326AAA3171DB173744B86CE42H91B84536321F6B738D2BBDF484A983C9A5940D462E1B2H574FD22H4C50C92H5979DCFC2EAAA7F935ABA2D21C9C890E7D7154B4C2D2EBEC9F8BB65E545A0D145D3D0001C25A67357F2322D01CB8B97239616403CE6E6BAFE7CFCE145C7075AF79CFF08858EED70DDF5752535FADA1E8F2F00DE7AE2EF219532F0E53186045F9B1B9981E565A7FE402958ADF2FA8B1A25029CD97A5B75A2H779B47792H6C103H7905DFDE2EEECF2HDBA7B2B044809E9D65ADE82HE29EBBBF438F782H74087C2H413D692H661A262H2312B02HB8C46E2H6519632H6A1601070336722H7C00042H0975E9EEE6DF136B6742C8C0D0F1082H2D51B12HF28E492H4F33942H84F8EC2HD1AD372H760A8B2HB3CFD72HC8B4C02HF589452H7A06D72H97EBCE2H8CF0A02H99E5B6FEEAD7B3FBE3D2D9D0CCE18C2HBDC1472H027EEF2HDFA3D22H94E84E2H611D8C86A6B75C2H433FDE2HD8A4B22H85F9BC2H8AF61D2H275BA42H9CE01C2H2955050E2A3F9A2H8BF7ECE0C8D12H4D61481F1222234F2H6F13A22HA4D8BB2HF18D912H96EADB2HD3AFE32HE8941C2H15698C2H9AE6A52HB7CBA2AC989D812HB9C5272H1E62212H1B67C62HF08CE82HDDA1152H225EF0FFC7CEBD2HB4C88A2H81FDAE2HA6DA73635F52B62HF884A72HA5D9AAACEA2F78B4055EC64BFEA535BA0B502H2E6A2BD6ABE3DE52FC4A21126D214423326203892H8FF3F82HC4B80A2H116DA22HB6CAED2HF38F592H08747E2H3549F62HBAC6F22HD7ABE82HCCB0FA2HD9A5762H3E427F2H3B47572H106CC02HFD81632H423E5A2H1F63C92HD4A8B12HA1DD872HC6BABC2H83FF3H1864E32HC5B9E82HCAB6662H671B9F2HDCA06A6B213C4E5806CB4B8881D2A1256B390E84C694D717184B29A0E4B66CA3AEFDB8787B285C9D9CCF985E590AA4676231D8041F4CC8DA96EBA52HF78B3HEC9084F9A98C0AA20C7FD55B0F72233068011B2H1D61322H621E212H3F43D62HF488E12HC1BDC22HE69AB42HA3DF042H3844FE2HE599FE2HEA96822H87FBE42HFC80902H89F5472H6E12D02HEB976A2H403C3HADD15A2H720EF22HCFB33B2H0478552H512DDA2HF68A7C2H334F652H48345E2H7509F92HFA86442H176B0F0E5C599619496C2A5E2D5FEA7B2F3H520005B23D6D48D6A2D1A3CD5F0B762H1644416EE1B1945226552750C397EA2H5A080D8A0555705E2A592B33A7F38E2H1E4C4926A9F9DCDAAEDDAF9E0B5F222H62303542CD9DB8C6B2C1B379EFBBC62H267471FE71210442364537C453077A2H6A383D9395C510821A4E33AE376F1EB62C7005A2395910029EFAB7069BF3B276722039155D0974DFA2FAD72983255EAA34681D150161303D2H265AF72HE39F672H7804232H25593B2H2A56D72HC7BB0B2H3C408A2HC9B5FA2HAED21D2H2B57BE2H80FCA02HED91B1B0EAE7605FB766DBBBD50A2H0060BD2D67153H00C4A30A0200733H446CD447868A1A54B3F82HF5FDDD8A8082D8B7232HEE0F0E1A26D241B48C2H3A241CCDCFD3E70F041E86AFA9BDF97C2H7E282A2B29178786968239198120C7CB35343H0703F2D23AEB0A35DD0C1F0EDE420002D7C782234H00143H00573H00573H00573H00573H00573H00583H00583H00583H00583H00583H00583H00583H00583H00583H00593H00593H00573H005C3H005C3H005D3H0036820A02000DCF6H00F03F2D173H006ADFA26F491FC218C1D4BDD7BFA01DBFADEAA14DF975F22D0D3H00A91249DCBA3B1138A42C56C208CF8H00ED08C27A927D7EB60A02005B33A0616D4A4B491BAC8E8CB2F8F9FD8D4D484A6C44474F6FA82HAEFE31353D41AA2HA288C7C3CFB7454A4866F0F1FDA584808CD0BDB1B9EF7362605E252D2159E3F2EEC09E4F9B25FCEAE8DEEAEDE5BD3822A0D63537350B111A16323031442914181A24BFB3BF9BA3A2D7BAECE1ED95FAF4E4DCADBBB98FD6D8C25E2H1F11495450526C242B27037B7A0F62D4D9D5AD3C2C3C042H252B73E5DA32E39827DD1E2H01B286AE384H00273H00603H00603H00603H00613H00613H00613H00613H00623H00623H00623H00623H00623H00623H00633H00633H00643H00643H00643H00643H00643H00643H00643H00653H00653H00653H00673H00673H00683H00683H00683H00683H00683H00693H006B3H006B3H006C3H006C3H006C3H006F3H006B8F0A0200392D033H0006D3482D063H00354A9F086D7E2D053H009B003A37CB2D263H0004617E17FCB529BDA386695C6723033D649045DDF13A457BE95801C854F813B24DE518F7D0912D083H007AA7CFA5572E5E592D0F3H00826F73743243D414F352CE1020BD2F2D153H00BD92B821D51ACCAB64F697A088270E2204CCEB3149E22D083H006633ABE1D83EB21E2D063H006EFB06B4DC7B2D093H0064C125B78D44D7AEA82D033H00097EBA2D033H00706DF02D073H00AF7421F43A96C12D0B3H00CA77AFEDEB7AEDB49605A42D033H00E196D02D143H0008459C666545FBCFB0F98DEFF314D25370A283F37506CE78DA5847990A020001151415492F2E2C123F2H3DBF737789B4494D4B15C3C2C0FE332H31732723DDE08DAD4594B9866EBF46BE452A010073EAB24D4H000A3H00723H00723H00723H00723H00733H00733H00733H00733H00743H00753H0071810A0200A9CF5H00806640CF5H00807640CF5H008066C05D02A0D3D163E39A0A020013A6A5AFEB2HC2C0FE2H454D6DF1F5F8C4C0539A9EBEBAAEC62H6573212E282078DCDBD3AF4A6AFE5392AD4594A44328350201108020334H000B3H00783H00783H00783H00783H00793H00793H00793H00793H00793H00793H007A3H00C5810A020015CF8H00CF6H002440CF6H00E03F8405DA16B92039A20A0200AFE9EEF868575343D7CD5EAB934947513D56504C0027B34A7E3C3A1842DC49A88448526030EDEBF3BBCD12CE78646E6521AFACAE90BF2BD2E614123052B3B5ADE533EC3086F7D757EE516E8657A77AB90D040307B48F144H00133H007D3H007E3H007F3H007F3H007F3H00803H00803H00803H00803H00803H00803H00813H00813H00823H00823H00823H00823H00843H00853H008A800A02008DCF5H00806640CF8H00B60AE82HF5095FA80A0200D93EAD68606AFE3733B263B7097A78742C919599C5E772BBBFAF3B2HF609D808B22725357196929AC27CEF2H2224B0417D9D4D9127080A1E5E13170347D144B52H891DE8D05A8A52E065677F33484C5C1CE4E7F99977766E0A7201BF030E2CAC151A25CD1C3EFAAA6B02039E0B68284H00193H00883H00883H00883H00883H00883H00893H00893H00893H00893H00893H008A3H008A3H008A3H008A3H008A3H008B3H008B3H008B3H008B3H008B3H008C3H008C3H008C3H008C3H008D3H00AD7E0A0200418609108B4A01919D0A0200692H6664361C1F1D23D1D0D280B8B9BB852H1A12324363F35A07945159C95D9490EB3AEE5063B363D93B38346C2HE1E9856C52C26BB48B63B2E028A3302H0228F994024H000E3H00903H00903H00903H00903H00913H00913H00933H00933H00933H00933H00933H00933H00933H00943H00577F0A020089CF8H0015066CF3DD2DF5D70A02002F2HACA0287A79696B10120A3A3235216598919480040715273D3E2A4AF9FDE5D52H04182C2H13333B2HEEFEBE4D435909F2F9FCE89C9F8DBF1516026211150D3D2H5C40742HAB8B832HC6D696656B71E14D41445034372517EDEEFA9A2H2D3505B0B4A89C2H43636B2H9E8ECE7D736939A6A9ACB8CCCFDDEFC5C6D2B22H455D6D080C10242HDBFBF32H766626959B8111FFF1F4E0646775479D9E8AEA2H5D45752H64784C7773535B2H4E5E1EADA3B9E958595C48FCFFEDDF757662022H756D5D2HBCA0940F0B2B232H263676C5CBD1412HA1A4B02H9787BF474E5A668F8D95A51E14064CA9A383D7F2ECD82HDAD7FDF9A674B81E2D2F03072H220672ADBD83856C7F6C303A3B3907DACAF4F281A12D98ABA749582HC7D7EF8EAE3697D2ED05D451251F3603005BD1403A4H00483H00973H00983H00983H00983H00983H009A3H009A3H009A3H009A3H009A3H009A3H009A3H009A3H009B3H009B3H009B3H009B3H009B3H009B3H009B3H009B3H009C3H009C3H009C3H009C3H009C3H009C3H009C3H009C3H009D3H009D3H009D3H009D3H009D3H009D3H009D3H009D3H009E3H009E3H009E3H009E3H009E3H009E3H009E3H009E3H009F3H009F3H009F3H009F3H009F3H009F3H009F3H009F3H00A13H00A13H00A13H00A13H00A23H00A23H00A23H00A23H00A23H00A23H00A43H00A43H00A43H00A53H00A53H00A13H00A93H00A93H00AA3H00A58B0A020049CF8H002D133H001C79B98EF4B5CBDB066EBEA3A7F603C3C5E6E0CF6H00F03F2D093H00FB105B57DC807E2430CF6H004440CF7H0040CF6H000840CF6H001040CF6H001440CF6H0018402D083H0058959FA95BF0706E2D0B3H00A01D96BDE542835F81CBEF2D0A3H00D7CCCFDC7A53593BB07A6F0C3D620710686A0B02008D8714C9D92H313321F4F2F6A2532H51038A888AB4D72HD5FD6C6E2F76D8E70FDE891CC1D1F8FDF9AD7E2H786E992H9FCF949098E49F2H97BD04020E2AFDFBF7AB5D12FDBEC22HC3910406043AE1E3EFCB8E8CF9940A35DD0C8D8A86FE44574967DDD8D088396D482H878E9AA6212B335F06D40CBE2F2535793212102E8599A19FE8E4D0CC52557D05160024067F734B5BABAC98FCFEEDF1A5829A98A6DDCDF9C7EEE8C0B89D8725738A9E9CA2B1BD95ABB2B49CE4FB6D80A065F2633F57CF5A02F5E8CAD4EAFDA3C129061AA6021D4123B3A6FE9895A7C505A9AE92FE64795947F2E2C47CA78993E9ACAE9AFA4B4F7B1FCCCAC09C4C4D4F718246962C01DB0FB1E810C51BAD8E704D32143066069391AFCCCED2D817110D41F36A93A7F3D3D5E70E082C583E292519B9BCB8EED8DBD9E79A00F9CDDADDC3CD40465E163E3F3D031416081000011D050D966B5B27070533DADCFC8CADB72H85C2ECE8EA869687DB1F1C1E208319E4D4C6CEECDE696F4B3FE1E0E2DC6D6F4D69535272564A51FFA56C242618140FBDFB1056546AFF6382AEE9F4C2C8342B1B15DCC6E8FA110921372928087814896C44DFDEF2F6F2D3C97BF3F8D8A4FCE1CBDD6848581A52436B1F352A0E142A0B1F5968785E26426F7D63F7D6C6B8881588D8EBEAAEC2AE8FEDE73F347C68E8F5A7C9FEC4BC9698A3C7CB011E52209CA7DBF566582232EEC3B9CF516A1204A9B1E9C5C1029A686BA723CDB17CFC162H510D01E2FAA68E8643C729FE38B852CA0D81672HFAA2AA55CB760609107464B569E50339F67E9C2H7B1F2B1A842549584129352EF27A98D917637C2H1C7C4CA63590F8100A601AC5C3AF9346685E0C0E090B35163C0E52A9ABA997222048082833D5C72H9290AE140F67277270D968E6D1D3ED8FA696CAF1F3F1CF2A284000F0EB0D1F2H1A18264C573F7F7A78D160B6999BA59A803274303B390779E0012D3919172DA0A68AF6968BBBBF7D4276246361635DA4A6828E061DB7E92H383A041E05212D3C3E5326C6E7E5DBF8E24C1636292B1561FE1F33CFEFE1DB42446814C4D9E9EDF96287AF2B0B013F8680A8D0FBE7D9D1BC909C961A0717435C484A74DE45A4883E1E102A75735F238598A8ACB08D9F9975EE0B235F7F754B52547C04574B757DC8E4E8E2B6AB9B9F8280ED98CE51B09CC2E2ECD6A1A78BF71388614521011735484E7A1E0C1F2B2797BAB2BC435F6D51211EF627E6900036000D204497734H00DB3H00AF3H00AF3H00AF3H00AF3H00AF3H00B03H00B03H00B13H00B43H00B43H00B53H00B53H00B63H00B63H00B63H00B63H00B83H00B83H00B83H00B93H00B93H00BA3H00BD3H00BD3H00BD3H00BF3H00C03H00C13H00C13H00C13H00C13H00C23H00C23H00C23H00C23H00C23H00C23H00C23H00C23H00C23H00C23H00C23H00C23H00C43H00C43H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C53H00C73H00C73H00C83H00C93H00C13H00CB3H00CE3H00CE3H00D03H00D03H00D13H00D13H00D13H00D13H00D13H00D13H00D13H00D13H00D13H00D13H00D13H00D13H00D23H00D23H00D23H00D23H00D23H00D23H00D23H00D23H00D23H00D23H00D23H00D23H00D23H00D43H00D43H00D43H00D43H00D53H00D53H00D53H00D53H00D53H00D53H00D73H00D73H00D73H00D73H00D83H00D83H00D83H00D93H00D93H00D93H00DA3H00DA3H00DC3H00DC3H00DC3H00DC3H00DD3H00DD3H00DD3H00DE3H00DE3H00DE3H00DF3H00DF3H00E13H00E13H00E13H00E13H00E13H00E23H00E23H00E23H00E23H00E23H00E43H00E43H00E43H00E43H00E43H00E53H00E53H00E53H00E53H00E53H00E73H00E73H00E73H00E73H00E73H00E83H00E83H00E83H00E83H00E83H00E83H00E83H00E83H00EA3H00EA3H00EA3H00EA3H00EA3H00EA3H00EA3H00EB3H00ED3H00ED3H00EE3H00EE3H00EE3H00EE3H00EE3H00EE3H00EE3H00EE3H00EE3H00EE3H00EE3H00EE3H00EF3H00EF3H00F03H00F03H00F03H00F03H00F03H00F03H00F03H00F03H00F03H00F03H00F03H00F13H00F13H00F13H00F13H00F13H00F13H00F13H00F13H00F13H00F13H00F13H00F13H00F23H00F23H00F23H00F23H00F23H00F23H00F23H00F23H00F23H00F63H000C9A0A0200C12D0A3H00316E2C4DD1B4BEF06C33CF8H00CF6H004DC02D0E3H005310CAAFB3C5634D748A1CD5C6022D0A3H00E926468E29F3E33DB47D2D0D3H000BC803EB1158FB8FB0DC4C19142D0B3H0024A19D98CB453E2E75ECB42D083H00C3809854509D1FCB2D0F3H00AB68A2476B8A30F3E411A36D6BA132CF5H00407A402D073H007E7B48D49B9DDF2D0C3H0029662445E98AA5FB6107257C2D0C3H0085C2D2239062569100E4D2092D093H00E11E52AB14FEE63AAC2D033H000603B82D033H003D7A0ECF5H00806640E22D0A3H0034B1A98EDC6C0C3B79E1CF6H001040CF5H00805640CF6H0054402D033H00D6D3EACF6H004E402D093H000D4A1161E2CAD40AC62D083H00322F9C05C9C001B1CF7H0040CF6H004D40941DC4D1097926D40A0200F5A83BE6F62HC8CAD87F797D29CED45A206D6F6D532D2H2C04D7D594CD556E6C5236A37E6E2H101200878185D1968C0278E4F7F5CB32A47969C9CDCB8935363242FAF3FDDB592H5C0C8D8F8DD1D6DAD8E63BAF7262BCB6BEECD3D1D3EDFF2HFED6061D93E92HA0A29C902H95BDB4B6F7AE042H0773040C0624D8DDD98DDED293CA290B0937AF38E5F52H9D9F8D686E6A3E0B119FE55F4C4E70A731ECFC8E8A8CCE909397E731383610A42HA1F13230326E1B17152BD0449989E9E5EBB95456546A1A2H1B33FDE668122HADAF91FC2HFAD2898BCA93DF2HDCA8F1F9F3D11F1A1E4ABBB7F6AFC9C0C2FCF365B8A8C1C2C6B6262F2107252H2070F82HF9A5E5E6E4DA282H2B5F08000A28BCB9BDE9929EDF86C0FF17C693FDF95600057D18C3624H00453H00FB3H00FB3H00FB3H00FB3H00FB3H00FC3H00FC3H00FC3H00FD3H00FD3H00FD3H00FD3H00FD3H00FD3H00FD3H00FD3H00FD3H00FD3H00FD3H00FD3H00FE3H00FE3H00FE3H00FE3H00FE3H00FE3H00FE3H00FE3H00FF3H00FF3H00FF3H00FF3H00FF4H00013H00013H00013H00013H00013H00013H00013H00013H00013H00013H00013H00012H002H012H002H012H002H012H002H012H002H012H002H012H002H012H002H012H0002012H0002012H0002012H0002012H0002012H0003012H0003012H0003012H0003012H0003012H0003012H0004012H0004012H0004012H0004012H0006012H00FD850A0200212D0A3H001AD77354BA5D8909F75ACF8H00CF9A5H99C93F2D093H009C99511F3FAF8BCB772D093H00019E98CD470666010CCF5H00805640CF5H008056C0E802F797231149EA0A0200452FBC61712H515341CCCACE9AA6BD33492H9092AC3A05ED3CF662BFAFE6E3E7B335343040D8DDDFF915161E3E292H2F7F5C58502C78A941C3F82HF2AEA8EFEDD3FAF6E2EC676145495D5A420A3339112326202H086661453145524612C8F7F5CBC2CADAD4EBEDF5BDE3768BBB33352H1BE0F8CAC8AB3DDCF08384AEAAF6EFD9DFCB5CB9917B7F5951E6FAEABE7043417FB1B098B430A54C68D9DCFEF20C1529275F447874BF29C4E43A3806164759796B746A4858F6E5FDAD161A182649DF36121712303C8A95AFA1756C525E584555034540427CCD55BC9824B25F7F1B192737E8F0D6C4051B3929C1DEEADE2H5B735F8C9630621A0D0F31E27A93B718093107EA7C95B19A9FBDB1051A202E6A754D7B9900E9CD9E9BB9B5BB22CFEF2B29170778644654150B2B595E4F7A4E22BB52769396B4B81609333D73EA072723211F0F302C0E1CE471E0BC9390AABE7E6745536D705440A9BF89BDC552BB9F30271B2FE810B51B9CD6281589B65E8FA2C1D723000708DE47684H005B3H0009012H0009012H0009012H0009012H0009012H000A012H000D012H000D012H000E012H000E012H000E012H000E012H0010012H0010012H0010012H0010012H0011012H0011012H0011012H0011012H0011012H0011012H0011012H0011012H0012012H0012012H0014012H0014012H0014012H0015012H0015012H0015012H0017012H0017012H0017012H0017012H0018012H001A012H001A012H001A012H001A012H001A012H001A012H001A012H001A012H001A012H001A012H001B012H001B012H001B012H001B012H001B012H001B012H001C012H001C012H001C012H001C012H001C012H001C012H001E012H0021012H0021012H0022012H0022012H0023012H0023012H0023012H0023012H0024012H0024012H0024012H0024012H0024012H0024012H0024012H0025012H0025012H0025012H0025012H0025012H0025012H0025012H0025012H0025012H0025012H0025012H0028012H0028012H0010012H002A012H002C012H004A8A0A0200B92D0A3H0006D3BFD03EA19DF57BFE2D0A3H0080FD37D1F088620A6D362D0D3H005A874A40704FD2F42123F502552D0B3H00F3189629444CD54FC2C56F2D073H0072DFD4605FF15B2D0C3H00657AE0493D6E39DFDDCB01C02D0C3H0091467E679CDE525DB400AEAD2D0A3H003D92B8A1551FCD2CE0E2CF6H001040CF6H00F03FCF7H0040CF8H00250ECA712072769E0A0200A738AB5E66898A960A626141E1C7D0DCB8636547E712143296859FADF58B9C90CCD6D7F353272606A2312B1941DFC8C498BDBFA7DBC0FE7EC70A35DD0C42EECE7106014B423F094H000F3H002F012H002F012H002F012H002F012H002F012H002F012H002F012H002F012H002F012H002F012H002F012H002F012H002F012H002F012H0030012H00777E0A02007DF50A2963FB5F009F0A0200432HA4A0D0C6C5C1E710121A3A472H4111212H2600626B6533CACECCF2202H2B311A1C0C347C7B772B080A0E5A2H7D7F41989A909C1A1B131FB69606AF3609E130A82F4C0C010063E12F114H00103H0033012H0033012H0033012H0033012H0033012H0034012H0034012H0034012H0034012H0034012H0034012H0034012H0034012H0034012H0034012H0035012H00AC850A0200792D0A3H00C78CCC309F2HF94BEA672D0D3H00F166F571BB4E15E57A021AD36E2D053H00321F67C242CF6H00F03FE22D0C3H004328225F93FCBB117BF9C3362D103H00AF347CD9BB77822412CE1CE0EFA9492BA0057AC1441080260B0200112H9490E004070325ACAEA686CD2HCB9B2C36BCC2F4797B45C152939F022H05133E2H3868E9F379075ED6D4EAF367A6AA512H5404E0E9EBF1AFAABA82E8EFE3BFE5E8EAF4D2D5C12HFDFAF2AA979F8FB7F1F8EC8C4C5D5F69D9D2CAFAD1D7C78789949AAC38273B6D2026241A828F9D97A5A08088B2B5A9E5FCFEE67ABCA7A5AB363028600ED105BB4F50545E6D6B773B4E684A2H18191B252600247E2HA3A19FDCDEC0D80C0D11097752546644572H7FF3F4D0A4C451B09CEF3EF254898FAFDF2H84AC80617559019CB4ACBE3D13091F9BB6A2B82HEDC5BD34A24F6F72774327201C1A0CD1EFE7FD81168FDB6FF76A3AF134945E535111059A9EA6CE128B16469C0485C9F4319D5BECEEAABA0F0B4F5BAF38B9F5F169ECA470B61EDC41430B177C783828E47DF8B05EC64F0B458317E99290DCC421256975E9EAA66E3B0F7B533406702H5C45A92D3D3C7276CBDF8FAB33126E189A91D3A90426486A063F4753C7E096EC6E4B235D7152381ED1E99F87EBCEBEC0E2D193D1220E5842ECCBA7BB2H702420F9E5B1919BB4D8AE00DB47B18A8E2HDC4559052D75583C425B9713FD1E1A4048534D2939AF88D09638E36F898844CC2EE1C1B1E92H8EEEDECACBA3CFC3C4A8ECFF65C8A87D1853B4737F0B57DFD8B680306B5709ADF6CCA2B1B7CFE726BCE1713D219D3D194606562H67655B2H80E884676EFC91F9DAB6AEBF9BEBB331142H603BF18D9A2C2A5A7A694F37670D28545C528DE9E600067E569FBDF30F2HBED0E8A63D94F04D1838462D673167D2D0D2EC663167312H2A28166B691F6F65641060565739017F7E127A6F4F3B752H782H7CB99975A03D02EA3B48F4FB190109CEA51D7E4H00973H003B012H003B012H003B012H003B012H003B012H003B012H003B012H003B012H003B012H003B012H003B012H003C012H003C012H003D012H003D012H003D012H003E012H003E012H003E012H0040012H0041012H0041012H0041012H0041012H0041012H0043012H0043012H0044012H0044012H0044012H0047012H0047012H0047012H0047012H004A012H004A012H004B012H004B012H004B012H004B012H004B012H004B012H004D012H004D012H004D012H004F012H004F012H004F012H0050012H0052012H0052012H0052012H0052012H0052012H0054012H0054012H0055012H0055012H0057012H0057012H0057012H0057012H0057012H0058012H0058012H0058012H0058012H0058012H0059012H0059012H0059012H0059012H0059012H005A012H005A012H005A012H005A012H005A012H005C012H005C012H005C012H005C012H005C012H005E012H005E012H005E012H005E012H005E012H005E012H005E012H005E012H005E012H005E012H005E012H005E012H005E012H005E012H0060012H0060012H0060012H0060012H0061012H0061012H0061012H0061012H0063012H0063012H0063012H0063012H0063012H0063012H0065012H0067012H0067012H0067012H0067012H0067012H0068012H0068012H0068012H0068012H0068012H0068012H0068012H0069012H0067012H006C012H006C012H006C012H006C012H006C012H006C012H006C012H006C012H006C012H006C012H006C012H006E012H006E012H006E012H006E012H006E012H006E012H006E012H006E012H006E012H006F012H006F012H0071012H0071012H0072012H0048A70A0200152D073H003FA82C48EB41B52D0E3H005237490EFC66780D05411CDA21E5CF5H004051402D0A3H00E431C542C4BB8F6FC98C2D093H009A1F4F40F22BE6CEC22D0D3H001760304185093A857DD1F2DF052D133H004411A562648527977EA682AF07768F2F9DEE7CCF8H00CF6H0059402D0A3H00F7C05810A7A54D438A6B2D0D3H0075160DCD9F26A509EEC2A20FDA2D0C3H005ADF8BB52A5A3A1517B36329CF6H00F03FE22D083H00DEB3607CE4A80C3D2D0F3H00762B43B4D693B5EC63EDA9E4D8DA5ACF6H000840CF6H004F402D0C3H00C5A65CD13582C5EF8D77FDF82D0F3H00F9EAC287579F6526DE6FC56A0200E62D093H003C694CFAEBD16989272D033H002132EF2D033H00E0DDE72D033H0073ECA32D073H004A8F487C4288AC2D053H009162FEF13ACF6H00C040CF7H00402D083H00CE63FF25131A86F12D0F3H0066DB236EE01B24E991002FCBCF0AF62D083H00F596AE4A16AB09952D0B3H002D2E178E48B93A040CA8DECF2H00E03HFFEF412D083H00D4E19739D4F42A4A2D0A3H00AC994D2A8C969ACAF7222D073H002247207FE74D282D0A3H00093A4ADB2C48FC14FC722D0A3H00370009D160780B03413F2D0E3H00B556AB8054E452C38480649CD4BA2D0A3H001F0876E30FC2C0DE6205C78021E34DFB2D48D40A02004B2H53577B47464E6E2HE1EDC9DAE4E2BC4CDF2E1266F2073F980DF4C0849E106A5A4B497738AE53632H512H799498BEBC41D7361A53527E7A5C537375B0AA2H982H4B4513BEB6B48A9701FCCC2H5C2H74F7FBDDDFD442A38FC4C5E9ED7976565033292H1B6B70DE842H494B75080C2C24F3F7D3DFCEC2D4D241572H5D2C383C302H33271B23263E0E2HC1DDE9D6C4D29C2HEFCBC704022H2A2HBD9195EDE0C6B86CFB6A3653566A7E34290D193AAC3961E9EFDFC7342A021A7DE57C289790A4B82C331F039296D6BEB5B1F599383C0A2CD3FDE7C77E52466A5D5288ADBBAF45505CCB3A06CBC6DAEE6FF90C34EAE4F4CC9F07FECAADA2B68A2125050D0C082C20101A0D0B05152H1EA2B0B5B91B5BA1A4A09F77A6ADB6956F0106D45F85164H00453H0075012H0075012H0075012H0075012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0076012H0077012H0077012H0077012H0077012H0078012H0078012H0078012H0078012H0079012H0079012H0079012H0079012H0079012H0079012H0079012H0079012H0079012H0079012H0079012H0079012H0079012H0079012H0078012H0077012H007C012H007C012H007C012H007C012H007C012H007C012H007C012H007C012H007C012H007C012H007C012H0075012H007E012H009A850A02006DCF6H00F03FCF6H005040CF7H0040CF6H001040CF8H00CF6H000840CF5H00408F403F127706551FF29F0A020023A1322HFF31A5546816C418AE515347071E1A0E4AD5D7C1A9282C3C6CAA3FCEF29E0AFFC70BD901B32A28307C0B0F1F5F1310026E0C0B1D49D5F46CCDC8F71FCE278B0D320403568752424H00103H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0081012H0082012H00F57E0A020051F408E711394D43AE0A0200A391022HCFC111C17B05D408BEE537EF5D2H0E2E26C4C7D1955FCC39017BAB73C16FBE7AD49E9FBBED1A0A3C58F8FFD18B06132E86FCFFE1ADD744B98933E3238967B67ADCD6D7FBA59286BC10B0B781C3FEE7CE7E3437116548DC3911E73BF35113CE7AA4A779C913A37CC016C71FA7755B8226E86E6B413DEBD43CEDA5F5192C040213A27A404H001F3H0085012H0085012H0085012H0085012H0085012H0085012H0086012H0086012H0086012H0086012H0086012H0086012H0086012H0086012H0087012H0087012H0087012H0087012H0087012H0087012H0087012H0087012H0088012H0088012H0088012H0088012H0088012H0088012H0088012H0088012H0089012H0022810A020039CF5H00804640CF6H000C40CF6H001040C011DD8BFB28A37C0B0200E344D7161AF32HF6A6C4C5C3954340427C222129332C2A267AA4BF394B2HBCBE80D0EF07D6AE3AFFF7588961E32HBAB0EC9E0BCEC624222C365B5D510DB0AA2C5E7577754BA432F7FF372H33652H30320CFCC32BFA59CE0B0393959B81AEA8A4F8ABB13745D0DAD8E628BD7870AAACA2B8494F431F92880E7CCCC9CBF5242C2E046379FF8DD0D2D0EEED75B0B8CA5E895F19175E0F44DE1B13A5759D1F9E9894C8848BC293831ADFD75943C5B79A989AA4F76BAEA683981E6C2H393B0559C401094A430A5B8C12D7DF14171D415FC0050D72717B27AE2EEBE370737925DD5C99915DDF1612B9BEB4AA4F494119DB582H952823276BF4F2FEA2FD79B0B407000A14C5C3CB93362CAED8C48587B9AFE4BD0EE6E3F3CBEFE2F8FEE3E5F5B57B7C6408796F655FABAEB2FEB4BDA1C97F6C6658909BBBB3E4E2FAB21519396D5F8040EA353F176382A2A09EF9EFC3E5FEF0CCD850576707DFC4E4CE5F5111796F685438E2F3EBBF829A98A6212F1B3D6A6C5C3C8F954F61C2D6D4EA2H85BF99E6E0D0B0F277E2BAC342DB8F33B52878E5FEA6C0CEDD89E3DFEA8A4EC4E18BE1517C127C4D7917DF898ECADE9BBDDBBD487A18D86B59393BC4C6FA92F9FDC1ADDADCD4881617152B30F6229C65A149CB3CC419CFEFCC320FBDBEB8EE3C31330D4F406E5CCDCBEF9B2DAA4B670813272D4D686668E3F5D9CBBE9680966C6D4D3D9514F1D98E83ABC7745640524E5D69C5C2C4E8940DD73BBDF67EB7B3B2A1B1893E38306866EF2H222H6E787A7F796D293C103A68515B5967A58CA4F6DCD9DBE5FD642HA97269D79D6062605EA3B5A59D352E90DA1613112F899E8EB6948F317B2E2C2E10F67F2HB22H5E484AEFE9FDB960F809354F55EFA1979694AA2H4B5D05A1A4A69836B7467A0882774F23213F35A2A4B8F4818F9BC38C8A9A2HDA51A49C041C00342H1F3F1B4948521E068D7840011804302H3B1B3F85849ED2E2699CA48E9488BC2HD7F7D341405A16CE45B0888B908CB8BA23DEEEFAE04E14F3F1F3CD1B0C2C240A11BFE52H3A3806DBCDEDE50B0A105CF07B8EB66A766A5E815D993787869CD01C97625A2F322E1A4CD52818041EB0EA6163615F796E4E46E4FF510B2HFCFEC0568B4FE12928327E76ED1820FEFCE2E8191F034F716B663A8D999BA52FA45169A4B7AB9F6BF20F3FF1EB451F7370724C8F03FECE171CDA66544FE1BB2HECEED033BF42721918024EF67D88B0F6E8F4C088B589DB5456546A29092921E1FA540E2H27251B0512323AE6E7FDB16760625C1893665E5D4E526656416169DFDEC488840FFAC2140A16220A1D3D35DBDAC08C94AB43927CE3CC51011AFE2HDD2C4H00ED3H0094012H0094012H0096012H0096012H0096012H0096012H0096012H0096012H0097012H009A012H009A012H009A012H009C012H009C012H009C012H009C012H009C012H009C012H009C012H009C012H009D012H00A0012H00A0012H00A0012H00A0012H00A0012H00A0012H00A0012H00A0012H00A0012H00A0012H00A1012H00A1012H00A1012H00A2012H00A2012H00A2012H00A6012H00A6012H00A6012H00A6012H00A8012H00A8012H00A8012H00A8012H00A8012H00A8012H00A8012H00A8012H00AA012H00AA012H00AB012H00AB012H00AC012H00AC012H00AE012H00AE012H00AE012H00AE012H00AE012H00AE012H00AE012H00B0012H00B0012H00B0012H00B0012H00B0012H00B1012H00B2012H00B4012H00B4012H00B5012H00B5012H00B5012H00B6012H00B6012H00B6012H00B6012H00B8012H00B8012H00B8012H00B8012H00B9012H00B9012H00B9012H00B9012H00B9012H00B9012H00B9012H00B9012H00B9012H00B9012H00B9012H00B9012H00BB012H00BB012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BC012H00BE012H00BE012H00BF012H00C0012H00B8012H00C2012H00C5012H00C5012H00C7012H00C7012H00C8012H00C8012H00C8012H00C8012H00C8012H00C8012H00CA012H00CA012H00CA012H00CA012H00CA012H00CA012H00CE012H00CE012H00CE012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D0012H00D1012H00D1012H00D1012H00D1012H00D1012H00D1012H00D1012H00D1012H00D1012H00D1012H00D1012H00D3012H00D3012H00D3012H00D3012H00D4012H00D4012H00D4012H00D4012H00D5012H00D5012H00D5012H00D5012H00D7012H00D7012H00D7012H00D7012H00D7012H00D7012H00D7012H00D7012H00D7012H00D7012H00D8012H00D8012H00D8012H00D8012H00D9012H00D9012H00D9012H00D9012H00D9012H00D9012H00D9012H00D9012H00D9012H00D9012H00DB012H00DB012H00DB012H00DB012H00DB012H00DC012H00DC012H00DC012H00DC012H00DC012H00DC012H00DC012H00DC012H00DC012H00DC012H00DC012H00DD012H00DD012H00DD012H00DD012H00DD012H00DD012H00DD012H00DD012H00DD012H00DD012H00DF012H00DF012H00DF012H00DF012H00E0012H00E0012H00E0012H00E0012H00E2012H006A9F0A0200DDE22D093H005DC622AF284EBE6E502D0A3H003E0353A46EB9B161C3FE2D033H004C19232D0C3H000788964B5DE0016B7C2BD8D2CF5H00407A402D0E3H00CBBC8E6743B9F76D2C86489D26DE2D083H006D969E421E9B090D2D0F3H00450ED401A5BC16456AC745FB4587E42D0A3H00D8F59BADA0E8AEC6F5BE2D0D3H00765B4AB0BCA30ADCAD9F2542B92D0B3H00DF003E25D82CE5A38EDD272D073H00DE23C480D37D032D0C3H002D56FC894DE2554775873D502D0C3H0091AA52BFB4128E3D84EC22F52D033H00B5BEFB2D033H009441E3CF5H008066402D053H006F50F4576C2D1C3H00CC99E0E5671180D26A85E3FEA95008295D3AE7990A7AEA8200C815A1CF7H0040CF6H004DC0CF6H00F03FCF8H002D243H0030ED6419C38D5C2H86B1E7728D3C449EC4EB67C57FCC062H391B0A2A266429407C3B93A92D253H008C592025A7514012AAC5233EE990C86A987F23195BB03A8D55144EE094C4A41509DD55C2DB2D273H00854EA1C67E5E910133B202BD004FF9795148627AA27F8BFE6CC3EF237D7B75A6914F41E3147E6C2D1D3H0040BDD4A9D3BD2C5696E177029D4CD42ED41BF7954F1C9649182C7AF00C2D213H00D1EA0D4272F205FD4796FEB99C93EDB5E5ACCEFEAE133F22B8BCB321C4829A235F2D133H00CADF721F09FF52E8AC83D134B74E9A83DB7C152D173H002D56C98E56C609496BBA3A45F8C71182BC358E7285C02ECF6H004D40CF6H005EC05A1422E5186505A00A02006705964B5BB92DECE02H3C3414C12HC79752505272A9ABAFF98E888AB4EB7FBEB2DCDED6F671A149CB5754447C192H1397E8EAEE8EEFD13DE8A4A0A4887757BB6E1926CE1F4275F4300002A20C8F374H00113H00F3012H00F3012H00F3012H00F3012H00F3012H00F4012H00F4012H00F5012H00F5012H00F5012H00F5012H00F5012H00F5012H00F5012H00F7012H00F7012H00F8012H00F6830A0200412D163H009815A0AD63FD6822E39ECFC5951257051F80C3EFB337E22D173H00161322AFE5F3EA209D984DC7130CD507918641ED3539BA2D093H0011CEE565EC2C5B119ECF6H00F03F600564D52C438D6D0B020023EE7DA0B0292C287C4FDB1A16171610364CD91C142HA6AEB4A5A3AFF3D32HD682EEE5E7D9E670B1BDC2C7C5D34BDE171342434F511E181048B421F220C9C8CE9E59CD0C005DC80D052H79716B04020E52797C7D61D0448589162H11378512D7DF2H575F45929498C4322H3763F5FEFCC2F961A0AC0D080A1C881FD6D2B9B8B4AA8F8981D9E376A577E8E9EFBFB226E7EBAE39FCF42H868E9485838FD3B1B7B6AAC5CDC395838082BCA3A9A5B3EC2HEABAA4BF354BF8FCFEC076EF2E22ABAEACBAFCFDF1F9FBFAFCAC340BE332AC36F7FBFD2DC1472H767020BC27E6EAA3A0A4B2372H3161F4EE641A1113112F920ECFC3909D97C1E8ECEED0E67FBEB29B9E9C8A6C6D6169EBEAECBCA49B73A29B06C7CBC8CFCD9D652H6A1465697517969C80122HA5B1212H6078E4CD53AA9EC9CAD0DE00012505DFDEC08850CF36028D8E949ADCDDF9D9DBDAC48C6BEB1226C1C4D8D63B3D256DD0CA783EDAD7D5EBCC52AB9F12110B052H507454F0F1EFA7F06E97A376616F619D1CFDD18E8BABDB8B04BF054E4F5119440EF1A2ACB9B5EBF8669BABAEB9BDB116946D594045595770766E26011BA9EF4E40427C2CB34A7EA9AAB0BE2HE1C5E5BFBEA0E8B02FD6E26D7A747AEE6D8CA0B2B82H90191F3F4F57D863D91A1B054DB8F20D5EB0A5A9F72DB24F7FF2E5E1EDBCF6095AD8DCD78F9C9E9CA2DC97683BA7A3ACF0626F6D53138A73472A29333D2HA88CAC8889972HDF46BF8B8E919799A8E2654E2E3D015FDF9417386F794F1D293404604A5D65038D8C92DAC2C1C3FDD54CB581D8DBC1CF4B4A6E4E9E9F81C9CC48B185FCF9E5EB84829AD27D67D5932014162887978BE345605C62D4D1C98110343200BAB32H9B7D7A5E2A311517219F8CA0A44C4B6B1B6FEA0F275BDD341081A0BAA862415D4B7E5E4C566143574901002850002D3527392A1EB24E696B0502042854232H0D33766E5A46B8A199892H785028B4938DC7261E04AA28AD4060726E4C38D9DFEB8F31B6277B81099CC4FAF6CEE475774F2322201676EC65F4A8578438EE3BE75F8D54681CDE01295369716C28442A2D1B7B4DCA5B07B73DA8F0666A5278494B731F565462021099085443902CFA4F932BF91E245092351D675DEDE0A4C806013757159E675386839F915E5840081B01B3F5060A08360A8D744046587870A5BB9F9358462H6EBDBBA5ED8804FDC954697517063C2442B595BDE18D00E9CD72735F272H3E166AF1F3EDA5231CF42553C2C559001B7C97CE5E4H00DE3H00FC012H00FC012H00FE012H00FE012H00FE012H00FE012H00FE012H00FE012H00FE012H00FF012H00FF012H00FF012H00FF012H00FF012H00FF012H00FF013H00023H00023H00023H00023H00022H0003022H0003022H0003022H0003022H0003022H0003022H0003022H0004022H0004022H0004022H0004022H0004022H0004022H0004022H0005022H0005022H0005022H0005022H0005022H0008022H0008022H0008022H0008022H0008022H0008022H0009022H0009022H0009022H0009022H000A022H000D022H000D022H000D022H000F022H000F022H000F022H000F022H000F022H000F022H000F022H000F022H0010022H0010022H0010022H0010022H0011022H0014022H0014022H0015022H0015022H0015022H0017022H0017022H0019022H0019022H0019022H0019022H001A022H001A022H001A022H001A022H001C022H001C022H001C022H001C022H001C022H001D022H001D022H001D022H001D022H001E022H001E022H001E022H001E022H001E022H001E022H001F022H001F022H001F022H001F022H0022022H0022022H0022022H0022022H0022022H0023022H0023022H0023022H0023022H0024022H0024022H0024022H0024022H0024022H0024022H0024022H0025022H0025022H0025022H0025022H0028022H0028022H0028022H0028022H0028022H0028022H0029022H0029022H0029022H0029022H002A022H002A022H002A022H002A022H002A022H002A022H002A022H002A022H002A022H002A022H002C022H002C022H002C022H002C022H002F022H002F022H002F022H002F022H002F022H0031022H0031022H0031022H0033022H0033022H0033022H0034022H0034022H0034022H0036022H0036022H0036022H0036022H0036022H0036022H0036022H0036022H0036022H0036022H0036022H0037022H0037022H0037022H0037022H0039022H0039022H003B022H003B022H003B022H003D022H003D022H003D022H003D022H003D022H003E022H003E022H003E022H003E022H003E022H003E022H003E022H0040022H0040022H0040022H0040022H0040022H0041022H0041022H0041022H0041022H0041022H0041022H0041022H0044022H0044022H0044022H0044022H0044022H0045022H0045022H0045022H0045022H0045022H0046022H0046022H0046022H0046022H0046022H0046022H0046022H0046022H0048022H00329F0A0200D92D0C3H00B6C3B164CD78E6404A7FB5BF2D0A3H00426FD394B205B9F9BFD22D0E3H009CB91DFE94143C89CDF2BF8184402D093H00DA47C02C394284B207E22D093H008FB458953294DC9CB22D033H00BCD95FCF7H00402D0D3H00BB002E176B80C885626A299F03CF6H00F03F2D243H00CC690C297F79ACCEBA456FF271B82494B397EAB254F4FD51CAB27E4A4E1175E99FE1F11FCF8H002D0B3H00302DF1AA801943DA5F9D5ECF6H003E40CF5H00804B40CF6H0044402D083H0017FC7CC09C29D3D72D0F3H005F04A653371EEC5FD04DC7D9E7353E2D133H00C2EF5314329B316128586469A16809A9BB104ACF6H0008402D033H0001561B2D033H0068A523CF6H005E402D0E3H00C72C8EBBDF201F8D7F72FD09920C2D133H00356A3A633F826BEF8E97CF255317EEEDB11F95CF6H002640CF6H004E40CF6H003940CF6H00F0BFCF6H004940CF5H00E06F40CF6H0014402D0A3H004CE98AA4E3F970463AD68E1240B8DE6591AC0B0200074CDF1E12DFDED8CE772H7121100A80FEF9FBF9C72EBA7B77243FB5CB2H60625C0837DF0E33A6676B4C4D4B5DAE2HA8F8D6CD47392H02003E1629C110787A7E68BD2HBBEB0F0A0C5E582527198214D5D9AA2HAFFF9B9C98CA2H51536DFFC028F9161F1D07A4A2AEF27863E5972HDCDEE06C53BB6A332H38222B2D217DAEA8A4DC6C2H614F3E2E2C2EDCD5CDFDF7F4E4A05B5F570FC9C0D8DA03051155C3D4D6D0C5C3D393D5C0CCC6A1AD8D850F081458B2A5ADA36E62464ADADDC58DDED6DC88F51F1D236E7E747E8885A5AD27203C700B1B151BF4FADED2B2B5ADE5F0E0D2E078772H5F0502265259417B7D3B2E18BC617949439B86B6EA8D93A3A90E1C2088CDD3E1EF9488B6E63C2111B550487E74BDAF93C3233E0E6A657B4B41273408582E3303A771E6032B0911232D6B7A40EC18333D27C6D8F0E23F2109B934180A0C7467533FCCCAE69AECF1C195CC54B199C61FD775585E720E1B3313559350526C9E07E2CA2H6C4E46F46D84A09796B0BCC8E5EDE3BB22CFEFE5E3D9C9644C5A482437030FEAFECE8A99BFA72HB5B084E010031B4B8E8A88B68811F8DC8B8AACA08CA3A9A71308AAFC6E6D6F51851CF5D178795F5329060C0292BFB7D98A8FB080960FEAC22H24060E4F636F65AD34DDF9C0C1E7EBB19E949A65714105BC9A829036330763CDDEEEDE54CD28002HF6D4DC290309031B826B4F42436569C3ECE6E8C75FB292F32A9A40F7F1C5A1020D1448737B7947A03AD7F72D0F2371E2E0E2DCFFE7D7CF7368B69CCECDCFF13B2C1C04564D93B92H8280BEB329C4E4F3E0D0E0B53F3D038E8C889EA72HA1F145764614772B29175CCA0B07D02HD585111612402H9795AB49769E4F7C75776D5E585408061D9BE92HB2B08EC6F911C02E28205CEDE1E5CFBEAEB0AE4F55417D77747820DBDFD38F4C4A463E822H8FA1405052504E475F6F555646022D2921798E989E9C31372367E02HF4F2555945715B5C4C0C9E89858FE2EECEC606011D51A1A8A4F42H8B89B7152AC213223125193BA0556D7A31C29D95869AAEDADDCB85BC8A9AACFFE3CFCB1116364642D93C148298A0A8465B4F1F2H1E1C22DAE50DDC222BC1D477EB1A26AFA2BE8AAD31C4FCA6A8B880A183BD87B090ACF69F809995A03CCDF1969B87B347645462F5699CA4BEB0A098F9DBE5DF039E6753716545110C2E2624EAEFCBBFC9DAFEF292958DC5D6DEC4C81B87764AE3EEF2C6381D2B1D50CC3901454B5B63745668526A7D7779EAECF4BCA8ADAFFF7C7E7C425FC53C08B1AA185E2H9B99A7170A1622474F55594CD0211D020F1327132A0036A13DC8F04A44546CF5D7E9D3A2B2BCB206193D311B1C044C59514B4787AEAC92C5C7C3D5662H60304A0B491B393A3806BF21E0EC313038342HB5B3E36746447A9D9F9B8D7E2H7828A2E1A5F3D5D2D0EEC9CBCFD94A2H4C1C0E4B095FDDDEDCE275777365962H90C0FABDF9AB696A6856EF71B0BC2H6068642H6563336776744A4D4F4B5DAE2HA8F8521B51030F02003E7F797D0D79767E58BFAFB5AF070E1E2H26252D71C42HC090ED7BBEB69B9E92CE50455F4192949CC415030507A4A2B6F2FEF5FDAD2H23DDE06C53BB6AA332F12F010CA8F3A5714H001D012H005F022H005F022H005F022H005F022H005F022H005F022H005F022H005F022H0060022H0063022H0063022H0063022H0063022H0063022H0064022H0067022H0067022H0067022H0067022H0069022H0069022H006B022H006B022H006C022H006F022H006F022H006F022H006F022H0070022H0073022H0073022H0074022H0074022H0074022H0074022H0074022H0074022H0075022H0075022H0077022H0077022H0079022H0079022H0079022H0079022H0079022H0079022H0079022H0079022H007B022H007B022H007B022H007B022H007B022H007B022H007B022H007B022H007B022H007E022H007E022H007E022H007E022H007F022H007F022H007F022H007F022H007F022H0080022H0080022H0080022H0080022H0080022H0080022H0081022H0081022H0081022H0081022H0081022H0081022H0081022H0081022H0081022H0081022H0083022H0083022H0083022H0083022H0083022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0084022H0085022H0085022H0085022H0085022H0085022H0085022H0085022H0085022H0085022H0085022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0087022H0089022H008B022H008B022H008B022H008B022H008D022H008D022H008F022H008F022H0090022H0093022H0093022H0093022H0093022H0094022H0097022H0097022H0097022H0097022H0097022H0097022H0098022H0098022H0098022H0098022H0098022H0098022H009A022H009A022H009C022H009C022H009C022H009C022H009C022H009C022H009C022H009C022H009D022H00A0022H00A0022H00A0022H00A0022H00A0022H00A1022H00A1022H00A1022H00A1022H00A1022H00A1022H00A1022H00A2022H00A0022H00A6022H00A6022H00A6022H00A6022H00A6022H00A6022H00A6022H00A7022H00A7022H00A7022H00A7022H00A7022H00A7022H00A7022H00A7022H00A7022H00A7022H00A7022H00A7022H00A7022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A8022H00A9022H00A9022H00A9022H00A9022H00A9022H00A9022H00A9022H00A9022H00A9022H00A9022H00A9022H00AB022H00AB022H00AB022H00AB022H00AC022H00AC022H00AC022H00AC022H00AD022H00AD022H00AD022H00AD022H00AD022H00AD022H00AD022H00AD022H00AD022H00AD022H00AD022H00AD022H00AE022H00AE022H00AE022H00AE022H00AF022H00AF022H00AF022H00AF022H00B0022H00B0022H00B0022H00B0022H00B0022H00B0022H00B1022H00B1022H00B3022H00B3022H00B3022H00B3022H00B3022H00B3022H00B7022H00EEA30A0200F12D0A3H0086A3B7086EA1652DDB2E2D093H00181505FA58A7B79E252D0F3H00BD6A2521FD92FE1C3AFB820C584537E22D093H00900DF3E4E58D279DDD2D0E3H00B5E278A9FD37F19312788E9358F02D0A3H003B08605CFB75ADAF86432D0D3H00AD5A7021F5ACF20D26E7AD256D2D083H001633C798DECEFAA52D083H003EDBDDD6B75DD51D2D0A3H00668397288E9E8A45EB532D0C3H00F8F5651A7899C4BC50D424532D0C3H003471B324211117AE3157734E2D033H0070EDE22D033H007784B82D033H002ECBE2CF7H0040CF6H005940CF6H001040CF6H00F03F2D093H0095C278C0063412AC4E2D093H00EAC797640C4F818877CF6H00E03FCF6H004DC0CF6H004D402D0D3H006FFCC9CAA269E82H484C14BC1F2D0A3H00383503CB3868957805AF2D0B3H008A6733D46AE8FCF7DB61FB2D083H00594614D54CAAD8AACF8H00CF6H0008402D0A3H00016E63B1A1652D83DCE62D0D3H00B3000F45727A35E1285C4420DB2D0D3H003CF981623DA8253901D663CA082D163H0075A29CFF165132CD7895C3DD823D94A6AB972CA8FCE22D133H00A3F00E769E612FDA142H7C31FC4387B89623C92D0E3H006A4724FD9FE20D17CD8B1958522BFE0EFE9CD75634022H00013H00013H00013H00013H00023H00023H00023H00023H00023H00023H00023H00023H00033H00033H00043H00043H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00053H00073H00073H00073H00073H00073H00073H00073H00073H00083H00083H00083H00083H00083H00083H00083H00083H00083H000B3H000E3H000F3H00103H00113H00123H00133H00143H00153H00173H00173H00193H001A3H001B3H001D3H001D3H001F3H001F3H001F3H001F3H001F3H001F3H001F3H001F3H001F3H00203H00203H00203H00203H00203H00213H00213H00213H00213H00213H00223H00223H00223H00253H00253H00253H00253H00253H00253H00253H00253H00253H00263H00263H00263H00263H00263H00263H00263H00273H00273H00273H00273H00273H00283H00283H00283H00283H00283H00283H00283H00293H00293H00293H00293H00293H00293H00293H002A3H002A3H002A3H002A3H002A3H002A3H002A3H002B3H002B3H002B3H002B3H002B3H002B3H002B3H002D3H002D3H002D3H002D3H002D3H002D3H002D3H002D3H002D3H002E3H002E3H002E3H002E3H002E3H002E3H002E3H002E3H002E3H00303H00303H00303H00303H00303H00303H00303H00303H00303H00313H00313H00313H00313H00313H00313H00313H00313H00313H00333H00353H00353H00353H00353H00353H00353H00353H00353H00353H00373H00373H00373H00373H00373H00383H00383H00383H00383H00383H00383H00383H00393H00393H00393H00393H00393H00393H00393H003A3H003A3H003A3H003A3H003A3H003A3H003A3H003B3H003B3H003B3H003B3H003B3H003B3H003B3H003D3H003D3H003D3H003D3H003D3H003D3H003D3H003D3H003D3H003D3H003E3H003E3H003E3H003E3H003E3H003E3H003E3H003E3H003E3H003E3H00403H00403H00403H00403H00403H00403H00403H00403H00403H00423H00423H00423H00423H00423H00423H00423H00433H00433H00433H00433H00433H00433H00433H00443H00443H00443H00443H00443H00443H00443H00463H00463H00463H00463H00463H00463H00473H00473H00473H00473H00473H00473H00483H00483H00483H00483H00483H00483H004A3H004A3H004A3H004A3H004A3H004A3H004B3H004B3H004B3H004B3H004C3H004C3H004C3H004C3H004C3H004C3H004C3H004C3H004C3H004C3H004C3H004D3H004D3H004D3H004D3H004E3H004E3H004E3H004E3H004E3H004E3H004E3H004E3H004E3H004F3H004F3H004F3H004F3H00503H00503H00503H00503H00503H00503H00503H00503H00503H00503H00503H004F3H004D3H00533H00533H00533H00533H00533H00533H00533H00533H004B3H005D3H005D3H005D3H006F3H006F3H00753H007A3H007A3H00853H00853H00853H00853H008D3H008D3H008D3H008D3H00943H00943H00943H00AA3H00AC3H00F63H00F63H00F63H00F63H00F63H00F63H00F63H00F63H00F63H00F63H00F63H00F63H00F63H00F63H00F83H00F93H0006012H0006012H0006012H0006012H0006012H0006012H002C012H002C012H002C012H002C012H002C012H002C012H002C012H002C012H0030012H0030012H0035012H0037012H0072012H0072012H0072012H0072012H0072012H0072012H0072012H0072012H0072012H0072012H007E012H007E012H007E012H007E012H007E012H007E012H007E012H0082012H0082012H0082012H0082012H0089012H0089012H0089012H008B012H008C012H008D012H008E012H0091012H0092012H0092012H0092012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H00E2012H0092012H00E4012H00E5012H00E6012H00E7012H00E8012H00E9012H00EA012H00EB012H00EC012H00ED012H00EE012H00EF012H00F8012H00F8012H00F8012H00FA012H00FA012H00FA012H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H0048022H00FA012H004A022H004A022H004A022H004A022H004B022H004B022H004B022H004B022H004C022H004C022H004C022H004C022H004D022H004D022H004D022H004D022H004E022H004E022H004E022H004E022H004F022H004F022H004F022H004F022H0050022H0050022H0050022H0050022H0052022H0054022H0055022H0056022H0057022H0058022H005A022H005A022H005C022H005D022H005D022H005D022H00B7022H00B7022H00B7022H00B7022H00B7022H00B7022H00B7022H00B7022H00B7022H00B7022H00B7022H00B7022H00B7022H005D022H00B7022H00DD1D0B0200AD2D053H0090CD61FE052D0A3H007942506D91680208649F2D0A3H006F80AE134F0AC8DEB29D2D063H0015AE7726201D2D0A3H001F707994822DB7451B8D2D063H00451E972109AE2D073H00CF601E39F7537B2D0F3H0092279F10FA2057D32F1A3EDEAF31492D0A3H003902B2A6D197574DB4C92D103H002F40FA538F500611E6D48502B26D64582D083H00DF3088C8CC65F7872D0F3H0037A842BBF75258FFF86173713799BA2D063H0052E7F5543A5B2D053H00F46179567E2D053H004D8668838A2D073H00C297EE09D18C962D053H00917A9D61192D063H00F6BBBD5D53292D073H0078954FE7B5AFD82D053H009FF0C9030C2D043H00CC59D29E2D053H0068C5FF21B72D063H00F15A3C91AFA22D0B3H001BBCDB77C13D876B9DD7442D093H00CAFF826C21AECED6F62D0A3H0057486410D7CD7C7BC6AD2D0B3H003DB638F387966E4C3C813D2D143H009481EE36C30C4447E93921D846E13777EDDE747C2D083H00A09DD9B55C1CA1022D053H0018B59AD2162D0E3H00E18ADEFEB96FF9090A2D7B7E804C2D0E3H006364459F0EEDDD377211FEF395BD2D033H0015AE232D093H0054410B6C1E44968E3E2D093H00D9221F982C6DB72B1D2D083H00DACF103425EF53652D053H009227AB18E92D073H007334D323193CE82D093H00C64B5F516DA3AFD0902D053H002324BDD7482D083H0040BD45937D1B17E32D083H00B8D52D847B7346BB2D0B3H0030EDE5E85FC98E56D160AC2D0C3H00830472DCFA4E7E542989BA3A2D083H00E79862275D900E7D2D0E3H003F103AE86FB392A7EEEA0CD087972D203H00917ACF205DD69BFC09126758B50EB3F4E1CABFD0F9030AA179E3BE2592DF1181CF6H0069402D0C3H00F15A0B8FA8B477D9A966C6282D0F3H00F50EA0DC48AC8BF06228EBDFD1ED232D0E3H0048252DC6D01854D9A94EDF19F08C2D0A3H00F2077F278126E4E3C5272D063H00B06D6B4AE577CF6H003040CF5H00A07240CF6H0079402D0A3H0062B76BED3B60EFD375772D083H00A09DF3B51D2BBE022D083H0018B58BDD1583E6DA2D0A3H0090CD4BFE000D2B75679D2D133H003E63257F8E06AD9C1F567CDAD7B38C7CC074272D0C3H00416A7E0472928A3EBE47039B2D0C3H00451E8230512HAE123A33EF4F2D0C3H0009925EB902D1195DD53E1A222D0C3H008DC6124D4E22BDA1D18A46562D0D3H00D1BA5D25CE6988710801EFDDA72D123H006ED3466459B05C9BC3D92CEA8F56DB6DBBF12D0F3H000431F6EA477462049DA80D88F66A2B2D0F3H0033F42D6F587939A64AADD9ADF9A8202D083H00BEE3B7FD138B650F2D0A3H00F6BBBE48412227EC4FE42D0A3H00D4C1A8FE83C84612AD2ECF8H00CF5H008066C0CF5H008066402D0F3H00A2F702ACEA37A183052E8DB2A375C82D0B3H008912ED31817A96C601BE902D0A3H00D00D05A4C1DBED35275D2D0C3H007EA3C03449D6AE5EE902FD9E2D0C3H00F2077C309D2AFAE28A26D11A2D053H00262BC37F042D0E3H00B728C32C66E1C22H6ECEF9FFB51B2D173H0049D2357DC3ABC10784EE9FF6BF63EE1F0D23796C8C50042D123H006411960AE794026438CCC1BE9676F16A35362D153H006A1F3C48818238F96336C8217BB03D1FB9EF193C212D093H009B3C65F05E870CEF042D103H0034A10B1124E4EB2A405065B9A5C090572D0B3H0024D1F64037D84499730D0B2D0F3H0087B89807B0666E47B04688CBCE62ED2D073H00E237E56CA6E6602D0C3H00319AC64E797F389DBD3D95EB2D0F3H00354E52863E63517412E3658D9BAEF22D143H008865FF8D90F8578E6910D6D2B24D5B2419E141E12D0E3H00D4C18BEDAFC91234A937C39504A02D0E3H009E4380A57A268EB9BF78DDFD7DD52D0F3H0058F56F81EB52A58C8F6828AACED5E72D193H0057487616CAC2251AC0AE1DC513F39DD26E563187302HF5C52H2D0E3H00B06D4759D37406E84DEB3F61E8D42D163H001A0FEDF4F8FB1828BF067FD0EEDA1A85E3DCF1B969F92D0D3H006C790178648A4C330D72910AF22D093H00FD765232CDEDA494672D113H00AE131D2F0E76134C92843EF94118842A6CCF5H00E06540CF5H00E06F402D0A3H00C34418B4AB3F3E3AE90E2D133H0009926EB611E71055D5250D70EEA927434B22E52D113H00C8A5B3424AA4DB4360DC588F754413EED5CF5H00A074402D083H00D56EBE4B6D4FB9442D063H00EDA6E769FF962D093H0037A86881F16D56F2FB2D073H00201D44329BA1262D083H00E7985811519502612D063H003F100FE768872D083H00F9C2DCED1CDC8C9CCF6H00F03FCF6H005040CF6H000840CF5H00408F40CF6H001040CF6H004DC0CF5H00407A402D0A3H00917A8A780D9AD4B55D41492D093H004778F94BF4BD2HB5FA2D0B3H00F0AD050AA035C0960BAEED2D0A3H0043C4A33F2889AEA27ECE2D0C3H008912E42A906F87D16CA589B52D0F3H000D46E9EDCCF638687610CAD434488D2D093H00C03D9428FF8687731A2D073H0055EE20F7EEDF2B2D0A3H00B06D0478E27012D25AA72D083H005E03F7DF737FC5EF2D103H0096DB5E01B7066ECCEEE31D92FED0FCEF2D083H00068B4E2327627BC72D063H003E631E748F1C2D0A3H0080FD546B35DAC6A894372D123H00AE1376121F7D1D4C858325B74757AF3070E12D093H004471F89D093B3AFE1E2D0B3H000992058B1DE10753D4245D2D153H00508DE407455E6AA3E8C89F404CB8D44A60DA43953E2D0A3H006972A5EBBD0FA17165082D063H00DF30A9D4CA7B2D083H0099E254C46CBBED702D0F3H00319ACE4C71792CB0A02193FD5B2B412D0E3H00F4617A537134E379B39DA7F6FC0D2D0D3H00BEE394FD1B96650FA9D3A95B462D0F3H004778F75BFFB8A49EC099C0160AAF2H2D0D3H00A2F71AAAEB2DA0AE293B81AFA22D163H001BBCEA61F83F946396EB45A38CB36228A5C9DAF6322C2D133H00257EC0C8385FC1B462D212EF8A9D6956308D272D0D3H009481CD3EDD087945E96E0FD6582D073H00855E68EAD87C6A2D0B3H00A09DFEBE1B3BB70979D1AB2D093H00B37488E4D9F5BF68E42D0B3H006C79247B69965601057F9D2D073H006F8099135833D02D0E3H00B2C78B78C1783126187A1E4C828E2D0F3H004CD9641E9A2059A229149FB90533220E5B408FB26B4H003D7F0A0200E1CF5H00E494406C003B0CCB2D", lIlI1IiIiiIIiI11111li())





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

