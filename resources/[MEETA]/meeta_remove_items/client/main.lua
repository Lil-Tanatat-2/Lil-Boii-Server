local Keys = {
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
local CurrentAction = nil
local IsOpenMenu = false

CurrentItemSelect = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)

end)


function OpenHudMenu()
	loadPlayerInventory()
    IsOpenMenu = true
    
    if CurrentAction == "Weapon" then
        ResultConfig = Config.Mode_illegal
    else
        ResultConfig = Config.Mode_Normal
    end

    SendNUIMessage({
		action = "display",
		mode = CurrentAction
	})

    SetNuiFocus(true, true)
end

function closeHUD()
	IsOpenMenu = false
	CurrentAction = nil
    SendNUIMessage({
        action = "hide"
    })
    SetNuiFocus(false, false)
end

RegisterNUICallback("NUIFocusOff", function()
    closeHUD()
end)

RegisterNUICallback("RemoveItem", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("meeta_remove_items:removeInventoryItem", data.item.type, data.item.name, data.number)
    end

    Wait(500)
    loadPlayerInventory()

    cb("ok")
end)

-- Blips
Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_y_construct_01"))
    while not HasModelLoaded(GetHashKey("s_m_y_construct_01")) do
        Wait(1)
    end

    npc = CreatePed(4, "s_m_y_construct_01", -187.08, 6551.14, 10.11, 43.0, false, true)

    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    Citizen.Wait(200)	
    TaskStartScenarioInPlace(npc, "WORLD_HUMAN_CLIPBOARD", true, true)
    -- local coords = GetEntityCoords(GetPlayerPed(-1))

    -- for k,v in pairs(Config.Zones) do
    --     for i = 1, #v.Pos, 1 do
    --         if v.Blips then
    --             local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)            

    --             SetBlipHighDetail(blip, true)
    --             SetBlipSprite (blip, v.Blips.Spirte)
    --             SetBlipScale  (blip, v.Blips.Size)
    --             SetBlipColour (blip, v.Blips.Color)
    --             SetBlipAsShortRange(blip, true)
    --             SetBlipAlpha (blip, 255)

    --             BeginTextCommandSetBlipName("STRING")
    --             AddTextComponentString(v.Blips.Text)
    --             EndTextCommandSetBlipName(blip)
    --         end
    --     end
    -- end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, v.Color.a, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
					CurrentAction = v.Mode
				end
			end
		end

		if isInMarker and not IsOpenMenu then
			ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to access the ~r~Litter~s~")
			if IsControlJustPressed(0, Keys['E']) then
                OpenHudMenu()
			end
		end

	end
end)

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function loadPlayerInventory()
    --TriggerServerEvent("esx_inventoryhud:KeyLoaded",  GetPlayerServerId(PlayerId()))
    ESX.TriggerServerCallback(
        "esx_inventoryhud:getPlayerInventory",
        function(data)
            items = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                limit = -1,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end

            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        
                        if inventory[key].type == "item_key" then
                            inventory[key].type = "item_key"
                        elseif inventory[key].type == "item_keyhouse" then
                            inventory[key].type = "item_keyhouse"
                        else
                            inventory[key].type = "item_standard"
                        end
                        
                        table.insert(items, inventory[key])
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
                        local ammo = GetWeaponHashFromPickup(weaponHash)
                        table.insert(
                            items,
                            {
                                label = weapons[key].label,
                                count = ammo,
                                limit = -1,
                                type = "item_weapon",
                                name = weapons[key].name,
                                usable = false,
                                rare = false,
                                canRemove = true
                            }
                        )
                    end
                end
            end


            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items
                }
            )
        end,
        GetPlayerServerId(PlayerId())
    )
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		closeHUD()
	end
end)