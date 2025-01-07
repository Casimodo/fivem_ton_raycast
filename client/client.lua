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




function StartLineCreate()
   
    CreateThread(function()
        
        local LockCoords
        local InGetLock = true
        local propHash = nil
        local propName = nil
        local oldPropName = nil
        local distance = 0 
        local disanceCoord = nil 
        local disanceMsg = "Appuyer pour reset une distance" 
        while InGetLock do
        
            if disanceCoord ~= nil then
                local distPlayerCoords = GetEntityCoords(PlayerPedId())
                distance = #(distPlayerCoords - disanceCoord)
                disanceMsg = "Distance de " .. tostring(distance) 
            end
        
            local KeysTabl = {{Text = 'Arrêter', Key = 194}, {Text = 'Copier infos Hash + Name', Key = 25}, {Text = 'Copier coordonées', Key = 24}, {Text = 'Récupère les Bones de la cible', Key = 29}, {Text = disanceMsg, Key = 173}}
            DrawScaleformMovieFullscreen(CreateInstuctionScaleformCustom("instructional_buttons", KeysTabl), 255, 255, 255, 255, 0)

            if Canceled then 
                Canceled = false 
                InGetLock = false 
                return 
            end

            local Toch, Coords, Entity = RayCastGamePlayCamera(100.0)

            -- Vérifie si l'entité touchée est un props
            if DoesEntityExist(Entity) and (GetEntityType(Entity) == 1 or GetEntityType(Entity) == 2 or GetEntityType(Entity) == 3) then
                -- C'est un props, récupère son ID, son hash et son nom
                local propId = Entity
                if (GetEntityModel(propId) ~= nil) then
                    propHash = GetEntityModel(propId)
                    propName = GetEntityArchetypeName(Entity) -- Cette fonction renvoie parfois des noms abrégés ou des hash
                    if (GetEntityType(Entity) == 2) then
                        propName = GetDisplayNameFromVehicleModel(propHash) -- Cette fonction renvoie parfois des noms abrégés ou des hash
                    end 

                    if (oldPropName ~= propName) then
                        SendNotification("info", "props:" .. json.encode(propName))
                        oldPropName = propName
                    end
                end
            end

            local pCoords = GetEntityCoords(PlayerPedId())
            local Color = {r = 0, g = 255, b = 0, a = 200}
            if Toch then
                DrawLine(pCoords.x, pCoords.y, pCoords.z, Coords.x, Coords.y, Coords.z, Color.r, Color.g, Color.b, Color.a)
                DrawMarker(28, Coords.x, Coords.y, Coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, Color.r, Color.g, Color.b, Color.a, false, true, 2, nil, nil, false)
                if IsDisabledControlJustPressed(0, 194) then
                    LockCoords = Coords
                    InGetLock = false
                end
                if IsDisabledControlJustPressed(0, 24) then
                    local message = "" .. Coords.x ..", ".. Coords.y ..", ".. Coords.z
                    print("Cords point vers: " .. message)
                    SendNUIMessage({
                        action = "copyToClipboard",
                        value = message
                    })
                    SendNotification("info", "Tu viens de copier les coordonées</br>Utilise le coller de windows pour récupérer les valeurs !")
                end
                if IsDisabledControlJustPressed(0, 25) then
                    local message = "propHash: " .. json.encode(propHash) .. "\rpropName: " .. json.encode(propName)
                    SendNUIMessage({
                        action = "copyToClipboard",
                        value = message
                    })
                    SendNotification("info", "Tu viens de copier les infos de l'objet</br>Utilise le coller de windows pour récupérer les valeurs !")
                end
                if IsDisabledControlJustPressed(0, 173) then
                    
                    if disanceCoord == nil then
                        SendNotification("info", "Tu viens de prendre un point reset de distance")
                    else
                        SendNotification("info", "Copie distance et rotation + Reset de distance")
                        SendNUIMessage({
                            action = "copyToClipboard",
                            value = "Distance : " .. tostring(distance) .. " / rotation : " .. tostring(GetEntityHeading(PlayerPedId()))
                        })
                    end
                    disanceCoord = GetEntityCoords(PlayerPedId())
                end

                if IsDisabledControlJustPressed(0, 29) then
                
                    local playerPed = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    if vehicle ~= 0 then
                        local bonesList = ListVehicleBones(vehicle)
                        SendNUIMessage({
                            action = "copyToClipboard",
                            value = "Bones List : " .. json.encode(bonesList, {indent=true})
                        })
                        SendNotification("info", "Bones copier")
                    else
                        SendNotification("warning", "Vous devez être dans un véhicules")
                    end

                end

            end         
            Wait(0)
        end

    end)

end


RegisterNetEvent('ton_raycast:show')
AddEventHandler("ton_raycast:show", function()
   
    print("Mode Raycast : ON")
    StartLineCreate()
   
end)


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
