-- ============================================================
-- player_position : affiche les coordonnees (x, y, z) du joueur
-- F4 (ou la commande player_position) pour afficher / masquer.
-- ============================================================

local showPosition = false

local function drawText2D(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(true)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end

-- Boucle d'affichage : lance seulement quand l'affichage est active
local function startDisplayLoop()
    CreateThread(function()
        while showPosition do
            local coords = GetEntityCoords(PlayerPedId())
            drawText2D(0.8, 0.9, ('Joueur : X %.3f | Y %.3f | Z %.3f'):format(coords.x, coords.y, coords.z), 0.5)
            Wait(0) -- le texte doit etre redessine a chaque image
        end
    end)
end

RegisterCommand('player_position', function()
    showPosition = not showPosition
    if showPosition then
        local c = GetEntityCoords(PlayerPedId())
        print(('[player_position] x : %.3f, y : %.3f, z : %.3f'):format(c.x, c.y, c.z))
        startDisplayLoop()
    end
end, false)

RegisterKeyMapping('player_position', 'Afficher / masquer la position du joueur', 'keyboard', 'F4')
