local job = 'police'

RegisterNUICallback('join_on_click', function(data, cb)
	if data.frequency then
		local isAllowed = false
		for _, freq in pairs(data.frequency) do
			if freq.access == job then
				print(job)
				isAllowed = true
				break
			end
		end
		if isAllowed then
			print('You have joined a new radio')
			cb({ allowed = true, id = 1, title = 'Test', frequency = data.frequency.freq })
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