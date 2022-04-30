
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('meeta_remove_items:removeInventoryItem')
AddEventHandler('meeta_remove_items:removeInventoryItem', function(type, itemName, itemCount)
	local _source = source

	if type == 'item_standard' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="red-text">ปริมาณที่ไม่ถูกต้อง</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = '<strong class="red-text">ปริมาณที่ไม่ถูกต้อง</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			else
				xPlayer.removeInventoryItem(itemName, itemCount)

				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = 'คุณได้ทิ้ง <strong class="amber-text">'..xItem.label..'</strong> จำนวน <strong class="green-text">'..itemCount..'</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end

	elseif type == 'item_money' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="red-text">จำนวนที่ไม่ถูกต้อง</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local playerCash = xPlayer.getMoney()

			if (itemCount > playerCash or playerCash < 1) then
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = '<strong class="red-text">จำนวนที่ไม่ถูกต้อง</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			else
				xPlayer.removeMoney(itemCount)

				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = 'คุณได้ทิ้ง <strong class="amber-text">เงินสด</strong> จำนวน <strong class="green-text">'..ESX.Math.GroupDigits(itemCount)..'</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end

	elseif type == 'item_account' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="red-text">จำนวนที่ไม่ถูกต้อง</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = '<strong class="red-text">จำนวนที่ไม่ถูกต้อง</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			else
				xPlayer.removeAccountMoney(itemName, itemCount)

				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = 'คุณได้ทิ้ง <strong class="amber-text">'..account.label..'</strong> จำนวน <strong class="green-text">'..ESX.Math.GroupDigits(itemCount)..'</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end

	elseif type == 'item_weapon' then

		local xPlayer = ESX.GetPlayerFromId(source)
		local loadout = xPlayer.getLoadout()

		for i=1, #loadout, 1 do
			if loadout[i].name == itemName then
				itemCount = loadout[i].ammo
				break
			end
		end

		if xPlayer.hasWeapon(itemName) then
			local weaponLabel, weaponPickup = ESX.GetWeaponLabel(itemName), 'PICKUP_' .. string.upper(itemName)

			xPlayer.removeWeapon(itemName)

			if itemCount > 0 then
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = 'คุณได้ทิ้ง <strong class="amber-text">'..weaponLabel..'</strong> กระสุนจำนวน <strong class="green-text">'..ESX.Math.GroupDigits(itemCount)..'</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			else
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = 'คุณได้ทิ้ง <strong class="amber-text">'..weaponLabel..'</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end

	end
end)