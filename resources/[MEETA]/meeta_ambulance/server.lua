ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('defibrillator', function(source)
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	local xItem = xPlayer.getInventoryItem("license_doctor")
	
	if xItem.count >= 1 then
		TriggerClientEvent('meeta_ambulance:cpr', _source)
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณไม่มี License Doctor</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

ESX.RegisterUsableItem('firstaid', function(source)
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'ambulance' then
		local xItem = xPlayer.getInventoryItem("firstaid")
		
		if xItem.count >= 1 then
			TriggerClientEvent('meeta_ambulance:firstaidUse', _source)
		else
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="red-text">คุณไม่มีชุดปฐมพยาบาล</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		end
	end
	
end)

ESX.RegisterServerCallback('meeta_ambulance:getItem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('meeta_ambulance:revive')
AddEventHandler('meeta_ambulance:revive', function(target)
	TriggerClientEvent('meeta_ambulance:revive', target)
end)

RegisterServerEvent('meeta_ambulance:DeleteItem')
AddEventHandler('meeta_ambulance:DeleteItem', function(Item)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(Item, 1)

end)

RegisterServerEvent('meeta_ambulance:anesthetic1')
AddEventHandler('meeta_ambulance:anesthetic1', function(target)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)	
	local xItem = xPlayer.getInventoryItem("anesthetic1")
	
	if xItem.count >= 1 then
		xPlayer.removeInventoryItem("anesthetic1", 1)
		TriggerClientEvent('meeta_ambulance:anesthetic1', target)
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="green-text">ฉีดยาสลบ 1 เข็ม</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = '<strong class="green-text">หมอได้ฉีดยาสลบให้คุณ 1 เข็ม</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณไม่มีเข็มฉีดยาสลบ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

RegisterServerEvent('meeta_ambulance:anesthetic2')
AddEventHandler('meeta_ambulance:anesthetic2', function(target)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)	
	local xItem = xPlayer.getInventoryItem("anesthetic2")
	
	if xItem.count >= 1 then
		xPlayer.removeInventoryItem("anesthetic2", 1)
		TriggerClientEvent('meeta_ambulance:anesthetic2', target)
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="green-text">ให้น้ำเกลือคนไข้</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = '<strong class="green-text">หมอได้ให้น้ำเกลือให้คุณ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	else
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณไม่มีเข็มให้น้ำเกลือ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end)

RegisterServerEvent('meeta_ambulance:put_cloth')
AddEventHandler('meeta_ambulance:put_cloth', function(target)
	TriggerClientEvent('meeta_ambulance:put_cloth', target)
end)

RegisterServerEvent('meeta_ambulance:unput_cloth')
AddEventHandler('meeta_ambulance:unput_cloth', function(target)
	TriggerClientEvent('meeta_ambulance:unput_cloth', target)
end)