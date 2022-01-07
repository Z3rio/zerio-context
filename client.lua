RegisterNUICallback("dataPost", function(data, cb)
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SetNuiFocus(false, false)
    if data.event then
        if data.isServer then
            TriggerServerEvent(data.event, data.args)
        else
            TriggerEvent(data.event, data.args)
        end
    end
    if data.callback then
        if data.args then
            pcall(data.callback, data.args)
        else
            pcall(data.callback)
        end
    end
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false, false)
end)


RegisterNetEvent('zerio-context:sendMenu', function(data)
    if not data then return end  
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })
end)
