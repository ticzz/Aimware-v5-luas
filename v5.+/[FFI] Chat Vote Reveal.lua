-- Variables
local CHudChat_Printf_Index = 27 -- if there was update please update...
local ChatPrefix = "\02[\07AIMWARE\02] "

-- Functions
local function FindHudElement(name)
    local m_Table       = mem.FindPattern("client.dll", "B9 ?? ?? ?? ?? 68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 89 46 24")
    local m_Function    = mem.FindPattern("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39")

    if (m_Table ~= nil and m_Function ~= nil) then
        return ffi.cast("void*(__thiscall*)(void*, const char*)", m_Function)(ffi.cast("void**", m_Table + 0x1)[0], name)
    end

    return nil
end

local CHudChat = FindHudElement("CHudChat")
if (CHudChat == nil) then error("CHudChat is nullptr.") end

local CHudChat_Printf = ffi.cast("void(__cdecl*)(void*, int, int, const char*, ...)", ffi.cast("void***", CHudChat)[0][CHudChat_Printf_Index])
local function ChatPrint(msg)
    CHudChat_Printf(CHudChat, 0, 0, " " .. ChatPrefix .. msg)
end

-- Callbacks
local m_VoteCastHandle = false
local m_VoteCastIgnoreEntityID = -1

callbacks.Register("DispatchUserMessage", function(msg)
    local msgID = msg:GetID()
    if (msgID == 46) then
        local ent_idx       = msg:GetInt(2)
        local vote_type     = msg:GetInt(3)     
        local details_str   = msg:GetString(5)

        m_VoteCastHandle = true
        m_VoteCastIgnoreEntityID = ent_idx

        if (vote_type == 0) then
            ChatPrint("\09" .. client.GetPlayerNameByIndex(ent_idx) .. "\01 started vote kick on \14" .. details_str)
        elseif (vote_type == 6) then
            ChatPrint("\09" .. client.GetPlayerNameByIndex(ent_idx) .. "\01 started vote to surrender")
        elseif (vote_type == 13) then
            ChatPrint("\09" .. client.GetPlayerNameByIndex(ent_idx) .. "\01 started vote to timeout")
        else
            m_VoteCastHandle = false
            m_VoteCastIgnoreEntityID = -1
        end
    elseif (msgID == 47) then
        m_VoteCastHandle = false
        ChatPrint("\04Vote passed!")
    elseif (msgID == 48) then
        m_VoteCastHandle = false
        ChatPrint("\07Vote failed!")
    end
end)

local m_VoteCastName = "vote_cast"
client.AllowListener(m_VoteCastName)

callbacks.Register("FireGameEvent", function(event)
    if (m_VoteCastHandle == false or event:GetName() ~= m_VoteCastName) then return end

    local entityid      = event:GetInt("entityid")
    if (m_VoteCastIgnoreEntityID == entityid) then
        m_VoteCastIgnoreEntityID = -1
        return
    end

	local vote_option   = event:GetInt("vote_option")
    if (vote_option ~= 0 and vote_option ~= 1) then return end -- Only Yes/No handle

    ChatPrint("\09" .. client.GetPlayerNameByIndex(entityid) .. "\01 voted " .. (vote_option == 0 and "\04Yes" or "\07No"))
end)
