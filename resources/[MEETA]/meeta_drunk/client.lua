
local drunkDriving 	 		 = false
local level					 = -1
local drunk					 = false
local timing				 = false

local knockedOut = false
local wait = 60
local wait_drunk = 300
local wait_drink = 30
local isDrunk = false
local isDrink = false

--Bong
local IsBong = false
local DrunkBong = false

-- Energy
local DrinkEnergy = false

local random_count = math.random(6, 9)
local random_count_knock = math.random(7, 9)
local random_knockWeed = math.random(1, 5)

local IsCustomAnimationWalk = false
local CurerntWalkAnimationDict = ""
local CurerntWalkAnimationAnim = ""

RegisterNetEvent('meeta_drunk:hookah')
AddEventHandler('meeta_drunk:hookah', function()
	if not IsBong then
		local prop_name = 'hei_heist_sh_bong_01'
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_name), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			IsBong = true
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)        
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.10, -0.25, 0.0, 95.0, 190.0, 180.0, true, true, false, true, 1, true)
			RequestAnimDict('"anim@safehouse@bong')  
			while not HasAnimDictLoaded('"anim@safehouse@bong') do
				Wait(0)
			end
			TaskPlayAnim(playerPed, '"anim@safehouse@bong', 'bong_stage1', 8.0, -8, -1, 49, 0, 0, 0, 0)
			Wait(10000)
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
			PlaceObjectOnGroundProperly(prop)
			Wait(1000)
			SetRunSprintMultiplierForPlayer(playerPed, 10)
			TriggerEvent('meeta_drunk:GetDrunkWeed')
			TriggerServerEvent('meeta_drunk:DeleteWeed')
			IsBong = false
			DrunkBong = true
			--DoScreenFadeOut(1000)
			Citizen.Wait(1000)
			ClearPedTasksImmediately(playerPed)
			SetTimecycleModifier("spectator5")
			SetPedMotionBlur(playerPed, true)
			SetPedIsDrunk(playerPed, true)
			--DoScreenFadeIn(1000)
		 end)			
	else
		ShowNotification("~r~Please wait...")
	end
end)

RegisterNetEvent('meeta_drunk:victim')
AddEventHandler('meeta_drunk:victim', function()
	local particleDictionary = "core"
	local particleName = "ent_amb_peeing"
	local animDictionary = 'missfbi3ig_0'
	local animName = 'shit_loop_trev'

	RequestNamedPtfxAsset(particleDictionary)
	while not HasNamedPtfxAssetLoaded(particleDictionary) do
		Citizen.Wait(0)
	end

	RequestAnimDict(animDictionary)

	while not HasAnimDictLoaded(animDictionary) do
		Citizen.Wait(0)
	end

	SetPtfxAssetNextCall(particleDictionary)
	bone = GetPedBoneIndex(GetPlayerPed(-1), 11816)

	TaskPlayAnim(GetPlayerPed(-1), animDictionary, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
	effect = StartParticleFxLoopedOnPedBone(particleName, GetPlayerPed(-1), 0.0, 0.5, 0.0, 0.0, 0.0, 20.0, bone, 2.0, false, false, false);
	Wait(2000)
	StopParticleFxLooped(effect, 0)
	ClearPedTasks(GetPlayerPed(-1))
	isDrunk = false
	random_count = math.random(3, 6)
	random_count_knock = math.random(7, 9)
end)

RegisterNetEvent('meeta_drunk:GetDrunkWeed') 
AddEventHandler('meeta_drunk:GetDrunkWeed', function()
	level = level + 1

	local ped = GetPlayerPed(-1)

	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 1.0
		setPlayerDrunkWeed(anim, "FAMILY5_DRUG_TRIP_SHAKE", shake)
		wait_drunk = 180
	elseif level == 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 2.0
		setPlayerDrunkWeed(anim, "FAMILY5_DRUG_TRIP_SHAKE", shake)
		wait_drunk = 180
	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunkWeed(anim, "FAMILY5_DRUG_TRIP_SHAKE", shake)
		wait_drunk = 180
	elseif level >= 3 then
		anim = "move_m@drunk@verydrunk"
		shake = 3.0
		setPlayerDrunkWeed(anim, "FAMILY5_DRUG_TRIP_SHAKE", shake)
		wait_drunk = 180
	elseif level >= 4 then
		anim = "move_m@drunk@verydrunk"
		shake = 4.0
		setPlayerDrunkWeed(anim, "FAMILY5_DRUG_TRIP_SHAKE", shake)
		wait_drunk = 180
	elseif level >= 5 then
		anim = "move_m@drunk@verydrunk"
		shake = 5.0
		setPlayerDrunkWeed(anim, "FAMILY5_DRUG_TRIP_SHAKE", shake)
		wait_drunk = 180
	end

	if level == random_knockWeed then
		wait = 60
		knockedOut = true
	end

end)

RegisterNetEvent('meeta_drunk:GetDrunkEnergy') 
AddEventHandler('meeta_drunk:GetDrunkEnergy', function()
	level = level + 1

	wait_drink = 180
	DrinkEnergy = true

	if level == 1 then
		wait = 60
		knockedOut = true
	end

end)

RegisterNetEvent('meeta_drunk:GetDrunk') 
AddEventHandler('meeta_drunk:GetDrunk', function()
	level = level + 1

	local ped = GetPlayerPed(-1)

	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		wait_drunk = 300
	elseif level == 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		wait_drunk = 600
	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		wait_drunk = 900
	elseif level >= 3 then
		anim = "move_m@drunk@verydrunk"
		shake = 3.0
		setPlayerDrunk(anim, shake)
		wait_drunk = 1200
	elseif level >= 4 then
		anim = "move_m@drunk@verydrunk"
		shake = 4.0
		setPlayerDrunk(anim, shake)
		wait_drunk = 1500
	elseif level >= 5 then
		anim = "move_m@drunk@verydrunk"
		shake = 5.0
		setPlayerDrunk(anim, shake)
		wait_drunk = 1800
	end
	
	--if level == random_count then
	if level == random_count then

		isDrunk = true
		TriggerEvent('meeta_drunk:victim')
	else
		isDrunk = false
	end

	if level == random_count_knock then
		wait = 60
		knockedOut = true
		level = -1
	end

end)

RegisterNetEvent('meeta_drunk:setWalk') 
AddEventHandler('meeta_drunk:setWalk', function(dict, anim)
	IsCustomAnimationWalk = true
	CurerntWalkAnimationDict = dict
	CurerntWalkAnimationAnim = anim
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = GetPlayerPed(-1)
		if knockedOut == true then
			SetPlayerInvincible(PlayerId(), true)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(ped)
			isDrunk = true

			if wait <= 0 then
				
				knockedOut = false
				if not DrunkBong then
					level = -1
					SetPlayerInvincible(PlayerId(), false)
					Sober()
				end
			else
				wait = wait -1
			end

		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		
		if level == -1 then
			if (GetEntityHealth(GetPlayerPed(-1)) < 159) then
				RequestAnimSet("move_m@injured")
				while not HasAnimSetLoaded("move_m@injured") do
					Citizen.Wait(0)
				end
				SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", 1 )
			else
				if IsCustomAnimationWalk then
					RequestAnimSet(CurerntWalkAnimationDict)
					while not HasAnimSetLoaded(CurerntWalkAnimationDict) do
						Citizen.Wait(0)
					end
					SetPedMovementClipset(GetPlayerPed(-1), CurerntWalkAnimationAnim, 1 )
				else
					ResetPedMovementClipset(GetPlayerPed(-1), 0)
				end
				

			end
		end

		if DrinkEnergy then
			SetPedMoveRateOverride(PlayerPedId(), 1.25)
		else
			SetPedMoveRateOverride(PlayerPedId(), 1.0)
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = GetPlayerPed(-1)

		if DrinkEnergy then
			if level >= 0 then
				if wait_drink <= 0 then
					level = -1
					Sober()
				else
					wait_drink = wait_drink -1
				end
	
			end
		else
			if level >= 0 then
				if wait_drunk <= 0 then
					level = -1
					Sober()
				else
					wait_drunk = wait_drunk -1
				end
	
			end
		end

		
	end
end)

function fuckDrunkDriver()

	math.randomseed(GetGameTimer())
	
	local shitFuckDamn = math.random(1, #Config.RandomVehicleInteraction)
	return Config.RandomVehicleInteraction[shitFuckDamn]
end

function setPlayerDrunkWeed(anim, name, shake)
	local PlayerPed = PlayerPedId()

	RequestAnimSet(anim)
      
	while not HasAnimSetLoaded(anim) do
		Citizen.Wait(100)
	end

	SetPedMovementClipset(PlayerPed, anim, true)
	ShakeGameplayCam(name, shake)
	SetPedMotionBlur(PlayerPed, true)
	SetPedIsDrunk(PlayerPed, true)
	SetPedConfigFlag(PlayerPed, 100, true)

end

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


function Sober()

	--Citizen.CreateThread(function()
	local playerPed = PlayerPedId()
	ClearTimecycleModifier()
	level = -1
	DrunkBong = false
	timing = false
	drunk = false
	drunkDriving = false
	isDrunk = false
	DrinkEnergy = false
	wait_drunk = 0
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(playerPed, 0)
	SetPedIsDrunk(playerPed, false)
	SetPedMotionBlur(playerPed, false)
	ClearPedSecondaryTask(playerPed)
	ShakeGameplayCam("DRUNK_SHAKE", 0.0)
	SetPedMoveRateOverride(PlayerPedId(), 1.0)

	--end)
end

RegisterNetEvent('meeta_drunk:drink') 
AddEventHandler('meeta_drunk:drink', function()
	if not isDrunk then
		local prop_name = 'prop_beer_blr'
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_name), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--TriggerEvent('meeta_drunk:GetDrunk')
		
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			isDrunk = true
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)        
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.07, -0.15, 0.015, 270.0, 175.0, 20.0, true, true, false, true, 1, true)
			--AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Wait(0)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
			Wait(7000)
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
			PlaceObjectOnGroundProperly(prop)
			Wait(1000)
			TriggerEvent('meeta_drunk:GetDrunk')
			TriggerServerEvent('meeta_drunk:DeleteBeer')
		end)
	else
		ShowNotification("~r~Please wait...")
	end
end)

RegisterNetEvent('meeta_drunk:drinkEnergy') 
AddEventHandler('meeta_drunk:drinkEnergy', function()
	if not isDrunk then
		local prop_name = 'prop_energy_drink'
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_name), false, false, false)
		if object ~= 0 then
			DeleteObject(object)
		end
		--TriggerEvent('meeta_drunk:GetDrunk')
		
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			isDrink = true
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)        
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.125, 0.0, 0.015, 270.0, 175.0, 20.0, true, true, false, true, 1, true)
			--AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Wait(0)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
			Wait(7000)
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
			PlaceObjectOnGroundProperly(prop)
			Wait(1000)
			TriggerEvent('meeta_drunk:GetDrunkEnergy')
			TriggerServerEvent('meeta_drunk:DeleteEnergy')
		end)
	else
		ShowNotification("~r~Please wait...")
	end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		Sober()
	end
end)