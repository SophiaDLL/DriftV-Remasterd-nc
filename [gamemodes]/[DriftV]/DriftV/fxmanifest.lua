fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "client/web/hud.html"

files {
    "client/web/hud.html",
    "client/web/js/hud.js",
    "client/web/css/hud.css",
    "client/web/fonts/Oswald-Light.eot",
    "client/web/fonts/Oswald-Light.svg",
    "client/web/fonts/Oswald-Light.ttf",
    "client/web/fonts/Oswald-Light.woff",
    "client/web/fonts/Oswald-Light.woff2",
    "client/web/fonts/Oswald-Regular.eot",
    "client/web/fonts/Oswald-Regular.svg",
    "client/web/fonts/Oswald-Regular.ttf",
    "client/web/fonts/Oswald-Regular.woff",
    "client/web/fonts/Oswald-Regular.woff2",
    "client/web/images/*.png",
}

client_scripts {
    "@drift-extra-assets/src/NativeUIReloaded.lua",
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    "config_cl.lua",
    "client/_security/*.lua",
    "client/class/*.lua",
    "client/gameplay/**/*.lua",
    "client/playerStuff/*.lua",
    "client/shop/*.lua",
    "client/module/*.lua",
    "client/*.lua"
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "config_sv.lua",
    "server/_security/*.lua",
    "server/class/*.lua",
    "server/crew/*.lua",
    -- "server/discord/*.lua",
    "server/*.lua"
}
