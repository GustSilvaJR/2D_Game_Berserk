local inimigo = require('entidades/inimigo')
local gerencia_inimigo = require('entidades/gerencia_inimigo')
local orc_module = {}

Data_sprites = {

    stopped = {
        name = 'stopped',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/Idle.png"),
        width_sprite = 480,
        height_sprite = 96,

        width_quad = 96,
        height_quad = 96,

        quant_quads = 5
    },
    
    run = {

        name = 'run',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/Run.png"),

        width_sprite = 576,
        height_sprite = 96,

        width_quad = 95,
        height_quad = 96,

        quant_quads = 6
    }

}

function orc_module.load_sprites(orc, data)
    local curr = false;

    if data.name == 'stopped' then
        curr = true;
    end

    gerencia_inimigo.generate_sprite(orc, data.name, data.sprite, data.width_sprite, data.height_sprite,
        data.width_quad, data.height_quad, data.quant_quads, 'right', curr);
end

function orc_module.novo(posX, posY, name)
    local data_enemy = inimigo.novo('25', 'Orc');
    local orc_demon = {};

    orc_demon.forca = data_enemy.forca;
    orc_demon.categoria = data_enemy.categoria;
    orc_demon.posX = posX;
    orc_demon.posY = posY - (Data_sprites.stopped.height_quad + 60);
    orc_demon.name = name;
    orc_demon.sprites = {};

    for k, v in pairs(Data_sprites) do
        orc_module.load_sprites(orc_demon, v);
    end

    return orc_demon;
end

return orc_module;
