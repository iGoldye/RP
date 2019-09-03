resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Inventory'

version '1.4.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'config.weapons.lua',
	'common.lua',
	'server/classes/item.lua',
	'server/classes/inventory.lua',
	'server/main.lua',
	'server/actions.lua',
	'server/pickups.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'config.weapons.lua',
	'common.lua',
	'client/main.lua',
	'client/actions.lua',
	'client/pickups.lua',
}

exports {
	'getItemActions',
	'runItemAction',
	'registerItemAction',
}

server_export 'getInventory'
server_export 'getItemLabel'
server_export 'giveItemTo'

dependency 'es_extended'
