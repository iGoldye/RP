resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Sosamba UI'
version '0.1.0'

files {
  'html/index.html',
  'html/vue.js',
  'html/app.js',
  'html/app.css',
  'html/notification-colors.css',
  'html/fonts/opensans-regular.ttf',
  'html/fonts/opensans-semibold.ttf',
}

server_scripts {
  'server/main.lua'
}

client_scripts {
  'client/main.lua'
}

ui_page 'html/index.html'
