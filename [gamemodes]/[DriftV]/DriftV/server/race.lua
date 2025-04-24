local race_saison = Config.raceSeaon
local races = {}

function SubmitRaceScore(source, race, points, vehicle, time)
    if races[race] == nil then
        races[race] = { scores = {} }
    end

    local function insertScore(scores, newScore)
        for i, score in ipairs(scores) do
            if score.points < newScore.points then
                table.insert(scores, i, newScore)
                return i
            end
        end
        table.insert(scores, newScore)
        return #scores
    end

    local newScore = { name = GetPlayerName(source), points = points, veh = vehicle, time = time }
    local position = insertScore(races[race].scores, newScore)

    if position <= 20 then
        TriggerClientEvent('chat:addMessage', -1, {
            color = {252, 186, 3},
            multiline = true,
            args = {"Drift", "The player " .. newScore.name .. " just took the " .. position .. " place at " .. race .. "!"}
        })
    end

    local cachedNames = {}
    for i = #races[race].scores, 1, -1 do
        local score = races[race].scores[i]
        if cachedNames[score.name] then
            table.remove(races[race].scores, i)
        else
            cachedNames[score.name] = true
        end
    end

    if position <= 20 and cachedNames[newScore.name] then
        SendDriftAttackScore(source, newScore.name, newScore.points, newScore.points, position, race, vehicle)
    end

    while #races[race].scores > 20 do
        table.remove(races[race].scores)
    end

    TriggerClientEvent("drift:RefreshRacesScores", -1, races)
    local db = rockdb:new()
    db:SaveTable("races_" .. race_saison, races)
    debugPrint("Race saved")
end

Citizen.CreateThread(function()
    local db = rockdb:new()

    races = db:GetTable("races_"..race_saison)
    if races == nil then
        print("Created races data from scratch")
        races = {}
    end

    TriggerClientEvent("drift:RefreshRacesScores", -1, races)
end)


RegisterSecuredNetEvent(Events.raceEnd, function(race, points, vehicle, time)
    local source = source
    SubmitRaceScore(source, race, points, vehicle, time)

    TriggerClientEvent('chat:addMessage', -1, {
        color = {3, 223, 252},
        multiline = true,
        args = {"Drift", "The player "..GetPlayerName(source).." finished the race "..race.." with "..GroupDigits(points).." points in a "..vehicle.." !"}
    })
end)

RegisterSecuredNetEvent(Events.raceData, function()
    TriggerClientEvent("drift:RefreshRacesScores", source, races)
end)