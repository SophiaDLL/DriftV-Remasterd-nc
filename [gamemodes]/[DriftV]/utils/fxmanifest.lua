fx_version 'cerulean'
games { 'gta5' }

name 'RageUI'


ui_page 'html/index.html'


files {
	'html/index.html',
	'html/jquery.js',
    'html/init.js',
}

client_scripts {
    '2Step/client.lua',
}


server_scripts {
    '2Step/server.lua',
}

ui_page('2Step/html/index.html')

client_scripts {
    '2Step/config/config.lua',
    '2Step/client.lua'
}

server_script '2Step/server.lua'

files {
    '2Step/html/index.html',
    '2Step/html/sounds/**'
}
