ESX = nil

local IsAnesthetic1 = false
local Anesthetic1_Timer = 0

local IsAnesthetic2 = false
local Anesthetic2_Timer = 0

local IsRevive = false
local IsRevive_Timer = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

------------------------------------------------------------------
--                          Doctor
------------------------------------------------------------------

RegisterNetEvent('meeta_ambulance:firstaidUse')
AddEventHandler('meeta_ambulance:firstaidUse', function()
	TriggerEvent('esx_inventoryhud:closeHud')

	local playerPed = PlayerPedId()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_player_actions',
	{
		title    = 'Player Actions',
		align    = 'top-left',
		elements = {
			{ label = "ฉีดยาสลบ", value = 'anesthetic1' },
			{ label = "ให้น้ำเกลือ", value = 'anesthetic2' },
			{ label = "ใส่ชุดให้คนไข้", value = 'put_cloth' },
			{ label = "ถอดชุดให้คนไข้", value = 'unput_cloth' }
		}
	}, function(data, menu)

		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 2.0 then
			local action = data.current.value
			if action == 'anesthetic1' then
				TriggerServerEvent('meeta_ambulance:anesthetic1', GetPlayerServerId(closestPlayer))
			elseif action == 'anesthetic2' then
				TriggerServerEvent('meeta_ambulance:anesthetic2', GetPlayerServerId(closestPlayer))
			elseif action == 'put_cloth' then
			
				local dirt = "anim@mp_player_intincarjazz_handslow@ds@"
				RequestAnimDict(dirt)
				while not HasAnimDictLoaded(dirt) do
					Citizen.Wait(100)
				end

				TaskPlayAnim(playerPed, dirt, 'exit', 8.0, -8, -1, 49, 0, 0, 0, 0)
				Wait(500)
				ClearPedTasks(GetPlayerPed(-1))
				TriggerServerEvent('meeta_ambulance:put_cloth', GetPlayerServerId(closestPlayer))
			elseif action == 'unput_cloth' then
				local dirt = "anim@mp_player_intincarjazz_handslow@ds@"
				RequestAnimDict(dirt)
				while not HasAnimDictLoaded(dirt) do
					Citizen.Wait(100)
				end

				TaskPlayAnim(playerPed, dirt, 'exit', 8.0, -8, -1, 49, 0, 0, 0, 0)
				Wait(500)
				ClearPedTasks(GetPlayerPed(-1))
				TriggerServerEvent('meeta_ambulance:unput_cloth', GetPlayerServerId(closestPlayer))
			end
		else
			TriggerEvent("pNotify:SendNotification", {
				text = '<strong class="red-text">ไม่มีผู้เล่นที่อยู่ใกล้คุณ</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		end

	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('meeta_ambulance:anesthetic1')
AddEventHandler('meeta_ambulance:anesthetic1', function()

	Anesthetic1_Timer = Anesthetic1_Timer+Config.Time1
	Wait(7000)
	IsAnesthetic1 = true

end)

RegisterNetEvent('meeta_ambulance:anesthetic2')
AddEventHandler('meeta_ambulance:anesthetic2', function()

	Anesthetic2_Timer = Anesthetic2_Timer+Config.Time2
	IsAnesthetic2 = true
	Citizen.CreateThread(function()
		Wait(500)
		setPlayerDrunk("move_m@drunk@verydrunk", 0.5)
	end)

end)

RegisterNetEvent('meeta_ambulance:put_cloth')
AddEventHandler('meeta_ambulance:put_cloth', function()

	local playerPed = PlayerPedId()
	
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin["sex"] == 0 then

			local accessorySkin = {}

			accessorySkin['torso_1'] = 144
			accessorySkin['torso_2'] = 0
			accessorySkin['tshirt_1'] = 15
			accessorySkin['tshirt_2'] = 0
			accessorySkin['arms'] = 6
			accessorySkin['pants_1'] = 65
			accessorySkin['pants_2'] = 0
			accessorySkin['shoes_1'] = 34
			accessorySkin['shoes_2'] = 0
			accessorySkin['helmet_1'] = -1
			accessorySkin['glasses_1'] = -1

			TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
		else
		
			local accessorySkin = {}

			accessorySkin['torso_1'] = 142
			accessorySkin['torso_2'] = 2
			accessorySkin['tshirt_1'] = 15
			accessorySkin['tshirt_2'] = 0
			accessorySkin['arms'] = 14
			accessorySkin['pants_1'] = 67
			accessorySkin['pants_2'] = 2
			accessorySkin['shoes_1'] = 35
			accessorySkin['shoes_2'] = 0
			accessorySkin['helmet_1'] = -1
			accessorySkin['glasses_1'] = -1
			TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
		end
		
	end)

end)

RegisterNetEvent('meeta_ambulance:unput_cloth')
AddEventHandler('meeta_ambulance:unput_cloth', function()

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

end)

-- ยาสลบ
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = GetPlayerPed(-1)
		if IsAnesthetic1 == true then
			DisableAllControlActions(0)
			DoScreenFadeOut(1000)

			while not IsScreenFadedOut() do
				Citizen.Wait(10)
			end

			if Anesthetic1_Timer <= 0 then
				IsAnesthetic1 = false
				DoScreenFadeIn(1000)
			else
				Anesthetic1_Timer = Anesthetic1_Timer -1
			end

		end
	end
end)

-- น้ำเกลือ
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local playerPed = PlayerPedId()
		if IsAnesthetic2 == true then

			if Anesthetic2_Timer <= 0 then
				IsAnesthetic2 = false
				ClearEffect()
			else
				Anesthetic2_Timer = Anesthetic2_Timer -1
			end

		end
	end
end)

function setPlayerDrunk(anim, shake)
	local PlayerPed = PlayerPedId()

	RequestAnimSet(anim)
      
	while not HasAnimSetLoaded(anim) do
		Citizen.Wait(100)
	end

	SetPedMovementClipset(PlayerPed, anim, true)
	ShakeGameplayCam("DRUNK_SHAKE", shake)
	SetPedMotionBlur(PlayerPed, true)
	SetPedIsDrunk(PlayerPed, true)

end

RegisterNetEvent('meeta_ambulance:cpr')
AddEventHandler('meeta_ambulance:cpr', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local random = math.random(1,100)
	TriggerEvent('esx_inventoryhud:closeHud')

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 1.0 then
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">ไม่มีผู้เล่นอยู่ใกล้คุณ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	else
		ESX.TriggerServerCallback('meeta_ambulance:getItem', function(result)

			if result then
				local closestPlayerPed = GetPlayerPed(closestPlayer)
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				ESX.Streaming.RequestAnimDict(lib, function()
					TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 33, 0, false, false, false)
				end)

				if random <= 50 then -- Success
					ClearPedTasks(playerPed)
					TriggerServerEvent('meeta_ambulance:revive', GetPlayerServerId(closestPlayer))

					TriggerEvent("pNotify:SendNotification", {
						text = '<strong class="green-text">คุณช่วยชีวิตเขาไว้ได้!!</strong>',
						type = "success",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})
				else -- Fail
					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(PlayerPedId(), lib, "cpr_fail", 8.0, -8.0, -1, 0, 0, false, false, false)
						Wait(20000)
						ClearPedTasks(playerPed)
					end)
				end
				
				TriggerServerEvent('meeta_ambulance:DeleteItem', 'defibrillator')
				
			else
				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="red-text">คุณไม่มี Defibrillator</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end, 'defibrillator')
	end

end)

RegisterNetEvent('meeta_ambulance:revive')
AddEventHandler('meeta_ambulance:revive', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	 Citizen.CreateThread(function()

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
	 end)

	SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
	Wait(5000)
	SetPlayerInvincible(playerPed, false)
	
end)

function RespawnPed(ped, coords, heading)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	SetEntityHealth(ped, 100)
	SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
	Wait(5000)

	setPlayerDrunk("move_m@drunk@verydrunk", 2.0)
	Citizen.CreateThread(function()
		Citizen.Wait(500)
		SetTimecycleModifier("spectator10")
		IsRevive = true
		IsRevive_Timer = Config.TimeRevive
	 end)	

	ESX.UI.Menu.CloseAll()
end

-- เวลฟืนฟู
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		
		if IsRevive == true then

			if IsRevive_Timer <= 0 then
				IsRevive = false
				ClearEffect()
			else
				IsRevive_Timer = IsRevive_Timer -1
			end

		end
	end
end)

function ClearEffect()
	local playerPed = PlayerPedId()
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(playerPed, 0)
	SetPedIsDrunk(playerPed, false)
	SetPedMotionBlur(playerPed, false)
	ClearPedSecondaryTask(playerPed)
	ShakeGameplayCam("DRUNK_SHAKE", 0.0)
	SetPedMoveRateOverride(PlayerPedId(), 1.0)
end