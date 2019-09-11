resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Extra admin commands'

version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/en.lua',
	'server/main.lua',
}

dependencies {}

exports {}