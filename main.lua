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
Cenario = 'forest';

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
local background_phase1, background_phase2, background_death;
local sx;
local sy;

-- Death Aux
local death_aux_song = 0;

-- Cadastrando Inimigos
gerencia_inimigo.add_enemy(orc_demon_1);

function love.load()

    love.window.setTitle('Berserk')
    love.window.setFullscreen(true)

    background_phase1, background_death = love.graphics.newImage('imagens/background/background.jpeg'),
        love.graphics.newImage('imagens/background/background_death.png');

    background_phase2 = love.graphics.newImage('imagens/background/background_hell.png'); 

    sx = love.graphics.getWidth() / background_phase1:getWidth()
    sy = love.graphics.getHeight() / background_phase1:getHeight()

    Music:setLooping(true) -- so it doesnt stop
    Music:setVolume(0.01)
    Music:play()

    gerencia.load();
    gerencia_inimigo.load();

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
    gerencia.generate_sprite(player, 'damaged', player.data_sprites.damaged.sprite,
        player.data_sprites.damaged.width_sprite, player.data_sprites.damaged.height_sprite,
        player.data_sprites.damaged.width_quad, player.data_sprites.damaged.height_quad,
        player.data_sprites.damaged.quant_quads, 'right', false, 0.2);
    gerencia.generate_sprite(player, 'abaixando', player.data_sprites.abaixando.sprite,
        player.data_sprites.abaixando.width_sprite, player.data_sprites.abaixando.height_sprite,
        player.data_sprites.abaixando.width_quad, player.data_sprites.abaixando.height_quad,
        player.data_sprites.abaixando.quant_quads, 'right', false, 0.3);
    gerencia.generate_sprite(player, 'pulando', player.data_sprites.pulando.sprite,
        player.data_sprites.pulando.width_sprite, player.data_sprites.pulando.height_sprite,
        player.data_sprites.pulando.width_quad, player.data_sprites.pulando.height_quad,
        player.data_sprites.pulando.quant_quads, 'right', false, 0.2);
    gerencia.generate_sprite(player, 'rolamento', player.data_sprites.rolamento.sprite,
        player.data_sprites.rolamento.width_sprite, player.data_sprites.rolamento.height_sprite,
        player.data_sprites.rolamento.width_quad, player.data_sprites.rolamento.height_quad,
        player.data_sprites.rolamento.quant_quads, 'right', false, 0.25);
    gerencia.generate_sprite(player, 'especial', player.data_sprites.especial.sprite,
        player.data_sprites.especial.width_sprite, player.data_sprites.especial.height_sprite,
        player.data_sprites.especial.width_quad, player.data_sprites.especial.height_quad,
        player.data_sprites.especial.quant_quads, 'right', false, 0.2);

end

function love.draw()

    if (Plane_alive) then
        if(Cenario == 'forest')then

        -- Resetando auxiliadores morte
        death_aux_song = 0;
        player.sprites.text_player_death.animation.idle = true;

        sx = love.graphics.getWidth() / background_phase1:getWidth();
        sy = love.graphics.getHeight() / background_phase1:getHeight();

        love.graphics.draw(background_phase1, 0, 0, 0, sx, sy) -- x: 0, y: 0, rot: 0, scale x and scale y

        gerencia.draw(player);
        gerencia_inimigo.draw(orc_demon_1);

        -- BARRA DE HP
        local h_bar_x, h_bar_y = 67, 37;

        love.graphics.setColor(love.math.colorFromBytes(168, 20, 0));
        love.graphics.rectangle('fill', h_bar_x, 1.5 * h_bar_y, player.vida * 1.5, 23, 10, 10, 0);

        love.graphics.setColor(0, 0, 0);
        love.graphics.rectangle('line', h_bar_x, 1.5 * h_bar_y, player.vida * 1.5, 23, 10, 10, 0);
        love.graphics.setColor(255, 255, 255);

        -- Desenhando Hp do personagem
        love.graphics.draw(player.sprites.hp_bar.sprite, player.sprites.hp_bar.quads[1], 0, 0);
        -- FIM BARRA DE HP

        -- BARRA ESPECIAL
        local s_bar_x, s_bar_y = 71, 55;

        love.graphics.setColor(love.math.colorFromBytes(255, 143, 0));
        love.graphics.rectangle('fill', s_bar_x, 1.5 * s_bar_y, player.especial * 1.4, 5, 5, 0);

        love.graphics.setColor(0, 0, 0);
        love.graphics.rectangle('line', s_bar_x, 1.5 * s_bar_y, player.especial_max * 1.4, 5, 5, 0);
        love.graphics.setColor(255, 255, 255);

        -- Desenhando Hp do personagem
        love.graphics.draw(player.sprites.hp_bar.sprite, player.sprites.hp_bar.quads[1], 0, 0);
        -- FIM BARRA DE HP

        elseif(Cenario == 'hell') then  
            
            print('To no inferno')

            --Gerando cenário
            sx = love.graphics.getWidth() / background_phase2:getWidth()
            sy = love.graphics.getHeight() / background_phase2:getHeight()

            love.graphics.draw(background_phase2, 0, 0, 0, sx, sy) -- x: 0, y: 0, rot: 0, scale x and scale y

            gerencia.draw(player);

            -- BARRA DE HP
            local h_bar_x, h_bar_y = 67, 37;

            love.graphics.setColor(love.math.colorFromBytes(168, 20, 0));
            love.graphics.rectangle('fill', h_bar_x, 1.5 * h_bar_y, player.vida * 1.5, 23, 10, 10, 0);

            love.graphics.setColor(0, 0, 0);
            love.graphics.rectangle('line', h_bar_x, 1.5 * h_bar_y, player.vida * 1.5, 23, 10, 10, 0);
            love.graphics.setColor(255, 255, 255);

            -- Desenhando Hp do personagem
            love.graphics.draw(player.sprites.hp_bar.sprite, player.sprites.hp_bar.quads[1], 0, 0);
            -- FIM BARRA DE HP

            -- BARRA ESPECIAL
            local s_bar_x, s_bar_y = 71, 55;

            love.graphics.setColor(love.math.colorFromBytes(255, 143, 0));
            love.graphics.rectangle('fill', s_bar_x, 1.5 * s_bar_y, player.especial * 1.4, 5, 5, 0);

            love.graphics.setColor(0, 0, 0);
            love.graphics.rectangle('line', s_bar_x, 1.5 * s_bar_y, player.especial_max * 1.4, 5, 5, 0);
            love.graphics.setColor(255, 255, 255);

            -- Desenhando Hp do personagem
            love.graphics.draw(player.sprites.hp_bar.sprite, player.sprites.hp_bar.quads[1], 0, 0);
            -- FIM BARRA DE HP
        end

    else
        player.sprites.text_player_death.animation.idle = false;
        -- Background de morte
        sx = love.graphics.getWidth() / background_death:getWidth();
        sy = love.graphics.getHeight() / background_death:getHeight();

        love.graphics.draw(background_death, 0, 0, 0, sx, sy); -- x: 0, y: 0, rot: 0, scale x and scale y

        love.graphics.draw(player.sprites.text_player_death.sprite,
            player.sprites.text_player_death.quads[player.sprites.text_player_death.animation.frame], 10,
            love.graphics.getHeight() - (love.graphics.getHeight() / 8));

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
            Plane_alive = true;
            player.state = 'peaceful';
            player.char.x = 20;

            orc_demon_1.posX = EndX - 200;
            State = 'peaceful';
            print(player.state);
        end
    end

end

function love.update(dt)

    gerencia.update(player.char, dt, player);
    gerencia_inimigo.update(orc_demon_1, player, dt);

    Pos_player_x = player.char.x;

    if (player.state == 'death') then
        Plane_alive = false
    else
        Plane_alive = true
    end

    print(State);

    if(State == 'death' and player.char.x >= EndX - 25) then
        print('teste')
        Cenario = 'hell';
    end

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

