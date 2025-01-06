-- function InstructionButton(ControlButton)
--     ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
-- end

-- function InstructionButtonMessage(text)
--     BeginTextCommandScaleformString("STRING")
--     AddTextComponentScaleform(text)
--     EndTextCommandScaleformString()
-- end

-- function InstructionalButton(controlButton, text)
--     ScaleformMovieMethodAddParamPlayerNameString(controlButton)
--     BeginTextCommandScaleformString("STRING")
--     AddTextComponentScaleform(text)
--     EndTextCommandScaleformString()
-- end

function CreateInstuctionScaleformCustom(scaleform, keys)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    ---------------------------------------------------------------------------------
    for k, v in pairs(keys) do     
        InstructionalButton(GetControlInstructionalButton(0, v.Key, 1), v.Text)
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(k)       
    end
    ---------------------------------------------------------------------------------
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    SetScaleformMovieAsNoLongerNeeded()
    return scaleform
end

-- function RotationToDirection(rotation)
--     local adjustedRotation = 
--     { 
--         x = (math.pi / 180) * rotation.x, 
--         y = (math.pi / 180) * rotation.y, 
--         z = (math.pi / 180) * rotation.z 
--     }
--     local direction = 
--     {
--         x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
--         y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
--         z = math.sin(adjustedRotation.x)
--     }
--     return direction
-- end

function RayCastGamePlayCamera(distance)
    -- Checks to see if the Gameplay Cam is Rendering or another is rendering (no clip functionality)
    local currentRenderingCam = false
    if not IsGameplayCamRendering() then
        currentRenderingCam = GetRenderingCam()
    end

    local cameraRotation = not currentRenderingCam and GetGameplayCamRot() or GetCamRot(currentRenderingCam, 2)
    local cameraCoord = not currentRenderingCam and GetGameplayCamCoord() or GetCamCoord(currentRenderingCam)
    local direction = RotationToDirection(cameraRotation)
    local destination =    {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local _, b, c, _, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))

    return b, c, e
end

local function ListVehicleBones(vehicle)
    if not DoesEntityExist(vehicle) then
        print("Véhicule non valide")
        return
    end

    -- Liste des noms d'os fournie
    local boneNames = {
        "chassis",  
        "windscreen",  
        "seat_pside_r",  
        "seat_dside_r",  
        "bodyshell",  
        "suspension_lm",  
        "suspension_lr",  
        "platelight",  
        "attach_female",  
        "attach_male",  
        "bonnet",  
        "boot",  
        "chassis_dummy",  
        "chassis_Control",  
        "door_dside_f",  
        "door_dside_r",  
        "door_pside_f",  
        "door_pside_r",  
        "Gun_GripR",  
        "windscreen_f",  
        "platelight",  
        "VFX_Emitter",  
        "window_lf",  
        "window_lr",  
        "window_rf",  
        "window_rr",  
        "engine",  
        "gun_ammo",  
        "ROPE_ATTATCH",  
        "wheel_lf",  
        "wheel_lr",  
        "wheel_rf",  
        "wheel_rr",  
        "exhaust",  
        "overheat",  
        "misc_e",  
        "seat_dside_f",  
        "seat_pside_f",  
        "Gun_Nuzzle",  
        "seat_r"
    }

    local bonesFound = {}

    for _, boneName in ipairs(boneNames) do
        -- Obtenir l'index de l'os à partir de son nom
        local boneIndex = GetEntityBoneIndexByName(vehicle, boneName)
        
        if boneIndex ~= -1 then
            table.insert(bonesFound, {name = boneName, index = boneIndex})
        end
    end

    -- Retourne la liste complète des os trouvés
    return bonesFound
end

-- function StartLineCreate()
   
--     CreateThread(function()
        
--         local LockCoords
--         local InGetLock = true
--         local propHash = nil
--         local propName = nil
--         local oldPropName = nil
--         local distance = 0 
--         local disanceCoord = nil 
--         local disanceMsg = "Appuyer pour reset une distance" 
--         while InGetLock do
        
--             if disanceCoord ~= nil then
--                 local distPlayerCoords = GetEntityCoords(PlayerPedId())
--                 distance = #(distPlayerCoords - disanceCoord)
--                 disanceMsg = "Distance de " .. tostring(distance) 
--             end
        
--             local KeysTabl = {{Text = 'Arrêter', Key = 194}, {Text = 'Copier infos Hash + Name', Key = 25}, {Text = 'Copier coordonées', Key = 24}, {Text = 'Récupère les Bones de la cible', Key = 29}, {Text = disanceMsg, Key = 173}}
--             DrawScaleformMovieFullscreen(CreateInstuctionScaleformCustom("instructional_buttons", KeysTabl), 255, 255, 255, 255, 0)

--             if Canceled then 
--                 Canceled = false 
--                 InGetLock = false 
--                 return 
--             end

--             local Toch, Coords, Entity = RayCastGamePlayCamera(100.0)

--             -- Vérifie si l'entité touchée est un props
--             if DoesEntityExist(Entity) and (GetEntityType(Entity) == 1 or GetEntityType(Entity) == 2 or GetEntityType(Entity) == 3) then
--                 -- C'est un props, récupère son ID, son hash et son nom
--                 local propId = Entity
--                 if (GetEntityModel(propId) ~= nil) then
--                     propHash = GetEntityModel(propId)
--                     propName = GetEntityArchetypeName(Entity) -- Cette fonction renvoie parfois des noms abrégés ou des hash
--                     if (GetEntityType(Entity) == 2) then
--                         propName = GetDisplayNameFromVehicleModel(propHash) -- Cette fonction renvoie parfois des noms abrégés ou des hash
--                     end 

--                     if (oldPropName ~= propName) then
--                         TriggerEvent("ESX:Notify", "info", 5000, "props:" .. json.encode(propName))
--                         oldPropName = propName
--                     end
--                 end
--             end

--             local pCoords = GetEntityCoords(PlayerPedId())
--             local Color = {r = 0, g = 255, b = 0, a = 200}
--             if Toch then
--                 DrawLine(pCoords.x, pCoords.y, pCoords.z, Coords.x, Coords.y, Coords.z, Color.r, Color.g, Color.b, Color.a)
--                 DrawMarker(28, Coords.x, Coords.y, Coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, Color.r, Color.g, Color.b, Color.a, false, true, 2, nil, nil, false)
--                 if IsDisabledControlJustPressed(0, 194) then
--                     LockCoords = Coords
--                     InGetLock = false
--                 end
--                 if IsDisabledControlJustPressed(0, 24) then
--                     local message = "" .. Coords.x ..", ".. Coords.y ..", ".. Coords.z
--                     print("Cords point vers: " .. message)
--                     SendNUIMessage({
--                         action = "copyToClipboard",
--                         value = message
--                     })
--                     TriggerEvent("ESX:Notify", "info", 5000, "Tu viens de copier les coordonées</br>Utilise le coller de windows pour récupérer les valeurs !")
--                 end
--                 if IsDisabledControlJustPressed(0, 25) then
--                     local message = "propHash: " .. json.encode(propHash) .. "\rpropName: " .. json.encode(propName)
--                     print("Cords point vers: " .. message)
--                     SendNUIMessage({
--                         action = "copyToClipboard",
--                         value = message
--                     })
--                     TriggerEvent("ESX:Notify", "info", 5000, "Tu viens de copier les infos de l'objet</br>Utilise le coller de windows pour récupérer les valeurs !")
--                 end
--                 if IsDisabledControlJustPressed(0, 173) then
                    
--                     if disanceCoord == nil then
--                         TriggerEvent("ESX:Notify", "info", 5000, "Tu viens de prendre un point reset de distance")
--                     else
--                         TriggerEvent("ESX:Notify", "info", 5000, "Copie distance et rotation + Reset de distance")
--                         SendNUIMessage({
--                             action = "copyToClipboard",
--                             value = "Distance : " .. tostring(distance) .. " / rotation : " .. tostring(GetEntityHeading(PlayerPedId()))
--                         })
--                     end
--                     disanceCoord = GetEntityCoords(PlayerPedId())
--                 end

--                 if IsDisabledControlJustPressed(0, 29) then
                
--                     local playerPed = PlayerPedId()
--                     local vehicle = GetVehiclePedIsIn(playerPed, false)
--                     if vehicle ~= 0 then
--                         local bonesList = ListVehicleBones(vehicle)
--                         SendNUIMessage({
--                             action = "copyToClipboard",
--                             value = "Bones List : " .. json.encode(bonesList, {indent=true})
--                         })
--                         TriggerEvent("ESX:Notify", "info", 5000, "Bones copier")
--                     else
--                         TriggerEvent("ESX:Notify", "info", 5000, "Vous devez être dans un véhicules")
--                     end

--                 end

--             end         
--             Wait(0)
--         end

--     end)

-- end


-- RegisterNetEvent('ton_raycast:show')
-- AddEventHandler("ton_raycast:show", function()
   
--     print("Mode Raycast : ON")
--     StartLineCreate()
   
-- end)


local Framework = nil

-- Détecte automatiquement le framework utilisé
CreateThread(function()
    if ESX ~= nil then
        Framework = "ESX"
    elseif QBCore ~= nil then
        Framework = "QBcore"
    elseif Qbox ~= nil then
        Framework = "Qbox"
    else
        print("^1Erreur : Aucun framework détecté !^0")
    end
end)

-- Envoi d'une notification (compatible avec plusieurs frameworks)
local function SendNotification(type, message)
    if Framework == "ESX" then
        TriggerEvent("ESX:Notify", type, 5000, message)
    elseif Framework == "QBcore" then
        TriggerEvent("QBCore:Notify", message, type)
    elseif Framework == "Qbox" then
        TriggerEvent("Qbox:Notify", type, message)
    else
        print("^1Notification : " .. message .. "^0")
    end
end

-- Fonction pour enregistrer la commande selon le framework
local function RegisterCommandFramework(commandName, callback)
    if Framework == "ESX" then
        ESX.RegisterCommand(commandName, "admin", function(xPlayer)
            callback(xPlayer)
        end, true)
    elseif Framework == "QBcore" then
        QBCore.Commands.Add(commandName, "Admin command", {}, false, function(source)
            local Player = QBCore.Functions.GetPlayer(source)
            callback(Player)
        end)
    elseif Framework == "Qbox" then
        Qbox.Commands.Register(commandName, "admin", {}, function(source)
            callback(source)
        end)
    else
        print("^1Erreur : Framework non détecté !^0")
    end
end

-- Gestion du mode Raycast
local function StartRaycastMode()
    CreateThread(function()
        local lockCoords = nil
        local inRaycastMode = true
        local props = { hash = nil, name = nil }
        local distanceCoord = nil
        local distanceMessage = "Appuyer pour réinitialiser une distance"

        while inRaycastMode do
            -- Gestion de la distance
            if distanceCoord then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - distanceCoord)
                distanceMessage = "Distance : " .. tostring(distance)
            end

            -- Création des boutons d'instruction
            local keysTable = {
                { Text = "Arrêter", Key = 194 },
                { Text = "Copier infos Hash + Name", Key = 25 },
                { Text = "Copier coordonnées", Key = 24 },
                { Text = "Récupérer Bones", Key = 29 },
                { Text = distanceMessage, Key = 173 }
            }
            DrawScaleformMovieFullscreen(CreateInstuctionScaleformCustom("instructional_buttons", keysTable), 255, 255, 255, 255, 0)

            -- Gestion des événements du raycast
            local hit, coords, entity = RayCastGamePlayCamera(100.0)

            if DoesEntityExist(entity) then
                local entityType = GetEntityType(entity)
                if entityType == 1 or entityType == 2 or entityType == 3 then
                    props.hash = GetEntityModel(entity)
                    props.name = entityType == 2 and GetDisplayNameFromVehicleModel(props.hash) or GetEntityArchetypeName(entity)
                end
            end

            -- Affiche une ligne jusqu'à l'entité ciblée
            local playerCoords = GetEntityCoords(PlayerPedId())
            if hit then
                local color = { r = 0, g = 255, b = 0, a = 200 }
                DrawLine(playerCoords.x, playerCoords.y, playerCoords.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)

                -- Gestion des touches
                if IsDisabledControlJustPressed(0, 194) then
                    lockCoords = coords
                    inRaycastMode = false
                elseif IsDisabledControlJustPressed(0, 24) then
                    local message = string.format("%.2f, %.2f, %.2f", coords.x, coords.y, coords.z)
                    SendNotification("info", "Coordonnées copiées : " .. message)
                elseif IsDisabledControlJustPressed(0, 25) then
                    local message = "Hash : " .. props.hash .. " / Nom : " .. props.name
                    SendNotification("info", "Infos copiées : " .. message)
                elseif IsDisabledControlJustPressed(0, 173) then
                    if distanceCoord then
                        SendNotification("info", "Distance réinitialisée : " .. tostring(distance))
                    else
                        SendNotification("info", "Point de distance défini.")
                    end
                    distanceCoord = GetEntityCoords(PlayerPedId())
                elseif IsDisabledControlJustPressed(0, 29) then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if vehicle ~= 0 then
                        local bonesList = ListVehicleBones(vehicle)
                        SendNotification("info", "Bones copiés : " .. json.encode(bonesList, { indent = true }))
                    else
                        SendNotification("error", "Vous devez être dans un véhicule.")
                    end
                end
            end
            Wait(0)
        end
    end)
end

-- Enregistrement de l'événement et de la commande
RegisterNetEvent("ton_raycast:show")
AddEventHandler("ton_raycast:show", function()
    print("Mode Raycast : Activé")
    StartRaycastMode()
end)

RegisterCommandFramework("ton_raycast", function(player)
    TriggerClientEvent("ton_raycast:show", player.source or player.PlayerData.source)
end)
