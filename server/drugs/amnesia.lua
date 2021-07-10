local playersProcessingAmnesia = {}

RegisterServerEvent('phoenix_droghe:pickedUpAmnesia')
AddEventHandler('phoenix_droghe:pickedUpAmnesia', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	ESX.SetTimeout(Config.Delays.AmnesiaPickup, function()
		if xPlayer.canCarryItem('cima_amnesia', 1) then
			xPlayer.addInventoryItem('cima_amnesia', 1)
		end
	end)
end)

RegisterServerEvent('phoenix_droghe:processAmnesia')
AddEventHandler('phoenix_droghe:processAmnesia', function()
	if not playersProcessingAmnesia[source] then
		local _source = source

		playersProcessingAmnesia[_source] = ESX.SetTimeout(Config.Delays.AmnesiaProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xAmnesia = xPlayer.getInventoryItem('cima_amnesia')

			if xAmnesia.count > 3 then
				if xPlayer.canSwapItem('cima_amnesia', 3, 'amnesia', 1) then
					xPlayer.removeInventoryItem('cima_amnesia', 3)
					xPlayer.addInventoryItem('amnesia', 1)    
				else
					xPlayer.showNotification(_U('processingfull'))
				end
			else
				xPlayer.showNotification(_U('_processingenough'))
			end

			playersProcessingAmnesia[_source] = nil
		end)
	else
		print(('phoenix_droghe: %s attempted to exploit amnesia processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingAmnesia[playerID] then
		ESX.ClearTimeout(playersProcessingAmnesia[playerID])
		playersProcessingAmnesia[playerID] = nil
	end
end

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)