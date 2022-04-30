resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'MEETA Advance Craft'

version '1.0.0'

ui_page 'html/ui.html'

client_scripts {
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua'
}

files {
    'html/ui.html',
    'html/css/materialize.css',
    'html/css/ui.css',
	'html/js/jquery.min.js',
    'html/js/scripts.js',
    'html/js/materialize.min.js',
    -- IMAGES
    'html/img/bullet.png'
}