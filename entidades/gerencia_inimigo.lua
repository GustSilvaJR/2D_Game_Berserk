local gerencia_inimigo = {};
local lu = require('../luaunit');
local quads = {};

Teste = '';

Inimigos = {};

gerencia_inimigo.load = function()

    Dir = 0;
    Dir_nome = 'stopped'
    Move_px = 20;
    State = 'peaceful'

    Run = coroutine.create(function()
        print('Inicio corroutine')
        local clock = 2
        while clock > 0 do
            clock = clock - coroutine.yield(true)
        end
        -- waited 5 seconds, do your thing here.
        print("End corroutine")

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

    if (modulo_distancia <= 300 and not(State == 'death')) then
        State = 'attention';
    end

    return {
        distancia = modulo_distancia,
        direcao = dir
    };

end

-- Set state dir, dir move, move px
gerencia_inimigo.sort_move = function(inimigo)

    local info_player = gerencia_inimigo.check_enemies(inimigo);

    if (State == 'peaceful') then
        if (Dir == 1 or Dir == 2) then
            Dir = 0;
            Dir_nome = 'stopped';
        else
            -- Direção--
            Dir = math.random(3, 0);

            if (Dir == 1) then
                Dir_nome = 'right'
            elseif (Dir == 2) then
                Dir_nome = 'left'
            end
        end
        -- Fim_Direção--

        -- Quantidade de pixels move--
        Move_px = math.random(9, 15);
    else

        if (info_player.distancia <= 100 and not(State == 'death')) then

            if (info_player.distancia <= 50) then
                if (info_player.direcao == 'right') then
                    Dir = 2;
                    Dir_nome = 'left'
                    Move_px = 5;
                else
                    Dir = 1
                    Dir_nome = 'right'
                    Move_px = 5;
                end
            else
                if (info_player.direcao == 'right') then
                    Dir = 1;
                    Dir_nome = 'right'
                else
                    Dir = 2
                    Dir_nome = 'left'
                end
                Move_px = 0;
                State = 'attacking'
            end
        else

            if (info_player.direcao == 'right') then
                Dir = 1;
                Dir_nome = 'right'
            else
                Dir = 2
                Dir_nome = 'left'
            end

            Move_px = 10;
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
    direction, current)

    enemy.sprites[name_sprite] = {
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
            timer = 0.1
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
                timer = 0.1
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
    if (State == 'death') then
        print('foi de lobby');

    else
        if inimigo.sprites.current.animation.direction == 'right' then
            love.graphics.draw(inimigo.sprites.current.sprite,
                inimigo.sprites.current.quads[inimigo.sprites.current.animation.frame], inimigo.posX, inimigo.posY)
        else            
            love.graphics.draw(inimigo.sprites.current.sprite,
                inimigo.sprites.current.quads[inimigo.sprites.current.animation.frame], inimigo.posX, inimigo.posY, 0,
                -1, 1, inimigo.sprites.current.quad_w, 0)
        end
    end
end

gerencia_inimigo.update = function(inimigo, dt)

    gerencia_inimigo.sleep_timer_to_sort(dt, inimigo);

    if Dir_nome == 'right' and not (State == 'attacking') and not (State == 'damaged') then
        inimigo.sprites.current = inimigo.sprites.run;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'right'
    elseif Dir_nome == 'left' and not (State == 'attacking') and not (State == 'damaged') then
        inimigo.sprites.current = inimigo.sprites.run;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'left'
    elseif (Dir_nome == 'right') and (State == 'attacking') then
        inimigo.sprites.current = inimigo.sprites.attack_1;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'right'
    elseif (Dir_nome == 'left') and (State == 'attacking') then
        inimigo.sprites.current = inimigo.sprites.attack_1;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'left'
    elseif (Dir_nome == 'right') and (State == 'damaged') then
        inimigo.sprites.current = inimigo.sprites.damaged;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'right'
    elseif (Dir_nome == 'left') and (State == 'damaged') then
        inimigo.sprites.current = inimigo.sprites.damaged;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'left'
    else
        inimigo.sprites.current.animation.idle = true;

        inimigo.sprites.current = inimigo.sprites.stopped;

        inimigo.sprites.current.animation.direction = 'left'
    end

    if not inimigo.sprites.current.animation.idle then
        inimigo.sprites.current.animation.timer = inimigo.sprites.current.animation.timer + dt;

        if inimigo.sprites.current.animation.timer > 0.2 then
            inimigo.sprites.current.animation.timer = 0.1;

            inimigo.sprites.current.animation.frame = inimigo.sprites.current.animation.frame + 1;

            if inimigo.sprites.current.animation.direction == "right" then
                if (inimigo.posX + Move_px < (EndX - inimigo.sprites.current.quad_w)) then
                    inimigo.posX = inimigo.posX + Move_px;
                else
                    Dir_nome = 'left'
                    Dir = 2
                end
            elseif inimigo.sprites.current.animation.direction == "left" then
                if (inimigo.posX - Move_px > inimigo.sprites.current.quad_w) then
                    inimigo.posX = inimigo.posX - Move_px;
                else
                    Dir_nome = 'right'
                    Dir = 1
                end
            end

            if inimigo.sprites.current.animation.frame > inimigo.sprites.current.animation.max_frames then
                inimigo.sprites.current.animation.frame = 1
            end
        end

    end
end

return gerencia_inimigo;
