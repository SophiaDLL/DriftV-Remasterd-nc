BlipInfo = {}

function BlipInfo.create(config)
    local data = {}
    
    if config.setTitle then 
        data.title = config.setTitle
    end
    
    if config.setType then
        data.type = config.setType
    end
    
    if config.setTexture then
        if type(config.setTexture) == "string" then
            if config.setTexture:match("^https?://") then
                local textureData = CreateDuiTexture(config.setTexture) -- draw 
                if textureData then
                    data.textureDict = textureData.dict
                    data.textureName = textureData.name
                    data.isDuiTexture = true
                end
            else
                data.textureDict = config.setTexture
                data.textureName = config.setTexture
            end
        elseif type(config.setTexture) == "table" then
            if config.setTexture.url then
                local textureData = CreateDuiTexture({ -- draw 
                    url = config.setTexture.url,
                    width = config.setTexture.width,
                    height = config.setTexture.height
                })
                if textureData then
                    data.textureDict = textureData.dict
                    data.textureName = textureData.name
                    data.isDuiTexture = true
                end
            else
                data.textureDict = config.setTexture[1] or config.setTexture.dict
                data.textureName = config.setTexture[2] or config.setTexture.name
            end
        end
    end
    
    if config.setRpText then
        data.rpText = config.setRpText
    end
    
    if config.setCashText then
        data.cashText = config.setCashText
    end
    
    if config.setApText then
        data.apText = config.setApText
    end

    data.components = {}

    if config.components then
        for _, comp in ipairs(config.components) do
            if comp.type == "basic" then
                table.insert(data.components, {
                    type = 0,
                    title = comp.title,
                    value = comp.value
                })
            elseif comp.type == "icon" then
                table.insert(data.components, {
                    type = 2,
                    title = comp.title,
                    value = comp.value,
                    iconIndex = comp.iconIndex,
                    iconHudColor = comp.iconHudColor,
                    isTicked = comp.isTicked
                })
            elseif comp.type == "divider" then
                table.insert(data.components, {type = 4})
            elseif comp.type == "description" then
                table.insert(data.components, {
                    type = 5,
                    value = comp.value
                })
            elseif comp.type == "social" then
                table.insert(data.components, {
                    type = 3,
                    title = comp.title,
                    value = comp.value,
                    crew = comp.crew,
                    isSocialClubName = comp.isSocialClubName
                })
            end
        end
    end

    return data
end
return BlipInfo
