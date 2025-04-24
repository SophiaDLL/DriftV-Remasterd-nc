local LastHoveredBlipHandle = 0
local BlipInfoStorage = {}

local function CreateBlipBuilder()
    return BlipInfoBuilder.new()
end

local function CallScaleformMethodOnFrontend(methodName, ...)
    if BeginScaleformMovieMethodOnFrontend(methodName) then
        local args = {...}
        for _, arg in ipairs(args) do
            local argType = type(arg)
            if argType == "boolean" then
                ScaleformMovieMethodAddParamBool(arg)
            elseif argType == "string" then
                ScaleformMovieMethodAddParamPlayerNameString(arg)
            elseif argType == "number" then
                if arg == math.floor(arg) then
                    ScaleformMovieMethodAddParamInt(arg)
                else
                    ScaleformMovieMethodAddParamFloat(arg)
                end
            end
        end
        EndScaleformMovieMethod()
    end
end

function CreateBlipInfo(blipHandle)
    return BlipInfoBuilder.new()
end

local function UpdateBlipInfo(blipHandle, config)
    if DoesBlipExist(blipHandle) then
        local blipInfo = BlipInfo.create(config)
        BlipInfoStorage[blipHandle] = blipInfo
        SetBlipAsMissionCreatorBlip(blipHandle, true)
        return true
    end
    return false
end

local function RemoveBlipInfo(blipHandle)
    if BlipInfoStorage[blipHandle] then
        local blipInfo = BlipInfoStorage[blipHandle]
        if blipInfo.isDuiTexture and blipInfo.textureName then
            CleanupDuiTexture(blipInfo.textureName)
        end
        BlipInfoStorage[blipHandle] = nil
        SetBlipAsMissionCreatorBlip(blipHandle, false)
        return true
    end
    return false
end


local function RequestTextureIfNeeded(textureDict)
    if textureDict and not HasStreamedTextureDictLoaded(textureDict) then
        RequestStreamedTextureDict(textureDict, true)
        while not HasStreamedTextureDictLoaded(textureDict) do
            Wait(0)
        end
        return true
    end
    return false
end

local function HandleMissionCreatorBlips()
    if not IsFrontendReadyForControl() then return end

    local curHoveredBlipHandle = GetNewSelectedMissionCreatorBlip()
    if IsHoveringOverMissionCreatorBlip() then
        if LastHoveredBlipHandle ~= curHoveredBlipHandle and DoesBlipExist(curHoveredBlipHandle) then
            if DoesBlipExist(LastHoveredBlipHandle) then
                CallScaleformMethodOnFrontend("SET_DATA_SLOT_EMPTY", 1)
            end
            LastHoveredBlipHandle = 0
        end
    else
        if DoesBlipExist(LastHoveredBlipHandle) then
            CallScaleformMethodOnFrontend("SET_DATA_SLOT_EMPTY", 1)
        end
        LastHoveredBlipHandle = 0
    end

    if curHoveredBlipHandle ~= LastHoveredBlipHandle and DoesBlipExist(curHoveredBlipHandle) and IsMissionCreatorBlip(curHoveredBlipHandle) then
        local blipInfo = BlipInfoStorage[curHoveredBlipHandle]
        if blipInfo then
            if blipInfo.textureDict then
                RequestTextureIfNeeded(blipInfo.textureDict)
            end

            TakeControlOfFrontend()
            CallScaleformMethodOnFrontend("SHOW_COLUMN", 65, 1, true)

            local data = blipInfo
            CallScaleformMethodOnFrontend("SET_COLUMN_TITLE", 1, "", data.title or "", data.type or 0,
                data.textureDict or "", data.textureName or "", 1, 0,
                data.rpText or false, data.cashText or false, data.apText or false)

            if data.components then
                for i, component in ipairs(data.components) do
                    if component.type <= 1 then
                        CallScaleformMethodOnFrontend("SET_DATA_SLOT", 1, i-1, 65, i-1, component.type, 0, 1,
                            component.title or "", component.value or "")
                    elseif component.type == 2 then
                        CallScaleformMethodOnFrontend("SET_DATA_SLOT", 1, i-1, 65, i-1, component.type, 0, 1,
                            component.title or "", component.value or "",
                            component.iconIndex or 0, component.iconHudColor or 0, component.isTicked or false)
                    elseif component.type == 3 then
                        local crewTag = (component.crew.isPrivate and "(" or ".") .. (component.crew.isRockstar and "*" or ".") .. (component.crew.lvl and component.crew.lvl or ".") .. (component.crew.tag and component.crew.tag or "") .. (component.crew.lvlColor and component.crew.lvlColor or "")
                        CallScaleformMethodOnFrontend("SET_DATA_SLOT", 1, i-1, 65, i-1, component.type, 0, 1,
                            component.title or "", component.value or "",
                            crewTag,
                            component.isSocialClubName or false)
                    elseif component.type == 4 then
                        CallScaleformMethodOnFrontend("SET_DATA_SLOT", 1, i-1, 65, i-1, component.type, 0, 0)
                    elseif component.type == 5 then
                        CallScaleformMethodOnFrontend("SET_DATA_SLOT", 1, i-1, 65, i-1, component.type, 0, 0,
                            component.value or "")
                    end
                end
            end

            CallScaleformMethodOnFrontend("DISPLAY_DATA_SLOT", 1)
            ReleaseControlOfFrontend()
        end
        LastHoveredBlipHandle = curHoveredBlipHandle
    end
end


CreateThread(function()
    for k, v in pairs(Config.Blips) do
        local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
        SetBlipSprite(blip, v.blipId)
        SetBlipDisplay(blip, v.displayType)
        SetBlipScale(blip, v.scale)
        SetBlipColour(blip, v.blipColor)
        SetBlipAsShortRange(blip, v.shortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(blip)

        UpdateBlipInfo(blip, v.blipInfo)
    end

    while true do
        HandleMissionCreatorBlips()
        Wait(IsPauseMenuActive() and 0 or 1000)
    end
end)

exports('CreateBlipBuilder', CreateBlipBuilder)
exports('UpdateBlipInfo', UpdateBlipInfo)
exports('RemoveBlipInfo', RemoveBlipInfo)
exports('GetBlipInfo', function(blipHandle)
    return BlipInfoStorage[blipHandle] or false
end)
