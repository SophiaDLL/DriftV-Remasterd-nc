--[[ 
    Blip Info Documentation Example
    All available options and configurations
    
    Blip Types (setType):
    0 = Standard (no icon)
    1 = Rockstar Verified
    2 = Rockstar Created
    
    Component Types:
    "basic"      = Simple title/value pair
    "icon"       = Title/value with icon and optional tick
    "social"     = Social Club specific component
    "divider"    = Horizontal line separator
    "description"= Multi-line text block



local blip = AddBlipForCoord(-123.6383, 562.4001, 196.0399)
SetBlipSprite(blip, 545)
SetBlipDisplay(blip, 4)
SetBlipScale(blip, 0.9)
SetBlipColour(blip, 47)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Mountain Drift Circuit")
EndTextCommandSetBlipName(blip)

local info = {
    setTitle = "Mountain Drift Circuit",  -- Header title
    setType = 0,                         -- Rockstar Verified style


    setTexture = {                       -- Custom image
        dict = "kblipinfo",        -- Texture dictionary
        name = "kcore"         -- Texture name
    },

    -- You can also use DUI textures
    -- setTexture = {
    --     url = "https://i.pinimg.com/originals/89/5c/e7/895ce751ba0379700381d17a67086931.gif",  -- image URL
    --     width = 498,    -- specify custom width (should be width of the image)
    --     height = 427    -- specify custom height (should be height of the image)
    -- },

    -- Reward Texts (Top right, optional)
    setCashText = "$25,000",             -- Cash reward
    setApText = "2500",                  -- Action points
    setRpText = "5000",                  -- RP reward


    -- Description Components
    components = {
           -- Icon Component Example
        {
            type = "icon",
            title = "Track Type",
            value = "Drift Course",
            iconIndex = 2,
            iconHudColor = 1,
            isTicked = false
        },

       -- Stat example
        {
            type = "basic",
            title = "Personal Best",
            value = "85,432 points",
        },

        -- Social Component Example 
        {
            type = "social",
            title = "Creator",
            value = "Kypos x Loki x Jordanpkl(EGG)",
            isSocialClubName = false, -- show rockstar icon next to the name
            crew = {
                tag = "KYPO",
                isPrivate = true, -- false triangle shape, true square shape
                isRockstar = true, -- shows R* icon
                lvl = 3, -- isPrivate needs to be true, values from 0-5, 0 is full bar, 5 is no bar
                lvlColor = "#00FFBF" -- Color of the lvl bar
            }
        },

        -- Divider Component
        {
            type = "divider"             --Basically just a line
        },

        {
            type = "description",        -- multi-line text
            value = "A challenging mountain course featuring tight hairpins and technical sections."
        },

        -- stat with icon
        {
            type = "basic",
            title = "Track Length",
            value = "2.3 miles",
        },

        -- state no icon
        {
            type = "basic",
            title = "Elevation Change",
            value = "850 ft",

        }
    }
}


exports['kBlipInfo']:UpdateBlipInfo(blip, info)

--]]
