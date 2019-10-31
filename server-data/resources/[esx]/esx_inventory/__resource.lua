resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Inventory'

version '1.4.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'db_wrapper.lua',
	'locales/en.js',
	'common.js',
	'config.weapons.js',
	'server/classes/item.js',
	'server/classes/items/Item_Abstract.js',
	'server/classes/items/Item_BankMoney.js',
	'server/classes/items/Item_BlackMoney.js',
	'server/classes/items/Item_ESX.js',
	'server/classes/items/Item_Money.js',
	'server/classes/items/Item_Weapon.js',
	'server/classes/items/Item_EquippedWeapon.js',
	'server/classes/items/Item_CarKey.js',
	'server/classes/items/Item_HouseKey.js',
	'server/classes/inventory.js',
	'server/main.js',
	'server/pickups.js',
	'server/actions.js',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
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
server_export 'registerItem'
server_export 'createItem'
server_export 'findItem'
server_export 'addItem'

dependency 'es_extended'
