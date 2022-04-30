ESX = nil
IsUsing = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function VehicleInFront()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, result = GetRaycastResult(rayHandle)
	return result
end


RegisterNetEvent('meeta_advanced_vehicle:washCar')
AddEventHandler('meeta_advanced_vehicle:washCar', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	TriggerEvent('esx_inventoryhud:closeHud')

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then

			if not IsUsing then
				IsUsing = true
				TriggerServerEvent("meeta_advanced_vehicle:DeleteItem", "wash")
				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="blue-text">ทำความสะอาดรถ</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)
					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)
					TriggerEvent("pNotify:SendNotification", {
						text = '<strong class="green-text">ทำความสะอาดรถเสร็จเรียบร้อยแล้ว</strong>',
						type = "error",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})
					IsUsing = false
				end)
			else
				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="blue-text">กรุณารอ...</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end
	else
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="white-text">ไม่มีรถที่อยู่ใกล้คุณ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

RegisterNetEvent('meeta_advanced_vehicle:onFixkit')
AddEventHandler('meeta_advanced_vehicle:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	TriggerEvent('esx_inventoryhud:closeHud')

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(PlayerPedId(), true) == false then -- ไม่ได้อยู่บนรถ

			closestVehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 4.0, 0, 71)
			local vehFront = VehicleInFront()

			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(playerPed), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(playerPed), true) then
            	IsInFront = false
            else
                IsInFront = true
            end

			if IsInFront and vehFront > 0 then 
				if not IsUsing then

					SetVehicleDoorOpen(vehFront, 4, false, false)
					IsUsing = true
					TriggerServerEvent("meeta_advanced_vehicle:DeleteItem", "fixkit")
					TriggerEvent("pNotify:SendNotification", {
						text = '<strong class="blue-text">ใช้อุปกรณ์ซ่อมรถ</strong>',
						type = "error",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})
					Citizen.Wait(1000)
					ESX.Streaming.RequestAnimDict("mini@repair", function()
						TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 49, 0, 0, 0, 0)
						Citizen.CreateThread(function()
							Citizen.Wait(30000)
							SetVehicleFixed(vehFront)
							SetVehicleDeformationFixed(vehFront)
							SetVehicleUndriveable(vehFront, false)
							SetVehicleEngineHealth(vehFront, 1000.0)
							SetVehicleBodyHealth(vehFront, 1000.0)
							SetVehiclePetrolTankHealth(vehFront, 1000.0)
							ClearPedTasksImmediately(playerPed)
							TriggerEvent("pNotify:SendNotification", {
								text = '<strong class="green-text">ซ่อมรถเสร็จเรียบร้อยแล้ว</strong>',
								type = "error",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
							Citizen.Wait(1000)
							SetVehicleDoorShut(vehFront, 4, false)
							IsUsing = false
						end)
					end)					
				else
					TriggerEvent("pNotify:SendNotification", {
						text = '<strong class="blue-text">กรุณารอ...</strong>',
						type = "error",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})
				end
			else
				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="red-text">คุณต้องเดินไปข้างหน้ารถ</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		else
			TriggerEvent("pNotify:SendNotification", {
				text = '<strong class="red-text">คุณต้องออกจากรถก่อน</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		end
	else
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="white-text">ไม่มีรถที่อยู่ใกล้คุณ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)