-- MODIFY BY THANAWUT PROMRAUNGDET THANK SOURCE FROM https://forum.fivem.net/t/release-crate-drop/113125

local pilot, aircraft, parachute, crate, pickup, blip, soundID
local requiredModels = {"p_cargo_chute_s", "ex_prop_adv_case_sm", "cuban800", "s_m_m_pilot_02", "prop_box_wood02a_pu"}
local getCrate = true
local itemObj = {}
ESX = nil
local PlayerData = {}

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


-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(Config.Time)
--         if ESX.GetPlayerData().job.name ~= 'police' and ESX.GetPlayerData().job.name ~= 'ambulance' then
        
--             local Location = Config.DropZone
--             local random_location = math.random(#Location)
--             TriggerEvent("crateDrop", true, 400.0, {["x"] = dropCoords.x, ["y"] = dropCoords.y, ["z"] = dropCoords.z})
--         end
-- 	end
    
-- end)

RegisterNetEvent("meeta_airdrop:sendBlips")
AddEventHandler("meeta_airdrop:sendBlips", function(location_x, location_y, location_z)
    if ESX.GetPlayerData().job.name ~= 'police' and ESX.GetPlayerData().job.name ~= 'ambulance' then

            blip = AddBlipForCoord(location_x, location_y, location_z)
            SetBlipSprite(blip, 4)
            SetBlipColour(blip, 1)
            SetBlipAlpha(blip, 255)
    end
end)

RegisterNetEvent("meeta_airdrop:removeBlips")
AddEventHandler("meeta_airdrop:removeBlips", function(location_x, location_y, location_z)
    if ESX.GetPlayerData().job.name ~= 'police' and ESX.GetPlayerData().job.name ~= 'ambulance' then

        RemoveBlip(blip)

    end
end)



RegisterNetEvent("meeta_airdrop:crateDrop")
AddEventHandler("meeta_airdrop:crateDrop", function(roofCheck, planeSpawnDistance)
    Citizen.CreateThread(function()
	
		local dropCoords = GetEntityCoords(GetPlayerPed(-1))

        if dropCoords.x and dropCoords.y and dropCoords.z and tonumber(dropCoords.x) and tonumber(dropCoords.y) and tonumber(dropCoords.z) then

        else
            dropCoords = {0.0, 0.0, 72.0}
        end
		
		TriggerServerEvent("meeta_airdrop:blips", dropCoords)
		
		Citizen.Wait(300000)

        if roofCheck and roofCheck ~= "false" then 

            local ray = StartShapeTestRay(vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), vector3(dropCoords.x, dropCoords.y, dropCoords.z), -1, -1, 0)
            local _, hit, impactCoords = GetShapeTestResult(ray)

            if hit == 0 or (hit == 1 and #(vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(impactCoords)) < 10.0) then 

                CrateDrop(planeSpawnDistance, dropCoords)
            else
                return
            end
        else
            CrateDrop(planeSpawnDistance, dropCoords)
			
        end
		

    end)
end)

function CrateDrop(planeSpawnDistance, dropCoords)
    --Citizen.CreateThread(function()

        for i = 1, #requiredModels do
            RequestModel(GetHashKey(requiredModels[i]))
            while not HasModelLoaded(GetHashKey(requiredModels[i])) do
                Wait(0)
            end
        end

        RequestWeaponAsset(GetHashKey("WEAPON_FLARE")) 
        while not HasWeaponAssetLoaded(GetHashKey("WEAPON_FLARE")) do
            Wait(0)
        end

        local rHeading = math.random(0, 360) + 0.0
        local planeSpawnDistance = (planeSpawnDistance and tonumber(planeSpawnDistance) + 0.0) or 400.0 
        local theta = (rHeading / 180.0) * 3.14
        local rPlaneSpawn = vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(math.cos(theta) * planeSpawnDistance, math.sin(theta) * planeSpawnDistance, -500.0) 

        local dx = dropCoords.x - rPlaneSpawn.x
        local dy = dropCoords.y - rPlaneSpawn.y
        local heading = GetHeadingFromVector_2d(dx, dy) 

        aircraft = CreateVehicle(GetHashKey("cuban800"), rPlaneSpawn, heading, false, true)
        SetEntityCollision(aircraft, false)
        SetEntityRecordsCollisions(aircraft, false)
        SetEntityHeading(aircraft, heading)
        SetVehicleDoorsLocked(aircraft, 2) 
        SetEntityDynamic(aircraft, true)
        ActivatePhysics(aircraft)
        SetVehicleForwardSpeed(aircraft, 60.0)
        SetHeliBladesFullSpeed(aircraft) 
        SetVehicleEngineOn(aircraft, true, true, false)
        ControlLandingGear(aircraft, 3) 
        OpenBombBayDoors(aircraft) 
        SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)

        pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)
        SetBlockingOfNonTemporaryEvents(pilot, true) 
        SetPedRandomComponentVariation(pilot, false)
        SetPedKeepTask(pilot, true)
        SetPlaneMinHeightAboveTerrain(aircraft, 50) 

        TaskVehicleDriveToCoord(pilot, aircraft, vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), 60.0, 0, GetHashKey("cuban800"), 262144, 15.0, -1.0) 

        local droparea = vector2(dropCoords.x, dropCoords.y)
        local planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
        while not IsEntityDead(pilot) and #(planeLocation - droparea) > 5.0 do 
            Wait(50)
            planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y) 
        end

        if IsEntityDead(pilot) then 
            print("PILOT: dead")
            do return end
        end

        TaskVehicleDriveToCoord(pilot, aircraft, 0.0, 0.0, 500.0, 60.0, 0, GetHashKey("cuban800"), 262144, -1.0, -1.0) 
        SetEntityAsNoLongerNeeded(pilot) 
        SetEntityAsNoLongerNeeded(aircraft)

        local crateSpawn = vector3(dropCoords.x, dropCoords.y, GetEntityCoords(aircraft).z - 5.0) 

        local Item = Config.Items
        local random_item = math.random(#Item)
        
        crate = CreateObject(GetHashKey("prop_box_wood02a_pu"), crateSpawn, true, true, true) 
        SetEntityLodDist(crate, 1000) 
        ActivatePhysics(crate)
        SetDamping(crate, 2, 0.1) 
        SetEntityVelocity(crate, 0.0, 0.0, -2.0) 

        AttachEntityToEntity(parachute, crate, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

        while HasObjectBeenBroken(crate) == false do
            Wait(0)
        end
        
        local parachuteCoords = GetEntityCoords(crate)
        
        --ShootSingleBulletBetweenCoords(parachuteCoords.x, parachuteCoords.y, parachuteCoords.z, parachuteCoords.x, parachuteCoords.y, parachuteCoords.z+1.0, 0, false, GetHashKey("WEAPON_FLARE"), 0, true, false, -1.0) 
        AddExplosion(parachuteCoords.x, parachuteCoords.y, parachuteCoords.z, 22, 1.0, true, false, 0.0)

        --DeleteObject(parachute)
        DetachEntity(crate)
        TriggerEvent('meeta_airdrop:removeBlips')

        while DoesObjectOfTypeExistAtCoords(parachuteCoords, 10.0, GetHashKey("w_am_flare"), true) do
            Wait(0)
            local prop = GetClosestObjectOfType(parachuteCoords, 10.0, GetHashKey("w_am_flare"), false, false, false)
            RemoveParticleFxFromEntity(prop)
            SetEntityAsMissionEntity(prop, true, true)
            DeleteObject(prop)
        end

        TriggerServerEvent('meeta_airdrop:dropItemTest', vector3(dropCoords.x, dropCoords.y, dropCoords.z) , Item[random_item])
        
        for i = 1, #requiredModels do
            Wait(0)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end

        RemoveWeaponAsset(GetHashKey("WEAPON_FLARE"))
        --getCrate = true


    --end)
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end
function getItemInAirDrop()

	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
	TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
			
	Citizen.Wait(8000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
	
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
		for k, v in pairs(itemObj) do
			ESX.Game.DeleteObject(v)
		end

        SetEntityAsMissionEntity(pilot, false, true)
        DeleteEntity(pilot)
        SetEntityAsMissionEntity(aircraft, false, true)
        DeleteEntity(aircraft)
        DeleteEntity(parachute)
        DeleteEntity(crate)
        RemovePickup(pickup)
        RemoveBlip(blip)

        for i = 1, #requiredModels do
            Wait(0)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end

    end
end)