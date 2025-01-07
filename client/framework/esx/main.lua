if not Framework.ESX() then return end

if Config.debug then
    print("^2DEBUG : Framework ESX détecté !^0")
end

local ESX = exports["es_extended"]:getSharedObject()
Framework.PlayerData = nil

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    Framework.PlayerData = xPlayer
    client.job = Framework.PlayerData.job
    client.gang = Framework.PlayerData.gang
    client.citizenid = Framework.PlayerData.identifier
end)

RegisterNetEvent("esx:onPlayerLogout", function()
    Framework.PlayerData = nil
end)

RegisterNetEvent("esx:setJob", function(job)
	Framework.PlayerData.job = job
    client.job = Framework.PlayerData.job
    client.gang = Framework.PlayerData.job
end)






-- =============================================================================
-- Début du code au dessous juste pour compatibilité générique
-- =============================================================================

-- Envoi d'une notification (compatible avec plusieurs frameworks)
function SendNotification(type, message)
    ESX.ShowNotification(message, type, 5000)
end
