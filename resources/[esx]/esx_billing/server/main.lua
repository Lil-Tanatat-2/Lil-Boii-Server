ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function tsToUnix(mysql_ts)
	local pattern = "(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)"
	local xyear, xmonth, xday, xhour, xmin, xsec = mysql_ts:match(pattern)
	local unixTs = os.time({year=xyear, month=xmonth, day=xday, hour=xhour, min=xmin, sec=xsec})
	return unixTs
  end

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(playerId)

	TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)

		if amount < 0 then
			print('esx_billing: ' .. GetPlayerName(_source) .. ' tried sending a negative bill!')
		elseif account == nil then

			if xTarget ~= nil then
				MySQL.Async.execute(
					'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
					{
						['@identifier']  = xTarget.identifier,
						['@sender']      = xPlayer.identifier,
						['@target_type'] = 'player',
						['@target']      = xPlayer.identifier,
						['@label']       = label,
						['@amount']      = amount
					},
					function(rowsChanged)
						TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
							text = _U('received_invoice'),
							type = "success",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					end
				)
			end

		else

			if xTarget ~= nil then
				MySQL.Async.execute(
					'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
					{
						['@identifier']  = xTarget.identifier,
						['@sender']      = xPlayer.identifier,
						['@target_type'] = 'society',
						['@target']      = sharedAccountName,
						['@label']       = label,
						['@amount']      = amount
					},
					function(rowsChanged)
						TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
							text = _U('received_invoice'),
							type = "success",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					end
				)
			end

		end
	end)

end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT id, identifier, sender, target_type, target, label, amount, date_format(time, "%Y-%m-%d") AS time FROM billing WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local bills = {}

			for i=1, #result, 1 do
				table.insert(bills, {
					id         = result[i].id,
					identifier = result[i].identifier,
					sender     = result[i].sender,
					targetType = result[i].target_type,
					target     = result[i].target,
					label      = result[i].label,
					amount     = result[i].amount,
					time		  = result[i].time
				})
			end

			cb(bills)

		end
	)

end)

ESX.RegisterServerCallback('esx_billing:getBillsIdView', function(source, cb, Id)

	MySQL.Async.fetchAll('SELECT id, identifier, sender, target_type, target, label, amount, date_format(time, "%Y-%m-%d") AS time FROM billing WHERE id = @id', {
		['@id'] = Id
	}, function(result)
		cb({
			id         = result[1].id,
			identifier = result[1].identifier,
			sender     = result[1].sender,
			targetType = result[1].target_type,
			target     = result[1].target,
			label      = result[1].label,
			amount     = result[1].amount,
			time		  = result[1].time
		})

	end)

end)

ESX.RegisterServerCallback('esx_billing:getBillsId', function(source, cb, Id)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT id, identifier, sender, target_type, target, label, amount, date_format(time, "%Y-%m-%d") AS time FROM billing WHERE identifier = @identifier AND id = @id', {
		['@identifier'] = xPlayer.identifier,
		['@id'] = Id
	}, function(result)
		cb({
			id         = result[1].id,
			identifier = result[1].identifier,
			sender     = result[1].sender,
			targetType = result[1].target_type,
			target     = result[1].target,
			label      = result[1].label,
			amount     = result[1].amount,
			time		  = result[1].time
		})

	end)

end)

ESX.RegisterServerCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll(
		'SELECT id, identifier, sender, target_type, target, label, amount, date_format(time, "%Y-%m-%d") AS time FROM billing WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local bills = {}

			for i=1, #result, 1 do
				table.insert(bills, {
					id         = result[i].id,
					identifier = result[i].identifier,
					sender     = result[i].sender,
					targetType = result[i].target_type,
					target     = result[i].target,
					label      = result[i].label,
					amount     = result[i].amount,
					time		  = result[i].time
				})
			end

			cb(bills)

		end
	)

end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(id)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll('DELETE FROM billing WHERE id = @id',{
		['@id'] = id
	})

end)


ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM billing WHERE id = @id',
		{
			['@id'] = id
		}, function(result)

			local sender     = result[1].sender
			local targetType = result[1].target_type
			local target     = result[1].target
			local amount     = result[1].amount
			local time     = result[1].time

			local xTarget = ESX.GetPlayerFromIdentifier(sender)

			if targetType == 'player' then

				if xTarget ~= nil then

					if xPlayer.getMoney() >= amount then

						MySQL.Async.execute('DELETE from billing WHERE id = @id',
						{
							['@id'] = id
						}, function(rowsChanged)
							xPlayer.removeMoney(amount)
							xTarget.addMoney(amount)

							TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
								text = _U('paid_invoice', amount),
								type = "success",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
							TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
								text = _U('received_payment', amount),
								type = "success",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})

							cb()
						end)

					elseif xPlayer.getBank() >= amount then

						MySQL.Async.execute('DELETE from billing WHERE id = @id',
						{
							['@id'] = id
						}, function(rowsChanged)
							xPlayer.removeAccountMoney('bank', amount)
							xTarget.addAccountMoney('bank', amount)

							TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
								text = _U('paid_invoice', amount),
								type = "success",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
							TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
								text = _U('received_payment', amount),
								type = "success",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})

							cb()
						end)

					else

						TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
							text = _U('target_no_money'),
							type = "success",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
						TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
							text = _U('no_money'),
							type = "success",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})

						cb()
					end

				else
					TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
						text = _U('player_not_online'),
						type = "success",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})
					cb()
				end

			else

				TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)

					if xPlayer.getMoney() >= amount then

						MySQL.Async.execute('DELETE from billing WHERE id = @id',
						{
							['@id'] = id
						}, function(rowsChanged)
							xPlayer.removeMoney(amount)
							account.addMoney(amount)

							TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
								text = _U('paid_invoice', amount),
								type = "success",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
							if xTarget ~= nil then
								TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
									text = _U('received_payment', amount),
									type = "success",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							end

							cb()
						end)

					elseif xPlayer.getBank() >= amount then

						MySQL.Async.execute('DELETE from billing WHERE id = @id',
						{
							['@id'] = id
						}, function(rowsChanged)
							xPlayer.removeAccountMoney('bank', amount)
							account.addMoney(amount)

							TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
								text = _U('paid_invoice', amount),
								type = "success",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
							if xTarget ~= nil then
								TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
									text = _U('received_payment', amount),
									type = "success",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							end

							cb()
						end)

					else
						TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
							text = _U('no_money'),
							type = "success",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})

						if xTarget ~= nil then
							TriggerClientEvent("pNotify:SendNotification", xTarget.source, {
								text = _U('target_no_money'),
								type = "success",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
						end

						cb()
					end
				end)

			end

		end
	)

end)