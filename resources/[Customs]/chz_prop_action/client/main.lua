ESX                           = nil

local lastBed = 0
local inBed = false
local cam = nil

local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5)
    end

    --LoadMarkers()
end)

local Coordinates = {
    --[[{ x = 29.337753295898, y = -1770.3348388672, z = 29.607357025146 - 0.945 },
    { x = 388.30194091797, y = -874.88238525391, z = 29.295169830322 - 0.945 },
    { x = 26.877752304077, y = -1343.0764160156, z = 29.497024536133 - 0.945 },]]
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local entity, distance = ESX.Game.GetClosestObject({
            'v_med_emptybed',
            'v_med_bed1',
            'v_med_bed2',
        })

        if distance ~= -1 and distance <= 2 then
            if entity ~= nil then
                local medBedCoords = GetEntityCoords(entity)
                if IsControlJustReleased(0, 73) then
                    inBed = false
                    -- RenderScriptCams(0, true, 200, true, true)
                    -- DestroyCam(cam, false)
                end
                if(inBed==false) then
                    ESX.Game.Utils.DrawText3D({ x = medBedCoords.x, y = medBedCoords.y, z = medBedCoords.z + 1 }, '[E],[G],[H],[F] นอน', 0.6)
                else
                    ESX.Game.Utils.DrawText3D({ x = medBedCoords.x, y = medBedCoords.y, z = medBedCoords.z + 1 }, '[X] ลุกขึ้น', 0.6)
                end

                if IsControlJustReleased(0, 38) then
                    local ped = GetPlayerPed(-1)
                    SetEntityHeading(ped,GetEntityHeading(entity)+90)
                    SetEntityCoords(ped, medBedCoords) 
                    OnTheBed(ped, "amb@world_human_bum_slumped@male@laying_on_right_side@base", "base")
                end
				
				if IsControlJustReleased(0, 74) then
                    local ped = GetPlayerPed(-1)
                    SetEntityHeading(ped,GetEntityHeading(entity)-180)
                    SetEntityCoords(ped, medBedCoords) 
                    OnTheBed(ped, "missheistfbi3b_ig8_2", "cpr_loop_victim")
                end
				
				if IsControlJustReleased(0, 23) then
                    local ped = GetPlayerPed(-1)
                    SetEntityHeading(ped,GetEntityHeading(entity)-180)
                    SetEntityCoords(ped, medBedCoords) 
                    OnTheBed(ped, "anim@gangops@morgue@table@", "ko_front")
                end
            else
                Citizen.Wait(500)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function OnTheBed(medBedCoords, inBedDict, inBedAnim)
    inBed = true
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )

    -- cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    -- SetCamActive(cam, true)
    -- RenderScriptCams(true, false, 1, true, true)
    -- AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    -- SetCamFov(cam, 100.0)
    -- SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
    --TaskStartScenarioInPlace(medBedCoords, "world_human_bum_slumped", 0, false)
end