local players = {}
local radios = {
	{ freq = 250, access = {'police'}},
	{ freq = 251, access = {'police'}},
	{ freq = 252, access = {'police', 'ambulance'}},
}

RegisterNetEvent('sync_radio', function(radioData, status)
	local playerId <const> = source

end)

RegisterCommand('customradio', function(source)

end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		print('test')
		Wait(1500)
		TriggerClientEvent('create_radios', -1, radios)
	end
end)
