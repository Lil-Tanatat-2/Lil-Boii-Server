-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("meeta_market:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory})
	else
		cb(nil)
	end
end)

ESX.RegisterServerCallback("meeta_market:getMarketData", function(source, cb)
	MySQL.Async.fetchAll("SELECT * FROM meeta_market ORDER BY count DESC", {

	}, function(result)
		if result then
			cb(result)
		else
			cb(nil)
		end
	end)
end)

ESX.RegisterServerCallback("meeta_market:buyMarketData", function(source, cb, itemname, count)
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemname)

	MySQL.Async.fetchAll("SELECT * FROM meeta_market WHERE item = @item", {
		['@item'] = itemname
	}, function(result)
		if result[1] then
			if xItem.limit ~= -1 and (xItem.count+count) > xItem.limit then
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = '<strong class="red-text">ช่องเก็บของไม่เพียงพอ</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				}) 
			else
				if result[1].count > 0 then

					local price = result[1].price*count

					if xPlayer.getMoney() >= price then
						xPlayer.removeMoney(price)
						xPlayer.addInventoryItem(itemname, count)

						MySQL.Async.execute('UPDATE meeta_market SET count = count-@count WHERE item = @item', {
							['@item']  = itemname,
							['@count'] = count,
						}, function(rows)
							if rows then
								TriggerClientEvent("pNotify:SendNotification", source, {
									text = 'ซื้อ <strong class="yellow-text">'..result[1].label..'</strong> จำนวน <strong class="blue-text">x'..count..'</strong> จ่าย <strong class="green-text">$'..price..'</strong>',
									type = "success",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								}) 
							end
						end)
					else
						TriggerClientEvent("pNotify:SendNotification", source, {
							text = '<strong class="red-text">คุณมีเงินไม่เพียงพอ</strong>',
							type = "success",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						}) 
					end
				else
					TriggerClientEvent("pNotify:SendNotification", source, {
						text = '<strong class="red-text">สินค้าหมด</strong>',
						type = "success",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					}) 
				end
			end
		else
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = '<strong class="red-text">ไม่มีสินค้า</strong>',
				type = "success",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			}) 
		end
	end)
end)

RegisterServerEvent('meeta_market:sellFunction')
AddEventHandler('meeta_market:sellFunction', function(Index, CurrentZone, Count)
	local _source = source
	local Item = CurrentZone.Item[Index]
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = xPlayer.getInventoryItem(Item.ItemName)
	local Price = 0

	if Item.RandomPrice then
		Price = math.random(Item.Price[1], Item.Price[2])
	else
		Price = Item.Price
	end

	if xItem.count <= 0 then
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">คุณมี '..Item.Text..' ไม่พอ</strong> ',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		}) 
	else

		if xItem.count >= Count then
			Price = Price*Count

			xPlayer.addMoney(Price)
			xPlayer.removeInventoryItem(Item.ItemName, Count)

			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = 'คุณได้ขาย <strong class="yellow-text">'..Item.Text_TH..' x'..Count..'</strong> ได้รับ <strong class="green-text">$'..Price..'</strong> ',
				type = "success",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})

			MySQL.Async.execute('UPDATE meeta_market SET count = count+@count WHERE item = @item', {
				['@item']  = Item.ItemName,
				['@count'] = Count,
			})
		else
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="red-text">คุณมี '..Item.Text..' ไม่พอ</strong> ',
				type = "success",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			}) 
		end
	end
end)