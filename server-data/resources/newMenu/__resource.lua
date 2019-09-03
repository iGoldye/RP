resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'@es_extended/client/wrapper.lua',
	'client.lua'
}

ui_page {
	'index.html'
}

files {
	'sourceCode/dist/index.html',
	'sourceCode/dist/assets/css/app.css',
	'sourceCode/dist/assets/js/app.js'
}

dependencies {
	'es_extended'
}
