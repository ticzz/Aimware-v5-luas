local KILL_SAYS = {"ez", "too fucking easy", "effortless", "easiest kill of my life",
    "retard blasted", "cleans?", "nice memesense retard", "hello mind explaining what happened there",
    "pounce out of your window disgusting tranny, you shouldnt exist in this world",
    "а вы че клины???", "обоссал мемюзера лол", "ты че там отлетел то",
    "lmao ur so ugly irl like bro doesnt it hurt to live like that, btw you know you can just end it all",
    "ROFL NICE *DEAD* HHHHHHHHHHHHHHHHHH", "take the cooldown and let your team surr retard",
    "go take some estrogen tranny", "uid police here present your user identification number right now",
    "нищий улетел", "*DEAD* пофикси нищ", "сразу видно юид иссуе хуле тут",
    "у мамки что кфг иссуе была шо тебя родила", "а ты и в жизни ньюкамыч????", "сука не позорься и ливни лол",
    "юид полиция подьехала открывай дверь уебыч", "набутылирован лол", "tranny holzed",
    "але ты там из хрущевки выеди а потом вырыгивай блять", "как там с мамкой комнату разделять АХАХАХХАХА как ты на акк накопил блять",
    "найс 0.5х0.5м комната блять ХАХАХАХА ТЫ ТАМ ЖЕ ДАЖЕ ПОВЕСИТЬСЯ НЕ МОЖЕШЬ МЕСТА НЕТ ПХПХПХППХ", "better buy the superior hack!",
    "на мыло и веревку то деньги есть нищ????", "whatcha shootin at retard", "опущены стяги, легион и.. А БЛЯТЬ ТЫЖ ТУТ ОПУЩ НАХУЙ ПХГАХААХАХАХАХА)))))))",
    "але какая с юидом ситуация)))", "бля че тут эта нищая собака заскулила", "не хотелось даже руки об тебя марать нищ сука", "ебать ты красиво на бутылку упал",
    "прости что без смазки)))", "алло это скорая? тут такая ситуация нищ упал))) ОЙ А ВЫ НИЩАМ ТО НЕ ПОМОГАЕТЕ?? ПОНЯТНО Я ПОЙДУ ТОГДА))))))))", 
    "nice 0.5x0.5m room you poorfag, how the fuck did you afford an acc hhhhhh", "вырыгнись из окна нахуй боберхук юзер",
    "тяжело с мемсенсом наверно????", "imagine losing at video games couldn't ever be me", "але а противники то где???", "nice chromosome count you sell??",
     "nice thirdworldspeak ROFL", "как ты на пк накопил даже не знаю )))))))))",
    "iq больше двух будет пмнешь ок????", "НИХУЯ ТАМ НЬЮКАМЫЧА ОРОШИЛИ СТРУЕЙ МОЧИ АХАХХАХАХАХАХАХАХА", "дал юид за щеку проверяй", "nn4ik shat on",
    "хуя тебя опустили манька))))",
    "ez", "effortless", "1", "nice antiaim, you sell?", "you pay for that?",
    "refund right now", "consider suicide", "bro are u clean?",
    "another retard blasted",
    "hhhhhhhhhhhhhhhhhh 1, you pay for that? refund so maybe youll afford some food for your family thirdworld monkey",
    "paster abandoned the match and received a 7 day competitive matchmaking cooldown",
    "freeqn.net/refund.php", "refund your rainbowhook right now pasteuser dog",
    "бля эт пиздец че какие то там нищи с мемсенсом рыгают блять",
    "тебе права голоса не давали thirdworlder ебаный",
    "на завод иди",
    "JAJAJAJJAJA NICE RAINBOWPASTE ROFL",
    "140er????", "get good get vantap4ik",
    "1 but all you need to fix your problems is a rope and a chair you ugly shit",
    "who (kto) are you (nn4ik) wattafak mens???????", "must be an uid issue", "holy shit consider refunding your trash paste rofl",
    "hello please refund your subpar product",
    "ебать тебя унесло", "рефандни пожалуйста",
    "на бутылку русак",
    "a вы (you) сэр собственно кто (who)?",
    "бля пиздос может рефнешь???",
    "как там жизнь с рупастой??????",
    "але может не будешь тратить мамкину зарплату на говнопасты???",
    "stop spending your lunch money on shitpastes retard",
    "бля я рядом только прошел а ты уже упал АУУ НИЩ С ТОБОЙ ВСЕ ХОРОШО??????????))))))",
    "ой нищий упал щас скорую вызовем",
    "ой а кто (who) ты (you) такой вотзефак мен))))))",
    "thats going in my media compilation right there get shamed retard rofl",
    "imagine the only thing you eat being bullets man being a thirdworlder must suck rofl", "so fucking ez", "bot_kick", "where the enemies at????",
    "але найс упал нищ ЛОООООООЛ", "с тобой там все хорошо????????????? а да ты нищ нахуя я спрашиваю ПХАХАХАХАХХА",
    "жаль конечно что против нищей играть надо)))", "тебе даже спин не поможет блять, нахуй ты вообще живешь", "ты можешь заселлить лишнюю хромосому???",
    "научи потом как так сосать на хвх", "когда не накопил на гормоны и чулки)))))))))))))", "как там жизнь на мамкину пенсию???????", 
    "але я бот_кик в консоль вроде прописал а вас там не кикнуло эт че баг??)))))))))",
    "крякоюзер down, на завод нахуй", "я не понял ты такой жирный потомучто дошики каждый день жрешь???? нормальную работу найди может на еду денег хватит))))))))))))",
    "насрал тебе в ротешник проверяй", "нихуя ты там как самолет отлетел ХАХАХХАХАХАХАХХХААХАА",
    "БЛЯ НИЩ ХУЯК ХУЯК И ТЕБЯ НЕТ КАК МОЖНО ТАКИМ БЫТЬ?????? ОБЬЯСНИСЬ БЛЯТЬ"
}

local STANDART_TIME_FOR_CHAR = 0.04
local MEDIUM_KILL_SAY_LENGTH = 25

local function getWrittingTime(kill_say)
    return string.len(kill_say) * STANDART_TIME_FOR_CHAR
end

local static_time = 0;
local selected_kill_say = nil;

local function getKillTime(event)

    if event then
        if event:GetName() == "player_death" then
            if client.GetPlayerIndexByUserID(event:GetInt("attacker")) == client.GetLocalPlayerIndex() and client.GetPlayerIndexByUserID(event:GetInt("userid")) ~= client.GetLocalPlayerIndex() then

                static_time = globals.RealTime()
                selected_kill_say = KILL_SAYS[math.random(0, #KILL_SAYS)]
            end
        end
    end       
end
client.AllowListener("player_death")
callbacks.Register("FireGameEvent", getKillTime)

local function sendTrashTalk() 
    if selected_kill_say and globals.RealTime() - static_time >= getWrittingTime(selected_kill_say) then

        client.ChatSay(selected_kill_say)
        selected_kill_say = nil;
    end
end
callbacks.Register("Draw", sendTrashTalk)
