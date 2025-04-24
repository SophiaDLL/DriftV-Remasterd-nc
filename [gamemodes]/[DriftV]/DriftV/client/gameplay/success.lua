Succes = {
    {
        name = "Session: 100k",
        label = "Session: You have exceeded 100,000 drift points! Great start!",
        xpReward = 50 * 1, -- 100k / 100k = 1
        funcToCheck = function()
            return CheckDriftPoints(100000)
        end,
    },
    {
        name = "Session: 250k",
        label = "Session: You have exceeded 250,000 drift points! Keep it up!",
        xpReward = 50 * 2.5, -- 250k / 100k = 2.5
        funcToCheck = function()
            return CheckDriftPoints(250000)
        end,
    },
    {
        name = "Session: 500k",
        label = "Session: You have exceeded 500,000 drift points! Amazing!",
        xpReward = 50 * 5, -- 500k / 100k = 5
        funcToCheck = function()
            return CheckDriftPoints(500000)
        end,
    },
    {
        name = "Session: 750k",
        label = "Session: You have exceeded 750,000 drift points! Incredible!",
        xpReward = 50 * 7.5, -- 750k / 100k = 7.5
        funcToCheck = function()
            return CheckDriftPoints(750000)
        end,
    },
    {
        name = "Session: 1 Million",
        label = "Session: You have exceeded 1 Million drift points! Bravo!",
        xpReward = 50 * 10, -- 1m / 100k = 10
        funcToCheck = function()
            return CheckDriftPoints(1000000)
        end,
    },
    {
        name = "Session: 2.5 Million",
        label = "Session: You have exceeded 2.5 Million drift points! Legendary!",
        xpReward = 50 * 25, -- 2.5m / 100k = 25
        funcToCheck = function()
            return CheckDriftPoints(2500000)
        end,
    },
    {
        name = "Session: 5 Million",
        label = "Session: You have exceeded 5 Million drift points! Unstoppable!",
        xpReward = 50 * 50, -- 5m / 100k = 50
        funcToCheck = function()
            return CheckDriftPoints(5000000)
        end,
    },
    {
        name = "Session: 10 Million",
        label = "Session: You have exceeded 10 Million drift points! Phenomenal!",
        xpReward = 50 * 100, -- 10m / 100k = 100
        funcToCheck = function()
            return CheckDriftPoints(10000000)
        end,
    },
    {
        name = "Session: 100 Million",
        label = "Session: You have exceeded 100 Million drift points! Godlike!",
        xpReward = 50 * 1000, -- 100m / 100k = 1000
        funcToCheck = function()
            return CheckDriftPoints(100000000)
        end,
    },
    {
        name = "Session: 1 Billion",
        label = "Session: You have exceeded 1 Billion drift points! The Ultimate Drift Master!",
        xpReward = 50 * 10000, -- 1b / 100k = 10000
        funcToCheck = function()
            return CheckDriftPoints(1000000000)
        end,
    },
}


Citizen.CreateThread(function()
while not loaded do Wait(1) end
    while true do
        for _,v in pairs(Succes) do
            if v.done == nil then
                if v.funcToCheck() then
                    v.done = true
                    p:SetSucces(v.name)
                    SendNUIMessage( {
                        ShowSucces = true,
                        label = v.label,
                    })
                    p:addExp(v.xpReward)
                    Wait(4000)
                    SendNUIMessage( {
                        HideSucces = true,
                    })
                    Wait(1000)
                end
            end
        end
        Wait(1000)
    end
end)



function CheckDriftPoints(points)
    if p:getSessionDrift() >= points then
        return true
    else
        return false
    end
end


local alpha = 0
local subAlpha = 0
local display = false
function DisplayLittleSucces(title, save, time)
    display = true
    if save == nil then
        p:SetSucces(title)
    end
    if time == nil then
        time = 500
    end
    local baseX = 0.5 -- gauche / droite ( plus grand = droite )
    local baseY = 1.00 -- Hauteur ( Plus petit = plus haut )
    local baseWidth = 0.0 -- Longueur
    local baseHeight = 0.03 -- Epaisseur

    local long = string.len(title)
    for i = 1, long do
        baseWidth = baseWidth + 0.006
    end


    Citizen.CreateThread(function()
        for i = 0,255 do
            alpha = alpha + 3
            subAlpha = subAlpha + 3

            if alpha >= 255 then
                alpha = 255
            end
            if subAlpha >= 200 then
                subAlpha = 200
            end
            Wait(0)
        end
        Wait(time)
        for i = 0,255 do
            alpha = alpha - 3
            if alpha <= 0 then
                alpha = 0
            end
            if subAlpha <= 0 then
                subAlpha = 0
            end
            if alpha <= 200 then
                subAlpha = subAlpha - 3
            end
            Wait(0)
        end
        display = false
        alpha = 0
        subAlpha = 0
    end)

    Citizen.CreateThread(function()
        while display do
            DrawRect(baseX, baseY - 0.060, baseWidth, baseHeight - 0.025, 110, 255, 168, alpha) -- Liseret
            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 0, 0, 0, subAlpha) -- Bannière
            DrawTexts(baseX, baseY - (0.043) - 0.013, title, true, 0.35, {255, 255, 255, alpha}, 2, 0) -- title
            Wait(1)
        end
    end)
end

-- local baseX = 0.5 -- gauche / droite ( plus grand = droite )
-- local baseY = 0.95 -- Hauteur ( Plus petit = plus haut )
-- local baseWidth = 0.05 -- Longueur
-- local baseHeight = 0.03 -- Epaisseur


-- Citizen.CreateThread(function()
--     while true do
--         DrawRect(baseX, baseY - 0.060, baseWidth, baseHeight - 0.025, 110, 255, 168, 255) -- Liseret
--         DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 0, 0, 0, 200) -- Bannière
--         DrawTexts(baseX, baseY - (0.043) - 0.013, "test", true, 0.35, {255, 255, 255, 255}, 2, 0) -- title
--         Wait(1)
--     end
-- end)

local LittleSucces = {}

function AddLittleSucces(title)
    table.insert(LittleSucces, {text = title})
end

Citizen.CreateThread(function()
    while true do
        if not display then
            if LittleSucces[1] ~= nil then
                DisplayLittleSucces(LittleSucces[1].text)
                table.remove(LittleSucces, 1)
                Wait(1000)
            end
        end
        Wait(200)
    end
end)