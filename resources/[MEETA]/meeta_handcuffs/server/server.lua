-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('meeta_handcruffs:checkItem', function(source, cb, item, item2)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	local xItem2 = xPlayer.getInventoryItem(item2)

	if xItem.count >= 1 then
		cb(true, (xItem2.count >= 1))
	else
		cb(false, (xItem2.count >= 1))
	end
end)

ESX.RegisterUsableItem('handcuffs', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getInventoryItem('handcuffs').count > 0 then
			TriggerClientEvent("meeta_handcruffs:selectPlayer", _source)
        else
			TriggerClientEvent("pNotify:SendNotification", _source, {
                text = '<strong class="red-text">คุณไม่มีกุญแจมือ</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            })
		end
	end
end)

RegisterServerEvent('meeta_handcruffs:notify')
AddEventHandler('meeta_handcruffs:notify', function(target)
	TriggerClientEvent("pNotify:SendNotification", target, {
        text = 'มีคนพยายามจะใส่ <strong class="red-text">กุญแจมือ</strong> คุณ',
        type = "error",
        timeout = 3000,
        layout = "bottomCenter",
        queue = "global"
    })
end)

RegisterServerEvent('meeta_handcruffs:handcuff')
AddEventHandler('meeta_handcruffs:handcuff', function(target, playerheading, playerCoords, playerlocation)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getInventoryItem('handcuffs').count > 0 then
		--TriggerClientEvent('meeta_handcruffs:handcuff', target)
        --xPlayer.removeInventoryItem('handcuffs', 1)
        TriggerClientEvent('meeta_handcruffs:getarrested', target, playerheading, playerCoords, playerlocation)
    	TriggerClientEvent('meeta_handcruffs:doarrested', source)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {
            text = '<strong class="red-text">คุณไม่มีกุญแจมือ</strong>',
            type = "error",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "global"
        })
	end
end)

RegisterServerEvent('meeta_handcruffs:unhandcuff')
AddEventHandler('meeta_handcruffs:unhandcuff', function(target, playerheading, playerCoords, playerlocation)
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getInventoryItem('handcuffs_key').count > 0 then
        TriggerClientEvent('meeta_handcruffs:getuncuffed', target, playerheading, playerCoords, playerlocation)
        TriggerClientEvent('meeta_handcruffs:douncuffing', source)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {
            text = '<strong class="red-text">คุณไม่มีลูกกุญแจมือ</strong>',
            type = "error",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "global"
        })
	end
	
end)

-- ESX.RegisterServerCallback('meeta_handcruffs:getOtherPlayerData', function(source, cb, target)

--     local xPlayer = ESX.GetPlayerFromId(target)

--     local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
--         ['@identifier'] = xPlayer.identifier
--     })

--     local firstname = result[1].firstname
--     local lastname  = result[1].lastname
--     local sex       = result[1].sex
--     local dob       = result[1].dateofbirth
--     local height    = result[1].height

--     local data = {
--         name      = GetPlayerName(target),
--         job       = xPlayer.job,
--         inventory = xPlayer.inventory,
--         accounts  = xPlayer.accounts,
--         weapons   = xPlayer.loadout,
--         firstname = firstname,
--         lastname  = lastname,
--         sex       = sex,
--         dob       = dob,
--         height    = height
--     }

--     TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
--         if status ~= nil then
--             data.drunk = math.floor(status.percent)
--         end
--     end)

--     if Config.EnableLicenses then
--         TriggerEvent('esx_license:getLicenses', target, function(licenses)
--             data.licenses = licenses
--             cb(data)
--         end)
--     else
--         cb(data)
--     end

-- end)