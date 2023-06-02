io.stdout:setvbuf('no')

Lu = require('../luaunit')

-- Classes Gerenciais
local gerencia = require('entidades/gerencia');
local gerencia_inimigo = require('entidades/gerencia_inimigo');

-- Entidades
local player = require('entidades/player')
local pocao = require('entidades/pocao')
local goblin = require('entidades/goblin')
local orc_module = require('entidades/orc_demon')

-- Instanciando Classes
local goblin_1 = goblin.novo()
local goblin_mago_1 = goblin.novo_mago()
local orc_demon_1 = orc_module.novo(0, Ground, 'Orc Demon');

-- Constantes
Teto = love.graphics.getHeight()
Chao = (love.graphics.getHeight() / 5) * 4 + 36
Gravidade = 0
--------------------------------------------------------------------------------------------------
---OrcDemon Data-----------------------------

-- Sprite Walk-------
local sprite_walk = love.graphics.newImage("imagens/enemyOrcWarrior/Walk.png");

local width_sprite = 672;
local height_sprite = 96;

local width_quad = 96;
local height_quad = 96;

local quant_quads = 7;
-- End Sprite Walk --

---End OrcDemon Data-------------------------

function love.load()
    gerencia.load();

    -- orc_demon = gerencia_inimigo.load(300, Ground, 'Orc Demon');
    -- gerencia_inimigo.generate_sprite(orc_demon, 'walk', sprite_walk, width_sprite, height_sprite, width_quad, height_quad, quant_quads, 'right');

    gerencia.generate_sprite(player, 'walk', player.data_sprites.walk.sprite, player.data_sprites.walk.width_sprite,
        player.data_sprites.walk.height_sprite, player.data_sprites.walk.width_quad,
        player.data_sprites.walk.height_quad, player.data_sprites.walk.quant_quads, 'right', true, 0.2);
    gerencia.generate_sprite(player, 'stopped', player.data_sprites.stopped.sprite,
        player.data_sprites.stopped.width_sprite, player.data_sprites.stopped.height_sprite,
        player.data_sprites.stopped.width_quad, player.data_sprites.stopped.height_quad,
        player.data_sprites.stopped.quant_quads, 'right', false, 0.3);
    gerencia.generate_sprite(player, 'ataque', player.data_sprites.ataque.sprite,
        player.data_sprites.ataque.width_sprite, player.data_sprites.ataque.height_sprite,
        player.data_sprites.ataque.width_quad, player.data_sprites.ataque.height_quad,
        player.data_sprites.ataque.quant_quads, 'right', false, 0.3);

end

function love.draw()
    gerencia.draw(player);
    gerencia_inimigo.draw(orc_demon_1);
end

function love.update(dt)
    gerencia.update(player.char, dt, player)
    gerencia_inimigo.update(orc_demon_1, dt)
end

-- Adicionar Inventario
-- player.obter_pocao(player1, pocao.novo())

-- Ataque inimigo
-- goblin.atacar(goblin_1 ,player1)
-- goblin.atacar(goblin_1 ,player1)
-- goblin.atacar(goblin_1 ,player1)

-- assert(#player1.pocoes == 1)

-- for k,v in pairs(goblin_1) do
--     local val = goblin_1[k];

--     if(val) then
--     print(k.." : "..goblin_1[k]);
--     end
-- end
