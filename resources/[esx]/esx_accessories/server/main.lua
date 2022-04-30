ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_accessories:saveOutfit')
AddEventHandler('esx_accessories:saveOutfit', function(label, skin, accessory)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local count_item = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_' ..accessory
	})

	local String_accessory

	if accessory == 'helmet' then
		String_accessory = "หมวก"
	elseif accessory == 'glasses' then
		String_accessory = "แว่นตา"
	elseif accessory == 'ears' then
		String_accessory = "ตุ้มหู"
	elseif accessory == 'mask' then
		String_accessory = "หน้ากาก"
	end

	local itemSkin = {}
	local item1 = string.lower(accessory) .. '_1'
	local item2 = string.lower(accessory) .. '_2'
	itemSkin[item1] = skin[item1]
	itemSkin[item2] = skin[item2]

	if count_item >= 5 then
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">กระเป๋าคุณเต็ม</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerClientEvent('esx_accessories:loadefaultskin', _source)
	else
		MySQL.Async.execute('INSERT INTO meeta_accessory_inventory(owner, label, skin, type) VALUES (@owner, @label, @skin, @type)', {
			['@owner'] = xPlayer.identifier,
			['@label'] = label,
			['@skin'] = json.encode(itemSkin),
			['@type'] = 'player_' ..accessory
		}, function(rows)
			if rows then
				pay(_source, String_accessory)
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = '<strong class="green-text">บันทึก'..String_accessory..'เรียบร้อยแล้ว</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
		end)
	end

	
end)

function pay(source, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.Price)
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = '<strong class="green-text">ซื้อ'..accessory..'เรียบร้อยแล้ว จ่าย $'..Config.Price..'</strong>',
		type = "success",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
	
	TriggerClientEvent("esx_inventoryhud:getOwnerAccessories", source)
	
end

ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
		local skin = (store.get('skin') and store.get('skin') or {})

		cb(hasAccessory, skin)
	end)

end)

ESX.RegisterServerCallback('esx_accessories:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.get('money') >= Config.Price)
end)
