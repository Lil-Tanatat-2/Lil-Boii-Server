local status = nil
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(100)
        
        SendNUIMessage({
            show = IsPauseMenuActive(),
            health = (GetEntityHealth(PlayerPedId())-100),
            st = status,
        })
    end
end)