local item = require('entidades/item')

local pocao = {}

function pocao.novo()
    local pocao = item.novo('Poção pequena', 'Cura', 50)
    item.vida = 100

    return pocao
end

return pocao