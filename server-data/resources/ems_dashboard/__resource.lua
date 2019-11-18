resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Emergency service Vue.js dashboard'
version '0.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/server.lua',
}

client_scripts {
	'client/client.lua',
	'config.lua',
}

files {
	'html/img/monitor.png',
	'html/ui.html',
}

ui_page 'html/ui.html'
