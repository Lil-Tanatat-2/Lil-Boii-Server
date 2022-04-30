-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil
local KeyItems = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('meeta_remote:ServerLock')
AddEventHandler('meeta_remote:ServerLock', function(plate)
	local _source = source
	TriggerClientEvent("meeta_remote:ClientLock", _source, plate)
end)
