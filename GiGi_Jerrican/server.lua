ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('GiGi_Jerrican:buy')
AddEventHandler('GiGi_Jerrican:buy', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 25

	 if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(25)
		xPlayer.addWeapon("weapon_petrolcan")
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Nao tens dinheiro suficiente'})
	end
end)