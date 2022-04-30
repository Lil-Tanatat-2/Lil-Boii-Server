ESX = nil
local timer = nil
local maksut = 0
local saannit = 0

TriggerEvent('esx:getSharedObject', function(obj) 
  ESX = obj
end)


RegisterServerEvent('payforplayer2')
AddEventHandler('payforplayer2',function(winnings)
	
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	xPlayer.addMoney(winnings)
end)

RegisterServerEvent('playerpays2')
AddEventHandler('playerpays2',function(bet)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	if xPlayer.get('money') >= bet then
		xPlayer.removeMoney(bet)
		TriggerClientEvent('spinit2',_source)
	else
		TriggerClientEvent('errormessage2',_source)
	end
end)