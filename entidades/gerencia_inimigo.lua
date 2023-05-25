local gerencia_inimigo = {};
local lu = require('../luaunit');
local inimigo = {};

gerencia_inimigo.load = function (posX, posY, name)
    inimigo = {
        posX,
        posY,
        name,
        sprites = {},
    }

    return inimigo;
end

gerencia_inimigo.generate_sprite = function (enemy, name_sprite, sprite, sprite_w, sprite_h, quad_w, quad_h, quant_quads)
    enemy.sprites[name_sprite] = {
        sprite,
        sprite_w,
        sprite_h,
        quad_w,
        quad_h
    }

    local quads = {}

    for i = 1, quant_quads do
        quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w, sprite_h);
    end

end

gerencia_inimigo.desenha_inimigo = function(inimigo)
    
end
gerencia_inimigo.movimento = function(inimigo)

end

return gerencia_inimigo;