fx_version 'cerulean'
game {'gta5'}

author 'lilfraae'
description 'Farm drugs way easier then noemal'
version '1.0.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/drugs/*.lua',
    'server/sv_script.lua',
    'config.lua'
}

client_scripts {
    'client/drugs/*.lua',
    'client/cl_script.lua',
    'config.lua'
}

shared_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua'
}

dependencies {
	'es_extended'
}