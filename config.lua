Config = {}

-- Language
Config.Locale = 'it'

-- Processing delays
Config.Delays = {
    WeedPickup = 1000,
    WeedProcessing = 3500,
    AmnesiaPickup = 1000,
    AmnesiaProcessing = 5500,
}

-- Map blips
Config.SetMapBlips = true

-- Zones
Config.DrugFields = {
    -- Weed
    WeedField = {
        coords = vector3(2225.5, 5577.6, 53.8),
        blipcoords = vector3(2249, 5590.1, 53.7),
        name = _U('blip_weedfield'),
        color = 25, 
        sprite = 496, 
        radius = 0.0,
        showOnRadar = true
    },
    WeedProcessing = {
        coords = vector3(-34.4, 1950.7, 190.3),
        blipcoords = vector3(-99.2, 1909.3, 197.1),
        name = _U('blip_weedprocess'),
        color = 25, 
        sprite = 496, 
        radius = 0.0,
        showOnRadar = true
    },

    -- Amnesia | NEVER set showOnRadar true!
    AmnesiaField = {
        coords = vector3(280.9, 6798.6, 15.7),
        blipcoords = vector3(280.9, 6798.6, 15.7),
        name = _U('blip_amnesiafield'),
        color = 25, 
        sprite = 496, 
        radius = 0.0,
        showOnRadar = false
    },
    AmnesiaProcessing = {
        coords = vector3(1391.9, 3605.9, 38.9),
        blipcoords = vector3(1391.9, 3605.9, 38.9),
        name = _U('blip_amnesiafield'),
        color = 25, 
        sprite = 496, 
        radius = 0.0,
        showOnRadar = false
    },
}