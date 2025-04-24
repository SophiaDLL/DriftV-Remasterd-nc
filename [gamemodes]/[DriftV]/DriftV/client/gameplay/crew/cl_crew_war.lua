local loadingMusic = {
    "crewWarLoadingMap_1",
    "crewWarLoadingMap_2"
}
local startingMusic = {
    --"crewWarStart_1",
    "crewWarStart_3"
    --"crewWarStart_2", -- Need intro change
}
local crewWarMaps = {
    {
        label = "Dock Run",
        price = 2200,
        pointPerSec = 750,
        speedLimit = 45,
        start =  vector4(978.5416, -3219.899, 5.900664, 2.842567),
        points = {
            {pos = vector4(978.5416, -3219.899, 5.900664, 2.842567), passed = false},
            {pos = vector4(978.9899, -2963.672, 5.302491, 23.70997), passed = false},
            {pos = vector4(883.5682, -2962.902, 5.301818, 171.2981), passed = false},
            {pos = vector4(837.2665, -3006.302, 5.302597, 42.47378), passed = false},
            {pos = vector4(873.814, -2956.078, 5.301877, 238.4264), passed = false},
            {pos = vector4(978.7961, -3028.436, 5.301324, 181.6824), passed = false},
            {pos = vector4(825.0024, -3061.35, 5.290692, 88.28062), passed = false},
            {pos = vector4(875.6521, -3116.358, 5.302404, 234.4023), passed = false},
            {pos = vector4(882.6172, -3212.163, 5.297845, 178), passed = false},
        },
         camCinematic = {
             {
                 cam1 = vector3(701.47882080078, 1281.3470458984, 490.5205078125),
                 cam1fov = 40.0,
                 cam1LookTo = vector3(709.77319335938, 1275.9268798828, 474.48480224609),
    
                 cam2 = vector3(752.69177246094, 1244.7911376953, 476.33471679688),
                 cam2fov = 35.0,
                 cam2LookTo = vector3(817.79528808594, 1195.453125, 470.01055908203),
             },
             {
                 cam1 = vector3(956.39971923828, 1067.9061279297, 463.07516479492),
                 cam1fov = 40.0,
                 cam1LookTo = vector3(908.70178222656, 1130.1066894531, 460.48919677734),
    
                 cam2 = vector3(941.69622802734, 1083.7308349609, 460.6741027832),
                 cam2fov = 35.0,
                 cam2LookTo = vector3(908.70178222656, 1130.1066894531, 460.48919677734),
             },
             {
                 cam1 = vector3(862.87774658203, 1124.0187988281, 469.32223510742),
                 cam1fov = 40.0,
                 cam1LookTo = vector3(964.13861083984, 1119.5717773438, 460.560546875),
    
                 cam2 = vector3(868.06677246094, 1130.2045898438, 469.82220458984),
                 cam2fov = 35.0,
                 cam2LookTo = vector3(964.13861083984, 1119.5717773438, 460.560546875),
             },
         }
    },
}

local warInfo = {}
local lobby = vector3(1107.04, -3157.399, -37.51859)
local warEndLobby = vector3(229.73329162598, -885.22637939453, 30.949995040894)
local lobbyIpl = "bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo"
local fightAgainst = ""
local warID = 0
local votedMap = nil
local inMapVote = false
local voted = false
local choosenMap = {}
local maps = RageUI.CreateMenu("DriftV Remastered", "Welcome to youre Drifting Paradise")
maps.Closable = false
local inMapLoad = false
local inVehLoad = false
local veh = RageUI.CreateMenu("DriftV Remastered", "Welcome to youre Drifting Paradise")
veh.Closable = false
local displayScoreBoard = false
local displayTempScoreboard = false

-- Step 1
function JoinCrewWarLobby()

    if p:isInVeh() then
        DeleteEntity(p:currentVeh())
    end

    RequestIpl(lobbyIpl)
    SetInteriorEntitySetColor(246273, "walls_01", 2)
    EnableInteriorProp(246273, "walls_01")
    EnableInteriorProp(246273, "furnishings_01")
    EnableInteriorProp(246273, "decorative_01")
    EnableInteriorProp(246273, "mural_01")
    RefreshInterior(246273)
    TriggerEvent("InteractSound_CL:PlayOnOne", startingMusic[math.random(1,#startingMusic)], 0.07)
    p:Teleport(lobby)
    TogglePasive(true)
end


-- Step 2
function StartMapVote()

    local timer = 30
    local timeBar = NativeUI.TimerBarPool()
    local time = NativeUI.CreateTimerBar("Map vote:")
    time:SetTextTimerBar(timer.."s")
    timeBar:Add(time)


    Citizen.CreateThread(function()
        while inMapVote do
            timer = timer - 1
            time:SetTextTimerBar(timer.."s")
            Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while inMapVote do
            timeBar:Draw()
            Wait(1)
        end
    end)

    RageUI.Visible(maps, true)
    while inMapVote do
        RageUI.IsVisible(maps, function()
            RageUI.Separator("Vote for the war map!")
            for k,v in pairs(crewWarMaps) do
                if not voted then
                    RageUI.Button(v.label, nil, {RightLabel = ">"}, true, {
                        onSelected = function()
                            TriggerServerEvent("crew:CrewWarsVoteForMap", v.label, warID)
                            ShowNotification("You voted for ~o~"..v.label)
                            voted = true
                            v.voted = true
                        end,
                    });
                else
                    if v.voted then
                        RageUI.Button(v.label, nil, {RightLabel = "~g~VOTED"}, false, {});
                    else
                        RageUI.Button(v.label, nil, {}, false, {});
                    end
                end
            end
        end)
        Wait(0)
    end
    RageUI.Visible(maps, false)
end

-- Step 3
function StartMapLoad(name)
    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do Wait(1) end
    TriggerEvent("InteractSound_CL:Stop")
    TriggerEvent("InteractSound_CL:PlayOnOne", loadingMusic[math.random(1,#loadingMusic)], 0.07)
    local map
    for k,v in pairs(crewWarMaps) do
        if v.label == name then
            map = v
            break
        end
    end
    choosenMap = map

    FreezeEntityPosition(p:ped(), true)
    SetEntityCoordsNoOffset(p:ped(), map.start.xyz, 0.0, 0.0, 0.0)

    local timer = 30
    local timeBar = NativeUI.TimerBarPool()
    local time = NativeUI.CreateTimerBar("Loading map:")
    time:SetTextTimerBar(timer.."s")
    timeBar:Add(time)


    Citizen.CreateThread(function()
        while inMapLoad do
            timer = timer - 1
            time:SetTextTimerBar(timer.."s")
            Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while inMapLoad do
            timeBar:Draw()
            Wait(1)
        end
    end)

    Citizen.CreateThread(function()
        while inMapLoad do
            local baseX = 0.3 -- gauche / droite ( plus grand = droite )
            local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
            local baseWidth = 0.3 -- Longueur
            local baseHeight = 0.03 -- Epaisseur
            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 255, 103, 92, 255) -- Liseret
            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
            DrawTexts(baseX, baseY - (0.043) - 0.013, warInfo.crew1.name, true, 0.35, {0, 0, 0, 255}, 2, 0) -- title
    
            DrawRect(baseX, baseY, baseWidth, baseHeight, 255, 103, 92, 255)
            DrawTexts(baseX - 0.140, baseY - 0.013, "name", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX - 0.060, baseY - 0.013, "level", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title

            local i = 1
            for k,v in pairs(warInfo.crew1.members) do
                DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
                DrawTexts(baseX - 0.140, baseY + (0.032 * i) - 0.013, v.name, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name
                DrawTexts(baseX - 0.060, baseY + (0.032 * i) - 0.013, GetPlayerLevelFromXp(v.exp), false, 0.35, {255, 255, 255, 255}, 6, 0) -- drift score
                i = i + 1
            end
    
            local baseX = 0.7 -- gauche / droite ( plus grand = droite )
            local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
            local baseWidth = 0.3 -- Longueur
            local baseHeight = 0.03 -- Epaisseur
    
            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 255, 103, 92, 255) -- Liseret
            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
            DrawTexts(baseX, baseY - (0.043) - 0.013, warInfo.crew2.name, true, 0.35, {0, 0, 0, 255}, 2, 0) -- title
    
            DrawRect(baseX, baseY, baseWidth, baseHeight, 255, 103, 92, 255)
            DrawTexts(baseX - 0.140, baseY - 0.013, "name", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX - 0.060, baseY - 0.013, "level", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title

            local i = 1
            for k,v in pairs(warInfo.crew2.members) do
                DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
                DrawTexts(baseX - 0.140, baseY + (0.032 * i) - 0.013, v.name, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name
                DrawTexts(baseX - 0.060, baseY + (0.032 * i) - 0.013, GetPlayerLevelFromXp(v.exp), false, 0.35, {255, 255, 255, 255}, 6, 0) -- drift score
                i = i + 1
            end
            Wait(1)
        end
    end)


    -- Cam animation

    cam.create("CAM_1")
    cam.create("CAM_2")

    while inMapLoad do
        for k,v in pairs(map.camCinematic) do
            if not inMapLoad then break end

            DoScreenFadeIn(1000)
            cam.setPos("CAM_1", v.cam1)
            cam.setFov("CAM_1", v.cam1fov)
            cam.lookAtCoords("CAM_1", v.cam1LookTo)
            cam.setActive("CAM_1")
            cam.render("CAM_1", true, false, 0)
            cam.setPos("CAM_2", v.cam2)
            cam.setFov("CAM_2", v.cam2fov)
            cam.lookAtCoords("CAM_2", v.cam2LookTo)
            
            
            cam.setActive("CAM_2")
            cam.switchToCam("CAM_2", "CAM_1", 13000)
            local timer = GetGameTimer() + 10000
            while GetGameTimer() < timer do
                if not inMapLoad then
                    break 
                end
                Wait(1)
            end

            if not inMapLoad then
                break 
            end
            DoScreenFadeOut(1000)
            Wait(1100)
        end
        Wait(0)
    end

    FreezeEntityPosition(p:ped(), false)
    cam.delete("CAM_1")
    cam.delete("CAM_2")
end


-- Step 4
function StartVehLoad()

    local timer = 15
    local timeBar = NativeUI.TimerBarPool()
    local time = NativeUI.CreateTimerBar("Choose your vehicle:")
    time:SetTextTimerBar(timer.."s")
    timeBar:Add(time)


    Citizen.CreateThread(function()
        while inVehLoad do
            timer = timer - 1
            time:SetTextTimerBar(timer.."s")
            Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while inVehLoad do
            timeBar:Draw()
            Wait(1)
        end
    end)

    RageUI.Visible(veh, true)
    while inVehLoad do
        RageUI.IsVisible(veh, function()
            RageUI.Separator("Choose your vehicle")
            for _,v in pairs(p:GetCars()) do
                RageUI.Button(v.label, nil, {}, true, {
                    onSelected = function()
                        if lastSpawned ~= nil then
                            TriggerServerEvent("DeleteEntity", lastSpawned)
                            while DoesEntityExist(NetworkGetEntityFromNetworkId(lastSpawned)) do
                                Wait(100)
                            end
                        end
                        local veh = entity:CreateVehicle(v.model, p:pos(), p:heading())
                        SetVehProps(veh:getEntityId(), v.props)
                        lastSpawned = veh:getNetId()
                        TaskWarpPedIntoVehicle(p:ped(), veh:getEntityId(), -1)
                    end,
                });
            end
        end)
        Wait(0)
    end
    RageUI.Visible(veh, false)
end


-- Step 5
function StartCrewWarRace(data)
    inRace = true
    ResetDriftPoint()
    SetPlayerInRace(true)
    local raceStopped = false

    SetPedCoordsKeepVehicle(p:ped(), data.start.xyz)
    SetEntityHeading(p:currentVeh(), data.start.w)
    FreezeEntityPosition(p:currentVeh(), true)
    ChangeSpeedLimit(data.speedLimit)
    TogglePasive(true)

    cam.create("CAM_1")
    cam.create("CAM_2")


    local countDown = 3
    local posToGo = {
       {pos = GetOffsetFromEntityInWorldCoords(p:currentVeh(), 0.0, 0.0, 8.0)}, -- up
       {pos = GetOffsetFromEntityInWorldCoords(p:currentVeh(), 0.0, 8.0, 0.0)}, -- front
       {pos = GetOffsetFromEntityInWorldCoords(p:currentVeh(), 0.0, -8.0, 5.0)}, -- back
    }

    for i = 1,3 do
        Subtitle("Drift race in ~b~"..countDown, 1000)
        PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)

        local rPos = vector3(0.0, 0.0, 0.0)
        if i ~= 3 then
            rPos = vector3(posToGo[i].pos.x + math.random(-1,1), posToGo[i].pos.y + math.random(-1,1), posToGo[i].pos.z + math.random(1,2))
        else
            rPos = vector3(posToGo[i].pos.x, posToGo[i].pos.y, posToGo[i].pos.z - 2)
        end

        cam.setPos("CAM_1", posToGo[i].pos)
        cam.setFov("CAM_1", 60.0)
        cam.lookAtCoords("CAM_1", p:pos())
        cam.setActive("CAM_1")
        cam.render("CAM_1", true, false, 0)

        cam.setPos("CAM_2", rPos)
        cam.setFov("CAM_2", 45.0)
        cam.lookAtCoords("CAM_2", p:pos())
        

        cam.setActive("CAM_2")
        cam.switchToCam("CAM_2", "CAM_1", 1500)

        Wait(1000)
        countDown = countDown - 1
    end

    Citizen.CreateThread(function()
        SetGameplayCamRelativeHeading(0.0)
        cam.render("CAM_2", false, true, 1000)
        Wait(1000)
        cam.delete("CAM_1")
        cam.delete("CAM_2")
    end)


    local startTime = GetGameTimer()
    PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 1)
    FreezeEntityPosition(p:currentVeh(), false)

    local blip = AddBlipForCoord(data.start.xyz)


    timeBar = NativeUI.TimerBarPool()

    local time = NativeUI.CreateTimerBar("Time:")
    time:SetTextTimerBar("20s")
    timeBar:Add(time)

    local checkpoints = NativeUI.CreateTimerBar("Checkpoints:")
    checkpoints:SetTextTimerBar("??/??")
    timeBar:Add(checkpoints)

    local distance = NativeUI.CreateTimerBar("Distance:")
    distance:SetTextTimerBar("??m")
    timeBar:Add(distance)

    for k,v in pairs(data.points) do
        SetBlipCoords(blip, v.pos.xyz)
        local timer = GetGameTimer() + 20000
        checkpoints:SetTextTimerBar(k.."/"..#data.points)
        local dst = #(v.pos.xyz - p:pos())
        while dst > 10.0 and not raceStopped do
            dst = math.floor(#(v.pos.xyz - p:pos()))
            DrawMarker(5, v.pos.xyz, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 235, 229, 52, 170, 0, 1, 2, 0, nil, nil, 0)
            DrawMarker(0, v.pos.x, v.pos.y, v.pos.z + 1.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 30.0, 66, 245, 111, 170, 0, 1, 2, 0, nil, nil, 0)

            if GetGameTimer() >= timer then
                raceStopped = true
            end

            time:SetTextTimerBar(tostring(math.floor((timer - GetGameTimer()) / 1000)))
            distance:SetTextTimerBar(tostring(dst).."m")

            timeBar:Draw()
            Wait(1)
        end
        if not raceStopped then
            PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
        end

    end
    PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
    RemoveBlip(blip)

    local endPoints = GetCurrentDriftPoint()
    if raceStopped then
        endPoints = endPoints
    end
    
    local endTime = GetGameTimer()
    local raceTime = endTime - startTime
    local raceSecond = math.floor(raceTime / 1000)

    local driftScore = endPoints
    -- endPoints = (endPoints - raceSecond * data.pointPerSec)

    -- if endPoints < 0 then
    --     endPoints = 0
    -- end

    -- endPoints = math.floor(endPoints  + (driftScore / raceSecond))
    endPoints = math.floor(driftScore/raceSecond)

    TriggerServerEvent("crew:CrewCarsAddScore", warID, p:getCrew(), endPoints, driftScore, raceSecond)
    DeleteEntity(p:currentVeh())
    displayTempScoreboard = true

    TeleportPlayer(lobby)
    AnimpostfxPlay("MP_Celeb_Win", -1, true)
    Citizen.CreateThread(function()
        while displayTempScoreboard do
            local baseX = 0.3 -- gauche / droite ( plus grand = droite )
            local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
            local baseWidth = 0.3 -- Longueur
            local baseHeight = 0.03 -- Epaisseur
            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 255, 103, 92, 255) -- Liseret
            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
            DrawTexts(baseX, baseY - (0.043) - 0.013, p:getCrew() .. " CREW", true, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            --DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, "Total: ", true, 0.35, {0, 0, 0, 255}, 6, 0) -- title
    
            DrawRect(baseX, baseY, baseWidth, baseHeight, 255, 103, 92, 255)
            DrawTexts(baseX - 0.140, baseY - 0.013, "crew members", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX - 0.060, baseY - 0.013, "drift score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.020, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.080, baseY - 0.013, "final score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title

            local i = 1
            for k,v in pairs(warInfo.indiScores[p:getCrew()]) do
                DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
                DrawTexts(baseX - 0.140, baseY + (0.032 * i) - 0.013, v.name, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name
                DrawTexts(baseX - 0.060, baseY + (0.032 * i) - 0.013, GroupDigits(v.driftScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- drift score
                DrawTexts(baseX + 0.020, baseY + (0.032 * i) - 0.013, v.time, false, 0.35, {255, 255, 255, 255}, 6, 0) -- time
                DrawTexts(baseX + 0.080, baseY + (0.032 * i) - 0.013, GroupDigits(v.finalScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- final score

                i = i + 1
            end
    
            local baseX = 0.7 -- gauche / droite ( plus grand = droite )
            local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
            local baseWidth = 0.3 -- Longueur
            local baseHeight = 0.03 -- Epaisseur
    
            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 255, 103, 92, 255) -- Liseret
            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
            DrawTexts(baseX, baseY - (0.043) - 0.013, fightAgainst .. " CREW", true, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            --DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, "Total: ", true, 0.35, {0, 0, 0, 255}, 6, 0) -- title
    
            DrawRect(baseX, baseY, baseWidth, baseHeight, 255, 103, 92, 255)
            DrawTexts(baseX - 0.140, baseY - 0.013, "crew members", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX - 0.060, baseY - 0.013, "drift score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.020, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.080, baseY - 0.013, "final score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title

            local i = 1
            for k,v in pairs(warInfo.indiScores[fightAgainst]) do
                DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
                DrawTexts(baseX - 0.140, baseY + (0.032 * i) - 0.013, v.name, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name
                DrawTexts(baseX - 0.060, baseY + (0.032 * i) - 0.013, GroupDigits(v.driftScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- drift score
                DrawTexts(baseX + 0.020, baseY + (0.032 * i) - 0.013, v.time, false, 0.35, {255, 255, 255, 255}, 6, 0) -- time
                DrawTexts(baseX + 0.080, baseY + (0.032 * i) - 0.013, GroupDigits(v.finalScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- final score

                i = i + 1
            end
            Wait(0)
        end
        AnimpostfxStopAll()
    end)


    SetPlayerInRace(false)
end


-- Step 6
function DisplayCrewWarScoreboard()
    TeleportPlayer(warEndLobby)

    AnimpostfxPlay("MP_Celeb_Win", -1, true)

    Citizen.CreateThread(function()
        while displayScoreBoard do


            local baseX = 0.3 -- gauche / droite ( plus grand = droite )
            local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
            local baseWidth = 0.3 -- Longueur
            local baseHeight = 0.03 -- Epaisseur
            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 255, 103, 92, 255) -- Liseret
            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
            DrawTexts(baseX, baseY - (0.043) - 0.013, p:getCrew() .. " CREW", true, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            --DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, "Total: ", true, 0.35, {0, 0, 0, 255}, 6, 0) -- title
    
            DrawRect(baseX, baseY, baseWidth, baseHeight, 255, 103, 92, 255)
            DrawTexts(baseX - 0.140, baseY - 0.013, "crew members", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX - 0.060, baseY - 0.013, "drift score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.020, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.080, baseY - 0.013, "final score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title

            local i = 1
            for k,v in pairs(warInfo.indiScores[p:getCrew()]) do
                DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
                DrawTexts(baseX - 0.140, baseY + (0.032 * i) - 0.013, v.name, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name
                DrawTexts(baseX - 0.060, baseY + (0.032 * i) - 0.013, GroupDigits(v.driftScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- drift score
                DrawTexts(baseX + 0.020, baseY + (0.032 * i) - 0.013, v.time, false, 0.35, {255, 255, 255, 255}, 6, 0) -- time
                DrawTexts(baseX + 0.080, baseY + (0.032 * i) - 0.013, GroupDigits(v.finalScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- final score

                i = i + 1
            end
    
            local baseX = 0.7 -- gauche / droite ( plus grand = droite )
            local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
            local baseWidth = 0.3 -- Longueur
            local baseHeight = 0.03 -- Epaisseur
    
            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 255, 103, 92, 255) -- Liseret
            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
            DrawTexts(baseX, baseY - (0.043) - 0.013, fightAgainst .. " CREW", true, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            --DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, "Total: ", true, 0.35, {0, 0, 0, 255}, 6, 0) -- title
    
            DrawRect(baseX, baseY, baseWidth, baseHeight, 255, 103, 92, 255)
            DrawTexts(baseX - 0.140, baseY - 0.013, "crew members", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX - 0.060, baseY - 0.013, "drift score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.020, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.080, baseY - 0.013, "final score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title

            local i = 1
            for k,v in pairs(warInfo.indiScores[fightAgainst]) do
                DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
                DrawTexts(baseX - 0.140, baseY + (0.032 * i) - 0.013, v.name, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name
                DrawTexts(baseX - 0.060, baseY + (0.032 * i) - 0.013, GroupDigits(v.driftScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- drift score
                DrawTexts(baseX + 0.020, baseY + (0.032 * i) - 0.013, v.time, false, 0.35, {255, 255, 255, 255}, 6, 0) -- time
                DrawTexts(baseX + 0.080, baseY + (0.032 * i) - 0.013, GroupDigits(v.finalScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- final score

                i = i + 1
            end


            ShowHelpNotification("Press ~INPUT_CELLPHONE_CANCEL~ to close result")
            DisableAllControlActions(0)
            if IsDisabledControlJustPressed(0, 177) then
                displayScoreBoard = false
            end
    
            if IsDisabledControlJustPressed(0, 176) then
                displayScoreBoard = false
            end
    
            if IsDisabledControlJustPressed(0, 179) then
                displayScoreBoard = false
            end
            Wait(0)
        end
        AnimpostfxStopAll()
    end)



end


-- Step 1
RegisterNetEvent("crew:CrewWarAboutToStart")
AddEventHandler("crew:CrewWarAboutToStart", function(crew2, warid)
    LeaveGarage(false, false)
    DisplayLittleSucces("crew war against ~b~"..crew2, false, 6000)
    fightAgainst = crew2
    warID = warid
    p:setCrewWarStatus(true)
    TriggerEvent("InteractSound_CL:PlayOnOne", "crewWarStart", 0.07)
    JoinCrewWarLobby()
end)

-- Step 2
RegisterNetEvent("crew:CrewWarStartMapVote")
AddEventHandler("crew:CrewWarStartMapVote", function()
    DisplayLittleSucces("Vote for the map you want", false, 15000)
    inMapVote = true
    votedMap = nil
    voted = false
    for k,v in pairs(crewWarMaps) do
        v.voted = false
    end
    StartMapVote()
end)

-- Step 3
RegisterNetEvent("crew:CrewWarLoadMap")
AddEventHandler("crew:CrewWarLoadMap", function(map)
    DisplayLittleSucces(map, false, 25*1000)
    inMapVote = false
    inMapLoad = true
    TriggerEvent("InteractSound_CL:Stop")
    StartMapLoad(map)
end)


-- Step 4
RegisterNetEvent("crew:CrewWarLoadVeh")
AddEventHandler("crew:CrewWarLoadVeh", function()
    DisplayLittleSucces("Choose your vehicle", false, 15*1000)
    inMapLoad = false
    inVehLoad = true
    StartVehLoad()
end)

-- Step 5
RegisterNetEvent("crew:CrewWarStartRace")
AddEventHandler("crew:CrewWarStartRace", function()
    inVehLoad = false
    TriggerEvent("InteractSound_CL:Stop")
    StartCrewWarRace(choosenMap)
end)


-- Step 6
RegisterNetEvent("crew:CrewWarEndLobby")
AddEventHandler("crew:CrewWarEndLobby", function()
    displayScoreBoard = true
    displayTempScoreboard = false
    DisplayCrewWarScoreboard()

    p:setCrewWarStatus(false)
end)

-- Extra step
RegisterNetEvent("crew:CrewWar60s")
AddEventHandler("crew:CrewWar60s", function()
    local timer = 60
    local timeBar = NativeUI.TimerBarPool()
    local time = NativeUI.CreateTimerBar("Race ending in:")
    time:SetTextTimerBar(timer.."s")
    timeBar:Add(time)


    Citizen.CreateThread(function()
        while timer >= 0 and p:GetCrewWarStatus() do
            timer = timer - 1
            time:SetTextTimerBar(timer.."s")
            Wait(1000)
        end
    end)  

    Citizen.CreateThread(function()
        while timer >= 0 and p:GetCrewWarStatus() do
            timeBar:Draw()
            Wait(1)
        end
    end)
end)

-- Missing map
RegisterNetEvent("crew:CrewWarNoMapSelected")
AddEventHandler("crew:CrewWarNoMapSelected", function()
    inMapVote = false
    displayScoreBoard = false
    displayTempScoreboard = false
    TeleportPlayer(warEndLobby)
    ShowNotification("No map selected. War cancelled")

    p:setCrewWarStatus(false)
end)

-- Kicked, too many player
RegisterNetEvent("crew:CrewWarNoMapSelected")
AddEventHandler("crew:CrewWarNoMapSelected", function()
    inMapVote = false
    displayScoreBoard = false
    displayTempScoreboard = false
    ShowNotification("You got kicked out of the crew war. Too many player.")

    p:setCrewWarStatus(false)
end)

RegisterNetEvent("crew:CrewWarRefreshData")
AddEventHandler("crew:CrewWarRefreshData", function(data)
    warInfo = data
    warInfo.myCrewScoreCount = 0
    for k,v in pairs(warInfo.indiScores[p:getCrew()]) do
        warInfo.myCrewScoreCount = warInfo.myCrewScoreCount + 1
    end

    warInfo.otherCrewScoreCount = 0
    for k,v in pairs(warInfo.indiScores[fightAgainst]) do
        warInfo.otherCrewScoreCount = warInfo.otherCrewScoreCount + 1
    end
end)




-- local exempleTable = {
--     {
--         name = "Toahsaka",
--         score = 78678,
--     },
--     {
--         name = "Rubylium",
--         score = 7867,
--     },
--     {
--         name = "NightSharekou",
--         score = 157867860,
--     },
--     {
--         name = "NightSharekou",
--         score = 7863,
--     },
-- }

-- Citizen.CreateThread(function()
--     AnimpostfxPlay("MP_Celeb_Win", -1, true)
--     while true do

--         local baseX = 0.3 -- gauche / droite ( plus grand = droite )
--         local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
--         local baseWidth = 0.3 -- Longueur
--         local baseHeight = 0.03 -- Epaisseur
--         DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 255, 103, 92, 255) -- Liseret
--         DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
--         DrawTexts(baseX, baseY - (0.043) - 0.013, "CATALACLUS" .. " CREW", true, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         --DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, "Total: ", true, 0.35, {0, 0, 0, 255}, 6, 0) -- title

--         DrawRect(baseX, baseY, baseWidth, baseHeight, 255, 103, 92, 255)
--         DrawTexts(baseX - 0.140, baseY - 0.013, "crew members", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawTexts(baseX - 0.060, baseY - 0.013, "drift score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawTexts(baseX + 0.020, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawTexts(baseX + 0.080, baseY - 0.013, "final score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         for i = 1,#exempleTable do
--             DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
--             DrawTexts(baseX - 0.140, baseY + (0.032 * i) - 0.013, exempleTable[i].name, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name
--             DrawTexts(baseX - 0.060, baseY + (0.032 * i) - 0.013, GroupDigits(exempleTable[i].score), false, 0.35, {255, 255, 255, 255}, 6, 0) -- drift score
--             DrawTexts(baseX + 0.020, baseY + (0.032 * i) - 0.013, "124s", false, 0.35, {255, 255, 255, 255}, 6, 0) -- time
--             DrawTexts(baseX + 0.080, baseY + (0.032 * i) - 0.013, "124s", false, 0.35, {255, 255, 255, 255}, 6, 0) -- final score
--         end

--         local baseX = 0.7 -- gauche / droite ( plus grand = droite )
--         local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
--         local baseWidth = 0.3 -- Longueur
--         local baseHeight = 0.03 -- Epaisseur

--         DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 255, 103, 92, 255) -- Liseret
--         DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
--         DrawTexts(baseX, baseY - (0.043) - 0.013, "SUPER SUN" .. " CREW", true, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         --DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, "Total: ", true, 0.35, {0, 0, 0, 255}, 6, 0) -- title

--         DrawRect(baseX, baseY, baseWidth, baseHeight, 255, 103, 92, 255)
--         DrawTexts(baseX - 0.140, baseY - 0.013, "crew members", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawTexts(baseX - 0.060, baseY - 0.013, "drift score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawTexts(baseX + 0.020, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawTexts(baseX + 0.080, baseY - 0.013, "final score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         for i = 1,#exempleTable do
--             DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
--             DrawTexts(baseX - 0.140, baseY + (0.032 * i) - 0.013, exempleTable[i].name, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name
--             DrawTexts(baseX - 0.060, baseY + (0.032 * i) - 0.013, GroupDigits(exempleTable[i].score), false, 0.35, {255, 255, 255, 255}, 6, 0) -- drift score
--             DrawTexts(baseX + 0.020, baseY + (0.032 * i) - 0.013, "124s", false, 0.35, {255, 255, 255, 255}, 6, 0) -- time
--             DrawTexts(baseX + 0.080, baseY + (0.032 * i) - 0.013, "124s", false, 0.35, {255, 255, 255, 255}, 6, 0) -- final score
--         end
--         Wait(0)
--     end
--     AnimpostfxStopAll()
-- end)