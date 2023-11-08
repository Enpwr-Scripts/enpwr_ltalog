local locale = '%s has left server\nId: %s\nReason: %s'
local ltaTable = {}
local timer

local function DrawText3Ds(x, y, z, text)
	local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(x, y, z)

	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 223)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), screenX, screenY)
end



RegisterNetEvent('ltalog:client', function(data)
    ltaTable = data

    for k,v in pairs(data) do
        if not v.id then timer = 1000 else timer = 0 end
    end
end)



CreateThread(function()
    while true do

        for k, v in pairs(ltaTable) do
            local coords = GetEntityCoords(PlayerPedId())
            local distance = #( coords.xyz - v.coords.xyz )

            if distance < 15.0 then
                local text = locale:format( v.name, v.id, v.reason )

                DrawText3Ds( v.coords.x, v.coords.y, v.coords.z, text )
            end
        end

        Wait(timer)
    end
end)