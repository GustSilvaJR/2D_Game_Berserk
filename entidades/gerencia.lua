Lu = require('../luaunit')
local gerencia_ataque = require('entidades/gerencia_ataque')

local gerencia = {};
local width;
local height;

gerencia.load = function()
    width, height = love.window.getDesktopDimensions();
end

gerencia.draw = function(jogador)
    if (Cenario == 'forest') then
        if jogador.sprites.current.animation.direction == 'right' then
            love.graphics.draw(jogador.sprites.current.sprite,
                jogador.sprites.current.quads[jogador.sprites.current.animation.frame], jogador.char.x, jogador.char.y)
        else
            love.graphics.draw(jogador.sprites.current.sprite,
                jogador.sprites.current.quads[jogador.sprites.current.animation.frame], jogador.char.x, jogador.char.y,
                0, -1, 1, jogador.sprites.current.quad_w, 0)
        end

        --love.graphics.print("Posicao Y:        " .. jogador.char.y)

    elseif (Cenario == 'hell') then
        if jogador.sprites.current.animation.direction == 'right' then
            love.graphics.draw(jogador.sprites.current.sprite,
                jogador.sprites.current.quads[jogador.sprites.current.animation.frame], jogador.char.x, jogador.char.y)
        else
            love.graphics.draw(jogador.sprites.current.sprite,
                jogador.sprites.current.quads[jogador.sprites.current.animation.frame], jogador.char.x, jogador.char.y,
                0, -1, 1, jogador.sprites.current.quad_w, 0)
        end
    end

    -- love.graphics.print(
    --     "\n\nCalc:                  " .. (-1 * ((jogador.y - jogador.velocidade) - jogador.inicio_salto)),
    --     jogador.x, jogador.y)
    -- love.graphics.print("\n\n\nCalc:        " .. (love.graphics.getHeight() / 5) * 3 + 36)
    -- love.graphics.print("\n\n\n\n\n\nSaltando:        " .. tostring(jogador.esta_saltando), jogador.x, jogador.y)

end

gerencia.update = function(jogador, dt, p2)
    if (not (p2.state == 'death')) then

        if(not(love.keyboard.isDown('j')))then
            p2.sprites.attack_1.animation.frame = 1;
        end

        if love.keyboard.isDown('d') and not (p2.state == 'damaged') then
            if not (p2.state == 'saltando') then
                p2.char.last_move_x = 'right';
                p2.sprites.current = p2.sprites.run;

                p2.sprites.current.animation.idle = false;
                p2.sprites.current.animation.direction = 'right'
            else
                p2.sprites.current.animation.direction = 'right'
            end

        elseif love.keyboard.isDown('a') and not (p2.state == 'damaged') then
            if not (p2.state == 'saltando') then
                p2.char.last_move_x = 'left';
                p2.sprites.current = p2.sprites.run;

                p2.sprites.current.animation.idle = false;
                p2.sprites.current.animation.direction = 'left'
            else
                p2.sprites.current.animation.direction = 'left'
            end
        elseif love.keyboard.isDown('j') and not (p2.state == 'damaged') then
            p2.state = 'attacking';

            p2.sprites.current = p2.sprites.attack_1;

            p2.sprites.current.animation.idle = false;

            if (p2.char.last_move_x == 'right') then
                p2.sprites.current.animation.direction = 'right'
            else
                p2.sprites.current.animation.direction = 'left'
            end

        elseif love.keyboard.isDown('k') and not (p2.state == 'damaged') then
            p2.state = 'defense';

            p2.sprites.current.animation.idle = false;

            p2.sprites.current = p2.sprites.defense;

            if (p2.char.last_move_x == 'right') then
                p2.sprites.current.animation.direction = 'right'
            else
                p2.sprites.current.animation.direction = 'left'
            end

        elseif love.keyboard.isDown('s') and not (p2.state == 'damaged') then
            p2.state = 'defense';

            p2.sprites.current.animation.idle = false;

            p2.sprites.current = p2.sprites.abaixando;

            if (p2.char.last_move_x == 'right') then
                p2.sprites.current.animation.direction = 'right'
            else
                p2.sprites.current.animation.direction = 'left'
            end

        elseif love.keyboard.isDown('w') and not (p2.state == 'damaged') then
            p2.state = 'saltando';

            p2.sprites.current.animation.idle = false;

            p2.sprites.current = p2.sprites.pulando;

            if (p2.char.last_move_x == 'right') then
                p2.sprites.current.animation.direction = 'right'
            else
                p2.sprites.current.animation.direction = 'left'
            end

        elseif love.keyboard.isDown('lshift') and not (p2.state == 'damaged') then
            p2.state = 'rolamento';

            p2.sprites.current.animation.idle = false;

            p2.sprites.current = p2.sprites.rolamento;

            if (p2.char.last_move_x == 'right') then
                p2.sprites.current.animation.direction = 'right'
            else
                p2.sprites.current.animation.direction = 'left'
            end
        elseif love.keyboard.isDown('space') and not (p2.state == 'damaged') then
            if (p2.especial == 100 and p2.especial_state == false) then
                p2.especial_state = true;
                p2.state = 'especial';

                p2.sprites.current.animation.idle = false;

                p2.sprites.current = p2.sprites.especial;

                if (p2.char.last_move_x == 'right') then
                    p2.sprites.current.animation.direction = 'right'
                else
                    p2.sprites.current.animation.direction = 'left'
                end
            end

        else
            if not (p2.state == 'saltando') and not (p2.state == 'damaged') then
                p2.state = 'peaceful';

                if (p2.sprites.current.name == 'attack_1') then
                    p2.sprites.current.animation.frame = 1;
                end

                p2.sprites.current = p2.sprites.stopped;

                if (p2.char.last_move_x == 'right') then
                    p2.sprites.current.animation.direction = 'right'
                else
                    p2.sprites.current.animation.direction = 'left'
                end
                p2.sprites.current.animation.idle = false;
            end

        end
    else

        p2.sprites.current = p2.sprites.death;

        p2.sprites.current.animation.idle = false;
        p2.sprites.current.animation.direction = 'right'
    end

    if not p2.sprites.current.animation.idle then
        p2.sprites.current.animation.timer = p2.sprites.current.animation.timer + dt;

        if p2.sprites.current.animation.timer > p2.sprites.current.animation.duration then
            p2.sprites.current.animation.timer = 0.1;

            if (not (p2.state == 'death' and p2.sprites.current.animation.frame ==
                p2.sprites.current.animation.max_frames) and not (p2.state == 'saltando')) then
                p2.sprites.current.animation.frame = p2.sprites.current.animation.frame + 1;
            end

            if (p2.sprites.current.animation.direction == "right" and
                (love.keyboard.isDown('d') or love.keyboard.isDown('lshift')) and not (p2.state == 'death')) then

                if (p2.state == 'rolamento') then
                    p2.char.x = p2.char.x + p2.sprites.current.animation.speed + 10;
                else
                    p2.char.x = p2.char.x + p2.sprites.current.animation.speed;
                end

            elseif (p2.sprites.current.animation.direction == "left" and
                (love.keyboard.isDown('a') or love.keyboard.isDown('lshift')) and not (p2.state == 'death')) then

                if (p2.state == 'rolamento') then
                    p2.char.x = p2.char.x - p2.sprites.current.animation.speed - 10;
                else
                    p2.char.x = p2.char.x - p2.sprites.current.animation.speed;
                end
            end

            if p2.state == 'saltando' then

                if (p2.sprites.current.animation.frame == p2.sprites.current.animation.max_frames and p2.char.y <
                    Ground_player) or (p2.state == 'saltando' and not (love.keyboard.isDown('w'))) then

                    p2.sprites.current.animation.frame = p2.sprites.current.animation.max_frames;
                    p2.char.y = p2.char.y + p2.sprites.current.animation.speed;

                    if (p2.char.y >= Ground_player) then
                        p2.char.y = Ground_player;

                        p2.sprites.current.animation.frame = 1;
                        p2.state = 'peaceful';

                        p2.sprites.current = p2.sprites.stopped;

                        if (p2.char.last_move_x == 'right') then
                            p2.sprites.current.animation.direction = 'right'
                        else
                            p2.sprites.current.animation.direction = 'left'
                        end
                        p2.sprites.current.animation.idle = false;
                    end
                else
                    p2.sprites.current.animation.frame = p2.sprites.current.animation.frame + 1;
                    p2.char.y = p2.char.y - p2.sprites.current.animation.speed - 20;
                end
            else

                -- Caso for um ataque, colocar som
                if p2.sprites.current.animation.frame == math.floor(p2.sprites.current.animation.max_frames / 2) and
                    p2.state == 'attacking' then
                    p2.song_attacks.normal_attack:setLooping(false)
                    p2.song_attacks.normal_attack:setVolume(1)
                    p2.song_attacks.normal_attack:play()
                end

                if p2.sprites.current.animation.frame > p2.sprites.current.animation.max_frames then

                    if (p2.sprites.current.name == 'attack_1' or p2.sprites.current.name == 'especial') then
                        if Cenario == 'hell' then
                            gerencia_ataque.valida_ataque(p2, Inimigos[2], true)
                        else
                            gerencia_ataque.valida_ataque(p2, Inimigos[1], true)
                        end

                        if (p2.state == 'especial') then
                            p2.especial = 0;
                            p2.state = 'peaceful';
                            p2.especial_state = false;

                            p2.sprites.current.animation.frame = 1;
                            p2.state = 'peaceful';

                            p2.sprites.current = p2.sprites.stopped;

                            if (p2.char.last_move_x == 'right') then
                                p2.sprites.current.animation.direction = 'right'
                            else
                                p2.sprites.current.animation.direction = 'left'
                            end
                            p2.sprites.current.animation.idle = false;
                        end

                    end

                    if (p2.state == 'damaged') then
                        p2.sprites.current.animation.frame = 1
                        p2.state = 'peaceful';
                    else

                        p2.sprites.current.animation.frame = 1
                    end
                end
            end
        end

    end
end

-- Animação Sprite
gerencia.generate_sprite = function(player, name_sprite, sprite, sprite_w, sprite_h, quad_w, quad_h, quant_quads,
    direction, current, duration, attack_range)

    if(attack_range) then
        print("Campo opcional foi passado: ".. attack_range )
    end

    player.sprites[name_sprite] = {
        name = name_sprite,
        sprite = sprite,
        sprite_w = sprite_w,
        sprite_h = sprite_h,
        quad_w = quad_w,
        quad_h = quad_h,
        attack_range = attack_range or nil,
        animation = {
            direction = direction,
            idle = false,
            frame = 1,
            max_frames = quant_quads,
            speed = 17,
            timer = 0.1,
            duration = duration
        }
    }

    player.sprites[name_sprite].quads = {};
    for i = 1, quant_quads do
        player.sprites[name_sprite].quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w,
            sprite_h);
    end

    if (current) then
        player.sprites.current = {}

        player.sprites.current = {
            name = name_sprite,
            sprite = sprite,
            sprite_w = sprite_w,
            sprite_h = sprite_h,
            quad_w = quad_w,
            quad_h = quad_h,
            animation = {
                direction = direction,
                idle = false,
                frame = 1,
                max_frames = quant_quads,
                speed = 10,
                timer = 1,
                duration = duration
            }
        }

        player.sprites.current.quads = {};
        for i = 1, quant_quads do
            player.sprites.current.quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w,
                sprite_h);
        end
    end

end

-- Info sprite imagens/sprites/corridaDirSpriteSheet.png quad_w->180, quad_h->120
return gerencia
