rockdb = {}

function rockdb:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function rockdb:SaveString(key, value)
    MySQL.update.await('INSERT INTO kvp (`key`, value) VALUES (?, ?) ON DUPLICATE KEY UPDATE value = ?', {
        key, value, value
    })
end

function rockdb:GetString(key)
    local row = MySQL.single.await('SELECT value FROM kvp WHERE `key` = ? LIMIT 1', {
        key
    })
    if not row then return nil end
    return row.value
end

function rockdb:SaveInt(key, value)
    MySQL.update.await('INSERT INTO kvp (`key`, value) VALUES (?, ?) ON DUPLICATE KEY UPDATE value = ?', {
        key, tostring(value), tostring(value)
    })
end

function rockdb:GetInt(key)
    local row = MySQL.single.await('SELECT value FROM kvp WHERE `key` = ? LIMIT 1', {
        key
    })
    if not row then return nil end
    return tonumber(row.value)
end

function rockdb:SaveFloat(key, value)
    MySQL.update.await('INSERT INTO kvp (`key`, value) VALUES (?, ?) ON DUPLICATE KEY UPDATE value = ?', {
        key, tostring(value), tostring(value)
    })
end

function rockdb:GetFloat(key)
    local row = MySQL.single.await('SELECT value FROM kvp WHERE `key` = ? LIMIT 1', {
        key
    })
    if not row then return nil end
    return tonumber(row.value)
end

function rockdb:SaveTable(key, table)
    local jsonValue = json.encode(table)
    MySQL.update.await('INSERT INTO kvp (`key`, value) VALUES (?, ?) ON DUPLICATE KEY UPDATE value = ?', {
        key, jsonValue, jsonValue
    })
end

function rockdb:GetTable(key)
    local row = MySQL.single.await('SELECT value FROM kvp WHERE `key` = ? LIMIT 1', {
        key
    })
    if not row then return nil end
    return json.decode(row.value)
end

-- Example usage
local function GetTimeInMs(first, seconde)
    return tostring(seconde - first)
end