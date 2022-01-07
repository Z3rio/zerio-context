local cacheData = {}

RegisterNUICallback("dataPost", function(id, cb)
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SetNuiFocus(false, false)
    if cacheData[id + 1].params.event then
        if cacheData[id + 1].params.isServer then
            TriggerServerEvent(cacheData[id + 1].params.event, cacheData[id + 1].params.args)
        else
            TriggerEvent(cacheData[id + 1].params.event, cacheData[id + 1].params.args)
        end
    end
    if cacheData[id + 1].params.callback then
        if cacheData[id + 1].params.args then
            pcall(cacheData[id + 1].params.callback, cacheData[id + 1].params.args)
        else
            pcall(cacheData[id + 1].params.callback)
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
    cacheData = data
end)
