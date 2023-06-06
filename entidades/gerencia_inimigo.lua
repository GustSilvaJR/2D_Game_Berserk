local gerencia_inimigo = {};
local lu = require('../luaunit');
local quads = {};
-- local inimigo = {};

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

-- Set state dir, dir move, move px
gerencia_inimigo.sort_move = function()

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
end

gerencia_inimigo.sleep_timer_to_sort = function(dt)

    if (coroutine.status(Run) == "dead") then
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
    if inimigo.sprites.current.animation.direction == 'right' then
        love.graphics.draw(inimigo.sprites.current.sprite,
            inimigo.sprites.current.quads[inimigo.sprites.current.animation.frame], inimigo.posX, inimigo.posY)
    else
        love.graphics.draw(inimigo.sprites.current.sprite,
            inimigo.sprites.current.quads[inimigo.sprites.current.animation.frame], inimigo.posX, inimigo.posY, 0, -1,
            1, inimigo.sprites.current.quad_w, 0)
    end
end

gerencia_inimigo.update = function(inimigo, dt)

    gerencia_inimigo.sleep_timer_to_sort(dt);

    if Dir_nome == 'right' then
        inimigo.sprites.current = inimigo.sprites.run;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'right'
    elseif Dir_nome == 'left' then
        inimigo.sprites.current = inimigo.sprites.run;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'left'
    else
        inimigo.sprites.current.animation.idle = true;

        inimigo.sprites.current = inimigo.sprites.stopped;

        inimigo.sprites.current.animation.direction = 'left'
        -- inimigo.sprites.current.animation.idle = false;
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
                    Dir_nome =  'left'
                    Dir = 2
                end
            elseif inimigo.sprites.current.animation.direction == "left" then
                if (inimigo.posX - Move_px > inimigo.sprites.current.quad_w) then
                    inimigo.posX = inimigo.posX - Move_px;
                else
                    Dir_nome =  'right'
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
