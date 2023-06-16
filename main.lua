io.stdout:setvbuf('no')

Lu = require('../luaunit')

-- Setando para fullscreen para que eu possa pegar toda a largura e altura da tela
love.window.setFullscreen(true);

-- Constantes
Teto = love.graphics.getHeight();
Chao = (love.graphics.getHeight() / 5) * 4 + 36;
Gravidade = 0;
Pos_player_x = 0;
Plane_alive = true;

EndX, Ground = love.graphics.getDimensions();
Music = love.audio.newSource('songs/theme/ds.mp3', 'static')

-- Classes Gerenciais
local gerencia = require('entidades/gerencia');
local gerencia_inimigo = require('entidades/gerencia_inimigo');
local gerencia_ataque_module = require('entidades/gerencia_ataque');

-- Entidades
local player = require('entidades/player')
local orc_module = require('entidades/orc_demon')

-- Instanciando Classes
local orc_demon_1 = orc_module.novo(EndX - 200, Ground - 20, 'Orc Demon_1');

-- Background
local background;
local sx;
local sy;

-- Death Aux
local death_aux_song = 0;

-- Cadastrando Inimigos
gerencia_inimigo.add_enemy(orc_demon_1);

function love.load()

    love.window.setTitle('Berserk')
    love.window.setFullscreen(true)

    background = love.graphics.newImage('imagens/background/background.jpeg')

    sx = love.graphics.getWidth() / background:getWidth()
    sy = love.graphics.getHeight() / background:getHeight()

    Music:setLooping(true) -- so it doesnt stop
    Music:setVolume(0.001)
    Music:play()

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
    gerencia.generate_sprite(player, 'text_player_death', player.data_sprites.text_player_death.sprite,
        player.data_sprites.text_player_death.width_sprite, player.data_sprites.text_player_death.height_sprite,
        player.data_sprites.text_player_death.width_quad, player.data_sprites.text_player_death.height_quad,
        player.data_sprites.text_player_death.quant_quads, 'right', false, 0.3);

end

function love.draw()

    if (Plane_alive) then
        -- Resetando auxiliadores morte
        death_aux_song = 0;
        player.sprites.text_player_death.animation.idle = true;
        background = love.graphics.newImage('imagens/background/background.jpeg')
        player.state = 'peaceful'

        love.graphics.draw(background, 0, 0, 0, sx, sy) -- x: 0, y: 0, rot: 0, scale x and scale y

        gerencia.draw(player);
        gerencia_inimigo.draw(orc_demon_1);

        local h_bar_x, h_bar_y = 67, 37;

        local c = player.vida / player.vida;

        love.graphics.setColor(love.math.colorFromBytes(168, 20, 0));
        love.graphics.rectangle('fill', h_bar_x, 1.5 * h_bar_y, player.vida * 1.5, 23, 10, 10, 0);

        love.graphics.setColor(0, 0, 0);
        love.graphics.rectangle('line', h_bar_x, 1.5 * h_bar_y, player.vida * 1.5, 23, 10, 10, 0);
        love.graphics.setColor(255, 255, 255);

        -- Desenhando Hp do personagem
        love.graphics.draw(player.sprites.hp_bar.sprite, player.sprites.hp_bar.quads[1], 0, 0);

    else
        player.sprites.text_player_death.animation.idle = false;
        -- Background de morte
        background = love.graphics.newImage('imagens/background/background_death.png');
        sx = love.graphics.getWidth() / background:getWidth();
        sy = love.graphics.getHeight() / background:getHeight();

        love.graphics.draw(background, 0, 0, 0, sx, sy); -- x: 0, y: 0, rot: 0, scale x and scale y

        love.graphics.draw(player.sprites.text_player_death.sprite,
            player.sprites.text_player_death.quads[player.sprites.text_player_death.animation.frame],
            love.graphics.getWidth() / 2 - player.sprites.text_player_death.quad_w / 2, love.graphics.getHeight() / 2);

        -- Musica de morte
        if (death_aux_song == 0) then
            Music:stop();
            Music = love.audio.newSource('songs/death/player_death.mp3', 'static');
            Music:setLooping(false); -- so it doesnt stop
            Music:setVolume(0.01);
            Music:play();
            death_aux_song = death_aux_song + 1;
        end

        if love.keyboard.isDown('space') then
            player.vida = 100;
        end
    end

end

function love.update(dt)
    gerencia.update(player.char, dt, player);
    gerencia_inimigo.update(orc_demon_1, player, dt);

    Pos_player_x = player.char.x;

    -- Sprite texto morte do player
    if not (player.sprites.text_player_death.animation.idle) then
        player.sprites.text_player_death.animation.timer = player.sprites.text_player_death.animation.timer + dt;

        if player.sprites.text_player_death.animation.timer > player.sprites.text_player_death.animation.duration then
            player.sprites.text_player_death.animation.timer = 0.1;

            if (not (player.sprites.text_player_death.animation.frame ==
                player.sprites.text_player_death.animation.max_frames)) then
                player.sprites.text_player_death.animation.frame = player.sprites.text_player_death.animation.frame + 1;
            else
                player.sprites.text_player_death.animation.frame = 1
            end
        end
    end

end

