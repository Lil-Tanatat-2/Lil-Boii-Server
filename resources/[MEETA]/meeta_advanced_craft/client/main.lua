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


function OpenShopMenu()
	loadPlayerInventory()
    IsOpenMenu = true
    
    if CurrentAction == "Weapon" then
        ResultConfig = Config.Mode_illegal
    else
        ResultConfig = Config.Mode_Normal
    end

    SendNUIMessage({
		action = "display",
		mode = CurrentAction,
		data = ResultConfig
	})

    SetNuiFocus(true, true)
end

RegisterNetEvent('meeta_advanced_craft:openCooking')
AddEventHandler('meeta_advanced_craft:openCooking', function()
	loadPlayerInventoryCooking()
    IsOpenMenu = true
    
    SendNUIMessage({
		action = "display",
		mode = "Normal",
		data = Config.Mode_Normal
	})

    SetNuiFocus(true, true)
end)

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

RegisterNUICallback("ClearAll", function(data)
    
    IsOpenMenu = true
    
    if data.mode == "Weapon" then
        ResultConfig = Config.Mode_illegal
        loadPlayerInventory()
    else
        ResultConfig = Config.Mode_Normal
        loadPlayerInventoryCooking()
    end

    SendNUIMessage({
		action = "display",
		mode = data.mode,
		data = ResultConfig
	})

    SetNuiFocus(true, true)
end)

function SetToSuccess(message, items, ConfigItems, Count)
    SendNUIMessage({
        action = "modal",
        message = "",
        closed = false
    })

    TriggerServerEvent("meeta_advanced_craft:GiveItem", items, ConfigItems, Count)

end

RegisterNetEvent('meeta_advanced_craft:SetMessage')
AddEventHandler('meeta_advanced_craft:SetMessage', function(message)
	SendNUIMessage({
        action = "update",
        message = message
    })
end)

function SetToFailed(message, Elem, Items, Counts)

    if Elem.Explosion then
        if Elem.ItemExplosion then

            local Explosion = false

            for k,v in pairs(Elem.ItemExplosion) do
                for kk,vv in pairs(Items) do
                    if v == vv then
                        Explosion = true
                    end
                end
            end

            if Explosion then
                message = '<h4 class="red-text" style="margin:0;">Failed!!!!!!!!!!!!!!!!!!!! RUNNNNNNNNNN</h4>'
            else
                message = message
            end
        
            SendNUIMessage({
                action = "modal",
                message = message,
                closed = Explosion
            })
            
            if Elem.DeleteItem then
                TriggerServerEvent("meeta_advanced_craft:DeleteItem", Items, Counts)
            end

            if Explosion then

                local coords = GetEntityCoords(GetPlayerPed(-1))
                Wait(Config.Explosion.Timer)
                AddExplosion(coords.x, coords.y, coords.z+1, 0, Config.Explosion.DamageScale, true, false, 2.0)
    
            end
        end
        
    else
        SendNUIMessage({
            action = "modal",
            message = message,
            closed = Explosion
        })
        
        if Elem.DeleteItem then
            TriggerServerEvent("meeta_advanced_craft:DeleteItem", Items, Counts)
        end
    end

end

RegisterNUICallback("CarftItem", function(data, cb)

    ResultConfig = Config.Mode_illegal

	for k,v in pairs(ResultConfig) do
		if k == data.mode then
            --PlaySoundFromCoord(self._soundId, self._sound, coords.x, coords.y, coords.z, self._soundSet, 0, 5.0, 0)

            local ItemTable = {}
            local ItemCountTable = {}

            local Item1 = data.item1 or nil
            local Item2 = data.item2 or nil
            local Item3 = data.item3 or nil
            local Item4 = data.item4 or nil
            local Item5 = data.item5 or nil
            local Item6 = data.item6 or nil
            local Item7 = data.item7 or nil
            local Item8 = data.item8 or nil

            local Count1 = data.count1 or nil
            local Count2 = data.count2 or nil
            local Count3 = data.count3 or nil
            local Count4 = data.count4 or nil
            local Count5 = data.count5 or nil
            local Count6 = data.count6 or nil
            local Count7 = data.count7 or nil
            local Count8 = data.count8 or nil

            table.insert(ItemTable, Item1)
            table.insert(ItemTable, Item2)
            table.insert(ItemTable, Item3)
            table.insert(ItemTable, Item4)
            table.insert(ItemTable, Item5)
            table.insert(ItemTable, Item6)
            table.insert(ItemTable, Item7)
            table.insert(ItemTable, Item8)

            table.insert(ItemCountTable, Count1)
            table.insert(ItemCountTable, Count2)
            table.insert(ItemCountTable, Count3)
            table.insert(ItemCountTable, Count4)
            table.insert(ItemCountTable, Count5)
            table.insert(ItemCountTable, Count6)
            table.insert(ItemCountTable, Count7)
            table.insert(ItemCountTable, Count8)

            local ItemResult = table.concat(ItemTable,",")
            local ItemCountResult = table.concat(ItemCountTable,",")

            if v.Used.ItemName == ItemResult and v.Used.ItemCount == ItemCountResult then
                SetToSuccess('<h4 class="green-text" style="margin:0;">Success!</h4>', ItemTable, v, ItemCountTable)
            else
                SetToFailed('<h4 class="red-text" style="margin:0;">Failed!</h4>', v, ItemTable, ItemCountTable)
            end
		end
	end
end)

RegisterNUICallback("PlayAnimationCooking", function(data, cb)
    closeHUD()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, false)
    TriggerEvent("meeta_cooking:spawnObjectOnGrill", Config.Mode_Normal[data.mode].Prop)
    TriggerEvent("pNotify:SendNotification", {
        text = '<strong class="yellow-text">กำลังทำอาหาร...</strong>',
        type = "error",
        timeout = 5000,
        layout = "bottomCenter",
        queue = "global"
    })
end)

RegisterNUICallback("CookingItem", function(data, cb)

    local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    local objectcooking = GetClosestObjectOfType(coords, 30.0, GetHashKey("prop_fish_slice_01"), false, false, false)
    ClearPedTasks(playerPed)
    SetEntityAsMissionEntity(objectcooking, true, true)
    DeleteEntity(objectcooking)

    TriggerEvent("meeta_cooking:cookingClean", Config.Mode_Normal[data.mode].Prop)

    ResultConfig = Config.Mode_Normal

	for k,v in pairs(ResultConfig) do
		if k == data.mode then

            local ItemTable = {}
            local ItemCountTable = {}

            local Item1 = data.item1 or nil
            local Item2 = data.item2 or nil
            local Item3 = data.item3 or nil
            local Item4 = data.item4 or nil
            local Item5 = data.item5 or nil
            local Item6 = data.item6 or nil
            local Item7 = data.item7 or nil
            local Item8 = data.item8 or nil

            local Count1 = data.count1 or nil
            local Count2 = data.count2 or nil
            local Count3 = data.count3 or nil
            local Count4 = data.count4 or nil
            local Count5 = data.count5 or nil
            local Count6 = data.count6 or nil
            local Count7 = data.count7 or nil
            local Count8 = data.count8 or nil

            table.insert(ItemTable, Item1)
            table.insert(ItemTable, Item2)
            table.insert(ItemTable, Item3)
            table.insert(ItemTable, Item4)
            table.insert(ItemTable, Item5)
            table.insert(ItemTable, Item6)
            table.insert(ItemTable, Item7)
            table.insert(ItemTable, Item8)

            table.insert(ItemCountTable, Count1)
            table.insert(ItemCountTable, Count2)
            table.insert(ItemCountTable, Count3)
            table.insert(ItemCountTable, Count4)
            table.insert(ItemCountTable, Count5)
            table.insert(ItemCountTable, Count6)
            table.insert(ItemCountTable, Count7)
            table.insert(ItemCountTable, Count8)

            local ItemResult = table.concat(ItemTable,",")
            local ItemCountResult = table.concat(ItemCountTable,",")

            if v.Used.ItemName == ItemResult then
                TriggerServerEvent("meeta_advanced_craft:GiveItem", ItemTable, v, ItemCountTable)
                TriggerEvent("pNotify:SendNotification", {
                    text = '<strong class="green-text">ทำอาหารเสร็จเรียบร้อยแล้ว</strong>',
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "global"
                })
            else
                TriggerEvent("pNotify:SendNotification", {
                    text = '<strong class="red-text">ส่วนผสมอาหารที่ไม่ถูกต้อง</strong>',
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "global"
                })
                -- SetToFailed('<h4 class="red-text" style="margin:0;">ส่วนผสมอาหารไม่ถูกต้อง!</h4>', v, ItemTable, ItemCountTable)
                ESX.Streaming.RequestAnimDict("anim@mp_player_intcelebrationmale@face_palm", function()
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationmale@face_palm", "face_palm", 8.0, -8.0, -1, 0, 0, false, false, false)
                end)
            end
		end
	end
end)


-- Blips
Citizen.CreateThread(function()
    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
        for i = 1, #v.Pos, 1 do
            if v.Blips then
                local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)            

                SetBlipHighDetail(blip, true)
                SetBlipSprite (blip, v.Blips.Spirte)
                SetBlipScale  (blip, v.Blips.Size)
                SetBlipColour (blip, v.Blips.Color)
                SetBlipAsShortRange(blip, true)
                SetBlipAlpha (blip, 128)

                AddTextEntry('BLIP_CRAFT', v.Blips.Text)
			    BeginTextCommandSetBlipName("BLIP_CRAFT")
                EndTextCommandSetBlipName(blip)
            end
        end
    end
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
			ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to access the ~y~Craft Mode~s~")
			if IsControlJustPressed(0, Keys['E']) then
                OpenShopMenu()
			end
		end

	end
end)

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
            --carkeys = data.carkeys

            if Config.IncludeCash and money ~= nil and money > 0 then
                for key, value in pairs(accounts) do
                    moneyData = {
                        label = _U("cash"),
                        name = "cash",
                        type = "item_money",
                        count = money,
                        usable = false,
                        rare = false,
                        limit = -1,
                        canRemove = true
                    }

                    table.insert(items, moneyData)
                end
            end

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

function loadPlayerInventoryCooking()
    --TriggerServerEvent("esx_inventoryhud:KeyLoaded",  GetPlayerServerId(PlayerId()))
    ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory", function(data)
        items = {}
        inventory = data.inventory

        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].count <= 0 then
                    inventory[key] = nil
                else

                    for k,v in pairs(Config.RawMaterial) do
                        if v ==  inventory[key].name then
                            table.insert(items, inventory[key])
                        end
                    end
                    
                    
                end
            end
        end

        SendNUIMessage(
            {
                action = "setItems",
                itemList = items
            }
        )
    end, GetPlayerServerId(PlayerId()))
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		closeHUD()
	end
end)