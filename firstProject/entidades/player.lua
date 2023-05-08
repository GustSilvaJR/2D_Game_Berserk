local player = {}

function player.novo(nome)
    return {
        vida = 100,
        pocoes = {},
        nome = nome,
    }
end

function player.obter_pocao (p, pocao)
    table.insert(p.pocoes, pocao)
end

function player.atacado(p, dano)
    if p.vida > 0 then
        p.vida = p.vida - dano

        if p.vida < 0 then
            print("Apos o ataque, " .. p.nome .. " morreu!")
        else
            print("Apos o ataque, " .. p.nome .. " tem HP:".. p.vida)
        end
    else
        print(p.nome .. " ja esta morto!")
    end
end

return player;