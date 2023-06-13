local player = {}

function player.obter_pocao(p, pocao)
    table.insert(p.pocoes, pocao)
end

function player.atacado(p, dano)
    if p.vida > 0 then
        p.vida = p.vida - dano

        if p.vida < 0 then
            print("Apos o ataque, " .. p.nome .. " morreu!")
        else
            print("Apos o ataque, " .. p.nome .. " tem HP:" .. p.vida)
        end
    else
        print(p.nome .. " ja esta morto!")
    end
end

-- Setando info do player
player.nome = "Guts"
player.vida = 100
player.dano_espada = 25
player.pocoes = {}
player.state = 'peaceful'
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

        sprite = love.graphics.newImage("imagens/sprites/corridaDirSpriteSheet.png"),

        width_sprite = 1003,
        height_sprite = 158,

        width_quad = 100.3,
        height_quad = 158,

        quant_quads = 10
    }, ----End Run----

    ----Stopped----
    stopped = {
        sprite = love.graphics.newImage("imagens/sprites/paradoDirSpriteSheet.png"),

        width_sprite = 1003,
        height_sprite = 158,

        width_quad = 142.7,
        height_quad = 158,

        quant_quads = 7
    }, ----End Stopped----

    ----Ataque----
    ataque = {
        sprite = love.graphics.newImage("imagens/sprites/ataqueDirSpriteSheet.png"),

        width_sprite = 2088,
        height_sprite = 158,

        width_quad = 190,
        height_quad = 158,

        quant_quads = 11
    }, ----End Stopped----
    
    ----Death----
    death = {
        sprite = love.graphics.newImage("imagens/sprites/mortoSpriteSheet.png"),

        width_sprite = 800,
        height_sprite = 158,

        width_quad = 200,
        height_quad = 158,

        quant_quads = 4
    } ----End Stopped----
}

player.char.y = Ground - (player.data_sprites.stopped.height_quad + 70);

return player;
