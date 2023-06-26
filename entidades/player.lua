local gerencia = require('entidades/gerencia');

local player = {}

local data_sprites = {

    ----Run----
    run = {

        name = 'run',
        sprite = love.graphics.newImage("imagens/sprites/movements/ANDANDO.png"),

        width_sprite = 1733,
        height_sprite = 200,

        width_quad = 172,
        height_quad = 200,

        quant_quads = 10,
        duration = 0.2
    }, ----End Run----

    ----Stopped----
    stopped = {

        name = 'stopped',
        sprite = love.graphics.newImage("imagens/sprites/movements/PARADO.png"),

        width_sprite = 1332,
        height_sprite = 200,

        width_quad = 190.5,
        height_quad = 200,

        quant_quads = 7,
        duration = 0.3
    }, ----End Stopped----

    ----Ataque_1----
    attack_1 = {
        name = 'attack_1',
        sprite = love.graphics.newImage("imagens/sprites/movements/ATK1.png"),

        width_sprite = 2780,
        height_sprite = 200,

        width_quad = 252,
        height_quad = 200,

        attack_range = 150,

        quant_quads = 11,
        duration = 0.2
    }, ----End Ataque_1----

    ----Defesa----
    defense = {
        name = 'defense',
        sprite = love.graphics.newImage("imagens/sprites/movements/DEFESA.png"),

        width_sprite = 100,
        height_sprite = 200,

        width_quad = 100,
        height_quad = 200,

        quant_quads = 1,
        duration = 0.3
    }, ----End Stopped----

    ----Death----
    death = {
        name = 'death',
        sprite = love.graphics.newImage("imagens/sprites/movements/MORTO.png"),

        width_sprite = 805,
        height_sprite = 200,

        width_quad = 200,
        height_quad = 200,

        quant_quads = 4,
        duration = 0.3
    }, ----End Stopped----

    ----Hp_bar----
    hp_bar = {
        name = 'hp_bar',
        sprite = love.graphics.newImage("imagens/sprites/hpBar/HP_BAR.png"),

        width_sprite = 85,
        height_sprite = 99,

        width_quad = 85,
        height_quad = 99,

        quant_quads = 1,
        duration = 0.3
    }, ----End Hp_bar----

    -----text_player_death----
    text_player_death = {
        name = 'text_player_death',
        sprite = love.graphics.newImage('imagens/background/text_death.png'),

        width_sprite = 1760,
        height_sprite = 35,

        width_quad = 437,
        height_quad = 35,

        quant_quads = 4,
        duration = 0.3
    }, ----text_player_death----

    -----Damaged----
    damaged = {
        name = 'damaged',
        sprite = love.graphics.newImage('imagens/sprites/movements/HURT.png'),

        width_sprite = 680,
        height_sprite = 200,

        width_quad = 170,
        height_quad = 200,

        quant_quads = 4,
        duration = 0.2
    }, ----Damaged----

    -----Abaixando----
    abaixando = {
        name = 'abaixando',
        sprite = love.graphics.newImage('imagens/sprites/movements/ABAIXANDO.png'),

        width_sprite = 160,
        height_sprite = 200,

        width_quad = 160,
        height_quad = 200,

        quant_quads = 1,
        duration = 0.3
    }, ----Abaixando----

    -----Pulando----
    pulando = {
        name = 'pulando',
        sprite = love.graphics.newImage('imagens/sprites/movements/PULANDO.png'),

        width_sprite = 900,
        height_sprite = 200,

        width_quad = 150,
        height_quad = 200,

        quant_quads = 6,
        duration = 0.2
    }, ----Fim Pulando----

    -----Rolamento----
    rolamento = {
        name = 'rolamento',
        sprite = love.graphics.newImage('imagens/sprites/movements/ROLAMENTO.png'),

        width_sprite = 1086,
        height_sprite = 200,

        width_quad = 181,
        height_quad = 200,

        quant_quads = 6,
        duration = 0.25
    }, ----Fim rolamento----

    -----Especial----
    especial = {
        name = 'especial',
        sprite = love.graphics.newImage('imagens/sprites/movements/ESPECIAL.png'),

        width_sprite = 4830,
        height_sprite = 200,

        width_quad = 345,
        height_quad = 200,

        attack_range = 300,

        quant_quads = 14,
        duration = 0.19
    } ----Especial----
}

function load_sprites(p, data)
    local curr = false;

    if data.name == 'stopped' then
        curr = true;
    end

    

    if (data.name == 'attack_1' or data.name == 'especial') then
        gerencia.generate_sprite(p, data.name, data.sprite, data.width_sprite, data.height_sprite, data.width_quad,
            data.height_quad, data.quant_quads, 'right', curr, data.duration, data.attack_range);
            print('wtf')
        else

        gerencia.generate_sprite(p, data.name, data.sprite, data.width_sprite, data.height_sprite, data.width_quad,
            data.height_quad, data.quant_quads, 'right', curr, data.duration);
    end
end

function player.obter_pocao(p, pocao)
    table.insert(p.pocoes, pocao)
end

-- Setando info do player
player.nome = "Guts"
player.vida = 100
player.especial = 100
player.especial_max = 100
player.dmg_especial = 70
player.especial_state = false
player.dano_espada = 25
player.pocoes = {}
player.state = 'peaceful'
player.defesa_bloq = 15

player.song_attacks = {}
player.song_attacks.normal_attack = love.audio.newSource('songs/attacks/guts/normal_attack.mp3', 'static');

player.char = {}
player.char.image = ''
player.char.velocidadeY = 3
player.char.velocidade = 5
player.char.salto = 170
player.char.esta_saltando = false
player.char.abaixado = false
player.char.em_ataque = false
player.char.inicio_salto = 0
player.char.altura = 70
player.char.largura = 104
player.char.esgotado = false
player.char.last_move_x = 'right'
-- Setando info do player

-- Setando posição do player  bom base em um sprite padrão
player.char.x = 20;
player.char.y = Ground - (data_sprites.stopped.height_quad + 70);

Ground_player = Ground - (data_sprites.stopped.height_quad + 70);

-- Animation
player.sprites = {}

for k, v in pairs(data_sprites) do
    load_sprites(player, v);
end

------------------------- Sprites -------------------------
-- player.data_sprites = {}

-- player.data_sprites = {

--     ----Run----
--     walk = {

--         sprite = love.graphics.newImage("imagens/sprites/movements/ANDANDO.png"),

--         width_sprite = 1733,
--         height_sprite =200,

--         width_quad = 172,
--         height_quad = 200,

--         quant_quads = 10
--     }, ----End Run----

--     ----Stopped----
--     stopped = {
--         sprite = love.graphics.newImage("imagens/sprites/movements/PARADO.png"),

--         width_sprite = 1332,
--         height_sprite = 200,

--         width_quad = 190.5,
--         height_quad = 200,

--         quant_quads = 7
--     }, ----End Stopped----

--     ----Ataque----
--     attack = {
--         sprite = love.graphics.newImage("imagens/sprites/movements/ATK1.png"),

--         width_sprite = 2780,
--         height_sprite = 200,

--         width_quad = 252,
--         height_quad = 200,

--         attack_range = 150,

--         quant_quads = 11
--     }, ----End Stopped----

--     ----Defesa----
--     defense = {
--         sprite = love.graphics.newImage("imagens/sprites/movements/DEFESA.png"),

--         width_sprite = 100,
--         height_sprite = 200,

--         width_quad = 100,
--         height_quad = 200,

--         quant_quads = 1
--     }, ----End Stopped----

--     ----Death----
--     death = {
--         sprite = love.graphics.newImage("imagens/sprites/movements/MORTO.png"),

--         width_sprite = 805,
--         height_sprite = 200,

--         width_quad = 200,
--         height_quad = 200,

--         quant_quads = 4
--     }, ----End Stopped----

--     ----Hp_bar----
--     hp_bar = {
--         sprite = love.graphics.newImage("imagens/sprites/hpBar/HP_BAR.png"),

--         width_sprite = 85,
--         height_sprite = 99,

--         width_quad = 85,
--         height_quad = 99,

--         quant_quads = 1
--     }, ----End Hp_bar----

--     -----text_player_death----
--     text_player_death = {
--         sprite = love.graphics.newImage('imagens/background/text_death.png');

--         width_sprite = 1760,
--         height_sprite = 35,

--         width_quad = 437,
--         height_quad = 35,

--         quant_quads = 4
--     }, ----text_player_death----

--     -----Damaged----
--     damaged = {
--         sprite = love.graphics.newImage('imagens/sprites/movements/HURT.png');

--         width_sprite = 680,
--         height_sprite = 200,

--         width_quad = 170,
--         height_quad = 200,

--         quant_quads = 4
--     }, ----Damaged----

--     -----Abaixando----
--     abaixando = {
--         sprite = love.graphics.newImage('imagens/sprites/movements/ABAIXANDO.png');

--         width_sprite = 160,
--         height_sprite = 200,

--         width_quad = 160,
--         height_quad = 200,

--         quant_quads = 1
--     }, ----Abaixando----

--     -----Pulando----
--     pulando = {
--         sprite = love.graphics.newImage('imagens/sprites/movements/PULANDO.png');

--         width_sprite = 900,
--         height_sprite = 200,

--         width_quad = 150,
--         height_quad = 200,

--         quant_quads = 6
--     }, ----Pulando----

--     -----Pulando----
--     rolamento = {
--         sprite = love.graphics.newImage('imagens/sprites/movements/ROLAMENTO.png');

--         width_sprite = 1086,
--         height_sprite = 200,

--         width_quad = 181,
--         height_quad = 200,

--         quant_quads = 6
--     }, ----Pulando----

--     -----Especial----
--     especial = {
--         sprite = love.graphics.newImage('imagens/sprites/movements/ESPECIAL.png');

--         width_sprite = 4830,
--         height_sprite = 200,

--         width_quad = 345,
--         height_quad = 200,

--         attack_range = 300,

--         quant_quads = 14
--     }, ----Especial----
-- }

return player;
