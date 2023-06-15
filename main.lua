io.stdout:setvbuf('no')

Lu = require('../luaunit')

-- Setando para fullscreen para que eu possa pegar toda a largura e altura da tela
love.window.setFullscreen(true);

-- Constantes
Teto = love.graphics.getHeight();
Chao = (love.graphics.getHeight() / 5) * 4 + 36;
Gravidade = 0;
Pos_player_x = 0;
I = 1;

EndX, Ground = love.graphics.getDimensions();

-- Classes Gerenciais
local gerencia = require('entidades/gerencia');
local gerencia_inimigo = require('entidades/gerencia_inimigo');
local gerencia_ataque_module = require('entidades/gerencia_ataque');

-- Entidades
local player = require('entidades/player')
local orc_module = require('entidades/orc_demon')

-- Instanciando Classes
local orc_demon_1 = orc_module.novo(EndX - 200, Ground - 20, 'Orc Demon_1');

-- Cadastrando Inimigos
gerencia_inimigo.add_enemy(orc_demon_1);

function love.load()

    music = love.audio.newSource('songs/theme/ds.mp3', 'static')
    music:setLooping(true) -- so it doesnt stop
    music:setVolume(0.5)
    music:play()

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
    gerencia.generate_sprite(player, 'attack', player.data_sprites.attack.sprite,
        player.data_sprites.attack.width_sprite, player.data_sprites.attack.height_sprite,
        player.data_sprites.attack.width_quad, player.data_sprites.attack.height_quad,
        player.data_sprites.attack.quant_quads, 'right', false, 0.2);
    gerencia.generate_sprite(player, 'death', player.data_sprites.death.sprite, player.data_sprites.death.width_sprite,
        player.data_sprites.death.height_sprite, player.data_sprites.death.width_quad,
        player.data_sprites.death.height_quad, player.data_sprites.death.quant_quads, 'right', false, 0.3);
    gerencia.generate_sprite(player, 'defense', player.data_sprites.defense.sprite,
        player.data_sprites.defense.width_sprite, player.data_sprites.defense.height_sprite,
        player.data_sprites.defense.width_quad, player.data_sprites.defense.height_quad,
        player.data_sprites.defense.quant_quads, 'right', false, 0.3);
    gerencia.generate_sprite(player, 'hp_bar', player.data_sprites.hp_bar.sprite,
        player.data_sprites.hp_bar.width_sprite, player.data_sprites.hp_bar.height_sprite,
        player.data_sprites.hp_bar.width_quad, player.data_sprites.hp_bar.height_quad,
        player.data_sprites.hp_bar.quant_quads, 'right', false, 0.3);

end

function love.draw()

    gerencia.draw(player);
    gerencia_inimigo.draw(orc_demon_1);

    -- Desenhando Hp do personagem
    love.graphics.draw(player.sprites.hp_bar.sprite, player.sprites.hp_bar.quads[I], 0, 0);

    local sx,sy = 75,35

	local c = player.vida/player.vida

	--local color = (128, 0, 0) -- red by 0 and green by 1
	love.graphics.setColor(255, 0, 0, 1)
	love.graphics.rectangle('fill',sx,1.5*sy,200,30, 10, 10, 0)

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle('line',sx,1.5*sy,200,30, 10, 10, 0)
    love.graphics.setColor(1, 1, 1)
end

function love.update(dt)
    gerencia.update(player.char, dt, player);
    gerencia_inimigo.update(orc_demon_1, player, dt);

    Pos_player_x = player.char.x;
end

