local inimigo = require('entidades/inimigo')
local gerencia_inimigo = require('entidades/gerencia_inimigo')
local boss_hell_module = {}

local data_sprites_asgrid = {

    run = {

        name = 'run',
        sprite = love.graphics.newImage("imagens/boss_hell_sprites/ANDANDO.png"),

        width_sprite = 1970,
        height_sprite = 280,

        width_quad = 197,
        height_quad = 280,

        quant_quads = 10,
        duration = 0.3
    },

    stopped = {

        name = 'stopped',
        sprite = love.graphics.newImage("imagens/boss_hell_sprites/PARADO.png"),

        width_sprite = 1230,
        height_sprite = 280,

        width_quad = 205,
        height_quad = 280,

        quant_quads = 6,
        duration = 0.3
    },

    attack_1 = {

        name = 'attack_1',
        sprite = love.graphics.newImage("imagens/boss_hell_sprites/ATK_1.png"),

        width_sprite = 5325,
        height_sprite = 280,

        width_quad = 355,
        height_quad = 280,

        quant_quads = 15,
        duration = 0.4
    },

    death = {

        name = 'death',
        sprite = love.graphics.newImage("imagens/boss_hell_sprites/MORTO.png"),

        width_sprite = 1230,
        height_sprite = 280,

        width_quad = 205,
        height_quad = 280,

        quant_quads = 20,
        duration = 1
    },
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
    local data_enemy = inimigo.novo('45', 'Asgrid', 1000);
    local boss_asgrid = {}

    boss_asgrid.forca = data_enemy.forca;
    boss_asgrid.categoria = data_enemy.categoria;
    boss_asgrid.vida = data_enemy.vida;
    boss_asgrid.posX = posX;
    boss_asgrid.posY = posY - (data_sprites_asgrid.stopped.height_quad + 60);
    boss_asgrid.name = name;

    boss_asgrid.sprites = {};
    
    for k, v in pairs(data_sprites_asgrid) do
        boss_hell_module.load_sprites(boss_asgrid, v);
    end

    return boss_asgrid;
end

return boss_hell_module;

