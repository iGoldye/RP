resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "index.html"

-- Example custom radios
supersede_radio "RADIO_05_TALK_01" { url = "http://uk1.internet-radio.com:8294/live", volume = 0.4, name = 'Bloods' }
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "http://edge3.peta.live365.net/b77280_128mp3", volume = 0.4, name = 'Aardvark Blues FM' }
supersede_radio "RADIO_13_JAZZ" { url = "http://airspectrum.cdnstream1.com:8078/1614_192", volume = 0.4, name = 'Smooth Jazz New York City' }
supersede_radio "RADIO_02_POP" { url = "http://gr01.cdnstream.com:8290/", volume = 0.4, name = 'Pop 100Hitz' }
supersede_radio "RADIO_16_SILVERLAKE" { url = "http://cast.magicstreams.gr:9125/;stream.nsv", volume = 0.4, name = 'Psyndora Chillout' }
supersede_radio "RADIO_18_90S_ROCK" { url = "http://curiosity.shoutca.st:6383/;stream.nsv", volume = 0.4, name = 'Neo Radio' }
supersede_radio "RADIO_07_DANCE_01" { url = "http://204.12.193.98:8415/listen.pls?sid=1", volume = 0.4, name = 'Jang Dong K-Pop' }
supersede_radio "RADIO_06_COUNTRY" { url = "http://us3.internet-radio.com:8297/stream", volume = 0.4, name = 'The Ranch Rebel' }
--supersede_radio "RADIO_02_POP" { url = "https://revolutionradio.ru:8443/live.ogg", volume = 0.2 }
--supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://stream.radioreklama.bg/nrj.ogg", volume = 0.2 }

files {
	"index.html"
}

client_scripts {
	"data.js",
	"client.js"
}
