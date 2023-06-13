io.stdout:setvbuf('no')

Lu = require('../luaunit')

-- Setando para fullscreen para que eu possa pegar toda a largura e altura da tela
love.window.setFullscreen(true);

-- Constantes
Teto = love.graphics.getHeight();
Chao = (love.graphics.getHeight() / 5) * 4 + 36;
Gravidade = 0;
Pos_player_x = 0;

EndX, Ground = love.graphics.getDimensions();

-- Classes Gerenciais
local gerencia = require('entidades/gerencia');
local gerencia_inimigo = require('entidades/gerencia_inimigo');
local gerencia_ataque_module = require('entidades/gerencia_ataque');

-- Entidades
local player = require('entidades/player')
local pocao = require('entidades/pocao')
local goblin = require('entidades/goblin')
local orc_module = require('entidades/orc_demon')


-- Instanciando Classes
local goblin_1 = goblin.novo()
local goblin_mago_1 = goblin.novo_mago()
local orc_demon_1 = orc_module.novo(EndX-200, Ground - 20, 'Orc Demon_1');

--Cadastrando Inimigos
gerencia_inimigo.add_enemy(orc_demon_1);


function love.load()
    gerencia.load();
    gerencia_inimigo.load();

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
    gerencia.update(player.char, dt, player);
    gerencia_inimigo.update(orc_demon_1, dt);

    Pos_player_x = player.char.x;
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
