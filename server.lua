local data = {}

AddEventHandler('playerDropped', function(reason)
	local src = source
    
    data[src] = {
        id = src,
        reason = reason,
        coords = GetEntityCoords(GetPlayerPed(src)),
        name = string.gsub(GetPlayerName(src),'~',''),
        timer = os.time() + 45 -- after 45 sec it disappears
    }

    TriggerClientEvent('ltalog:client', -1, data)
end)


CreateThread(function()
    while true do
        Wait(1000)

        for k, v in pairs(data) do
            if os.time() > data[v.id].timer then
                data[v.id] = nil
                TriggerClientEvent('ltalog:client', -1, data)
            end
        end
    end
end)

/*
    add_ace identifier.type:xyz command.testlog allow
*/

RegisterCommand('testlog', function(source, args, raw)
    local reason = 'Leaving'

    data[source] = {
        id = source,
        reason = reason,
        coords = GetEntityCoords(GetPlayerPed(source)),
        name = string.gsub(GetPlayerName(source),'~',''),
        timer = os.time() + 45 -- after 45 sec it disappears
    }

    TriggerClientEvent('ltalog:client', source, data)
end, true)


local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

RegisterCommand('checkkk', function (source, args, raw)
    local Character = VORPcore.getUser(source).getUsedCharacter

    print(json.encode(Character.inventory, {indent = true}))
end)