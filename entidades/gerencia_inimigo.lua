local gerencia_inimigo = {};
local lu = require('../luaunit');
local quads = {};
--local inimigo = {};

gerencia_inimigo.load = function (posX, posY, name)
    local inimigo = {
        posX = posX,
        posY = posY,
        name = name,
        sprites = {},
    }

    return inimigo;
end

gerencia_inimigo.generate_sprite = function (enemy, name_sprite, sprite, sprite_w, sprite_h, quad_w, quad_h, quant_quads, state)
    --enemy.sprites.name_sprite = {}
    
    table.insert(enemy.sprites, {[name_sprite] = {}})

    enemy.sprites[name_sprite] = {
        sprite = sprite,
        sprite_w = sprite_w,
        sprite_h = sprite_h,
        quad_w = quad_w,
        quad_h = quad_h,
        animation = {
            action = state,
            idle = true,
            frame = 1,
            max_frames = quant_quads,
            speed = 20,
            timer = 0.1
        }
    }

    for i = 1, quant_quads do
        quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w, sprite_h);
    end

end

gerencia_inimigo.draw = function(inimigo)
    love.graphics.draw(inimigo.sprites.walk.sprite, quads[1], inimigo.posX, inimigo.posY)
end

gerencia_inimigo.movimento = function(inimigo)

end

return gerencia_inimigo;