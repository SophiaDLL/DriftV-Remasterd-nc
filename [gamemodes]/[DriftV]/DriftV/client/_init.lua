Events = nil
loaded = false
local first = true
local waitingSpawn = true
PlayersCrew = {}
Crew = {}
KingDriftCrew = {
    name = "Nothing",
    elo = 5,
}
CrewRanking = {}

Citizen.CreateThread(function()
    TriggerServerEvent("driftV:InitPlayer")
    TriggerServerEvent("drift:GetRaceData")
    player:new()
    loaded = true

    startCinematic()


    SetPlayerInvincible(GetPlayerIndex(), true) 
    RequestIpl('shr_int')
end)

RegisterNetEvent("syncEvents")
AddEventHandler("syncEvents", function(ev)
    Events = ev
end)

RegisterNetEvent("driftV:RefreshData")
AddEventHandler("driftV:RefreshData", function(data)
    p:SetCars(data.cars)
    p:SetDriftPoint(data.driftPoint)
    p:SetMoney(data.money)
    p:InitSucces(data.succes)
    p:setExp(data.exp)
    p:setCrew(data.crew)
    p:setCrewOwner(data.crewOwner)
end)

RegisterNetEvent("driftV:RefreshOtherPlayerData")
AddEventHandler("driftV:RefreshOtherPlayerData", function(crew, pCrews, king)
    PlayersCrew = pCrews
    Crew = crew
    KingDriftCrew = king
end)

RegisterNetEvent("driftV:RefreshCrewRanking", function(ranking)
    CrewRanking = ranking
end)

local possibleCam = {   
    -- CAMERA 1 
    {
        cam1 = vector3(-1844.697, 64.29037, 487.627), --vector4(-1844.697, 64.29037, 487.627, 62.16765)
        cam1fov = 40.0,
        cam1LookTo = vector3(-83.3176, -814.6838, 328.4993),-- vector4(-83.3176, -814.6838, 328.4993, 62.16765)

        cam2 = vector3(785.0239, -228.9342, 526.7943), --vector4(785.0239, -228.9342, 526.7943, 62.16765)
        cam2fov = 25.0,
        cam2LookTo = vector3(-83.3176, -814.6838, 328.4993), --vector4(940.9302, -2920.824, 6.082768, 134.0334)
    },
    -- CAMERA 2
    {
        cam1 = vector3(-408.4018, 1181.996, 326.0692), -- vector4(-408.4018, 1181.996, 326.0692, 275.1053)
        cam1fov = 40.0,
        cam1LookTo = vector3(-411.1234, 1175.376, 324.9142), --vector4(-411.1234, 1175.376, 324.9142, 275.1053)

        cam2 = vector3(-400.2285, 1181.763, 326.6424), -- vector4(-400.2285, 1181.763, 326.6424, 275.1053)
        cam2fov = 40.0,
        cam2LookTo = vector3(-416.9135, 1189.378, 326.6424), -- vector4(-416.9135, 1189.378, 326.6424, 275.1053)

        entity = {
            model = "sunrise1",
            pos = vector4(-411.1234, 1175.376, 324.9142, 275.1053)
        },
    },
    -- CAMERA 3
    {
        cam1 = vector3(192.95159912109, -836.13739013672, 31.089879989624),
        cam1fov = 40.0,
        cam1LookTo = vector3(206.22041320801, -848.85394287109, 40.686096191406),

        cam2 = vector3(197.71852111816, -836.44244384766, 31.338581085205),
        cam2fov = 40.0,
        cam2LookTo = vector3(208.77725219727, -835.74896240234, 30.484485626221),

        entity = {
            model = "SULTANRSV8",
            pos = vector4(204.36486816406, -836.13897705078, 30.082794189453, 106.61936950684),
        },
    },
    -- CAMERA 4
    {
        cam1 = vector3(-2295.989, 435.0497, 180.293), --vector4(-2295.989, 435.0497, 180.293, 64.26134)
        cam1fov = 40.0,
        cam1LookTo = vector3(-2307.973, 415.4665, 174.7061), --vector4(-2307.973, 415.4665, 174.7061, 64.26134)

        cam2 = vector3(-2313.656, 414.6147, 174.3751), --vector4(-2313.656, 414.6147, 174.3751, 64.26134)
        cam2fov = 40.0,
        cam2LookTo = vector3(-2308.454, 411.9258, 174.1923), -- vector4(-2308.454, 411.9258, 174.1923, 64.26134)

        entity = {
            model = "ITALIGTON",
            pos = vector4(-2305.994, 408.6498, 173.7396, 64.26141),
        },
    },
    -- CAMERA 5
    {
        cam1 = vector3(-837.0415, 186.7916, 74.75805), --vector4(-837.0415, 186.7916, 74.75805, 152.5854)
        cam1fov = 40.0,
        cam1LookTo = vector3(-832.9034, 173.4257, 71.43719), --vector4(-832.9034, 173.4257, 71.43719, 152.5854)

        cam2 = vector3(-836.687, 169.8946, 72.31146), -- vector4(-836.687, 169.8946, 72.31146, 152.5854)
        cam2fov = 35.0,
        cam2LookTo = vector3(-832.9034, 173.4257, 71.43719),

        entity = {
            model = "N2FUTO",
            pos = vector4(-828.4255, 175.2204, 70.03642, 152.5855),
        },
    },
        -- CAMERA 6
    {
        cam1 = vector3(-74.75574, -833.8609, 327.0023), -- vector4(-74.75574, -833.8609, 327.0023, 165.5751)
        cam1fov = 40.0,
        cam1LookTo = vector3(-77.06525, -827.6976, 326.7029), -- vector4(-77.06525, -827.6976, 326.7029, 165.5751)
    
        cam2 = vector3(-63.09195, -819.4227, 326.9065), --vector4(-63.09195, -819.4227, 326.9065, 165.5751)
        cam2fov = 35.0,
        cam2LookTo = vector3(-77.06525, -827.6976, 326.7029),
    
        entity = {
            model = "jester3c",
            pos = vector4(-74.73578, -818.9178, 325.448, 165.5752),
        },
    },

    
    -- CAMERA TEMPLATE
    -- {
    --     cam1 = vector3(REPLACE),
    --     cam1fov = 40.0,
    --     cam1LookTo = vector3(REPLACE),

    --     cam2 = vector3(REPLACE),
    --     cam2fov = 35.0,
    --     cam2LookTo = vector3(REPLACE),

    --     entity = {
    --         model = "JESTGPR",
    --         pos = REPLACEv4,
    --     },
    -- },

    
}

local possibleMusic = {
    "loading1",
    "loading2",
    "loading3",
    "loading4",
}

function startCinematic()

    Citizen.CreateThread(function()
        exports.spawnmanager.spawnPlayer()
        cam.create("CAM_1")
        cam.create("CAM_2")

        while waitingSpawn do
            for k,v in pairs(possibleCam) do
                if not waitingSpawn then break end
                local entity = nil
                if v.entity ~= nil then
                    LoadModel(v.entity.model)
                    entity = CreateVehicle(GetHashKey(v.entity.model), v.entity.pos, 0, 1)
                    SetVehicleDirtLevel(entity, 0.0)
                    SetVehicleOnGroundProperly(entity)
                end

                DoScreenFadeIn(2000)
                cam.setPos("CAM_1", v.cam1)
                cam.setFov("CAM_1", v.cam1fov)
                cam.lookAtCoords("CAM_1", v.cam1LookTo)
                cam.setActive("CAM_1")
                cam.render("CAM_1", true, false, 0)

                cam.setPos("CAM_2", v.cam2)
                cam.setFov("CAM_2", v.cam2fov)
                cam.lookAtCoords("CAM_2", v.cam2LookTo)

                
                

                cam.setActive("CAM_2")
                cam.switchToCam("CAM_2", "CAM_1", 15000)
                local timer = GetGameTimer() + 10000
                while GetGameTimer() < timer do
                    Wait(1)
                end


                if not waitingSpawn then DeleteEntity(entity) break end
                DoScreenFadeOut(2000)
                Wait(2100)
                if entity ~= nil then
                    DeleteEntity(entity)
                end
            end
            Wait(0)
        end
    end)


    DisplayRadar(false)
    SetNuiFocus(true, true)

    SendNUIMessage({
        containerJoins = true,
        -- music = possibleMusic[math.random(1,#possibleMusic)]
    })
    local music = possibleMusic[math.random(1,#possibleMusic)]
    TriggerEvent("InteractSound_CL:PlayOnOne", music, 0.07)


    
end

RegisterNUICallback('joinServer', function(data)
    if not waitingSpawn then
        return
    end
    waitingSpawn = false
    
    SendNUIMessage({
        joinClick = true
    })
    TriggerEvent("InteractSound_CL:Stop")

    DoScreenFadeOut(1500)
    Wait(1500)
    DoScreenFadeIn(2000)

    RenderScriptCams(false, false, false, 0, 0)
    SetNuiFocus(false, false)

    cam.delete("CAM_1")
    cam.delete("CAM_2")
    DisplayRadar(true)
    TriggerEvent("FeedM:showNotification", "Welcome back! Press F1 to use the main menu! Have fun on DriftV !", 30000, "danger")
    SetAudioFlag("LoadMPData", true)
    SetBigmapActive(false, false)
    EnableLobby()
end)