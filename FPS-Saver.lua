local fps_target = gui.Slider( gui.Reference( "Ragebot", "Hitscan", "Advanced" ), "fps_target", "FPS Target", 80, 0, 144 )

callbacks.Register( "CreateMove", function()
  local fps_target_adjusted = fps_target:GetValue() * 1000
  local cur_fps = 1000 / globals.AbsoluteFrameTime()
  local cur_proc = gui.GetValue("rbot.hitscan.maxprocessingtime")
  local final_proc = cur_proc
  if cur_fps < fps_target_adjusted then -- if under fps target, processtime - 5
    final_proc = cur_proc - 5
  end
  if cur_fps > fps_target_adjusted then -- if over fps target, processtime + 5
    final_proc = cur_proc + 5
   end
   gui.SetValue("rbot.hitscan.maxprocessingtime", final_proc)
end )