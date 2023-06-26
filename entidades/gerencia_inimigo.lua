local gerencia_inimigo = {};
local lu = require('../luaunit');
local gerencia_ataque = require('entidades/gerencia_ataque')

local quads = {};

Teste = '';

Inimigos = {};

gerencia_inimigo.load = function()

    Dir = 0;
    Dir_nome = 'stopped'
    Move_px = 20;
    State = 'peaceful'

    Run = coroutine.create(function()
        local clock = 2
        while clock > 0 do
            clock = clock - coroutine.yield(true)
        end
        -- waited 5 seconds, do your thing here.

        gerencia_inimigo.sort_move();
    end)

end

gerencia_inimigo.add_enemy = function(enemy)
    table.insert(Inimigos, enemy);
end

gerencia_inimigo.check_enemies = function(inimigo)
    local modulo_distancia = inimigo.posX - Pos_player_x;
    local dir = 'left';

    if (modulo_distancia < 0) then
        modulo_distancia = modulo_distancia * -1;
        dir = 'right';
    end

    if (modulo_distancia <= 300 and not (inimigo.state == 'death')) then
        inimigo.state = 'attention';
    end

    return {
        distancia = modulo_distancia,
        direcao = dir
    };

end

-- Set state dir, dir move, move px
gerencia_inimigo.sort_move = function(inimigo)

    local info_player = gerencia_inimigo.check_enemies(inimigo);

    if (inimigo.state == 'peaceful') then
        if (inimigo.dir == 1 or inimigo.dir == 2) then
            inimigo.dir = 0;
            inimigo.dir_nome = 'stopped';
        else
            -- Direção--
            inimigo.dir = math.random(3, 0);

            if (inimigo.dir == 1) then
                inimigo.dir_nome = 'right'
            elseif (inimigo.dir == 2) then
                inimigo.dir_nome = 'left'
            end
        end
        -- Fim_Direção--

        -- Quantidade de pixels move--
        if inimigo.categoria == 'Orc'then
            
            inimigo.move_px = math.random(9, 15);
        else
            inimigo.move_px = math.random(15, 25);
        end
    else
        print(inimigo.sprites.attack_1.attack_range, inimigo.name)
        if (info_player.distancia <= inimigo.sprites.attack_1.attack_range and not (inimigo.state == 'death')) then

            if (info_player.distancia <= 20) then
                if (info_player.direcao == 'right') then
                    inimigo.dir = 2;
                    inimigo.dir_nome = 'left'
                    inimigo.move_px = 5;
                else
                    inimigo.dir = 1
                    inimigo.dir_nome = 'right'
                    inimigo.move_px = 5;
                end
            else
                if (info_player.direcao == 'right') then
                    inimigo.dir = 1;
                    inimigo.dir_nome = 'right'
                else
                    inimigo.dir = 2
                    inimigo.dir_nome = 'left'
                end
                inimigo.move_px = 0;
                inimigo.state = 'attacking'
            end
        else

            if (info_player.direcao == 'right') then
                inimigo.dir = 1;
                inimigo.dir_nome = 'right';
                if (not (inimigo.state == 'death')) then
                    inimigo.state = 'peaceful';
                end
            else
                inimigo.dir = 2;
                inimigo.dir_nome = 'left';
                if (not (inimigo.state == 'death')) then
                    inimigo.state = 'peaceful';
                end
            end

            if inimigo.categoria == "Orc" then
                inimigo.move_px = 15;
            else
                inimigo.move_px = 25;
            end
        end
    end
end

gerencia_inimigo.sleep_timer_to_sort = function(dt, inimigo)

    if (coroutine.status(Run) == "dead") then
        Run = coroutine.create(function()
            local clock = 1
            while clock > 0 do
                clock = clock - coroutine.yield(true)
            end
            -- waited 5 seconds, do your thing here.

            gerencia_inimigo.sort_move(inimigo);
        end)
    end

    coroutine.resume(Run, dt)
end

gerencia_inimigo.generate_sprite = function(enemy, name_sprite, sprite, sprite_w, sprite_h, quad_w, quad_h, quant_quads,
    direction, current, duration, attack_range)

    enemy.sprites[name_sprite] = {
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
            speed = 10,
            timer = 0.1,
            duration = duration
        }
    }

    enemy.sprites[name_sprite].quads = {};
    for i = 1, quant_quads do
        enemy.sprites[name_sprite].quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w,
            sprite_h);
    end

    if (current) then
        enemy.sprites.current = {}

        enemy.sprites.current = {
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
                speed = 10,
                timer = 0.1,
                duration = duration
            }
        }

        enemy.sprites.current.quads = {};
        for i = 1, quant_quads do
            enemy.sprites.current.quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w,
                sprite_h);
        end
    end

    -- for i = 1, quant_quads do
    --     quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w, sprite_h);
    -- end

end

gerencia_inimigo.draw = function(inimigo)

    if inimigo.sprites.current.animation.direction == 'right' then
        love.graphics.draw(inimigo.sprites.current.sprite,
            inimigo.sprites.current.quads[inimigo.sprites.current.animation.frame], inimigo.posX, inimigo.posY)
    else
        love.graphics.draw(inimigo.sprites.current.sprite,
            inimigo.sprites.current.quads[inimigo.sprites.current.animation.frame], inimigo.posX, inimigo.posY, 0, -1,
            1, inimigo.sprites.current.quad_w, 0)
    end

end

gerencia_inimigo.update = function(inimigo, player, dt)

    
    if (not (inimigo.state == 'death')) then
        gerencia_inimigo.sleep_timer_to_sort(dt, inimigo);

        if inimigo.dir_nome == 'right' and not (inimigo.state == 'attacking') and not (inimigo.state == 'damaged') then
            inimigo.sprites.attack_1.animation.frame = 1;

            inimigo.sprites.current = inimigo.sprites.run;

            inimigo.sprites.current.animation.idle = false;
            inimigo.sprites.current.animation.direction = 'right'
        elseif inimigo.dir_nome == 'left' and not (inimigo.state == 'attacking') and not (inimigo.state == 'damaged') then
            inimigo.sprites.attack_1.animation.frame = 1;

            inimigo.sprites.current = inimigo.sprites.run;

            inimigo.sprites.current.animation.idle = false;
            inimigo.sprites.current.animation.direction = 'left'
        elseif (inimigo.dir_nome == 'right') and (inimigo.state == 'attacking') then
            inimigo.sprites.current = inimigo.sprites.attack_1;

            inimigo.sprites.current.animation.idle = false;
            inimigo.sprites.current.animation.direction = 'right'
        elseif (inimigo.dir_nome == 'left') and (inimigo.state == 'attacking') then
            inimigo.sprites.current = inimigo.sprites.attack_1;

            inimigo.sprites.current.animation.idle = false;
            inimigo.sprites.current.animation.direction = 'left'
        elseif (inimigo.dir_nome == 'right') and (inimigo.state == 'damaged') then
            inimigo.sprites.attack_1.animation.frame = 1;
            inimigo.sprites.current = inimigo.sprites.damaged;

            inimigo.sprites.current.animation.idle = false;
            inimigo.sprites.current.animation.direction = 'right'
        elseif (inimigo.dir_nome == 'left') and (inimigo.state == 'damaged') then
            inimigo.sprites.attack_1.animation.frame = 1;
            inimigo.sprites.current = inimigo.sprites.damaged;

            inimigo.sprites.current.animation.idle = false;
            inimigo.sprites.current.animation.direction = 'left'
        else
            if (not (inimigo.state == 'death')) then
                inimigo.sprites.attack_1.animation.frame = 1;
                inimigo.sprites.current.animation.idle = true;

                inimigo.sprites.current = inimigo.sprites.stopped;
                inimigo.state = 'peaceful'
                inimigo.sprites.current.animation.direction = 'left'
            end

        end
    else

        inimigo.sprites.current = inimigo.sprites.death;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'left'
    end

    if not inimigo.sprites.current.animation.idle then
        inimigo.sprites.current.animation.timer = inimigo.sprites.current.animation.timer + dt;

        if inimigo.sprites.current.animation.timer > inimigo.sprites.current.animation.duration then
            inimigo.sprites.current.animation.timer = 0.1;

            if (not (inimigo.state == 'death' and inimigo.sprites.current.animation.frame ==
                inimigo.sprites.current.animation.max_frames)) then
                inimigo.sprites.current.animation.frame = inimigo.sprites.current.animation.frame + 1;
            end

            if inimigo.sprites.current.animation.direction == "right" and not (inimigo.state == 'death') then
                if (inimigo.posX + inimigo.move_px < (EndX - inimigo.sprites.current.quad_w)) then
                    inimigo.posX = inimigo.posX + inimigo.move_px;
                else
                    inimigo.dir_nome = 'left'
                    inimigo.dir = 2
                end
            elseif inimigo.sprites.current.animation.direction == "left" and not (inimigo.state == 'death') then
                if (inimigo.posX - inimigo.move_px > inimigo.sprites.current.quad_w) then
                    inimigo.posX = inimigo.posX - inimigo.move_px;
                else
                    inimigo.dir_nome = 'right'
                    inimigo.dir = 1
                end
            end

            if inimigo.sprites.current.animation.frame == 3 and inimigo.state == 'attacking' and Cenario == 'forest' then
                inimigo.song_attacks.normal_attack:setLooping(false)
                inimigo.song_attacks.normal_attack:setVolume(1)
                inimigo.song_attacks.normal_attack:setPitch(0.5)
                inimigo.song_attacks.normal_attack:play()
            end

            if inimigo.sprites.current.animation.frame > inimigo.sprites.current.animation.max_frames and
                not (inimigo.state == 'death') then

                if (inimigo.state == 'attacking') then
                    if(Cenario == 'hell')then
                        gerencia_ataque.valida_ataque(player, Inimigos[2], false)
                    else

                        gerencia_ataque.valida_ataque(player, Inimigos[1], false)
                    end
                end

                inimigo.sprites.current.animation.frame = 1
            end
        end

    end

end

return gerencia_inimigo;
