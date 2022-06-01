RegisterNUICallback('join_on_click', function(data, cb)

end)

RegisterNetEvent('create_radios', function(radios)
	SendNUIMessage({
		action = 'create_radios',
		frequencies = radios
	})
end)