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

dependency 'es_extended'