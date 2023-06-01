local gerencia_inimigo = {};
local lu = require('../luaunit');
local quads = {};
-- local inimigo = {};

gerencia_inimigo.load = function(posX, posY, name)
    local inimigo = {
        posX = posX,
        posY = posY,
        name = name,
        sprites = {}
    }

    return inimigo;
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
                timer = 0.1,
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
        love.graphics.draw(inimigo.sprites.current.sprite, inimigo.sprites.current.quads[inimigo.sprites.current.animation.frame], inimigo.posX,
            inimigo.posY)
    else
        love.graphics.draw(inimigo.sprites.current.sprite, inimigo.sprites.current.quads[inimigo.sprites.current.animation.frame], inimigo.posX,
            inimigo.posY, 0, -1, 1, inimigo.sprites.current.quad_w, 0)
    end
end

gerencia_inimigo.update = function(inimigo, dt)

    if love.keyboard.isDown('e') then
        inimigo.sprites.current = inimigo.sprites.run;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'right'
    elseif love.keyboard.isDown('q') then
        inimigo.sprites.current = inimigo.sprites.run;

        inimigo.sprites.current.animation.idle = false;
        inimigo.sprites.current.animation.direction = 'left'
    else
        inimigo.sprites.current.animation.idle = true;

        inimigo.sprites.current = inimigo.sprites.stopped;

        inimigo.sprites.current.animation.direction = 'right'
       -- inimigo.sprites.current.animation.idle = false;
    end

    if not inimigo.sprites.current.animation.idle then
        inimigo.sprites.current.animation.timer = inimigo.sprites.current.animation.timer + dt;

        if inimigo.sprites.current.animation.timer > 0.2 then
            inimigo.sprites.current.animation.timer = 0.1;

            inimigo.sprites.current.animation.frame = inimigo.sprites.current.animation.frame + 1;

            if inimigo.sprites.current.animation.direction == "right" and love.keyboard.isDown('e') then
                inimigo.posX = inimigo.posX + inimigo.sprites.current.animation.speed;
            elseif inimigo.sprites.current.animation.direction == "left" and love.keyboard.isDown('q') then
                inimigo.posX = inimigo.posX - inimigo.sprites.current.animation.speed;
            end

            if inimigo.sprites.current.animation.frame > inimigo.sprites.current.animation.max_frames then
                inimigo.sprites.current.animation.frame = 1
            end
        end

    end
end

return gerencia_inimigo;
