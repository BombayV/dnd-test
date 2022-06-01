local players = {}
local radios = {
	{ freq = 250, access = {'police'}},
	{ freq = 251, access = {'police'}},
	{ freq = 252, access = {'police', 'ambulance'}},
}

RegisterNetEvent('sync_radio', function(radioData, status)
	local playerId <const> = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
end)

RegisterCommand('customradio', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('customradio', source)
	end
end)

AddEventHandler('onServerResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerClientEvent('create_radios', -1, radios)
	end
end)
