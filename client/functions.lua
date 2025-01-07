
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


function ListVehicleBones(vehicle)
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

function InstructionalButton(controlButton, text)
    ScaleformMovieMethodAddParamPlayerNameString(controlButton)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function RotationToDirection(rotation)
    local adjustedRotation = 
    { 
        x = (math.pi / 180) * rotation.x, 
        y = (math.pi / 180) * rotation.y, 
        z = (math.pi / 180) * rotation.z 
    }
    local direction = 
    {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
        z = math.sin(adjustedRotation.x)
    }
    return direction
end