fx_version 'cerulean'
game 'gta5'

name "k4_moneywash"
description "A ESX Moneywash Script by k4."
author "K4.dev"
version "1.0.0"

shared_scripts {
	'@es_extended/imports.lua',
	'shared/*.lua',
	'@es_extended/locale.lua',
}

client_scripts {
	'client/*.lua',
	'locales/*.lua'	
}

server_scripts {
	'server/*.lua',
	'locales/*.lua'
}

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/script.js',
	'nui/style.css',
	'nui/images/*.png'
}
