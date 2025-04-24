local svConfig = {}

-- Configuration
 svConfig.versionChecker = true -- Version Checker
 svConfig.supportChecker = true -- Support Checker (If you use exports, it is recommended that you leave this on)

AddEventHandler('chatMessage', function(source, author, message)
    local formattedMessage = author .. ': ' .. message
    updateLogFile(formattedMessage)
end)

function updateLogFile(v)
    if LoadResourceFile(GetCurrentResourceName(), 'chat_log.log') == nil then
        SaveResourceFile(GetCurrentResourceName(), 'chat_log.log', '')
    end
    local logFile = LoadResourceFile(GetCurrentResourceName(), 'chat_log.log')
    local logFile = logFile .. os.date("[%H:%M:%S] ") .. v .. '\n'
    SaveResourceFile(GetCurrentResourceName(), 'chat_log.log', logFile)
end

-- Antispam System (Beta)
local users = {}
function checkSpam(source, message)
    local BlockedStatus = false

    -- Checks if the user has sent a message before
    if users[source] == nil then
        users[source] = {time = os.time()}
        return false
    end

    -- Check if the user has sent messages too quickly
    if os.time() - users[source].time < 2 then
        BlockedStatus = true
    end

    -- Check if the message is a repeat of the last message
    if message == users[source].lastMessage then
        BlockedStatus = true
    end

    -- Update the user's information in the table
    users[source] = {lastMessage = message, time = os.time()}

    return BlockedStatus
end

exports('checkSpam', checkSpam)
