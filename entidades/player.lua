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
player.pocoes = {}
player.char = {}
player.char.image = love.graphics.newImage("imagens/guts_parado_dir.png")
player.char.velocidadeY = 3
player.char.velocidade = 2.5
player.char.salto = 170
player.char.esta_saltando = false
player.char.abaixado = false
player.char.em_ataque = false
player.char.inicio_salto = 0
player.char.altura = 70
player.char.largura = 104
player.char.esgotado = false
player.char.last_move_x = ''

-- Setando para fullscreen para que eu possa pegar toda a largura e altura da tela
love.window.setFullscreen(true)

local width, height = love.graphics.getDimensions();
local background = love.graphics.newImage('imagens/Background.jpeg')

local sy = love.graphics.getHeight() / background:getHeight()

print("inferno \n\n\n")
print(height)

-- Animation
player.sprites = {}

------------------------- Sprites -------------------------
player.data_sprites = {}

player.data_sprites = {

    ----Run----
    walk = {

        sprite = love.graphics.newImage("imagens/sprites/corridaDirSpriteSheet.png"),

        width_sprite = 1808,
        height_sprite = 133,

        width_quad = 179.5,
        height_quad = 120,

        quant_quads = 10
    }, ----End Run----

    ----Stopped----
    stopped = {
        sprite = love.graphics.newImage("imagens/sprites/paradoDirSpriteSheet.png"),

        width_sprite = 1593,
        height_sprite = 156,

        width_quad = 226.5,
        height_quad = 150,

        quant_quads = 7
    },----End Stopped----

    ----Ataque----
    ataque = {
        sprite = love.graphics.newImage("imagens/sprites/ataqueDirSpriteSheet.png"),

        width_sprite = 1574,
        height_sprite = 158,

        width_quad = 144,
        height_quad = 160,

        quant_quads = 11
    } ----End Stopped----
}

-- Setando posição do player  bom base em um sprite padrão
player.char.x = 0;

Ground = height;
player.char.y = Ground - (player.data_sprites.stopped.height_quad + 60);

return player;
