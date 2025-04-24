local DuiTextures = {}
local blipDuiTextureUID = 1

function CreateDuiTexture(texture)
    if not texture then return nil end
    
    local url, width, height
    if type(texture) == "string" then
        url = texture
        width, height = 512, 256 --fb 
    elseif type(texture) == "table" then
        url = texture.url
        width = texture.width or 512
        height = texture.height or 512
    end
    
    if not url then return nil end

    local textureName = "dui_blip_tex_" .. blipDuiTextureUID
    blipDuiTextureUID = blipDuiTextureUID +1
    local txdName = textureName .. "_dict"
    local runtimeTxd = CreateRuntimeTxd(txdName)
    local duiObject = CreateDui(url, width, height)
    local duiHandle = GetDuiHandle(duiObject)
    
    local duiTexture = CreateRuntimeTextureFromDuiHandle(runtimeTxd, textureName, duiHandle)
    
    DuiTextures[textureName] = {
        object = duiObject,
        texture = duiTexture,
        txd = runtimeTxd,
        dict = txdName,
        name = textureName
    }
    
    return {
        dict = txdName,
        name = textureName
    }
end

local function CleanupDuiTexture(textureName)
    local duiData = DuiTextures[textureName]
    if duiData then

        if duiData.object then
            DestroyDui(duiData.object)
        end

        DuiTextures[textureName] = nil
    end
end