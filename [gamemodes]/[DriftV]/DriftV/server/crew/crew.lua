crew = {}
pCrew = {}
KingDriftCrew = {
    name = "Nothing",
    elo = 1000,
}
CrewRanking = {}

function DoesCrewExist(name)
    return crew[name] ~= nil
end

function CreateCrew(tag, name, desc)
    if crew[name] == nil then
        local newCrew = {
            tag = tag,
            name = name,
            memberCount = 1,
            totalPoints = 0,
            win = 0,
            loose = 0,
            elo = 1000,
            members = {},
            rank = 500,
            needSave = true
        }
        crew[name] = newCrew

        -- Insert the new crew into the database
        MySQL.insert.await('INSERT INTO `crews` (tag, name, memberCount, totalPoints, win, loose, elo, members, rank) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            newCrew.tag, newCrew.name, newCrew.memberCount, newCrew.totalPoints, newCrew.win, newCrew.loose, newCrew.elo, json.encode(newCrew.members), newCrew.rank
        })

        return true
    else
        return false
    end
end

function RefreshKingDriftCrew()
    KingDriftCrew = {
        name = "Nothing",
        elo = 1000,
    }

    for _, v in pairs(crew) do
        if v.elo > KingDriftCrew.elo then
            KingDriftCrew.elo = v.elo
            KingDriftCrew.name = v.name
            debugPrint("New drift king crew: " .. v.name .. " with " .. v.elo .. " elo")
        end
    end
end

function RefreshCrewRanking()
    local ranking = {}

    local function insertIntoRanking(crewMember)
        for i = 1, #ranking do
            if crewMember.elo > ranking[i].elo then
                table.insert(ranking, i, crewMember)
                return
            end
        end
        table.insert(ranking, crewMember)
    end

    for _, v in pairs(crew) do
        local crewMember = {
            name = v.name,
            elo = v.elo,
            win = v.win,
            loose = v.loose,
            points = v.totalPoints,
            members = v.memberCount
        }
        insertIntoRanking(crewMember)
    end

    CrewRanking = ranking
end

function RefreshCrewMemberCount(crewName)
    local count = 0
    local points = 0
    for _, v in pairs(crew[crewName].members) do
        count = count + 1
        points = points + v.points
    end

    crew[crewName].memberCount = count
    crew[crewName].totalPoints = points
    crew[crewName].needSave = true
end

function JoinCrew(source, crewName, isCrewOwner)
    local pCrewName = player[source].crew
    local pLicense = GetLicense(source)
    LeaveCrew(source)

    if DoesCrewExist(crewName) then
        if crew[crewName].memberCount < 10 then
            crew[crewName].members[pLicense] = {points = 0, name = GetPlayerName(source)}
            if isCrewOwner then
                player[source].crewOwner = true
            end
            pCrew[source] = crewName
            RefreshCrewMemberCount(crewName)
        end
    end
end

function LeaveCrew(source)
    local pCrewName = player[source].crew
    local pLicense = GetLicense(source)
    if DoesCrewExist(pCrewName) then
        crew[pCrewName].members[pLicense] = nil
        player[source].crew = "None"
        pCrew[source] = "None"

        if player[source].crewOwner then
            for k, v in pairs(pCrew) do
                if v == pCrewName then
                    pCrew[k] = "None"
                end
            end

            player[source].crewOwner = false
            crew[pCrewName] = nil

            -- Delete the crew from the database
            MySQL.update.await('DELETE FROM `crews` WHERE name = ?', { pCrewName })
            debugPrint("Crew " .. pCrewName .. " got deleted")
        else
            RefreshCrewMemberCount(pCrewName)
        end
        RefreshPlayerData(source)
        SavePlayer(source)
    end
end

function KickPlayerFromCrew(source, crewName, key)
    if DoesCrewExist(crewName) then
        crew[crewName].members[key] = nil
        crew[crewName].needSave = true
    end

    for _, v in pairs(GetPlayers()) do
        local pLicense = GetLicense(v)
        if pLicense == key then
            LeaveCrew(tonumber(v))
            debugPrint("Player " .. v .. " got kicked from " .. crewName .. " crew")
            break
        end
    end

    RefreshCrewMemberCount(crewName)
    RefreshOtherPlayerData()
end

function AddPointsToCrew(source, pointsToAdd)
    local pCrewName = player[source].crew
    local pLicense = GetLicense(source)
    if DoesCrewExist(pCrewName) then
        crew[pCrewName].members[pLicense].points = math.floor(crew[pCrewName].members[pLicense].points + pointsToAdd)
        RefreshCrewMemberCount(pCrewName)
    end
end

RegisterNetEvent("driftV:CreateCrew")
AddEventHandler("driftV:CreateCrew", function(tag, crewName)
    local source = source
    if CreateCrew(tag, crewName) then
        JoinCrew(source, crewName, true)
        player[source].crew = crewName
        player[source].crewOwner = true
        RefreshPlayerData(source)
        RefreshOtherPlayerData()
        SavePlayer(source)
    end
end)

RegisterNetEvent("driftV:JoinCrew")
AddEventHandler("driftV:JoinCrew", function(crewName, id)
    local source = source
    JoinCrew(id, crewName, false)
    player[id].crew = crewName
    player[id].crewOwner = false
    RefreshPlayerData(id)
    RefreshOtherPlayerData()
    SavePlayer(id)
end)

RegisterNetEvent("driftV:InvitePlayer")
AddEventHandler("driftV:InvitePlayer", function(crewName, id)
    local source = source
    TriggerClientEvent("driftV:GetInvitedToCrew", id, crewName, source)
end)

RegisterNetEvent("driftV:LeaveCrew")
AddEventHandler("driftV:LeaveCrew", function()
    local source = source
    LeaveCrew(source)
    RefreshPlayerData(source)
    RefreshOtherPlayerData()
    SavePlayer(source)
end)

RegisterNetEvent("driftV:KickFromCrew")
AddEventHandler("driftV:KickFromCrew", function(target)
    local source = source
    KickPlayerFromCrew(source, player[source].crew, target)
end)

RegisterNetEvent("driftV:StartMatchmaking")
AddEventHandler("driftV:StartMatchmaking", function()
    local source = source
    AddCrewToMatchmaking(player[source].crew)
    AddCrewMemberToMatchmaking(player[source].crew, source)
end)

Citizen.CreateThread(function()
    -- Load all crews from the database
    local result = MySQL.query.await('SELECT * FROM `crews`')
    if result then
        for _, row in ipairs(result) do
            crew[row.name] = {
                tag = row.tag,
                name = row.name,
                memberCount = row.memberCount,
                totalPoints = row.totalPoints,
                win = row.win,
                loose = row.loose,
                elo = row.elo,
                members = json.decode(row.members),
                rank = row.rank,
                needSave = false
            }
        end
    end

    RefreshKingDriftCrew()
    debugPrint("Loaded all crews")
    while true do
        -- Save only crews that need to be saved to the database
        local savedCount = 0
        for name, data in pairs(crew) do
            if data.needSave then
                MySQL.update.await('UPDATE `crews` SET memberCount = ?, totalPoints = ?, win = ?, loose = ?, elo = ?, members = ?, rank = ? WHERE name = ?', {
                    data.memberCount, data.totalPoints, data.win, data.loose, data.elo, json.encode(data.members), data.rank, name
                })
                data.needSave = false
                savedCount = savedCount + 1
            end
        end
        
        if savedCount > 0 then
            debugPrint("Crews saved: " .. savedCount)
        end
        
        RefreshCrewRanking()
        debugPrint("Crew ranking refresh ...")
        Wait(30 * 1000)
    end
end)