local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

        if GetDistanceBetweenCoords(coords, Config.DrugFields.AmnesiaField.coords, true) < 3 then
            if not isPickingUp then
				ESX.ShowHelpNotification(_U('amnesia_pickupprompt'))
			end

            if IsControlJustPressed(0, 38) and not isPickingUp then
                PickUpAmnesia()
            end
        else
            Citizen.Wait(500)
        end
    end
end)

-- Disable some ped action
Citizen.CreateThread(function()
    while true do
        if isPickingUp or isProcessing then
            DisableControlAction(0, 32) -- W
			DisableControlAction(0, 34) -- A
			DisableControlAction(0, 31) -- S
			DisableControlAction(0, 30) -- D
			DisableControlAction(0, 22) -- Jump
			DisableControlAction(0, 44) -- Cover
            Wait(0)
        else
            Wait(250)
        end
    end
end)

function PickUpAmnesia()
	isPickingUp = true
    
	TriggerServerEvent('phoenix_droghe:pickedUpAmnesia')

	local timeLeft = Config.Delays.AmnesiaPickup / 1000

	exports['progressBars']:startUI(Config.Delays.AmnesiaPickup, _U('pickup'))

    while timeLeft > 0 do
		
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
	end

	isPickingUp = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.DrugFields.AmnesiaProcessing.coords, true) < 2 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('amnesia_processprompt'))
			end

			if IsControlJustPressed(0, 38) and not isProcessing then
                ProcessAmnesia()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessAmnesia()
	isProcessing = true

	TriggerServerEvent('phoenix_droghe:processAmnesia')
	local timeLeft = Config.Delays.AmnesiaProcessing / 1000
	exports['progressBars']:startUI(Config.Delays.AmnesiaProcessing, _U('processing'))
	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
	end

	isProcessing = false
end
