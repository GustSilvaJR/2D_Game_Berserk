local player = {}

function player.obter_pocao(p, pocao)
    table.insert(p.pocoes, pocao)
end



-- Setando info do player
player.nome = "Guts"
player.vida = 100
player.dano_espada = 25
player.pocoes = {}
player.state = 'peaceful'
player.defesa_bloq = 15
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



local background = love.graphics.newImage('imagens/Background.jpeg')

local sy = love.graphics.getHeight() / background:getHeight()

-- Animation
player.sprites = {}

------------------------- Sprites -------------------------
player.data_sprites = {}

player.data_sprites = {

    ----Run----
    walk = {

        sprite = love.graphics.newImage("imagens/sprites/newImagesIuri/ANDANDO.png"),

        width_sprite = 1733,
        height_sprite =200,

        width_quad = 172,
        height_quad = 200,

        quant_quads = 10
    }, ----End Run----

    ----Stopped----
    stopped = {
        sprite = love.graphics.newImage("imagens/sprites/newImagesIuri/PARADO.png"),

        width_sprite = 1332,
        height_sprite = 200,

        width_quad = 190.5,
        height_quad = 200,

        quant_quads = 7
    }, ----End Stopped----

    ----Ataque----
    attack = {
        sprite = love.graphics.newImage("imagens/sprites/newImagesIuri/ATK1.png"),

        width_sprite = 2780,
        height_sprite = 200,

        width_quad = 252,
        height_quad = 200,

        quant_quads = 11
    }, ----End Stopped----

    ----Defesa----
    defense = {
        sprite = love.graphics.newImage("imagens/sprites/newImagesIuri/DEFESA.png"),

        width_sprite = 100,
        height_sprite = 200,

        width_quad = 100,
        height_quad = 200,

        quant_quads = 1
    }, ----End Stopped----
    
    ----Death----
    death = {
        sprite = love.graphics.newImage("imagens/sprites/newImagesIuri/MORTO.png"),

        width_sprite = 805,
        height_sprite = 200,

        width_quad = 200,
        height_quad = 200,

        quant_quads = 4
    }, ----End Stopped----

    ----Hp_bar----
    hp_bar = {
        sprite = love.graphics.newImage("imagens/sprites/hpBar/HP_BAR.png"),

        width_sprite = 1320,
        height_sprite = 98,

        width_quad = 220,
        height_quad = 98,

        quant_quads = 6
    } ----End Hp_bar----
}

player.char.y = Ground - (player.data_sprites.stopped.height_quad + 70);

return player;
