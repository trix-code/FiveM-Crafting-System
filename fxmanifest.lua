
fx_version "cerulean"
game "gta5"
lua54 "yes"
shared_script {
	'@es_extended/imports.lua',
	"config.lua",
	'@ox_lib/init.lua'
}
server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"server.lua",
}
client_scripts {
	"config.lua",
	"client.lua"
}

escrow_ignore {
    'config.lua',
  }
