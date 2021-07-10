ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function CreateBlip(coords, text, radius, color, sprite)
	if Config.SetMapBlips then
		local blip = AddBlipForRadius(coords, radius)

		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, 1)
		SetBlipAlpha (blip, 128)

		-- create a blip in the middle
		blip = AddBlipForCoord(coords)

		SetBlipHighDetail(blip, true)
		SetBlipSprite (blip, sprite)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
end

Citizen.CreateThread(function()
	if Config.SetMapBlips then
		for k,zone in pairs(Config.DrugFields) do
			if zone.showOnRadar then
				CreateBlip(zone.blipcoords, zone.name, zone.radius, zone.color, zone.sprite)
			end
		end
	end
end)