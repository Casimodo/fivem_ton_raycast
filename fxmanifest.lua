fx_version "cerulean"
game "gta5"

name "ton_raycast"
description "Outil admin pour obtenir des coordonnées, rotations et distances en un clic avec copier-coller."
author "tontonCasi@twitch"
version "1.0.0"

lua54 "yes"

client_scripts {
    "client/framework/esx/main.lua",
    "client/framework/qb/main.lua",
    "client/functions.lua",
    "client/client.lua"
}

server_scripts {
    "server/framework/esx/main.lua",
    "server/framework/qb/main.lua"
}

shared_scripts {
    "shared/config.lua",
    "shared/framework/framework.lua",
    --"@ox_lib/init.lua"
}

files {
    "html/js/val_copy.js",
    "html/index.html"
}

ui_page "html/index.html"
