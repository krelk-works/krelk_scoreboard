fx_version 'bodacious'
game 'gta5'

author 'You'
version '1.0.0'

ui_page 'html/main.html'

files {
    'html/*.*',
}

client_script 'client.lua'
server_script 'server.lua'
shared_scripts {
    'shared.lua',
    '@es_extended/imports.lua'
}

