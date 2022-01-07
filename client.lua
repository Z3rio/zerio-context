local cacheData = {}

RegisterNUICallback("dataPost", function(id, cb)
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SetNuiFocus(false, false)
    local data = cacheData[id + 1]
    if data then
        if data.params.event then
            if data.params.isServer then
                TriggerServerEvent(data.params.event, data.params.args)
            else
                TriggerEvent(data.params.event, data.params.args)
            end
        end
        if data.params.callback then
            if data.params.args then
                pcall(data.params.callback, data.params.args)
            else
                pcall(data.params.callback)
            end
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

Citizen.CreateThread(function()
    Citizen.Wait(500)
    TriggerEvent("zerio-context:sendMenu", {
        {
            header = "Test"
        },
        {
            header ="Test",
            txt = "Test",
            params = {
                callback = function(args)
                    print(args)
                end,
                args = "give_card"
            }
        }
    })
end)
