-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)

end)

local IsCanLock = true

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1000.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

function LockVehicle(plate) 
    if IsCanLock == true then
        IsCanLock = false
        local coords = GetEntityCoords(GetPlayerPed(-1))
        cars = ESX.Game.GetVehiclesInArea(coords, Config.DistanceSignal)
        local carstrie = {}
        local cars_dist = {}		
        notowned = 0

        if #cars == 0 then
            
        else

            for j=1, #cars, 1 do
                local coordscar = GetEntityCoords(cars[j])
                local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
                table.insert(cars_dist, {cars[j], distance})
            end

            for k=1, #cars_dist, 1 do
                local z = -1
                local distance, car = 999
                for l=1, #cars_dist, 1 do
                    if cars_dist[l][2] < distance then
                        distance = cars_dist[l][2]
                        car = cars_dist[l][1]
                        z = l
                    end
                end
                if z ~= -1 then
                    table.remove(cars_dist, z)
                    table.insert(carstrie, car)
                end
            end

            for i=1, #carstrie, 1 do
                local plates = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
                
                if plates == plate then
                    local prop = nil
                    
                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then

                        local ped = GetPlayerPed(-1)
                        -- RequestAnimDict("anim@mp_player_intmenu@key_fob@")
                        -- while (not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@")) do Citizen.Wait(0) end
                        -- TaskPlayAnim(ped,"anim@mp_player_intmenu@key_fob@","fob_click",2.0,-1.0, 5000, 0, 1, true, true, true)
                        -- RequestAnimDict("anim@mp_player_intmenu@key_fob@")

                        -- while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                        --     Citizen.Wait(0)
                        -- end
                        -- TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, -8.0, -1, 0, 0, false, false, false)

                        
                        --TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, -8.0, -1, 0, 0, false, false, false)
                        
                        local x,y,z = table.unpack(GetEntityCoords(ped))
                        prop = CreateObject(GetHashKey("p_car_keys_01"), x, y, z , true, true, true)
                        local boneIndex = GetPedBoneIndex(ped, 64017)
                        AttachEntityToEntity(prop, ped, boneIndex, 0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

                        RequestAnimDict("anim@mp_player_intmenu@key_fob@")

                        while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                            Citizen.Wait(0)
                        end

                        TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, -8, -1, 49, 0, 0, 0, 0)
                        Citizen.Wait(900)
                        ClearPedSecondaryTask(PlayerPedId())
                    end

                    --Citizen.Wait(500)
                    local VehicleStatus = GetVehicleDoorLockStatus(carstrie[i])
                    if VehicleStatus == 4 then
                        SetVehicleDoorsLocked(carstrie[i], 1)
                        TriggerEvent("pNotify:SendNotification", {
                            text = 'ปลดล็อครถ : ' ..plates,
                            type = "success",
                            timeout = 3000,
                            layout = "bottomCenter",
                            queue = "global"
                        })    
                        SendNUIMessage({
                            transactionType     = 'playSound',
                            transactionFile     = "unlock",
                            transactionVolume   = 0.5
                        })
                    else
                        SetVehicleDoorsLocked(carstrie[i], 4)
                        TriggerEvent("pNotify:SendNotification", {
                            text = 'ล็อครถ : ' ..plates,
                            type = "success",
                            timeout = 3000,
                            layout = "bottomCenter",
                            queue = "global"
                        })    
                        SendNUIMessage({
                            transactionType     = 'playSound',
                            transactionFile     = "lock",
                            transactionVolume   = 0.5
                        })
                    end

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        
                        Citizen.Wait(650)

                        DeleteObject(prop)

                    end
                
                    break
                end
                -- TriggerEvent("pNotify:SendNotification", {
                --     text = 'Plate : ' ..plates,
                --     type = "success",
                --     timeout = 3000,
                --     layout = "bottomCenter",
                --     queue = "global"
                -- })    
                -- ESX.TriggerServerCallback('carlock:isVehicleOwner', function(owner)
                --     if owner and hasAlreadyLocked ~= true then
                --         local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
                --         vehicleLabel = GetLabelText(vehicleLabel)
                --         local lock = GetVehicleDoorLockStatus(carstrie[i])
                --         if lock == 1 or lock == 0 then
                --             SetVehicleDoorShut(carstrie[i], 0, false)
                --             SetVehicleDoorShut(carstrie[i], 1, false)
                --             SetVehicleDoorShut(carstrie[i], 2, false)
                --             SetVehicleDoorShut(carstrie[i], 3, false)
                --             SetVehicleDoorsLocked(carstrie[i], 2)
                --             PlayVehicleDoorCloseSound(carstrie[i], 1)
                --             ESX.ShowNotification('You have ~r~locked~s~ your ~y~'..vehicleLabel..'~s~.')
                --             if not IsPedInAnyVehicle(PlayerPedId(), true) then
                --                 TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                --             end
                --             hasAlreadyLocked = true
                --         elseif lock == 2 then
                --             SetVehicleDoorsLocked(carstrie[i], 1)
                --             PlayVehicleDoorOpenSound(carstrie[i], 0)
                --             ESX.ShowNotification('You have ~g~unlocked~s~ your ~y~'..vehicleLabel..'~s~.')
                --             if not IsPedInAnyVehicle(PlayerPedId(), true) then
                --                 TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                --             end
                --             hasAlreadyLocked = true
                --         end
                --     else
                --         notowned = notowned + 1
                --     end
                --     if notowned == #carstrie then
                --         ESX.ShowNotification("No vehicles to lock nearby.")
                --     end	
                -- end, plate)
            end	
        end
        Citizen.Wait(Config.Delay)

        IsCanLock = true
    end
end

RegisterNetEvent("meeta_remote:ClientLock")
AddEventHandler("meeta_remote:ClientLock",function(plate)
    --TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 1.0)
    LockVehicle(plate)
end)

function all_trim(s)
    if s then
        return s:match "^%s*(.*)":match "(.-)%s*$"
    else
        return "noTagProvided"
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(0)

        -- Press Key
        if IsControlJustPressed(1, Config.Key["U"]) and IsPedInAnyVehicle(PlayerPedId(), true) and IsCanLock == true then
            
            IsCanLock = false

            TriggerServerEvent("esx_inventoryhud:KeyLoaded",  GetPlayerServerId(PlayerId()))
            ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory", function(data)
                inventory = data.inventory

                localVehId = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                if localVehId and localVehId ~= 0 then
                    local localVehPlate = string.lower(GetVehicleNumberPlateText(localVehId))
                    if inventory ~= nil then
                        for key, value in pairs(inventory) do
                            if inventory[key].count <= 0 then
                                inventory[key] = nil
                            else
                                if inventory[key].type == "item_key" then
                                    if all_trim(localVehPlate) == string.lower(inventory[key].label) then
                                        
                                        local VehicleStatus = GetVehicleDoorLockStatus(localVehId)
                                        if VehicleStatus == 4 then
                                            SetVehicleDoorsLocked(localVehId, 1)
                                            TriggerEvent("pNotify:SendNotification", {
                                                text = 'ปลดล็อครถ : ' ..inventory[key].label,
                                                type = "success",
                                                timeout = 3000,
                                                layout = "bottomCenter",
                                                queue = "global"
                                            })    
                                            SendNUIMessage({
                                                transactionType     = 'playSound',
                                                transactionFile     = "unlock",
                                                transactionVolume   = 0.5
                                            })
                                        else
                                            SetVehicleDoorsLocked(localVehId, 4)
                                            TriggerEvent("pNotify:SendNotification", {
                                                text = 'ล็อครถ : ' ..inventory[key].label,
                                                type = "success",
                                                timeout = 3000,
                                                layout = "bottomCenter",
                                                queue = "global"
                                            })    
                                            SendNUIMessage({
                                                transactionType     = 'playSound',
                                                transactionFile     = "lock",
                                                transactionVolume   = 0.5
                                            })
                                        end   
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end, GetPlayerServerId(PlayerId()))

            Citizen.Wait(Config.Delay)

            IsCanLock = true

        end

    end
end)