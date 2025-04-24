local message = Config.serverAutoMessage


Citizen.CreateThread(function()

            SetConvarReplicated("sv_hostname", string.format(Config.serverName, tostring(PlayerCount), Config.discordLink))
            SetConvarReplicated("sv_projectName", string.format(Config.projectName))
            SetConvarReplicated("sv_projectDesc", string.format(Config.projectDesc))
            SetConvarReplicated("load_server_icon", string.format(Config.icon))

            SetConvarServerInfo("Type", "Drift")
            SetConvarServerInfo("Framework", "DrftV Remastered")
            SetConvarServerInfo("Discord", Config.discordLink)
end)


--
-- REMOVED LOOP logic
--
    -- while true do
        -- for _,v in pairs(message) do
            -- SetConvarServerInfo("Players", tostring(GetNumPlayerIndices()))
            -- Wait(1*60000)