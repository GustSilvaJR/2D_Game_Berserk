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
    direction)

    enemy.sprites[name_sprite] = {
        sprite = sprite,
        sprite_w = sprite_w,
        sprite_h = sprite_h,
        quad_w = quad_w,
        quad_h = quad_h,
        animation = {
            direction = direction,
            idle = false,
            frame = 4,
            max_frames = quant_quads,
            speed = 10,
            timer = 0.1
        }
    }

    for key, value in pairs(enemy.sprites.walk) do
        print('\t', key, value)
    end

    for i = 1, quant_quads do
        quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w, sprite_h);
    end

end

gerencia_inimigo.draw = function(inimigo)
    if inimigo.sprites.walk.animation.direction == 'right' then
        love.graphics.draw(inimigo.sprites.walk.sprite, quads[inimigo.sprites.walk.animation.frame], inimigo.posX,
            inimigo.posY)
    else
        love.graphics.draw(inimigo.sprites.walk.sprite, quads[inimigo.sprites.walk.animation.frame], inimigo.posX,
            inimigo.posY, 0, -1, 1, inimigo.sprites.walk.quad_w, 0)
    end
end

gerencia_inimigo.update = function(inimigo, dt)

    if love.keyboard.isDown('e') then
        inimigo.sprites.walk.animation.idle = false;
        inimigo.sprites.walk.animation.direction = 'right'
    elseif love.keyboard.isDown('q') then
        inimigo.sprites.walk.animation.idle = false;
        inimigo.sprites.walk.animation.direction = 'left'
    else
        inimigo.sprites.walk.animation.idle = true;
        inimigo.sprites.walk.animation.frame = 4;
    end

    if not inimigo.sprites.walk.animation.idle then
        inimigo.sprites.walk.animation.timer = inimigo.sprites.walk.animation.timer + dt;

        if inimigo.sprites.walk.animation.timer > 0.2 then
            inimigo.sprites.walk.animation.timer = 0.1;

            inimigo.sprites.walk.animation.frame = inimigo.sprites.walk.animation.frame + 1;

            if inimigo.sprites.walk.animation.direction == "right" then
                inimigo.posX = inimigo.posX + inimigo.sprites.walk.animation.speed;
            elseif inimigo.sprites.walk.animation.direction == "left" then
                inimigo.posX = inimigo.posX - inimigo.sprites.walk.animation.speed;
            end

            if inimigo.sprites.walk.animation.frame > inimigo.sprites.walk.animation.max_frames then
                inimigo.sprites.walk.animation.frame = 1
            end
        end

    end
end

return gerencia_inimigo;
