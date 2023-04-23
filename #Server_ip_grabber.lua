function grabServerIP()

local serverIP = engine.GetServerIP();

print(serverIP)
end
callbacks.Register("Draw", "serverIP", grabServerIP)
