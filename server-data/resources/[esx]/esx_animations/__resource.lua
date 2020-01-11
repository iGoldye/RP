resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Animations'

version '1.0.0'

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/extra_anims.lua'
}

server_scripts {
	'server/main.lua',
}

ui_page 'html/ui.html'

files {
	'html/img/*.png',
	'html/img/icons/*.png',
	'html/img/icons/menus/*.png',
	'html/ui.html',
	'html/roboto.ttf',
	'html/css/app.css',
	'html/scripts/app.js'
}

dependency 'es_extended'