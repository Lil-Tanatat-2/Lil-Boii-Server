ESX = nil
local isProcessing = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local locations = { 
    { x = 277.42, y = 3611.06, z = 32.65, h = 276.5}, 
	{ x = 276.17, y = 3615.29, z = 32.40, h = 289.39}, 
	{ x = 268.23, y = 3624.57, z = 32.54, h = 306.03}, 
	{ x = 270.31, y = 3621.85, z = 32.40, h = 306.32}, 
	{ x = 276.83, y = 3607.33, z = 32.90, h = 253.50}, 
	{ x = 275.62, y = 3603.83, z = 33.12, h = 250.14},
} 

local store = { 
    [_U('open_store')] = { x = 387.61, y = 3585.77, z = 32.34}, 
} 

local sell = { 
    [_U('sell_fish')] = { x = -1845.43, y = -1196.18, z = 18.33}, 
} 

local blips = {
	{title = _U('fishing_blip'), sprite = 68, x = 264.01, y = 3611.71, z = 33.87},	
	{title = _U('store_blip'), sprite = 52, x = 387.61, y = 3585.77, z = 32.34},
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.sprite)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.6)
      SetBlipColour(info.blip, 0)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
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
		
		local px,py,pz = table.unpack(Config.Zones.catfish.coords)
		if GetDistanceBetweenCoords(coords, Config.Zones.catfish.coords, true) < 10 then
				
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
      
	Citizen.Wait(5)
	
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k, v in pairs(locations) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 100 then
				DrawMarker(27, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			end
		end
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k, v in pairs(store) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 100 then
				DrawMarker(27, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			end
		end
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k, v in pairs(sell) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 100 then
				DrawMarker(27, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords,Config.Zones.catfish.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~g~Process")
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
					Process()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function Process()
	isProcessing = true
	
	TaskPlayAnim(PlayerPedId(), "mini@repair" ,"fixing_a_ped" ,8.0, -8.0, -1, 48, 0, false, false, false )

	TriggerServerEvent('loffe_fishing:processcat')
	local timeLeft = 7000 / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.Zones.catfish.coords, false) > 4 then
			TriggerServerEvent('loffe_fishing:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
      
	Citizen.Wait(5)
	
		local coords = GetEntityCoords(GetPlayerPed(-1))
		
		for k, v in pairs(locations) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
				DrawText3D(v.x, v.y, v.z+0.9, _U('start'), 0.80)
				if IsControlPressed(0, 38) then
					local fishingrod = 0
					local fishingbait = 0
					local ultrafishingbait = 0
					local extremefishingbait = 0
					
					ESX.TriggerServerCallback('loffe_fishing:getItems', function(fishingRod, fishingBait, ultrafishingBait, extremefishingBait)
						fishingrod = fishingRod
						fishingbait = fishingBait
						ultrafishingbait = ultrafishingBait
						extremefishingbait = extremefishingBait
					end)
					Wait(500)
					if (fishingrod > 0 and fishingbait > 0) or (fishingrod > 0 and ultrafishingbait > 0) or (fishingrod > 0 and extremefishingbait > 0) then
						local ped = GetPlayerPed(-1)
						ClearPedTasks(ped)
						SetEntityHeading(ped, v.h)
						TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_FISHING", 0, false)
						local caught = false
						local this = 0
						if extremefishingbait > 0 then
							Wait(math.random(6000, 8500))
							TriggerServerEvent('loffe_fishing:bait', 'lEbait', 1)
						elseif ultrafishingbait > 0 then
							Wait(math.random(8500, 12000))
							TriggerServerEvent('loffe_fishing:bait', 'lUbait', 1)
						elseif fishingbait > 0 then
							Wait(math.random(25000, 30000))
							TriggerServerEvent('loffe_fishing:bait', 'lbait', 1)
						end
						local randomThis = math.random(100, 350)
						while not caught do
							Wait(5)
							local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.5)
							DrawText3D(offset.x, offset.y, offset.z, _U('on_hook'), 0.8)
							this = this + 1
							if this == randomThis then
								caught = true
								local fishingRod = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_fishing_rod_01"), false, false, false)
								ClearPedTasks(ped)
								SetEntityAsMissionEntity(fishingRod, true, true)
								DeleteEntity(fishingRod)
								
							else
								if IsControlPressed(0, 18) --[[enter]] then
									local fishingRod = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_fishing_rod_01"), false, false, false)
									ClearPedTasks(ped)
									SetEntityAsMissionEntity(fishingRod, true, true)
									DeleteEntity(fishingRod)
									local randomWeight = math.random(5000, 14000)
									TriggerServerEvent('loffe_fishing:caught')
									caught = true
									
								end
							end
						end
						caught = false
					else
						Notify(_U('no_equipment'), 2500)
					end
				end
			end
		end
	end
end)

RegisterNetEvent('loffe-fishing:boatFishing')
AddEventHandler('loffe-fishing:boatFishing', function()
    local coords = GetEntityCoords(GetPlayerPed(-1))
        local closestvehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 12294)
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) and IsEntityInWater(closestvehicle) then
                    
                    local fishingrod = 0
					local fishingbait = 0
					local ultrafishingbait = 0
					local extremefishingbait = 0

                    ESX.TriggerServerCallback('loffe_fishing:getItems', function(fishingRod, fishingBait, ultrafishingBait, extremefishingBait)
						fishingrod = fishingRod
						fishingbait = fishingBait
						ultrafishingbait = ultrafishingBait
						extremefishingbait = extremefishingBait
					end)
                    Wait(500)
                    if (fishingrod > 0 and fishingbait > 0) or (fishingrod > 0 and ultrafishingbait > 0) or (fishingrod > 0 and extremefishingbait > 0) then
                    local ped = GetPlayerPed(-1)
                    ClearPedTasks(ped)
                    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_FISHING", 0, false)
                    local caught = false
                    local this = 0
                    	if extremefishingbait > 0 then
							Wait(math.random(6000, 8500))
							TriggerServerEvent('loffe_fishing:bait', 'lEbait', 1)
						elseif ultrafishingbait > 0 then
							Wait(math.random(8500, 12000))
							TriggerServerEvent('loffe_fishing:bait', 'lUbait', 1)
						elseif fishingbait > 0 then
							Wait(math.random(25000, 30000))
							TriggerServerEvent('loffe_fishing:bait', 'lbait', 1)
						end
                    local randomThis = math.random(100, 250)
                    while not caught do
                        Wait(5)
                        local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 1.0)
                        DrawText3D(offset.x, offset.y, offset.z, _U('on_hook'), 0.6)
                        this = this + 1
                        if this == randomThis then
                            caught = true
                            local fishingRod = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_fishing_rod_01"), false, false, false)
                            ClearPedTasks(ped)
                            SetEntityAsMissionEntity(fishingRod, true, true)
                            DeleteEntity(fishingRod)
                           
                        else
                            if IsControlPressed(0, 18) --[[enter]] then
                                local fishingRod = GetClosestObjectOfType(coords, 10.0, GetHashKey("prop_fishing_rod_01"), false, false, false)
                                ClearPedTasks(ped)
                                SetEntityAsMissionEntity(fishingRod, true, true)
                                DeleteEntity(fishingRod)
                                local randomWeight = math.random(5000, 14000)
                                TriggerServerEvent('loffe_fishing:caught')
                                caught = true
                                Notify(_U('you_caught') .. randomWeight/1000 .. ' kg', 2000)
                            end
                        end
                    end
                        caught = false
                end
        end
end)

Citizen.CreateThread(function()
	while true do
      
	Citizen.Wait(5)
	
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k, v in pairs(sell) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
				DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
				if IsControlPressed(0, 38) then
					TriggerServerEvent('loffe_fishing:sell')
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
      
	Citizen.Wait(5)
	
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k, v in pairs(store) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
				DrawText3D(v.x, v.y, v.z+0.9, k, 0.80)
				if IsControlPressed(0, 38) then
					OpenFishMenu()
				end
			end
		end
	end
end)

function OpenFishMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'fish_menu',
        {
            title    = _U('fishing_store'),
            elements = {
				{label = _U('fishing_rod'), item = 'lrod', price = 1500, amount = 1},
				{label = _U('fishing_bait'), item = 'lbait', price = 5, amount = 1},
				
            }
        },
        function(data, menu)
			local item = data.current.item
			local price = data.current.price
			local amount = data.current.amount
            TriggerServerEvent('loffe_fishing:buyEquipment', item, price, amount)
        end,
    function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent('loffe_fishing:notify')
AddEventHandler('loffe_fishing:notify', function(msg)
	Notify(msg, 5000)
end)

function Notify(message, time)
    local timePassed = 0
    while timePassed <= time/10 do
        Wait(1)
        timePassed = timePassed + 1
        local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.5)
        DrawText3D(offset.x, offset.y, offset.z, message, 0.8)
    end
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
 
    AddTextComponentString(text)
    DrawText(_x, _y)
 
    local factor = (string.len(text)) / 230
    DrawRect(_x, _y + 0.0250, 0.095 + factor, 0.06, 41, 11, 41, 100)
end