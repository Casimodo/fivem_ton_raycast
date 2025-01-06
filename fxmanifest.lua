fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "ton_raycast"
description "Permet d'avoir pour les admin fiveM un rayon pour avoir les coordonnées, rotation, distance qui renvoi un copié/collé"
author "tontonCasi@twitch"
version "0.0.1"

client_script {
  	"client/*.lua",
}

server_script {
	"server/*.lua",
}

shared_script {
   "shared/config.lua",
   '@es_extended/imports.lua',
}

ui_page 'html/index.html'

files {
    'html/js/val_copy.js',
    'html/index.html'
}