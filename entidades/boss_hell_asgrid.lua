local inimigo = require('entidades/inimigo')
local gerencia_inimigo = require('entidades/gerencia_inimigo')
local boss_hell_module = {}

local data_sprites_asgrid = {

    run = {

        name = 'run',
        sprite = love.graphics.newImage("imagens/boss_hell_sprites/ANDANDO.png"),

        width_sprite = 2100,
        height_sprite = 280,

        width_quad = 210,
        height_quad = 280,

        quant_quads = 10,
        duration = 0.3
    },

    stopped = {

        name = 'stopped',
        sprite = love.graphics.newImage("imagens/boss_hell_sprites/PARADO.png"),

        width_sprite = 1330,
        height_sprite = 280,

        width_quad = 220,
        height_quad = 280,

        quant_quads = 6,
        duration = 0.3
    },

    attack_1 = {

        name = 'attack_1',
        sprite = love.graphics.newImage("imagens/boss_hell_sprites/ATK_1.png"),

        width_sprite = 5850,
        height_sprite = 280,

        width_quad = 390,
        height_quad = 280,

        attack_range = 390,

        quant_quads = 15,
        duration = 0.2
    },

    death = {

        name = 'death',
        sprite = love.graphics.newImage("imagens/boss_hell_sprites/MORTO.png"),

        width_sprite = 6500,
        height_sprite = 280,

        width_quad = 325,
        height_quad = 280,

        quant_quads = 20,
        duration = 0.8
    }
}

function boss_hell_module.load_sprites(boss_hell, data)
    local curr = false;

    if data.name == 'stopped' then
        curr = true;
    end

    gerencia_inimigo.generate_sprite(boss_hell, data.name, data.sprite, data.width_sprite, data.height_sprite,
        data.width_quad, data.height_quad, data.quant_quads, 'right', curr, data.duration);

end

function boss_hell_module.novo(posX, posY, name)
    local boss_asgrid = {}
    inimigo.novo(boss_asgrid, '45', 'Boss', 1000, 50, posX, (posY - (data_sprites_asgrid.stopped.height_quad + 60)),
        name);

    boss_asgrid.sprites = {};

    for k, v in pairs(data_sprites_asgrid) do
        boss_hell_module.load_sprites(boss_asgrid, v);
    end

    return boss_asgrid;
end

return boss_hell_module;

