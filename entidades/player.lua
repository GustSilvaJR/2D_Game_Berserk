local player = {}

function player.novo(nome)
    return {
        vida = 100,
        pocoes = {},
        nome = nome
    }
end

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
player.char = {}
player.char.image = love.graphics.newImage("imagens/guts_parado_dir.png")
player.char.velocidadeY = 4
player.char.velocidade = 2
player.char.salto = 170
player.char.esta_saltando = false
player.char.abaixado = false
player.char.inicio_salto = 0
player.char.altura = 70
player.char.largura = 104
player.char.esgotado = false
player.char.last_move_x = ''
player.char.x = 0
player.char.y = (love.graphics.getHeight() / 5) * 4 + 36

return player;
