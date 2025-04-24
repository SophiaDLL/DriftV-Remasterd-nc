
local random = math.random
local function uuid()
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

Events = {
    pay = uuid() .."drift:Pay",  -- Pay event for server
    busted = uuid() .."drift:GotBusted", -- Busted Event (when someone is busted)
    refreshCars = uuid() .."drift:UpdateCars", -- Garage Refresh Event
    buyVeh = uuid() .."drift:BuyVehicle", -- Buying Vehicle Event
    setPassive = uuid() .."drift:SetInPassive", -- Passive mode toggle event
    reqSync = uuid() .."drift:RequestSync",
    getSync = uuid() .."drift:SyncPlayer",
    setArchivment = uuid() .."driftV:SetPlayerArchivement", -- Achivement Event
    SetExp = uuid() .."driftV:SubmitExpPoints", -- XP Event
    addMoney = uuid() .."driftV:AddMoney", -- Money adding event
    setDriftPoint = uuid() .."driftV:SubmitDriftPoint", -- Drift score event
    raceEnd = uuid() .."drift:EndRace", -- Race Ending event
    raceData = uuid() .."drift:GetRaceData", -- Race Data event
    sellVeh = uuid() .."drift:SellVehicle", -- Sell vehicle event
}

function RegisterSecuredNetEvent(event, func)
    while event == nil do
        SecurityPrint("Trying to register [" .. event .. "] event which is nil ...")
        Wait(500)
    end
    SecurityPrint("Registered Secured net event ["..event.."]")
    RegisterNetEvent(event)
    AddEventHandler(event, func)
end

function SecurityPrint(text)
    print("^1SECURITY: ^7"..text)
end
