-- ESX.RegisterCommand("ton_raycast", "admin", function(xPlayer, args)

-- 	xPlayer.triggerEvent("ton_raycast:show")

-- end, true)


-- Détection automatique du framework
local Framework = nil

CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        Framework = "ESX"
        ESX = exports['es_extended']:getSharedObject()
    elseif GetResourceState('qbx_core') == 'started' then
        Framework = "Qbox"
        --Qbox = exports['qbx_core']
        Qbox = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('qb-core') == 'started' then
        Framework = "QBcore"
        QBCore = exports['qb-core']:GetCoreObject()
    else
        Framework = "inc"
        print("^3Framework non détecté, utilisation par défaut : Error !")
    end

    print("^2Framework détecté : " .. (Framework or "Aucun") .. "^0")
end)

function EnsureFrameworkLoaded()
    while Framework == nil do
        print("^3En attente de la détection du framework...^0")
        Wait(100)
    end
end

-- Fonction pour enregistrer la commande en fonction du framework
local function RegisterCommandFramework(commandName, permission, callback)

	EnsureFrameworkLoaded() -- Attente jusqu'à ce que le framework soit chargé

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
RegisterCommandFramework("ton_raycast", "admin", function(player)
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
