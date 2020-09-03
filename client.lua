ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(5000)
    end
end)

local playerPed = GetPlayerPed(-1)
local maxHealth = GetEntityMaxHealth(playerPed)
local health = GetEntityHealth(playerPed)
local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))

local HealShop = {
    Base = { Title = "Hôpital" },
    Data = { currentMenu = "Obtenir des Soins Médicaux" },
    Events = {
        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
            if btn.name == "Petit Soin" then
                TriggerServerEvent('soin:petit')
                PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", true)
                local health = GetEntityHealth(GetPlayerPed(-1))
                SetEntityHealth(GetPlayerPed(-1), (health + 50))
                ESX.ShowNotification('Vous avez pris des Petit Soins')
            end
            if btn.name == "Grand Soin" then
                TriggerServerEvent('soin:grand')
                PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", true)
                local health = GetEntityHealth(GetPlayerPed(-1))
                SetEntityHealth(GetPlayerPed(-1), (health + 100))
                ESX.ShowNotification('Vous avez pris des Grand Soins')
            end
        end,
    },

    Menu = {
        ["Obtenir des Soins Médicaux"] = {
            b = {
                {name = "Petit Soin", ask = "~g~1500€", askX = true},
                {name = "Grand Soin", ask = "~g~3000€", askX = true},
            }
        },
    }
}
local point = vector3(304.96, -595.57, 43.28);


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), point) < 1.5 then
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour parler au ~b~Médecin")
		    if IsControlJustPressed(1,51) then 
                CreateMenu(HealShop)
		    end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), point) < 3.5 then
		    if IsControlJustPressed(1,51) then 
                CreateMenu(HealShop)
		    end
        end
    end
end)


Citizen.CreateThread(function()
    local hash = GetHashKey("s_m_m_doctor_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(5000)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_doctor_01", 304.96, -595.57, 42.28, 352.03, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)