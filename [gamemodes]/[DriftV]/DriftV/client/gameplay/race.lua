local racesScores = {}
local inRace = false
local race = {

    --- RACES UNDER $1,000 REWARDS
    {
        label = "LS Observatory",
        start =  vector4(-429.0257, 1190.349, 325.0423, 74.51242),
        price = 1200,
        expReward = 750,
        baseScore = 85000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(-478.6462, 1256.28, 317.3154, 305.3306), passed = false},
            {pos = vector4(-351.4814, 1455.357, 288.3223, 283.2676), passed = false},
            {pos = vector4(-218.4355, 1299.808, 305.3869, 116.3622), passed = false},
            {pos = vector4(-328.6823, 1186.411, 322.5218, 135.0607), passed = false},
            {pos = vector4(-429.0257, 1190.349, 325.0423, 74.51242), passed = false},
        }
    },
    {
        label = "Chupacabra Docs",
        start =  vector4(-165.8184, -2439.57, 5.403574, 271.741),
        price = 1500,
        expReward = 750,
        baseScore = 50000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(-62.44464, -2483.97, 5.433324, 156.2465), passed = false},
            {pos = vector4(-31.3787, -2521.623, 5.408247, 303.7127), passed = false},
            {pos = vector4(22.93539, -2445.618, 5.400997, 50.19005), passed = false},
            {pos = vector4(-225.3838, -2407.434, 5.401044, 202.0645), passed = false},
            {pos = vector4(-168.936, -2440.405, 5.396833, 271.0258), passed = false},
        }
    },
    {
        label = "Dock Run",
        start =  vector4(978.5416, -3219.899, 5.900664, 2.842567),
        price = 2200,
        expReward = 1000,
        baseScore = 135000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(978.5416, -3219.899, 5.900664, 2.842567), passed = false},
            {pos = vector4(978.9899, -2963.672, 5.302491, 23.70997), passed = false},
            {pos = vector4(883.5682, -2962.902, 5.301818, 171.2981), passed = false},
            {pos = vector4(837.2665, -3006.302, 5.302597, 42.47378), passed = false},
            {pos = vector4(873.814, -2956.078, 5.301877, 238.4264), passed = false},
            {pos = vector4(978.7961, -3028.436, 5.301324, 181.6824), passed = false},
            {pos = vector4(825.0024, -3061.35, 5.290692, 88.28062), passed = false},
            {pos = vector4(875.6521, -3116.358, 5.302404, 234.4023), passed = false},
            {pos = vector4(882.6172, -3212.163, 5.297845, 178.0), passed = false},
        }
    },
    {
        label = "Elysian Docks",
        start =  vector4(202.2397, -3044.907, 5.234527, 223.7417),
        price = 2200,
        expReward = 1000,
        baseScore = 120000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(297.3101, -3233.766, 5.112319, 160.1831), passed = false},
            {pos = vector4(177.5498, -3284.115, 4.988851, 1.154156), passed = false},
            {pos = vector4(183.8212, -3046.581, 5.170897, 351.7595), passed = false},
            {pos = vector4(266.2525, -2797.185, 5.42202, 226.8886), passed = false},
            {pos = vector4(300.9582, -3050.094, 5.303448, 181.6123), passed = false},
            {pos = vector4(264.1638, -3091.405, 5.185097, 83.29774), passed = false},
            {pos = vector4(209.4514, -3051.451, 5.232073, 42.45306), passed = false},
        }
    },
    {
        label = "LS Underground",
        start =  vector4(-2088.55, 1106.927, -27.96381, 182.7677),
        price = 2400,
        expReward = 1000,
        baseScore = 180000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(-2059.668, 1052.047, -27.95291, 2.022249), passed = false},
            {pos = vector4(-1922.495, 1027.453, -27.97998, 268.4698), passed = false},
            {pos = vector4(-1852.925, 1121.141, -27.96529, 356.4455), passed = false},
            {pos = vector4(-1954.581, 1150.643, -27.96599, 89.13308), passed = false},
            {pos = vector4(-1967.053, 1201.753, -27.96321, 90.73451), passed = false},
            {pos = vector4(-2119.746, 1218.667, -27.9624, 309.5526), passed = false},
            {pos = vector4(-2086.875, 1119.359, -27.96456, 179.4772), passed = false},
        }
    },
    --- RACES UNDER $2,500 REWARDS
    {
        label = "Kush City Right Route",
        start =  vector4(1623.787, -3422.958, 40.13169, 239.6298),
        price = 3200,
        expReward = 1500,
        baseScore = 180000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(1775.684, -3404.999, 31.47404, 242.8694), passed = false},
            {pos = vector4(2000.331, -3376.843, 45.90614, 332.0429), passed = false},
            {pos = vector4(1981.604, -3202.33, 46.66716, 80.05404), passed = false},
            {pos = vector4(1981.799, -3100.323, 64.60371, 102.4378), passed = false},
            {pos = vector4(2014.739, -3003.347, 88.90171, 39.39345), passed = false},
            {pos = vector4(1954.318, -2952.719, 84.0991, 176.7787), passed = false},
            {pos = vector4(1866.921, -2884.558, 67.43599, 119.4678), passed = false},
        }
    },
    {
        label = "Kush City Touge",
        start =  vector4(2088.968, -2927.218, 133.5952, 188.3642),
        price = 3500,
        expReward = 1750,
        baseScore = 180000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(2218.297, -2968.459, 127.3235, 205.9428), passed = false},
            {pos = vector4(2189.384, -3032.252, 111.369, 216.6832), passed = false},
            {pos = vector4(2173.225, -3094.357, 89.20761, 220.5234), passed = false},
            {pos = vector4(2155.615, -3192.178, 70.25352, 211.3148), passed = false},
            {pos = vector4(2140.811, -3216.302, 55.96109, 29.72679), passed = false},
            {pos = vector4(2134.899, -3255.196, 47.9077, 214.2159), passed = false},
            {pos = vector4(2132.665, -3514.196, 48.16708, 244.7665), passed = false},
        }
    },
    --- RACES UNDER $5,000 REWARDS
    {
        label = "Vinewood Hills",
        start =  vector4(150.3112, 1652.589, 228.4458, 295.0632),
        price = 6500,
        expReward = 3250,
        baseScore = 300000,
        pointPerSec = 750,
        speedLimit = 60,
        points = {
            {pos = vector4(340.0148, 1696.006, 240.7602, 307.8852), passed = false},
            {pos = vector4(670.4041, 1739.469, 188.1732, 227.8252), passed = false},
            {pos = vector4(984.5569, 1728.336, 163.5785, 269.0059), passed = false},
            {pos = vector4(1034.606, 1592.77, 168.4278, 162.9796), passed = false},
            {pos = vector4(1128.252, 1427.215, 163.3772, 226.0284), passed = false},
            {pos = vector4(1191.174, 1199.3, 158.2648, 135.4354), passed = false},
            {pos = vector4(1234.749, 982.8331, 141.9243, 167.1285), passed = false},
            {pos = vector4(1065.484, 750.286, 154.8073, 151.0721), passed = false},
            {pos = vector4(926.5706, 708.265, 179.809, 357.8967), passed = false},
            {pos = vector4(996.0533, 906.6816, 210.1873, 350.7943), passed = false},
            {pos = vector4(807.0869, 940.5504, 234.7316, 152.6287), passed = false},
            {pos = vector4(622.1285, 782.7297, 203.488, 87.11863), passed = false},
            {pos = vector4(470.6987, 873.1309, 197.5321, 26.15948), passed = false},
            {pos = vector4(535.5259, 1024.416, 216.5773, 350.5644), passed = false},
            {pos = vector4(411.5039, 1202.791, 249.2453, 0.1193051), passed = false},
            {pos = vector4(551.4205, 1362.9, 298.0745, 336.6306), passed = false},
            {pos = vector4(732.4644, 1357.902, 336.9794, 298.0266), passed = false},
            {pos = vector4(812.3979, 1275.627, 359.9078, 83.56644), passed = false},
        }
    },
    {
        label = "Banham Canyon",
        start =  vector4(-2652.097, 1514.488, 116.7912, 331.8986),
        price = 6600,
        expReward = 3250,
        baseScore = 350000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(-2549.814, 1667.193, 145.1183, 273.8195), passed = false},
            {pos = vector4(-2523.09, 1850.997, 165.2741, 38.64588), passed = false},
            {pos = vector4(-2350.345, 1893.489, 182.7485, 203.551), passed = false},
            {pos = vector4(-2172.123, 1957.863, 189.9555, 331.6472), passed = false},
            {pos = vector4(-2052.534, 1958.236, 188.2827, 153.0048), passed = false},
            {pos = vector4(-1967.867, 1760.072, 176.5926, 265.3867), passed = false},
            {pos = vector4(-1820.234, 1838.036, 157.2525, 273.5696), passed = false},
            {pos = vector4(-1834.517, 2034.265, 133.01, 270.2286), passed = false},
            {pos = vector4(-1676.458, 2226.288, 85.60239, 68.44885), passed = false},
            {pos = vector4(-1941.625, 2292.908, 55.99584, 109.569), passed = false},
            {pos = vector4(-2093.932, 2298.308, 37.33912, 17.30975), passed = false},
        }
    },
         {
         label = "DNX DOWNHILL (Grapeseed)",
         start = vector4(509.2826, 5401.436, 670.8432, 266.9132),
         price = 8500,
         expReward = 4250,
         baseScore = 400000,
         pointPerSec = 750,
         speedLimit = 45,
         points = {
             {pos = vector4(706.3962, 5445.264, 640.4167, 333.2213), passed = false},
             {pos = vector4(898.5911, 5538.69, 583.2724, 250.6156), passed = false},
             {pos = vector4(1215.527, 5543.312, 502.9278, 274.3951), passed = false},
             {pos = vector4(1192.16, 5450.95, 437.5946, 152.3939), passed = false},
             {pos = vector4(1286.083, 5453.092, 406.1604, 266.5511), passed = false},
             {pos = vector4(1504.39, 5455.079, 378.9609, 303.2401), passed = false},
             {pos = vector4(1316.602, 5379.818, 355.9798, 53.64342), passed = false},
             {pos = vector4(1385.188, 5356.068, 322.0292, 319.8287), passed = false},
             {pos = vector4(1734.557, 5415.979, 270.4958, 278.6199), passed = false},
             {pos = vector4(1631.805, 5317.469, 227.7281, 289.4785), passed = false},
             {pos = vector4(2033.628, 5353.686, 162.9684, 266.8577), passed = false},
             {pos = vector4(2405.076, 5285.546, 87.62711, 243.5846), passed = false},
             {pos = vector4(2473.309, 5118.051, 45.81842, 185.0673), passed = false},
         }
     },
     {
        label = "DNX UPHILL (Grapeseed)",
        start = vector4(2473.615, 5117.847, 45.79837, 7.3365),
        price = 8500,
        expReward = 4250,
        baseScore = 400000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(2405.076, 5285.546, 87.62711, 243.5846), passed = false},
            {pos = vector4(2033.628, 5353.686, 162.9684, 266.8577), passed = false},
            {pos = vector4(1631.805, 5317.469, 227.7281, 289.4785), passed = false},
            {pos = vector4(1734.557, 5415.979, 270.4958, 278.6199), passed = false},
            {pos = vector4(1385.188, 5356.068, 322.0292, 319.8287), passed = false},
            {pos = vector4(1316.602, 5379.818, 355.9798, 53.64342), passed = false},
            {pos = vector4(1504.39, 5455.079, 378.9609, 303.2401), passed = false},
            {pos = vector4(1286.083, 5453.092, 406.1604, 266.5511), passed = false},
            {pos = vector4(1192.16, 5450.95, 437.5946, 152.3939), passed = false},
            {pos = vector4(1215.527, 5543.312, 502.9278, 274.3951), passed = false},
            {pos = vector4(898.5911, 5538.69, 583.2724, 250.6156), passed = false},
            {pos = vector4(706.3962, 5445.264, 640.4167, 333.2213), passed = false},
            {pos = vector4(509.2826, 5401.436, 670.8432, 266.9132), passed = false},
        }
    },
    {
       label = "DNX DOWNHILL (Paleto)",
       start =  vector4(342.2733, 5258.915, 645.2808, 86.31089),
       price = 6500,
       baseScore = 285000,
       pointPerSec = 750,
       speedLimit = 45,
       points = {
           {pos = vector4(272.9638, 5294.698, 619.9901, 193.2316), passed = false},
           {pos = vector4(258.1189, 5592.754, 601.6661, 60.64501), passed = false},
           {pos = vector4(411.8753, 5842.779, 551.8004, 160.0854), passed = false},
           {pos = vector4(238.0058, 5767.861, 528.6358, 276.4357), passed = false},
           {pos = vector4(107.2767, 5724.895, 498.2364, 160.5852), passed = false},
           {pos = vector4(370.0889, 5917.317, 475.1984, 310.6736), passed = false},
           {pos = vector4(261.2971, 5884.335, 448.0705, 114.6965), passed = false},
           {pos = vector4(127.3875, 5862.978, 412.9735, 298.5591), passed = false},
           {pos = vector4(241.0736, 5957.849, 376.9022, 112.1751), passed = false},
           {pos = vector4(-53.60342, 5803.153, 350.0356, 315.5145), passed = false},
           {pos = vector4(206.566, 5990.924, 331.6117, 295.8719), passed = false},
           {pos = vector4(22.2614, 5931.761, 298.6057, 136.4969), passed = false},
           {pos = vector4(-56.61521, 5902.782, 283.8918, 316.3917), passed = false},
           {pos = vector4(285.6821, 6218.287, 250.9201, 126.9467), passed = false},
           {pos = vector4(-38.30626, 5964.735, 224.3245, 140.0496), passed = false},
           {pos = vector4(69.98751, 6100.753, 198.184, 302.896), passed = false},
           {pos = vector4(390.3671, 6326.392, 161.9159, 94.91354), passed = false},
           {pos = vector4(82.28471, 6153.034, 137.2733, 126.3419), passed = false},
           {pos = vector4(-6.59749, 6142.444, 123.2905, 309.3533), passed = false},
           {pos = vector4(346.3486, 6363.279, 100.0205, 280.3758), passed = false},
           {pos = vector4(684.395, 6408.679, 64.24783, 269.5724), passed = false},
           {pos = vector4(1163.838, 6587.617, 32.20724, 289.9012), passed = false},
       }
    },
    {
        label = "DNX UPHILL (Paleto)",
        start =  vector4(1163.838, 6587.617, 32.20724, 70.9012),
        price = 6500,
        expReward = 3250,
        baseScore = 285000,
        pointPerSec = 750,
        speedLimit = 45,
        points = {
            {pos = vector4(1163.838, 6587.617, 32.20724, 289.9012), passed = false},
            {pos = vector4(684.395, 6408.679, 64.24783, 269.5724), passed = false},
            {pos = vector4(346.3486, 6363.279, 100.0205, 280.3758), passed = false},
            {pos = vector4(-6.59749, 6142.444, 123.2905, 309.3533), passed = false},
            {pos = vector4(82.28471, 6153.034, 137.2733, 126.3419), passed = false},
            {pos = vector4(390.3671, 6326.392, 161.9159, 94.91354), passed = false},
            {pos = vector4(69.98751, 6100.753, 198.184, 302.896), passed = false},
            {pos = vector4(-38.30626, 5964.735, 224.3245, 140.0496), passed = false},
            {pos = vector4(285.6821, 6218.287, 250.9201, 126.9467), passed = false},
            {pos = vector4(-56.61521, 5902.782, 283.8918, 316.3917), passed = false},
            {pos = vector4(22.2614, 5931.761, 298.6057, 136.4969), passed = false},
            {pos = vector4(206.566, 5990.924, 331.6117, 295.8719), passed = false},
            {pos = vector4(-53.60342, 5803.153, 350.0356, 315.5145), passed = false},
            {pos = vector4(241.0736, 5957.849, 376.9022, 112.1751), passed = false},
            {pos = vector4(127.3875, 5862.978, 412.9735, 298.5591), passed = false},
            {pos = vector4(261.2971, 5884.335, 448.0705, 114.6965), passed = false},
            {pos = vector4(370.0889, 5917.317, 475.1984, 310.6736), passed = false},
            {pos = vector4(107.2767, 5724.895, 498.2364, 160.5852), passed = false},
            {pos = vector4(238.0058, 5767.861, 528.6358, 276.4357), passed = false},
            {pos = vector4(411.8753, 5842.779, 551.8004, 160.0854), passed = false},
            {pos = vector4(258.1189, 5592.754, 601.6661, 60.64501), passed = false},
            {pos = vector4(272.9638, 5294.698, 619.9901, 193.2316), passed = false},
            {pos = vector4(342.2733, 5258.915, 645.2808, 86.31089), passed = false},
        }
     },
    --- RACES UNDER $10,000 REWARDS   

    --- EXP TEMPLATE
    --$1000 = expReward = 500,
    --$1500 = expReward = 750,
    --$2000 = expReward = 1000,
    --$2500 = expReward = 1250,
    --$3000 = expReward = 1500,
    --$3500 = expReward = 1750,
    --$4000 = expReward = 2000,
    --$4500 = expReward = 2250,
    --$5000 = expReward = 2500,
    --$5500 = expReward = 2750,
    --$6000 = expReward = 3000,
    --$6500 = expReward = 3250,
    --$7000 = expReward = 3500,

    --- TEMPLATE    
    -- {
    --     label = "Banham Canyon",
    --     start =  vector4(-2652.097, 1514.488, 116.7912, 331.8986),
    --     price = 6500,
    --     baseScore = 350000,
    --     pointPerSec = 750,
    --     speedLimit = 45,
    --     points = {
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --         {pos = vec, passed = false},
    --     }
    -- },
}

local baseX = 0.2 -- gauche / droite ( plus grand = droite )
local baseY = 0.2 -- Hauteur ( Plus petit = plus haut )
local baseWidth = 0.3 -- Longueur
local baseHeight = 0.03 -- Epaisseur

Citizen.CreateThread(function()
    while not loaded do Wait(1) end
    while Events == nil do Wait(1) end
    TriggerServerEvent(Events.raceData)

    while true do
        if not inRace and not p:GetCrewWarStatus() then
            local pPed = p:ped()
            local pCoords = p:pos()
            for k,v in pairs(race) do
                if #(v.start.xyz - pCoords) <= 7.0 then
                    if racesScores[v.label] ~= nil then

                        while #(v.start.xyz - p:pos()) <= 7.0 and not inRace and not p:GetCrewWarStatus() do

                            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 110, 255, 168, 255) -- Liseret
                            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
                            DrawTexts(baseX - 0.148, baseY - (0.043) - 0.013, v.label, false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
                            DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, tostring(#racesScores[v.label].scores), true, 0.35, {0, 0, 0, 255}, 6, 0) -- title
                    
                            DrawRect(baseX, baseY, baseWidth, baseHeight, 110, 255, 168, 255)
                
                            DrawTexts(baseX - 0.145, baseY - 0.013, "player", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
                            DrawTexts(baseX + 0.005, baseY - 0.013, "score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
                            DrawTexts(baseX + 0.085, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title

                            for i = 1,#racesScores[v.label].scores do
                                DrawRect(baseX, baseY + (0.032 * i), baseWidth, baseHeight, 0, 0, 0, 210)
                                DrawTexts(baseX - 0.14, baseY + (0.032 * i) - 0.013, "#"..i, true, 0.35, {255, 255, 255, 255}, 6, 0) -- place
                                DrawTexts(baseX - 0.13, baseY + (0.032 * i) - 0.013, racesScores[v.label].scores[i].name .. " - " .. racesScores[v.label].scores[i].veh, false, 0.35, {255, 255, 255, 255}, 6, 0) -- name + veh
                                DrawTexts(baseX + 0.005, baseY + (0.032 * i) - 0.013, GroupDigits(math.floor(racesScores[v.label].scores[i].points)), false, 0.35, {255, 255, 255, 255}, 6, 1) -- score
                                DrawTexts(baseX + 0.085, baseY + (0.032 * i) - 0.013, racesScores[v.label].scores[i].time.."s", false, 0.35, {255, 255, 255, 255}, 6, 1) -- score

                            end

                            Wait(1)
                        end
                    else
                        while #(v.start.xyz - p:pos()) <= 7.0 and not inRace and not player:GetCrewWarStatus() do
                            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 110, 255, 168, 255) -- Liseret
                            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
                            DrawTexts(baseX - 0.148, baseY - (0.043) - 0.013, v.label, false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
                            DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, tostring(0), true, 0.35, {0, 0, 0, 255}, 6, 0) -- title
                            
                            DrawRect(baseX, baseY, baseWidth, baseHeight, 110, 255, 168, 255)
                            DrawTexts(baseX + 0.025, baseY - 0.013, "score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
                            DrawTexts(baseX - 0.145, baseY - 0.013, "player", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
                            Wait(1)
                        end
                    end
                end
            end
        end
        Wait(500)
    end
end)

Citizen.CreateThread(function()
    while not loaded do Wait(1) end

    for k, v in pairs(race) do
        zone.addZone(v.label, v.start.xyz, "Press ~INPUT_CONTEXT~ to start the race", function() StartRace(v, k) end, true, 4, 3.0, {255, 255, 255}, 170, "markers", "finish", 0.0, 0.0, 0.0)

        -- If you un-comment this it will interfear with the new blip System
        -- AddBlip(v.start.xyz, 38, 2, 0.85, 44, v.label)
    end
end)


local blip = 0
local timeBar = nil

function StartRace(data, raceKey)
    -- Check if the player is in a vehicle
    if not IsPedInAnyVehicle(p:ped(), false) then
        ShowNotification("~r~YOU NEED TO BE IN A VEHICLE TO START THIS RACE")
        return
    end

    inRace = true
    Drift.ResetDriftCounter()
    Drift.SetInRace(true)
    SetPlayerInRace(true)
    local raceStopped = false

    SetPedCoordsKeepVehicle(p:ped(), data.start.xyz)
    SetEntityHeading(p:currentVeh(), data.start.w)
    FreezeEntityPosition(p:currentVeh(), true)
    ChangeSpeedLimit(data.speedLimit)
    TogglePasive(true)

    cam.create("CAM_1")
    cam.create("CAM_2")

    -- Countdown logic...
    local countDown = 3
    local posToGo = {
        {pos = GetOffsetFromEntityInWorldCoords(p:ped(), 0.0, 0.0, 8.0)}, -- up
        {pos = GetOffsetFromEntityInWorldCoords(p:ped(), 0.0, 8.0, 0.0)}, -- front
        {pos = GetOffsetFromEntityInWorldCoords(p:ped(), 0.0, -8.0, 5.0)}, -- back
    }

    for i = 1, 3 do
        Subtitle("Drift race in ~b~" .. countDown, 1000)
        PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)

        local rPos = vector3(0.0, 0.0, 0.0)
        if i ~= 3 then
            rPos = vector3(posToGo[i].pos.x + math.random(-1, 1), posToGo[i].pos.y + math.random(-1, 1), posToGo[i].pos.z + math.random(1, 2))
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

    blip = AddBlipForCoord(data.start.xyz)


    timeBar = NativeUI.TimerBarPool()

    local time = NativeUI.CreateTimerBar("Time:")
    time:SetTextTimerBar("30s")
    timeBar:Add(time)

    local checkpoints = NativeUI.CreateTimerBar("Checkpoints:")
    checkpoints:SetTextTimerBar("??/??")
    timeBar:Add(checkpoints)

    local distance = NativeUI.CreateTimerBar("Distance:")
    distance:SetTextTimerBar("??m")
    timeBar:Add(distance)

    for k,v in pairs(data.points) do
        SetBlipCoords(blip, v.pos.xyz)
        local timer = GetGameTimer() + 30000
        checkpoints:SetTextTimerBar(k.."/"..#data.points)
        local dst = #(v.pos.xyz - p:pos())
        while dst > 10.0 and not raceStopped and not p:GetCrewWarStatus() do
            dst = math.floor(#(v.pos.xyz - p:pos()))
            DrawMarker(5, v.pos.xyz, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 235, 229, 52, 170, 0, 1, 2, 0, nil, nil, 0)
            DrawMarker(0, v.pos.x, v.pos.y, v.pos.z + 1.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 30.0, 66, 245, 111, 170, 0, 1, 2, 0, nil, nil, 0)

            if GetGameTimer() >= timer then
                raceStopped = true
            end

            ShowHelpNotification("Press ~INPUT_CELLPHONE_CANCEL~ to cancel the drift race")
            if IsControlJustReleased(0, 177) then
                raceStopped = true

                SetPedCoordsKeepVehicle(p:ped(), data.start.xyz)
                SetEntityHeading(p:currentVeh(), data.start.w)
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

    local endPoints = Drift.GetCurrentDriftPoint()
    SetPlayerInRace(false)


    if not raceStopped and not p:GetCrewWarStatus() then
        

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




        local pVeh = p:currentVeh()
        local model = GetEntityModel(pVeh)

        TriggerServerEvent(Events.raceEnd, data.label, endPoints, GetDisplayNameFromVehicleModel(model), raceSecond)

        SetPedCoordsKeepVehicle(p:ped(), data.start.xyz)
        SetEntityHeading(p:currentVeh(), data.start.w)

        local displayResult = true
        AnimpostfxPlay("MP_Celeb_Win", -1, true)

        p:GiveMoney(endPoints / 2500 * data.price)

        local baseX = 0.5 -- gauche / droite ( plus grand = droite )
        local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
        local baseWidth = 0.3 -- Longueur
        local baseHeight = 0.03 -- Epaisseur

        while displayResult do
        
            DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 110, 255, 168, 255) -- Liseret
            DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
            DrawTexts(baseX - 0.148, baseY - (0.043) - 0.013, "FINAL SCORE", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            --DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, "#1", true, 0.35, {0, 0, 0, 255}, 6, 0) -- title
    
            DrawRect(baseX, baseY, baseWidth, baseHeight, 110, 255, 168, 255)
            DrawTexts(baseX - 0.145, baseY - 0.013, "drift score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX - 0.060, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawTexts(baseX + 0.025, baseY - 0.013, "final score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
            DrawRect(baseX, baseY + (0.032), baseWidth, baseHeight, 0, 0, 0, 210)
    
            DrawTexts(baseX - 0.145, baseY + (0.032) - 0.013, GroupDigits(driftScore), false, 0.35, {255, 255, 255, 255}, 6, 0) -- name + veh
            DrawTexts(baseX - 0.060, baseY + (0.032) - 0.013, raceSecond.."s", false, 0.35, {255, 255, 255, 255}, 6, 0) -- name + veh
            DrawTexts(baseX + 0.025, baseY + (0.032) - 0.013, GroupDigits(endPoints), false, 0.35, {255, 255, 255, 255}, 6, 1) -- score
    
            DrawRect(baseX, baseY + 0.058 + 0.035, baseWidth, baseHeight - 0.025, 110, 255, 168, 200) -- Liseret
            DrawRect(baseX, baseY + 0.043 + 0.035, baseWidth, baseHeight, 0, 0, 0, 200) -- Bannière
    
            DrawTexts(baseX, baseY + (0.065), "Final score is your drift score minus time used", true, 0.35, {255, 255, 255, 255}, 6, 1) -- score

            ShowHelpNotification("Press ~INPUT_CELLPHONE_CANCEL~ to close")
            DisableAllControlActions(0)
            if IsDisabledControlJustPressed(0, 177) then
                displayResult = false
            end
    
            if IsDisabledControlJustPressed(0, 176) then
                displayResult = false
            end
    
            if IsDisabledControlJustPressed(0, 179) then
                displayResult = false
            end
            Wait(1)
        end

        AnimpostfxStopAll()
        p:addExp(data.expReward)
        p:addExp(math.floor(endPoints / 4500))
        p:SetSucces(data.label)
        SendNUIMessage( {
            ShowSucces = true,
            label = "Race: "..data.label,
        })

        
        SendNUIMessage( {
            HideSucces = true,
        })
    else
        ShowNotification("Race cancelled ! You need to go faster !")
    end

    ChangeSpeedLimit(39)
    Citizen.CreateThread(function()
        Wait(3000)
        if not inRace then
            TogglePasive(false)
        end
    end)
    TogglePasive(false)
    inRace = false
    Drift.SetInRace(false)
end


RegisterNetEvent("drift:RefreshRacesScores")
AddEventHandler("drift:RefreshRacesScores", function(scores)
    racesScores = scores
end)



-- Citizen.CreateThread(function()
--     local displayResult = true


--     local baseX = 0.5 -- gauche / droite ( plus grand = droite )
--     local baseY = 0.5 -- Hauteur ( Plus petit = plus haut )
--     local baseWidth = 0.3 -- Longueur
--     local baseHeight = 0.03 -- Epaisseur

--     AnimpostfxPlay("MP_race_crash", -1, true)

--     local score = 85041
--     local sec = 54
--     local endPoints = (score - sec * 350)

    

--     while displayResult do
        
--         DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.02, 110, 255, 168, 255) -- Liseret
--         DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 255, 255, 255, 255) -- Bannière
--         DrawTexts(baseX - 0.148, baseY - (0.043) - 0.013, "FINAL SCORE", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         --DrawTexts(baseX + 0.135, baseY - (0.043) - 0.013, "#1", true, 0.35, {0, 0, 0, 255}, 6, 0) -- title

--         DrawRect(baseX, baseY, baseWidth, baseHeight, 110, 255, 168, 255)
--         DrawTexts(baseX - 0.145, baseY - 0.013, "drift score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawTexts(baseX - 0.060, baseY - 0.013, "time", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawTexts(baseX + 0.025, baseY - 0.013, "final score", false, 0.35, {0, 0, 0, 255}, 2, 0) -- title
--         DrawRect(baseX, baseY + (0.032), baseWidth, baseHeight, 0, 0, 0, 210)

--         DrawTexts(baseX - 0.145, baseY + (0.032) - 0.013, GroupDigits(score), false, 0.35, {255, 255, 255, 255}, 6, 0) -- name + veh
--         DrawTexts(baseX - 0.060, baseY + (0.032) - 0.013, sec.."s", false, 0.35, {255, 255, 255, 255}, 6, 0) -- name + veh
--         DrawTexts(baseX + 0.025, baseY + (0.032) - 0.013, GroupDigits(endPoints), false, 0.35, {255, 255, 255, 255}, 6, 1) -- score

--         DrawRect(baseX, baseY + 0.058 + 0.035, baseWidth, baseHeight - 0.025, 110, 255, 168, 200) -- Liseret
--         DrawRect(baseX, baseY + 0.043 + 0.035, baseWidth, baseHeight, 0, 0, 0, 200) -- Bannière

--         DrawTexts(baseX, baseY + (0.065), "Final score is your drift score minus time used", true, 0.35, {255, 255, 255, 255}, 6, 1) -- score
        
--         ShowHelpNotification("Press ~INPUT_CELLPHONE_CANCEL~ to close")

--         DisableAllControlActions(0)
--         if IsDisabledControlJustPressed(0, 177) then
--             displayResult = false
--         end

--         if IsDisabledControlJustPressed(0, 176) then
--             displayResult = false
--         end

--         if IsDisabledControlJustPressed(0, 179) then
--             displayResult = false
--         end
--         Wait(1)
--     end
--     AnimpostfxStopAll()
    
-- end)