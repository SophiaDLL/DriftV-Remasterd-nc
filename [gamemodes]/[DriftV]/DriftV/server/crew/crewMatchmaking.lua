local matchmaking = {}
local wars = {}

function StartWarsBetweenCrew(crew1, crew2)
    Citizen.CreateThread(function()
        local warId = uuid()
        wars[warId] = {
            crew1 = crew1,
            crew2 = crew2,
            scores = {
                [crew1.name] = 0,
                [crew2.name] = 0,
            },
            indiScores = {
                [crew1.name] = {},
                [crew2.name] = {},
            },
            warID = warId,
            votedMaps = {},
            waitingFirstPlayerFinish = true,
            instanceID = math.random(1,1000),
            needDone = 0,
            done = 0,
            refresh = function()
                NotifyCrewMembers(crew1, "crew:CrewWarRefreshData", wars[warId])
                NotifyCrewMembers(crew2, "crew:CrewWarRefreshData", wars[warId])
            end,
        }

        -- Balance teams if necessary
        BalanceTeams(crew1, crew2)

        -- Calculate total tasks needed to complete
        wars[warId].needDone = #crew1.members + #crew2.members

        -- Send players to war lobby
        NotifyCrewMembers(crew1, "crew:CrewWarAboutToStart", crew2.name, warId)
        NotifyCrewMembers(crew2, "crew:CrewWarAboutToStart", crew1.name, warId)
        SetCrewInstance(crew1, wars[warId].instanceID)
        SetCrewInstance(crew2, wars[warId].instanceID)

        Wait(10 * 1000)
        wars[warId].refresh()
        debugPrint("Starting map vote (30s)")

        NotifyCrewMembers(crew1, "crew:CrewWarStartMapVote")
        NotifyCrewMembers(crew2, "crew:CrewWarStartMapVote")

        Wait(30 * 1000) -- Map load time
        wars[warId].refresh()
        debugPrint("Loading map (30s)")

        local selectedMap = SelectMap(wars[warId].votedMaps)
        if not selectedMap then
            NotifyCrewMembers(crew1, "crew:CrewWarNoMapSelected")
            NotifyCrewMembers(crew2, "crew:CrewWarNoMapSelected")
            return
        end

        debugPrint("Map: " .. selectedMap .. " with highest votes")

        NotifyCrewMembers(crew1, "crew:CrewWarLoadMap", selectedMap)
        NotifyCrewMembers(crew2, "crew:CrewWarLoadMap", selectedMap)

        Wait(30 * 1000)
        wars[warId].refresh()
        debugPrint("Choose car (15s)")

        NotifyCrewMembers(crew1, "crew:CrewWarLoadVeh")
        NotifyCrewMembers(crew2, "crew:CrewWarLoadVeh")
        Wait(15 * 1000)
        debugPrint("Starting crew war race !!")

        NotifyCrewMembers(crew1, "crew:CrewWarStartRace")
        NotifyCrewMembers(crew2, "crew:CrewWarStartRace")

        -- Wait for race results
        WaitForRaceResults(warId, crew1, crew2)

        -- Teleport everyone back to lobby
        wars[warId].refresh()
        NotifyCrewMembers(crew1, "crew:CrewWarEndLobby")
        NotifyCrewMembers(crew2, "crew:CrewWarEndLobby")

        SetCrewInstance(crew1, 1)
        SetCrewInstance(crew2, 1)

        -- Determine the winner and update ELO
        DetermineWinnerAndUpdateELO(warId, crew1, crew2)

        RefresKingDriftCrew()
        RefreshOtherPlayerData()

        -- Clean up the war data
        wars[warId] = nil
    end)
end

-- Helper function to notify crew members
function NotifyCrewMembers(crew, event, ...)
    for _, member in pairs(crew.members) do
        TriggerClientEvent(event, member.id, ...)
    end
end

-- Helper function to set player instances
function SetCrewInstance(crew, instanceID)
    for _, member in pairs(crew.members) do
        SetPlayerInstance(member, instanceID)
    end
end

-- Helper function to balance teams
function BalanceTeams(crew1, crew2)
    local diff = #crew1.members - #crew2.members
    if diff > 0 then
        for i = 1, diff do
            TriggerClientEvent("crew:CrewWarNoMapSelected", crew1.members[#crew1.members].id)
            crew1.members[#crew1.members] = nil
        end
    elseif diff < 0 then
        for i = 1, -diff do
            TriggerClientEvent("crew:CrewWarNoMapSelected", crew2.members[#crew2.members].id)
            crew2.members[#crew2.members] = nil
        end
    end
end

-- Helper function to select the map
function SelectMap(votedMaps)
    local selectedMap, mostVotes = nil, 0
    for map, votes in pairs(votedMaps) do
        if votes > mostVotes then
            mostVotes = votes
            selectedMap = map
        end
    end
    return selectedMap
end

-- Helper function to wait for race results
function WaitForRaceResults(warId, crew1, crew2)
    while wars[warId].waitingFirstPlayerFinish or wars[warId].needDone ~= wars[warId].done do
        wars[warId].refresh()
        Wait(1000)
    end

    local timer = GetGameTimer() + 60 * 1000 
    while GetGameTimer() < timer and wars[warId].done < wars[warId].needDone do
        wars[warId].refresh()
        Wait(1000)
    end
end

-- Helper function to determine the winner and update ELO
function DetermineWinnerAndUpdateELO(warId, crew1, crew2)
    local crew1Score = wars[warId].scores[crew1.name]
    local crew2Score = wars[warId].scores[crew2.name]

    if crew1Score > crew2Score then
        UpdateEloAndStats(crew1, crew2, crew1Score, crew2Score)
        NotifyWinner(crew1, crew2, crew1Score)
    else
        UpdateEloAndStats(crew2, crew1, crew2Score, crew1Score)
        NotifyWinner(crew2, crew1, crew2Score)
    end
end

-- Helper function to update ELO and stats
function UpdateEloAndStats(winningCrew, losingCrew, winningScore, losingScore)
    crew[winningCrew.name].elo, crew[losingCrew.name].elo = CrewEloNewRating(
        crew[winningCrew.name].elo,
        crew[losingCrew.name].elo,
        1, 0
    )
    crew[winningCrew.name].win = crew[winningCrew.name].win + 1
    crew[losingCrew.name].loose = crew[losingCrew.name].loose + 1
end

-- Helper function to notify winner
function NotifyWinner(winningCrew, losingCrew, winningScore)
    TriggerClientEvent("FeedM:showNotification", -1, "Crew ~b~".. winningCrew.name .."~s~ has just won a crew war against crew ~b~".. losingCrew.name .." ~s~with ~o~".. GroupDigits(winningScore) .." points !", 10000, "danger")
    SendTextToWebhook("crew_war", 0x5cffe1, "CREW WARS RESULT", "Crew ``".. winningCrew.name .."`` has just won a crew war against crew ``".. losingCrew.name .."`` with ".. GroupDigits(winningScore) .." points vs "..GroupDigits(wars[warId].scores[losingCrew.name]) .." points !\n``(+ ".. GroupDigits(wars[warId].scores[winningCrew.name] - wars[warId].scores[losingCrew.name]) .." )``")
end

function AddCrewToMatchmaking(crewName)
    if not matchmaking[crewName] then
        matchmaking[crewName] = {
            name = crewName,
            members = {}
        }
        TriggerClientEvent("FeedM:showNotification", -1, "Crew ~b~" .. crewName .. "~s~ joined crew war matchmaking", 10000, "danger")
    end
end

function AddCrewMemberToMatchmaking(crewName, source)
    if not matchmaking[crewName] then
        AddCrewToMatchmaking(crewName)
    end

    local crew = matchmaking[crewName]
    local memberIndex = nil

    for k, v in pairs(crew.members) do
        if v.id == source then
            memberIndex = k
            break
        end
    end

    if memberIndex then
        -- Remove member from matchmaking
        table.remove(crew.members, memberIndex)
        TriggerClientEvent("crew:CrewWarRefreshCrewData", source, crew.members, false)
    else
        -- Add member to matchmaking
        table.insert(crew.members, { id = source, name = GetPlayerName(source), exp = player[source].exp })
        NotifyAllCrewMembers(crew)
    end

    -- If no members left in crew, remove crew from matchmaking
    if #crew.members == 0 then
        matchmaking[crewName] = nil
    end
end

function NotifyAllCrewMembers(crew)
    for _, member in pairs(crew.members) do
        TriggerClientEvent("crew:CrewWarRefreshCrewData", member.id, crew.members, true)
    end
end

function RemoveInactivePlayers()
    for crewName, crew in pairs(matchmaking) do
        for i = #crew.members, 1, -1 do
            local member = crew.members[i]
            if GetPlayerPing(member.id) == 0 then
                table.remove(crew.members, i)
            end
        end
        -- If no members left, remove crew from matchmaking
        if #crew.members == 0 then
            matchmaking[crewName] = nil
        end
    end
end

function FindRandomMatch()
    RemoveInactivePlayers()

    local crewNames = {}
    for crewName in pairs(matchmaking) do
        table.insert(crewNames, crewName)
    end

    if #crewNames > 1 then
        local random1Index = math.random(1, #crewNames)
        local crew1Name = crewNames[random1Index]

        local random2Index
        repeat
            random2Index = math.random(1, #crewNames)
        until random2Index ~= random1Index
        local crew2Name = crewNames[random2Index]

        local crew1 = matchmaking[crew1Name]
        local crew2 = matchmaking[crew2Name]

        -- Notify players that they are no longer in matchmaking
        NotifyAllCrewMembers(crew1)
        NotifyAllCrewMembers(crew2)

        -- Start the war between two crews
        StartWarsBetweenCrew(crew1, crew2)

        -- Remove matched crews from matchmaking
        matchmaking[crew1Name] = nil
        matchmaking[crew2Name] = nil
    end
end

Citizen.CreateThread(function()
    Wait(5000)
    while true do
        FindRandomMatch()
        Wait(20 * 1000)
    end
end)


Citizen.CreateThread(function()
    Wait(5000)
    while true do
        FindRandomMatch()
        Wait(20 * 1000)
    end
end)

RegisterNetEvent("crew:CrewWarsVoteForMap")
AddEventHandler("crew:CrewWarsVoteForMap", function(map, warID)
    if wars[warID].votedMaps[map] == nil then
        wars[warID].votedMaps[map] = 0
    end
    wars[warID].votedMaps[map] = wars[warID].votedMaps[map] + 1
end)

RegisterNetEvent("crew:CrewCarsAddScore")
AddEventHandler("crew:CrewCarsAddScore", function(warID, crew, score, driftScore, raceSecond)
    wars[warID].scores[crew] = wars[warID].scores[crew] + score
    wars[warID].indiScores[crew][source] = {name = GetPlayerName(source), finalScore = score, driftScore = driftScore, time = raceSecond}
    if score ~= 0 then
        wars[warID].waitingFirstPlayerFinish = false
    end
    wars[warID].done = wars[warID].done + 1
    wars[warID].refresh()
end)

function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end