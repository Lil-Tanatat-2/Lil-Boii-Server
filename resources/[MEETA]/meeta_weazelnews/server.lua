ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('news_cam', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getInventoryItem('news_cam').count > 0 then
            TriggerClientEvent("Cam:ToggleCam", _source)
        else
			TriggerClientEvent("pNotify:SendNotification", _source, {
                text = '<strong class="red-text">คุณไม่มีกล้องนักข่าว</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            })
		end
	end
end)

ESX.RegisterUsableItem('news_mic', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getInventoryItem('news_mic').count > 0 then
            TriggerClientEvent("Mic:ToggleMic", _source)
        else
			TriggerClientEvent("pNotify:SendNotification", _source, {
                text = '<strong class="red-text">คุณไม่มีไมค์นักข่าว</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            })
		end
	end
end)

ESX.RegisterUsableItem('news_bmic', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getInventoryItem('news_bmic').count > 0 then
            TriggerClientEvent("Mic:ToggleBMic", _source)
        else
			TriggerClientEvent("pNotify:SendNotification", _source, {
                text = '<strong class="red-text">คุณไม่มีไมค์บูม</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            })
		end
	end
end)