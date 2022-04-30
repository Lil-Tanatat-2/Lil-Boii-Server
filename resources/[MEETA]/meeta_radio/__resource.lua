resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Shops'

version '1.1.0'

ui_page 'html/ui.html'

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}

files {
	'html/img/radio.png',
    'html/ui.html',
    'html/css/materialize.css',
	'html/css/ui.css',
	'html/dev/getHTMLMediaElement.css',
	-- JS
	'html/js/jquery.min.js',
	'html/js/scripts.js',
	-- VoiceRTC
	'html/js/RTCMultiConnection.min.js',
	'html/dev/getHTMLMediaElement.js',
	-- Sound
	'html/sound/off.mp3',
	'html/sound/on.mp3',
}
