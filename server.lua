ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('soin:petit')
AddEventHandler('soin:petit', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if(xPlayer.getMoney() >= 1500) then
        local societyAccount = nil
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
            societyAccount = account
        end)
        if societyAccount ~= nil then
            societyAccount.addMoney(1500)
        end
        xPlayer.removeMoney(1500)
        sendNotification(_source, 'Vous avez demandé un petit soin pour 1 500€', 'success', 2500)
    else
       sendNotification(_source, 'Vous n\'avez pas 1 500€', 'error', 2500)
    end
end)


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('soin:grand')
AddEventHandler('soin:grand', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if(xPlayer.getMoney() >= 3000) then
        local societyAccount = nil
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
            societyAccount = account
        end)
        if societyAccount ~= nil then
            societyAccount.addMoney(3000)
        end
        xPlayer.removeMoney(3000)
        sendNotification(_source, 'Vous avez demandé un grand soin pour 3 000€', 'success', 2500)
    else
       sendNotification(_source, 'Vous n\'avez pas 3 000€', 'error', 2500)
    end
end)


function sendNotification(xSource, message, messageType, messageTimeout)
    TriggerClientEvent("pNotify:SendNotification", xSource, {
        text = message,
        type = messageType,
        queue = "lmao",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end