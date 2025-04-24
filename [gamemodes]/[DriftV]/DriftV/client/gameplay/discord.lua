Citizen.CreateThread(function()
while not loaded do Wait(500) end
    

    while true do
        SetDiscordAppId(1332768064495947939)
        SetDiscordRichPresenceAsset("logo")
        SetDiscordRichPresenceAssetText("discord.gg/DriftV")
        if inLobby then
            SetRichPresence("Loading into Drift Paradise")
        elseif p:IsInGarage() then
            SetRichPresence("Working On there Drift Vehicles")
        else
            SetRichPresence("Drifting in "..p:GetMap())
        end
        Wait(1000)
    end
end)