Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local spawnedGrasss = 0
local grassPlants = {}
local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		if PlayerData.job ~= nil and PlayerData.job.name == 'plowman' then
			local coords = GetEntityCoords(PlayerPedId())

			if GetDistanceBetweenCoords(coords, Config.CircleZones.GrassField.coords, true) < 50 then
				SpawnGrassPlants()
				Citizen.Wait(500)
			else
				Citizen.Wait(500)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'plowman' then
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)

			if GetDistanceBetweenCoords(coords, Config.CircleZones.GrassProcessing.coords, true) < 20.0 then
				DrawMarker(1, 843.43, 2197.7, 50.93, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 1.0, 100, 204, 100, 100, false, true, 2, false, false, false, false)
			end
		end
		
	end
end)	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if PlayerData.job ~= nil and PlayerData.job.name == 'plowman' then
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)

			if GetDistanceBetweenCoords(coords, Config.CircleZones.GrassProcessing.coords, true) < 3 then
				if not isProcessing then
					ESX.ShowHelpNotification(_U('grass_processprompt'))
				end
				if IsControlJustReleased(0, Keys['G']) and not isProcessing then
					ProcessGrass()
				end
			else
				Citizen.Wait(500)
			end
		end	
	end
end)

function ProcessGrass()
	if PlayerData.job ~= nil and PlayerData.job.name == 'plowman' then
		isProcessing = true

		local playerPed = PlayerPedId()
		
		TriggerServerEvent('1666dc4c-4a0c-4b9e-a211-f1277d589ab3')

		while isProcessing do
			Citizen.Wait(0)
			
			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.GrassProcessing.coords, false) > 5 then
				ESX.ShowNotification(_U('grass_processingtoofar'))
				TriggerServerEvent('a25b15f2-e2c4-4b4b-9e70-bbd0809c3554')
				break
			end
		end

		isProcessing = false
	end	
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'plowman' then
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			local nearbyObject, nearbyID

			for i=1, #grassPlants, 1 do
				if GetDistanceBetweenCoords(coords, GetEntityCoords(grassPlants[i]), false) < 1 then
					nearbyObject, nearbyID = grassPlants[i], i
				end
			end

			if nearbyObject and IsPedOnFoot(playerPed) then

				if not isPickingUp then
					ESX.ShowHelpNotification(_U('grass_pickupprompt'))
				end

				local AttachedEntity = GetEntityAttachedTo(playerPed)
				if (IsEntityAttached(playerPed)) and (GetEntityModel(AttachedEntity) == GetHashKey("a_c_cow")) then
					if IsControlJustReleased(0, Keys['G']) and not isPickingUp then
						isPickingUp = true

						ESX.TriggerServerCallback('9816ac66-69b5-4f9a-8a17-193b830b4ba5', function(canPickUp)

							if canPickUp then
								
								Citizen.Wait(1500)
				
								ESX.Game.DeleteObject(nearbyObject)
				
								table.remove(grassPlants, nearbyID)
								spawnedGrasss = spawnedGrasss - 1
				
								TriggerServerEvent('ccf1c87c-df5d-4ef4-991f-45bf47ec2576')
							else
								ESX.ShowNotification(_U('grass_inventoryfull'))
							end

							isPickingUp = false

						end, 'grass')
					end
				else
					ESX.ShowNotification("You are not in cow.")
				end	
			else
				Citizen.Wait(500)
			end
		end
	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(grassPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnGrassPlants()
	while spawnedGrasss < 25 do
		Citizen.Wait(0)
		local grassCoords = GenerateGrassCoords()

		ESX.Game.SpawnLocalObject('prop_bush_med_03_cr2', grassCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(grassPlants, obj)
			spawnedGrasss = spawnedGrasss + 1
		end)
	end
end

function ValidateGrassCoord(plantCoord)
	if spawnedGrasss > 0 then
		local validate = true

		for k, v in pairs(grassPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.GrassField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateGrassCoords()
	while true do
		Citizen.Wait(1)
		if PlayerData.job ~= nil and PlayerData.job.name == 'plowman' then
			local grassCoordX, grassCoordY

			math.randomseed(GetGameTimer())
			local modX = math.random(-75, 75)

			Citizen.Wait(100)

			math.randomseed(GetGameTimer())
			local modY = math.random(-75, 75)

			if modX > 0 then
				grassCoordX = Config.CircleZones.GrassField.coords.x + modX
			else
				grassCoordX = Config.CircleZones.GrassField.coords.x - modX
			end

			if modY > 0 then
				grassCoordY = Config.CircleZones.GrassField.coords.y + modY
			else
				grassCoordY = Config.CircleZones.GrassField.coords.y - modY
			end
			
			local coordZ = GetCoordZ(grassCoordX, grassCoordY)
			local coord = vector3(grassCoordX, grassCoordY, coordZ)

			if ValidateGrassCoord(coord) then
				return coord
			end
		end	
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 25.0, 26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end