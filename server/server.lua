-- ESX.RegisterCommand("ton_raycast", "admin", function(xPlayer, args)

-- 	xPlayer.triggerEvent("ton_raycast:show")

-- end, true)


-- Détection automatique du framework
local Framework = Config.Framework

if Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
elseif Framework == "Qbox" then
    --Qbox = exports['qbx_core']
    Qbox = exports['qb-core']:GetCoreObject()
elseif Framework == "QBcore" then
    QBCore = exports['qb-core']:GetCoreObject()
else
    Framework = "inc"
    print("^3Framework non détecté, utilisation par défaut : Error !")
end
print("^2Framework config : " .. (Framework or "Aucun") .. "^0")

-- Fonction pour enregistrer la commande en fonction du framework
local function RegisterCommandFramework(commandName, permission, callback)

    if ESX then
        -- ESX
        ESX.RegisterCommand(commandName, permission, function(xPlayer, args)
            callback(xPlayer)
        end, true)
    elseif QBCore then
        -- QBCore
        QBCore.Commands.Add(commandName, permission, {}, false, function(source, args)
            local Player = QBCore.Functions.GetPlayer(source)
            callback(Player)
        end)
    elseif Qbox then
        -- Qbox
        Qbox.Commands.Add(commandName, permission, {}, false, function(source, args)
            callback(source) -- Pour Qbox, tu peux utiliser directement le `source`
        end)
    else
        print("^1Erreur : Framework non détecté !^0")
    end
end

-- Appel de la fonction pour enregistrer la commande
RegisterCommandFramework("ton_raycast", "", function(player)
    if ESX then
        -- Envoi d'un événement pour ESX
        player.triggerEvent("ton_raycast:show")
    elseif QBCore then
        -- Envoi d'un événement pour QBcore
        TriggerClientEvent("ton_raycast:show", player.PlayerData.source)
    elseif Qbox then
        -- Envoi d'un événement pour Qbox
        TriggerClientEvent("ton_raycast:show", player)
    end
end)
