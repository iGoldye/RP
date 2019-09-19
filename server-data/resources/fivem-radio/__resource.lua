resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "index.html"

-- Example custom radios
supersede_radio "RADIO_05_TALK_01" { url = "http://uk1.internet-radio.com:8294/live", volume = 0.4 }
--supersede_radio "RADIO_02_POP" { url = "https://revolutionradio.ru:8443/live.ogg", volume = 0.2 }
--supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://stream.radioreklama.bg/nrj.ogg", volume = 0.2 }

files {
	"index.html"
}

client_scripts {
	"data.js",
	"client.js"
}
