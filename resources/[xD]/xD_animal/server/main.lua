ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('ec4edd67-85e0-475a-a4ce-5f10ae6976a3', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		MySQL.Async.fetchAll('SELECT pet FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].pet ~= nil then
				cb(result[1].pet)
			else
				cb('')
			end
		end)
	end	
end)

RegisterServerEvent('c38d5e57-b4af-4a6c-ac4d-432b419a8df2')
AddEventHandler('c38d5e57-b4af-4a6c-ac4d-432b419a8df2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		xPlayer.removeInventoryItem('croquettes', 1)
	end	
end)

ESX.RegisterServerCallback('e9c3cfde-fea9-4803-be0a-269d417b996a', function(source, cb, pet)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if pet ~= nil then
			local price = GetPriceFromPet(pet)

			if price == 0 then
				cb(false)
			end
	
			if xPlayer.getMoney() >= price then
				xPlayer.removeMoney(price)

				MySQL.Async.execute('UPDATE users SET pet = @pet WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@pet'] = pet
				}, function(rowsChanged)
					TriggerClientEvent('c887068e-8236-45c1-82cf-a60264ca5448', xPlayer.source, _U('you_bought', pet, ESX.Math.GroupDigits(price)))
					cb(true)
				end)
			else
				TriggerClientEvent('c887068e-8236-45c1-82cf-a60264ca5448', _source, _U('your_poor'))
				cb(false)
			end
		end
	end
end)

function GetPriceFromPet(pet)
	for i=1, #Config.PetShop, 1 do
		if Config.PetShop[i].pet == pet then
			return Config.PetShop[i].price
		end
	end
	return 0
end