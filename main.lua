--Classes Gerenciais
local gerencia = require('entidades/gerencia')

--Entidades
local player = require('entidades/player')
local pocao = require('entidades/pocao')
local goblin = require('entidades/goblin')

--Instanciando Classes
local player1 = player.novo('Gustavo')
local goblin_1 = goblin.novo()
local goblin_mago_1 = goblin.novo_mago()

--Constantes
Teto = love.graphics.getHeight()
Chao = (love.graphics.getHeight() / 5) * 4 + 36
Gravidade = 0

gerencia.telaPrincipal()
gerencia.desenhar(player.char)
gerencia.movimentacao(player.char)



--Adicionar Inventario
--player.obter_pocao(player1, pocao.novo())

--Ataque inimigo
--goblin.atacar(goblin_1 ,player1)
--goblin.atacar(goblin_1 ,player1)
--goblin.atacar(goblin_1 ,player1)




-- assert(#player1.pocoes == 1)

-- for k,v in pairs(goblin_1) do
--     local val = goblin_1[k];

--     if(val) then
--     print(k.." : "..goblin_1[k]);
--     end
-- end
