local playersProcessingCannabis = {}

RegisterServerEvent('phoenix_droghe:pickedUpCannabis')
AddEventHandler('phoenix_droghe:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	ESX.SetTimeout(Config.Delays.WeedPickup, function()
		if xPlayer.canCarryItem('cannabis', 1) then
			xPlayer.addInventoryItem('cannabis', 1)
		end
	end)
end)

RegisterServerEvent('phoenix_droghe:processCannabis')
AddEventHandler('phoenix_droghe:processCannabis', function()
	if not playersProcessingCannabis[source] then
		local _source = source

		playersProcessingCannabis[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCannabis = xPlayer.getInventoryItem('cannabis')

			if xCannabis.count > 3 then
				if xPlayer.canSwapItem('cannabis', 3, 'marijuana', 1) then
					xPlayer.removeInventoryItem('cannabis', 3)
					xPlayer.addInventoryItem('marijuana', 1)    
				else
					xPlayer.showNotification(_U('weed_processingfull'))
				end
			else
				xPlayer.showNotification(_U('weed_processingenough'))
			end

			playersProcessingCannabis[_source] = nil
		end)
	else
		print(('phoenix_droghe: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingCannabis[playerID] then
		ESX.ClearTimeout(playersProcessingCannabis[playerID])
		playersProcessingCannabis[playerID] = nil
	end
end

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)