zone = {}
zone.zones = {}
zone.addZone = function(name, pos, text, action_, haveMarker, markerType, markerSize, markerColor, markerAlpha, dict, marker, rotX, rotY, rotZ)
    print("[info]: Adding new zone " .. name)

    -- Set default values for rotation if not provided
    rotX = rotX or 0.0
    rotY = rotY or 0.0
    rotZ = rotZ or 0.0

    local newZone = {
        name = name,
        pos = pos,
        text = text,
        actions = action_,
        haveMarker = haveMarker,
        markerType = markerType,
        markerSize = markerSize,
        markerColor = markerColor,
        markerAlpha = markerAlpha,
        dict = dict,
        marker = marker,
        rotX = rotX,
        rotY = rotY,
        rotZ = rotZ,
    }
    zone.zones[name] = newZone
end

zone.removeZone = function(name)
    zone.zones[name] = nil
end

-- @ Zone handler

local closestZones = {}
local lastUpdateTime = 0
local updateInterval = 250 -- milliseconds

Citizen.CreateThread(function()
    while p == nil do Wait(1000) end
    while true do
        local currentTime = GetGameTimer()
        
        -- Refresh distances every 250 ms
        if currentTime - lastUpdateTime >= updateInterval then
            closestZones = {}
            for k, v in pairs(zone.zones) do
                local dst = GetDistanceBetweenCoords(p:pos(), v.pos, true)
                if dst <= 20.0 and not p:GetCrewWarStatus() then
                    table.insert(closestZones, {zone = v, distance = dst})
                end
            end
            lastUpdateTime = currentTime
        end

        for _, data in ipairs(closestZones) do
            local v = data.zone
            local dst = data.distance
            if v.haveMarker then
                DrawMarker(v.markerType, v.pos, 0.0, 0.0, 0.0, v.rotX, v.rotY, v.rotZ, v.markerSize, v.markerSize, v.markerSize, v.markerColor[1], v.markerColor[2], v.markerColor[3], v.markerAlpha, 0, 1, 2, 0, nil, nil, 0)
            end

            if dst <= 2.0 then
                ShowHelpNotification(v.text, true)
                if IsControlJustReleased(0, 38) then
                    v.actions()
                end
            end
        end

        Wait(1)
    end
end)