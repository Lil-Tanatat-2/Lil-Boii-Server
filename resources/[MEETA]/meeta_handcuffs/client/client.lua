-- CREATE BY THANAWUT PROMRAUNGDET

ESX = nil
local PlayerData = {}
local IsHandcuffed = false
local HandcuffTimer = {}
local HandcuffPlayer = {}

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

function CheckPlayer(player)
	for k,v in pairs(HandcuffPlayer) do
		if v == player then
			return true
		end
	end
	return false
end

function tablefind(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            return index
        end
    end
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('meeta_handcruffs:selectPlayer')
AddEventHandler('meeta_handcruffs:selectPlayer', function()

	TriggerEvent('esx_inventoryhud:closeHud')

	local playerPed = PlayerPedId()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_player_actions',
	{
		title    = 'Player Actions',
		align    = 'top-left',
		elements = {
			{ label = "กุญแจมือ", value = 'handcuffs' },
			{ label = "คลุมหัว", value = 'headbag' }
		}
	}, function(data, menu)

		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 1.0 then
			local action = data.current.value

			if action == 'handcuffs' then

				ESX.TriggerServerCallback("meeta_handcruffs:checkItem", function(item1, item2)

					local element_subs1 = {
						{ label = "ใส่กุญแจมือ", value = 'handcuffs' },
						{ label = "ไขกุญแจมือ", value = 'unhandcuffs' },
						{ label = "ปล้น", value = 'search' },
						{ label = "อุ้ม", value = 'lyffup' }
					}

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_player_actions_handcruffs',{
						title    = 'กุญแจมือ',
						align    = 'top-left',
						elements = element_subs1
					}, function(data1, menu1)
						if data1.current.value == "handcuffs" then
						
							-- ใส่กุญแจมือ
							if item1 then
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer ~= -1 and closestDistance <= 1.0 then
									playerheading = GetEntityHeading(GetPlayerPed(-1))
									playerCoords = GetEntityCoords(GetPlayerPed(-1))
									playerlocation = GetEntityForwardVector(PlayerPedId())
									TriggerServerEvent('meeta_handcruffs:handcuff', GetPlayerServerId(closestPlayer), playerheading, playerCoords, playerlocation)
									table.insert(HandcuffPlayer, GetPlayerServerId(closestPlayer))
								else
									TriggerEvent("pNotify:SendNotification", {
										text = '<strong class="red-text">ไม่มีผู้เล่นที่อยู่ใกล้คุณ</strong>',
										type = "error",
										timeout = 3000,
										layout = "bottomCenter",
										queue = "global"
									})
								end
							else
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">คุณไม่มีกุญแจมือ</strong>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							end

						elseif data1.current.value == "unhandcuffs" then
							
							-- ไขกุญแจมือ
							if item1 then
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer ~= -1 and closestDistance <= 1.0 then

									print(GetPlayerServerId(closestPlayer))
									candoplayer = CheckPlayer(GetPlayerServerId(closestPlayer))
									if candoplayer then

										playerheading = GetEntityHeading(GetPlayerPed(-1))
										playerCoords = GetEntityCoords(GetPlayerPed(-1))
										playerlocation = GetEntityForwardVector(PlayerPedId())
										TriggerServerEvent('meeta_handcruffs:unhandcuff', GetPlayerServerId(closestPlayer), playerheading, playerCoords, playerlocation)
										table.remove(HandcuffPlayer, tablefind(HandcuffPlayer,GetPlayerServerId(closestPlayer)))
									else
										TriggerEvent("pNotify:SendNotification", {
											text = '<strong class="red-text">ผู้เล่นยังไม่โดนใส่กุญแจมือ</strong>',
											type = "error",
											timeout = 3000,
											layout = "bottomCenter",
											queue = "global"
										})
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
							else
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">คุณไม่มีลูกกุญแจมือ</strong>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							end

						elseif data1.current.value == "search" then

							-- ปล้น
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 1.0 then
								candoplayer = CheckPlayer(GetPlayerServerId(closestPlayer))
								if candoplayer then
									OpenBodySearchMenu(GetPlayerServerId(closestPlayer))
								else
									TriggerEvent("pNotify:SendNotification", {
										text = '<strong class="red-text">ผู้เล่นยังไม่โดนใส่กุญแจมือ</strong>',
										type = "error",
										timeout = 3000,
										layout = "bottomCenter",
										queue = "global"
									})
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
							
						elseif data1.current.value == "lyffup" then

							-- อุ้ม
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 1.0 then
								candoplayer = CheckPlayer(GetPlayerServerId(closestPlayer))
								if candoplayer then
									TriggerEvent('esx_barbie_lyftupp:on')
								else
									TriggerEvent("pNotify:SendNotification", {
										text = '<strong class="red-text">ผู้เล่นยังไม่โดนใส่กุญแจมือ</strong>',
										type = "error",
										timeout = 3000,
										layout = "bottomCenter",
										queue = "global"
									})
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
							
						end
					end, function(data, menu)
						menu.close()
					end)
				end, "handcuffs", "handcuffs_key")

			elseif action == 'headbag' then
				ESX.TriggerServerCallback("meeta_handcruffs:checkItem", function(item1, item2)

					local element_subs2 = {
						{ label = "คลุมหัว", value = 'puton' },
						{ label = "ยกคลุมหัว", value = 'putoff' }
					}

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'meeta_player_actions_headbag',{
						title    = 'คลุมหัว',
						align    = 'top-left',
						elements = element_subs2
					}, function(data2, menu2)
						if data2.current.value == "puton" then

							-- คลุมหัว
							if item1 then
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer ~= -1 and closestDistance <= 1.0 then
									local dirt = "anim@mp_player_intincarjazz_handslow@ds@"
									RequestAnimDict(dirt)
									while not HasAnimDictLoaded(dirt) do
										Citizen.Wait(100)
									end

									TaskPlayAnim(playerPed, dirt, 'exit', 8.0, -8, -1, 49, 0, 0, 0, 0)
									Wait(500)
									ClearPedTasks(GetPlayerPed(-1))
									TriggerServerEvent('esx_worek:sendclosest', GetPlayerServerId(closestPlayer))
									TriggerServerEvent('esx_worek:closest')
								else
									TriggerEvent("pNotify:SendNotification", {
										text = '<strong class="red-text">ไม่มีผู้เล่นที่อยู่ใกล้คุณ</strong>',
										type = "error",
										timeout = 3000,
										layout = "bottomCenter",
										queue = "global"
									})
								end
							else
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">คุณไม่มีถุงกระดาษ</strong>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							end

						elseif data2.current.value == "putoff" then
							
							-- ยกเลิกคลุมหัว
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 1.0 then
								TriggerServerEvent('esx_worek:zdejmij')
							else
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">ไม่มีผู้เล่นที่อยู่ใกล้คุณ</strong>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							end
						end
					end, function(data, menu)
						menu.close()
					end)
				end, "paper_bag", "handcuffs")
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

function SearchAreaPlayer(player)

	local playerPed = PlayerPedId()
	local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), Config.PlayerDistance)
	local found = false
	for i = 1, #players, 1 do
		if players[i] ~= PlayerId() then			
			if GetPlayerServerId(players[i]) == player then
				found = true
			end
		end
	end

	return found

end

function OpenBodySearchMenu(player)
	
	local found = SearchAreaPlayer(player)

	if found then
	local data1 = {
		vehicle = Config.RootVehicleKey,
		house = Config.RootHouseKey
	}
	ESX.UI.Menu.CloseAll()
	TriggerEvent("esx_inventoryhud:openOtherInventory", player, "", "", {}, data1)
		-- ESX.TriggerServerCallback('meeta_handcruffs:getOtherPlayerData', function(data)

		-- 	local data1 = {
		-- 		vehicle = Config.RootVehicleKey,
		-- 		house = Config.RootHouseKey
		-- 	}
		-- 	TriggerEvent("esx_inventoryhud:openOtherInventory", player, data.firstname, data.lastname, data.weapons, data1)
	
		-- end, player)
	else
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">คุณอยู่ไกลเกินไป</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end

Citizen.CreateThread(function()

    while true do
		Citizen.Wait(10)

		local playerPed = PlayerPedId()

		if IsHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen
 
			DisableControlAction(0, Keys['M'], true) -- Phone
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
            
			
			
			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end

	end
	
end)

RegisterNetEvent('meeta_handcruffs:getarrested')
AddEventHandler('meeta_handcruffs:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	ESX.Streaming.RequestAnimDict("mp_arrest_paired", function()
		TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
		Citizen.Wait(3060)
		TriggerEvent("meeta_handcruffs:handcuff")
	end)
	
end)

RegisterNetEvent('meeta_handcruffs:douncuffing')
AddEventHandler('meeta_handcruffs:douncuffing', function()
	Citizen.Wait(250)
	ESX.Streaming.RequestAnimDict("mp_arresting", function()
		TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,3750, 2, 0, 0, 0, 0)
	end)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('meeta_handcruffs:getuncuffed')
AddEventHandler('meeta_handcruffs:getuncuffed', function(playerheading, playercoords, playerlocation)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	ESX.Streaming.RequestAnimDict("mp_arresting", function()
		TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,3750, 2, 0, 0, 0, 0)
		Citizen.Wait(3000)
		TriggerEvent("meeta_handcruffs:unrestrain")
		ESX.UI.Menu.CloseAll()
	end)
	
end)


RegisterNetEvent('meeta_handcruffs:doarrested')
AddEventHandler('meeta_handcruffs:doarrested', function()
	Citizen.Wait(250)
	ESX.Streaming.RequestAnimDict("mp_arrest_paired", function()
		TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	end)
	Citizen.Wait(3000)
end)


RegisterNetEvent('meeta_handcruffs:handcuff')
AddEventHandler('meeta_handcruffs:handcuff', function()
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if not IsHandcuffed then

			IsHandcuffed = true

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			DisplayRadar(false)

			if Config.EnableHandcuffTimer then

				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end

				StartHandcuffTimer()
			end

		end
	end)

end)

RegisterNetEvent('meeta_handcruffs:unrestrain')
AddEventHandler('meeta_handcruffs:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		DisplayRadar(true)
		TriggerEvent("meeta_handcruffs:headbagOut")

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	HandcuffTimer.Active = true

	HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
		TriggerEvent('meeta_handcruffs:unrestrain')
		HandcuffTimer.Active = false
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('meeta_handcruffs:unrestrain')
		TriggerEvent('meeta_handcruffs:removeSpecialContact', 'police')

		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)