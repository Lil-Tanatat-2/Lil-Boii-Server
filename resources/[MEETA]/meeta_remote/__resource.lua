resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

client_scripts {
	"config.lua",
    "client/client.lua"
}

server_scripts {
    "config.lua",
    "server/server.lua"
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/sounds/lock.ogg',
    'html/sounds/unlock.ogg'
}