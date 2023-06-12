local inimigo = {}

function inimigo.novo (forca, categoria, vida)
    return {
        forca = forca,
        categoria = categoria,
        vida = vida
    }
end

return inimigo 