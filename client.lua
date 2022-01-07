RegisterNUICallback("dataPost", function(data, cb)
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SetNuiFocus(false)
    if data.isServer then
        TriggerServerEvent(data.event, data.args)
    else
        print(json.encode(data))
        TriggerEvent(data.event, data.args)
    end
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
end)


RegisterNetEvent('nh-context:sendMenu', function(data)
    if not data then return end  
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)
