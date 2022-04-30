ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local selling = false
local success = false
local copscalled = false
local notintrested = false

RegisterNetEvent('meeta_selldrug:checkItem')
AddEventHandler('meeta_selldrug:checkItem', function(Items)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then

		local found = false
		for k,v in pairs(Items) do
			local xItem = xPlayer.getInventoryItem(v.ItemName).count
            if xItem >= 1 then
				found = true
            end
		end
		
		if found then
			TriggerClientEvent("meeta_selldrug:UpdateHas", source, true)
		else
			TriggerClientEvent("meeta_selldrug:UpdateHas", source, false)
		end
	end
end)

function CountCop()
	local xPlayers = ESX.GetPlayers()
	local cops = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end
	return cops
end
  
RegisterNetEvent('meeta_selldrug:trigger')
AddEventHandler('meeta_selldrug:trigger', function(Data)

	selling = true
	if selling == true then
		TriggerEvent('meeta_selldrug:pass_or_fail')
		TriggerClientEvent('esx:showNotification', source, "Negotiating prices with buyers...")
 	end
	
end)

RegisterServerEvent('meeta_selldrug:fetchjob')
AddEventHandler('meeta_selldrug:fetchjob', function()
    local xPlayer  = ESX.GetPlayerFromId(source)
    TriggerClientEvent('meeta_selldrug:getjob', source, xPlayer.job.name)
end)


RegisterNetEvent('meeta_selldrug:sell')
AddEventHandler('meeta_selldrug:sell', function(Data, Ped)

	local cops = CountCop()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Data.ItemName).count
	local payment_price = math.random(Data.Price[1],Data.Price[2])
	local NumofNpc = math.random(1,100)
	local canSell = false
		
	if Data.UseCop == true then
		if cops < Config.CopsRequiredToSell then
			TriggerClientEvent('esx:showNotification', source, "~r~No Cops...")
			canSell = false
		else
			canSell = true
		end
	else
		canSell = true
	end

	if canSell then

		if xItem < 1 then
			TriggerClientEvent('esx:showNotification', source, '#'..NumofNpc..' You not have '..Data.ItemLabel_En)
		else

			if xItem >= 1 and success == true then
				if Data.DirtMoney then
					TriggerClientEvent('esx:showNotification', source, "You got ~r~Dirty Money ~g~x" .. payment_price)
					TriggerClientEvent("meeta_selldrug:animation", source)
					xPlayer.removeInventoryItem(Data.ItemName, 1)
					xPlayer.addAccountMoney('black_money', payment_price)
				else
					TriggerClientEvent('esx:showNotification', source, "You got ~g~Money ~g~x" .. payment_price)
					TriggerClientEvent("meeta_selldrug:animation", source)
					xPlayer.removeInventoryItem(Data.ItemName, 1)
					xPlayer.addMoney(payment_price)
				end
				
				selling = false
			elseif selling == true and success == false and notintrested == true then
				TriggerClientEvent('esx:showNotification', source, '#'..NumofNpc..' ' ..Data.Message1)
				selling = false
			elseif copscalled == true and success == false then
				if Data.UseCop then
					TriggerClientEvent("meeta_selldrug:setNpcCallPolice", source, Ped)
					TriggerClientEvent('esx:showNotification', source, Data.Message2)
				else
					TriggerClientEvent('esx:showNotification', source, Data.Message2)
				end
				
				selling = false
				
			end
		end
	end
end)

RegisterNetEvent('meeta_selldrug:callPolice')
AddEventHandler('meeta_selldrug:callPolice', function(face, hair, sex)
	TriggerClientEvent("meeta_selldrug:notifyPolice", -1, face, source, hair, sex)
	TriggerClientEvent("meeta_selldrug:notifyPoliceMsg", source, hair, sex)
end)

RegisterNetEvent('meeta_selldrug:pass_or_fail')
AddEventHandler('meeta_selldrug:pass_or_fail', function()
	local percent = math.random(1, 11)
	if percent == 7 or percent == 8 or percent == 9 then
		success = false
		notintrested = true
	elseif percent ~= 8 and percent ~= 9 and percent ~= 10 and percent ~= 7 then
		success = true
		notintrested = false
	else
		notintrested = false
		success = false
		copscalled = true
	end
end)

RegisterNetEvent('meeta_selldrug:sell_dis')
AddEventHandler('meeta_selldrug:sell_dis', function()
	TriggerClientEvent('esx:showNotification', source, "You are far.")
end)