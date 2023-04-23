local oldtime = 0.0
local num = 0
local P2C = {}

-- 动态组名内容设置区， []内数字为组名滚动的顺序
P2C[0] = "Organner.pl "
P2C[1] = "rganner.pl O"
P2C[2] = "ganner.pl Or"
P2C[3] = "anner.pl Org"
P2C[4] = "nner.pl Orga"
P2C[5] = "ner.pl Organ"
P2C[6] = "er.pl Organn"
P2C[7] = "r.pl Organne"
P2C[8] = "pl Organner."
P2C[9] = "l Organner.p"
P2C[10] = " Organner.pl"
P2C[11] = "Organner.pl "
P2C[12] = "Organner.pl "
-- 如需添加新行，请将[]内数字向下增加1


-- 动态组名标题设置区
function drawtext()                                          -- 左上角加载LUA提示
	Render.Text(10,20,"AW ClanTag LUA For Paste2Cheats")
--  Render.Text(水平位置,垂直位置,"显示内容")                -- 示例
end


-- 动态组名速度设置区
function autoclan()
	if math.abs(Globals.curtime - oldtime) > 0.65 then       -- 将0.65改为组名滚动的时间
		Misc.SetClanTag(P2C[num % 12],"Organner.pl")         -- 将13改为上面组名滚动的次数，一般设置为最后一行的数字
		oldtime = Globals.curtime
		num = num + 1
	end
end


-- Hook设置区，一般不需要变动，增加新功能时需要在本区域内添加HOOK
Hook.AddHook(drawtext,"PaintTraverse_last", PaintTraverse_last)
Hook.AddHook(autoclan,"CreateMove_last", CreateMove_last)