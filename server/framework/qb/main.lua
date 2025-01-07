if not Framework.QBCore() then return end

local QBCore = exports["qb-core"]:GetCoreObject()




-- =============================================================================
-- Début du code au dessous juste pour compatibilité générique
-- =============================================================================

function RegisterCommandFramework(commandName, callback)
    QBCore.Commands.Add(commandName, "group.admin", {}, false, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        callback(Player)
    end)
end

RegisterCommandFramework("ton_raycast", function(player)
    TriggerClientEvent("ton_raycast:show", player.PlayerData.source)
end)