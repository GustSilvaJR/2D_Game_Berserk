local item = {}

function item.novo(nome, tipo, custo)
    return {
        nome = nome,
        tipo = tipo,
        custo = custo,
    }
end

return item