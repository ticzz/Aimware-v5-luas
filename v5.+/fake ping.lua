local ref_misc = gui.Reference("Misc")
local fake_ping_enabled = gui.Checkbox(ref_misc, "fake_ping_enabled", "Enable Fake Ping", false)
local fake_ping_value = gui.Slider(ref_misc, "fake_ping_value", "Fake Ping Value", 0, 0, 1000)

local function get_fake_latency()
  if fake_ping_enabled:GetValue() then
    return fake_ping_value:GetValue() / 1000
  else
    return 0
  end
end

callbacks.Register("CreateMove", function(cmd)
  -- установить фейк пинг
  local latency = get_fake_latency()
  client.SetConVar("net_fakejitter", latency, true)
  client.SetConVar("net_fakelag", latency, true)
end)

callbacks.Register("Draw", function()
  -- отображать текущий фейк пинг
  if fake_ping_enabled:GetValue() then
    local fake_ping = fake_ping_value:GetValue()
    draw.Color(255, 255, 255, 255)
    draw.Text(10, 50, "Fake Ping: " .. fake_ping .. " ms")
  end
end)
