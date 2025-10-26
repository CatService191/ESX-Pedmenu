ESX = exports["es_extended"]:getSharedObject()

RegisterCommand("ped", function()
    OpenPedMenu()
end, false)

function OpenPedMenu()
    local elements = {
        {label = "Menschen", value = "standard"},
        {label = "Tiere", value = "animals"},
        {label = "Addons", value = "addons"}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_main', {
        title    = "Ped Auswahl",
        align    = "top-left",
        elements = elements
    }, function(data, menu)
        if data.current.value == "standard" then
            OpenPedCategory(Config.StandardPeds, "Standard Peds")
        elseif data.current.value == "animals" then
            OpenPedCategory(Config.AnimalPeds, "Tier Peds")
        elseif data.current.value == "addons" then
            OpenPedCategory(Config.AddonPeds, "Addon Peds")
        end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenPedCategory(list, title)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ped_category', {
        title    = title,
        align    = "top-left",
        elements = list
    }, function(data, menu)
        SetPedModel(data.current.model)
    end, function(data, menu)
        menu.close()
    end)
end

function SetPedModel(model)
    local player = PlayerPedId()
    local modelHash = GetHashKey(model)

    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(10)
    end

    SetPlayerModel(PlayerId(), modelHash)
    SetModelAsNoLongerNeeded(modelHash)
end