resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'@es_extended/client/wrapper.lua',
	'client.lua'
}

ui_page {
	'dist/index.html'
}

files {
	'dist/index.html',
	'dist/assets/css/app.css',
	'dist/assets/js/app.js'
}

dependencies {
	'es_extended'
}
