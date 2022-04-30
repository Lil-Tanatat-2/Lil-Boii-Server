resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Farmer Job by PKS.in.TH'

version '2.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/grass.lua'
}

dependencies {
	'es_extended'
}