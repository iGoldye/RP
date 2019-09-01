resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Sosamba UI'
version '0.1.0'

--[[
files {
  'html/index.html',
  'html/vue.js',
  'html/app.js',
  'html/app.css',
  'html/notification-colors.css',
  'html/fonts/opensans-regular.ttf',
  'html/fonts/opensans-semibold.ttf',
}
]]--

files {
	'html/js/app.js',
	'html/css/app.css',
	'html/css/chunk-vendors.css',
	'html/chunk-vendors.bundle.js',
	'html/favicon.ico',
	'html/index.html',

	'html/app.js',
	'html/vendors~app.bundle.js',
}

server_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'config.lua',
  'server/main.lua',
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'config.lua',
  'client/main.lua',
}

ui_page 'html/index.html'
