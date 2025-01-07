if not Framework.ESX() then return end

local ESX = exports["es_extended"]:getSharedObject()



-- =============================================================================
-- Début du code au dessous juste pour compatibilité générique
-- =============================================================================

function RegisterCommandFramework(commandName, callback)
    ESX.RegisterCommand(commandName, "admin", function(xPlayer)
        callback(xPlayer)
    end, true)
end


RegisterCommandFramework("ton_raycast", function(player)
    -- Envoi d'un événement pour ESX
    player.triggerEvent("ton_raycast:show")
    
end)