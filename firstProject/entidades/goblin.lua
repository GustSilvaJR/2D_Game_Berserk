local inimigo = require('entidades/inimigo')
local player = require('entidades/player')
local goblin = {}

function goblin.novo()
    local goblin = inimigo.novo(10, 'Goblins')
    goblin.envenena = true
    goblin.mago = false

    return goblin
end

function goblin.novo_mago()
    local goblin = goblin.novo()
    goblin.envenena = false
    goblin.mago = true
    return goblin
end

function goblin.atacar(goblin_enemy, p )
    print("Goblin atacou  " .. p.nome.. "!")
    player.atacado(p, goblin_enemy.forca)
end

return goblin