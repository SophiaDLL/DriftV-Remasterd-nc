-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

version '1.0.0'
author 'Cfx.re <root@cfx.re>'
description 'Provides baseline chat functionality using a NUI-based interface.'
repository 'https://github.com/citizenfx/cfx-server-data'

lua54 'yes'
ui_page 'dist/ui.html'

client_script 'cl_chat.lua'
server_script 'sv_chat.lua'

files {
  'dist/ui.html',
  'dist/index.css',
  'html/vendor/*.css',
  'html/vendor/fonts/*.woff2',
}

fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

dependencies {
  'yarn',
  'webpack'
}

webpack_config 'webpack.config.js'

server_script 'theme/server/main.lua'
client_script 'theme/client/main.lua'

file 'theme/style.css'

chat_theme 'ccChat' {
    styleSheet = 'theme/theme/style.css',
    msgTemplates = {
        ccChat = '<div id="notification" class="noisy"><div id="color-box" style="background-color: {0} !important;" class="noisy"></div><div id="info"><div id="top-info"><div id="left-info"><h1 id="title"><i class="{1}"></i></h1><h2 id="sub-title">{2}</h2></div><h2 id="time">{3}</h2></div><div id="bottom-info"><br><p id="text">{4}</p></div></div>'
    }
}

exports {
    'getTimestamp'
}

