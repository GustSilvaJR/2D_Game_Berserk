local inimigo = require('entidades/inimigo')
local gerencia_inimigo = require('entidades/gerencia_inimigo')
local orc_module = {}

local data_sprites = {

    run = {

        name = 'run',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/CORRENDO.png"),

        width_sprite = 480,
        height_sprite = 150,

        width_quad = 80,
        height_quad = 150,

        quant_quads = 6,
        duration = 0.2
    },

    stopped = {
        name = 'stopped',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/PARADO.png"),

        width_sprite = 900,
        height_sprite = 150,

        width_quad = 163,
        height_quad = 150,

        quant_quads = 5,
        duration = 0.2
    },
    
    attack_1 = {
        name = 'attack_1',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/ATK1.png"),
        
        width_sprite = 640,
        height_sprite = 150,

        width_quad = 160,
        height_quad = 150,

        attack_range = 160,

        quant_quads = 4,
        duration = 0.3
    },

    damaged = {
        name = 'damaged',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/HURT.png"),
        width_sprite = 200,
        height_sprite = 150,

        width_quad = 100,
        height_quad = 150,

        quant_quads = 2,
        duration = 0.4
    },

    death = {
        name = 'death',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/MORTO.png"),
        width_sprite = 440,
        height_sprite = 150,

        width_quad = 110,
        height_quad = 150,

        quant_quads = 4,
        duration = 0.2
    }

}

function orc_module.load_sprites(orc, data)
    local curr = false;

    if data.name == 'stopped' then
        curr = true;
    end

    gerencia_inimigo.generate_sprite(orc, data.name, data.sprite, data.width_sprite, data.height_sprite,
        data.width_quad, data.height_quad, data.quant_quads, 'right', curr, data.duration);

    end

--function orc_module.keep_track(orc)

function orc_module.novo(posX, posY, name)
    local orc_demon = {};
    inimigo.novo(orc_demon, '20', 'Orc', 100, 25, posX, (posY - (data_sprites.stopped.height_quad + 60)), name);

    --orc songs attacks
    orc_demon.song_attacks = {}
    orc_demon.song_attacks.normal_attack = love.audio.newSource('songs/attacks/orc/normal_attack.mp3', 'static');

    orc_demon.sprites = {};

    for k, v in pairs(data_sprites) do
        orc_module.load_sprites(orc_demon, v);
    end

    return orc_demon;
end

return orc_module;
