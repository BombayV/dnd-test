local job = 'police'

RegisterCommand('test', function()
	SetNuiFocus(true, true)
end)

RegisterNUICallback('join_on_click', function(data, cb)
	if data and data.frequency then
		local isAllowed = false
		for _, allowedJob in pairs(data.frequency.access) do
			if allowedJob == job then
				isAllowed = true
				break
			end
		end
		if isAllowed then
			print('You have joined a new radio')
			cb({ allowed = true, id = GetPlayerServerId(PlayerId()), title = GetPlayerName(PlayerId()), frequency = data.frequency.freq })
			return
		end
	end
	cb({ allowed = false })
end)

RegisterNetEvent('create_radios', function(radios)
	SendNUIMessage({
		action = 'create_radios',
		frequencies = radios
	})
end)