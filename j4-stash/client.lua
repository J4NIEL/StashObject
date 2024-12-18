local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    exports['qb-target']:AddTargetModel('v_med_pillow', {
        options = {
            {
                type = "client",
                event = "depo", 
                icon = "fas fa-box-open",
                label = "Depoyu aç", 
            },
            {
                type = "server",
                event = "j4-stash:server:SearchStash", 
                icon = "fas fa-search",
                label = "Başka birinin deposunu ara", 
                job = "police" 
            },
        },
        distance = 2.5 
    })
end)


RegisterNetEvent("depo")
AddEventHandler("depo", function()
    TriggerEvent("inventory:client:SetCurrentStash", "Depo_"..QBCore.Functions.GetPlayerData().citizenid)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Depo_"..QBCore.Functions.GetPlayerData().citizenid)
end)

RegisterNetEvent("policeCheckStash")
AddEventHandler("policeCheckStash", function()
    local chance = math.random(1, 100)
    if chance <= 50 then
       
        TriggerEvent("inventory:client:SetCurrentStash", "Depo_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Depo_"..QBCore.Functions.GetPlayerData().citizenid)
    else
       
        TriggerEvent('QBCore:Notify', "Depoyu açamadınız, kontrol ediliyor.", "error")
    end
end)

RegisterNetEvent("j4-stash:client:RequestPlayerID")
AddEventHandler("j4-stash:client:RequestPlayerID", function()

    local dialog = exports['qb-input']:ShowInput({
        header = "Player ID Giriniz",
        submitText = "Ara", 
        inputs = {
            {
                text = "Player ID (#)", 
                name = "playerid", 
                type = "text", 
                isRequired = true, 
            },
        }
    })

    
    if dialog then
        if dialog.playerid then
            TriggerServerEvent("j4-stash:server:HandleStashSearch", dialog.playerid)
        else
            TriggerEvent('QBCore:Notify', "Lütfen bir Player ID girin.", "error")
        end
    end
end)


RegisterNetEvent("j4-stash:client:StartSearch")
AddEventHandler("j4-stash:client:StartSearch", function()
    TriggerServerEvent("j4-stash:server:SearchStash")
end)


RegisterCommand("searchstash", function()
    TriggerEvent("j4-stash:client:StartSearch")
end, false)


RegisterNetEvent("j4-stash:client:OpenStash")
AddEventHandler("j4-stash:client:OpenStash", function(stashName)
    TriggerEvent("inventory:client:SetCurrentStash", stashName)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName)

    print("Stash açıldı: " .. stashName) 
end)
