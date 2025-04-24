function GetLicense(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, Config.UseIdentifierAsKey) then
            return v
        end
    end
end

function GetDiscord(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "discord") then
            return v
        end
    end
end

function debugPrint(text)
    print("^3DriftV: ^7"..text)
end

RegisterNetEvent("DeleteEntity", function(ent)
    local entity = NetworkGetEntityFromNetworkId(ent)
    if DoesEntityExist(entity) then
        DeleteEntity(entity)
    else
        print("Entity does not exist for network ID: " .. tostring(ent))
    end
end)

function GroupDigits(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1' .. (' ')):reverse())..right
end