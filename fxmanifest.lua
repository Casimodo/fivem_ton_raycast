-- fx_version 'cerulean'
-- game 'gta5'
-- lua54 'yes'

-- name "ton_raycast"
-- description "Permet d'avoir pour les admin fiveM un rayon pour avoir les coordonnées, rotation, distance qui renvoi un copié/collé"
-- author "tontonCasi@twitch"
-- version "0.0.1"

-- client_script {
--   	"client/*.lua",
-- }

-- server_script {
-- 	"server/*.lua",
-- }

-- shared_script {
--    "shared/config.lua",
--    '@es_extended/imports.lua',
-- }

-- ui_page 'html/index.html'

-- files {
--     'html/js/val_copy.js',
--     'html/index.html'
-- }

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "ton_raycast"
description "Outil admin pour obtenir des coordonnées, rotations et distances en un clic avec copier-coller."
author "tontonCasi@twitch"
version "0.0.2"

-- Page HTML pour l'interface utilisateur
ui_page 'html/index.html'

-- Fichiers nécessaires pour l'interface utilisateur
files {
    'html/js/val_copy.js',
    'html/index.html'
}

-- Scripts partagés entre client et serveur
shared_scripts {
    'shared/config.lua',           -- Fichier de configuration commun
    --'@es_extended/imports.lua',    -- Inclus uniquement si ESX est utilisé
    '@ox_lib/init.lua',            -- Inclus pour les fonctionnalités avancées si disponible
}

-- Scripts client
client_scripts {
    'client/*.lua',                -- Scripts spécifiques au client
}

-- Scripts serveur
server_scripts {
    'server/*.lua',                -- Scripts spécifiques au serveur
}

-- Dépendances nécessaires selon le framework utilisé
dependencies {
    --'es_extended',  -- Pour ESX
    'qb-core',      -- Pour QBcore
    'oxmysql',      -- Base de données utilisée par ESX/QBcore
}
