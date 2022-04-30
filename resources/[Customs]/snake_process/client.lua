ESX = nil
local playersProcessing = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip 

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)

	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	for k,zone in pairs(Config.Zones) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		
		local px,py,pz = table.unpack(Config.Zones.snakefish.coords)
		if GetDistanceBetweenCoords(coords, Config.Zones.snakefish.coords, true) < 10 then
				
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords,Config.Zones.snakefish.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~g~Process")
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
					SnakeProcess()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function SnakeProcess()
	isProcessing = true
	
	TaskPlayAnim(PlayerPedId(), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 48, 0, false, false, false )

	TriggerServerEvent('loffe_fishing:processsnake')
	local timeLeft = 7000 / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.Zones.snakefish.coords, false) > 4 then
			TriggerServerEvent('loffe_fishing:cancelProcessing')
			break
		end
	end

	isProcessing = false
end
