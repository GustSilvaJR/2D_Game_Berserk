local player = {}

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
player.char.image = love.graphics.newImage("imagens/guts_parado_dir.png")
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

-- Setando posição do player  bom base em um sprite padrão
player.char.x = 20;

-- Animation
player.sprites = {}

------------------------- Sprites -------------------------
player.data_sprites = {}

player.data_sprites = {

    ----Run----
    walk = {

        sprite = love.graphics.newImage("imagens/sprites/movements/ANDANDO.png"),

        width_sprite = 1733,
        height_sprite =200,

        width_quad = 172,
        height_quad = 200,

        quant_quads = 10
    }, ----End Run----

    ----Stopped----
    stopped = {
        sprite = love.graphics.newImage("imagens/sprites/movements/PARADO.png"),

        width_sprite = 1332,
        height_sprite = 200,

        width_quad = 190.5,
        height_quad = 200,

        quant_quads = 7
    }, ----End Stopped----

    ----Ataque----
    attack = {
        sprite = love.graphics.newImage("imagens/sprites/movements/ATK1.png"),

        width_sprite = 2780,
        height_sprite = 200,

        width_quad = 252,
        height_quad = 200,

        quant_quads = 11
    }, ----End Stopped----

    ----Defesa----
    defense = {
        sprite = love.graphics.newImage("imagens/sprites/movements/DEFESA.png"),

        width_sprite = 100,
        height_sprite = 200,

        width_quad = 100,
        height_quad = 200,

        quant_quads = 1
    }, ----End Stopped----
    
    ----Death----
    death = {
        sprite = love.graphics.newImage("imagens/sprites/movements/MORTO.png"),

        width_sprite = 805,
        height_sprite = 200,

        width_quad = 200,
        height_quad = 200,

        quant_quads = 4
    }, ----End Stopped----

    ----Hp_bar----
    hp_bar = {
        sprite = love.graphics.newImage("imagens/sprites/hpBar/HP_BAR.png"),

        width_sprite = 85,
        height_sprite = 99,

        width_quad = 85,
        height_quad = 99,

        quant_quads = 1
    }, ----End Hp_bar----

    -----text_player_death----
    text_player_death = {
        sprite = love.graphics.newImage('imagens/background/text_death.png');

        width_sprite = 1760,
        height_sprite = 35,

        width_quad = 437,
        height_quad = 35,

        quant_quads = 4
    }, ----text_player_death----

    -----Damaged----
    damaged = {
        sprite = love.graphics.newImage('imagens/sprites/movements/HURT.png');

        width_sprite = 680,
        height_sprite = 200,

        width_quad = 170,
        height_quad = 200,

        quant_quads = 4
    }, ----Damaged----

    -----Abaixando----
    abaixando = {
        sprite = love.graphics.newImage('imagens/sprites/movements/ABAIXANDO.png');

        width_sprite = 160,
        height_sprite = 200,

        width_quad = 160,
        height_quad = 200,

        quant_quads = 1
    }, ----Abaixando----

    -----Pulando----
    pulando = {
        sprite = love.graphics.newImage('imagens/sprites/movements/PULANDO.png');

        width_sprite = 900,
        height_sprite = 200,

        width_quad = 150,
        height_quad = 200,

        quant_quads = 6
    }, ----Pulando----

    -----Pulando----
    rolamento = {
        sprite = love.graphics.newImage('imagens/sprites/movements/ROLAMENTO.png');

        width_sprite = 1086,
        height_sprite = 200,

        width_quad = 181,
        height_quad = 200,

        quant_quads = 6
    }, ----Pulando----

    -----Especial----
    especial = {
        sprite = love.graphics.newImage('imagens/sprites/movements/ESPECIAL.png');

        width_sprite = 4830,
        height_sprite = 200,

        width_quad = 345,
        height_quad = 200,

        quant_quads = 14
    }, ----Especial----
}

player.char.y = Ground - (player.data_sprites.stopped.height_quad + 70);

Ground_player = Ground - (player.data_sprites.stopped.height_quad + 70);

return player;
