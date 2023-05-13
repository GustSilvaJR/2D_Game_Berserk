local gerencia = {}

gerencia.telaPrincipal = function()
    function love.load()
        love.window.setTitle('Berserk')
        love.window.setFullscreen(true)

        -- love.graphics.setBackgroundColor(40 / 255, 40 / 255, 40 / 255)

        Background = love.graphics.newImage('imagens/Background.jpeg')
    end
end

gerencia.desenhar = function(jogador)
    function love.draw()
        for i = 0, love.graphics.getWidth() / Background:getWidth() do
            love.graphics.draw(Background, i * Background:getWidth(), love.graphics.getHeight() / 5)
        end
        love.graphics.draw(jogador.image, jogador.x, jogador.y)
        love.graphics.print("Posicao Y:        " .. jogador.y)
        -- love.graphics.print(
        --     "\n\nCalc:                  " .. (-1 * ((jogador.y - jogador.velocidade) - jogador.inicio_salto)),
        --     jogador.x, jogador.y)
        -- love.graphics.print("\n\n\n\nChao:        " .. Chao, jogador.x, jogador.y)
        -- love.graphics.print("\n\n\n\n\n\nSaltando:        " .. tostring(jogador.esta_saltando), jogador.x, jogador.y)
    end
end

gerencia.movimentacao = function(jogador)
    function love.update(dt)
        if love.keyboard.isDown('w') then
            jogador.velocidade = 3

            if jogador.esta_saltando == false then
                jogador.inicio_salto = jogador.y
                jogador.esta_saltando = true
            end

            if (-1 * ((jogador.y - jogador.velocidadeY) - jogador.inicio_salto)) >= jogador.salto then
                jogador.esta_saltando = false
                jogador.velocidadeY = 0
                jogador.esgotado = true
            elseif (not jogador.esgotado) then
                jogador.y = jogador.y - jogador.velocidadeY
            else
                jogador.y = jogador.y + 4
            end
        end

        if (not love.keyboard.isDown('w') and jogador.esta_saltando) then
            jogador.velocidade = 5
            jogador.y = jogador.y + 4
        end

        -- if (not love.keyboard.isDown('d') and not love.keyboard.isDown('w')) then
        --     jogador.image = love.graphics.newImage("imagens/guts_parado_dir.png")
        -- end

        -- if (not love.keyboard.isDown('a') and not love.keyboard.isDown('w')) then
        --     jogador.image = love.graphics.newImage("imagens/guts_parado_esq.png")
        -- end

        if love.keyboard.isDown('s') then

            if (jogador.abaixado == false) then
                jogador.abaixado = true;
                jogador.y = (((love.graphics.getHeight() / 5) * 4) + 41);
                jogador.image = love.graphics.newImage("imagens/abaixa.png");
            end

            if (jogador.y + jogador.velocidade < Chao) then
                jogador.y = jogador.y + jogador.velocidade

            else
                jogador.y = jogador.y
                jogador.esta_saltando = false
            end
        end

        --RESET ESTADO abaixado
        if love.keyboard.isDown('s') then
            jogador.abaixado = false;
        end

        -- IMPLEMENTANDO ANIMAÇÃO PARA FIM DE QUEDA
        if (jogador.y >= (Chao - 200) and not love.keyboard.isDown('w') and not love.keyboard.isDown('s')) then
            jogador.image = love.graphics.newImage("imagens/terminando_queda.png")

        end

        if (jogador.y >= (Chao - 30) and not love.keyboard.isDown('s')) then
            jogador.image = love.graphics.newImage("imagens/guts_parado_dir.png")
        end

        -- RESETANDO ESTADO DE SALTO
        if jogador.y >= Chao then
            jogador.esta_saltando = false
            jogador.esgotado = false
            jogador.velocidadeY = 2
            jogador.velocidade = 2

            if (jogador.last_move_x == 'd' and not love.keyboard.isDown('w') and not love.keyboard.isDown('s')) then
                jogador.image = love.graphics.newImage("imagens/guts_parado_dir.png")
            else
                if (jogador.last_move_x == 'a' and not love.keyboard.isDown('w') and not love.keyboard.isDown('s')) then
                    jogador.image = love.graphics.newImage("imagens/guts_parado_esq.png")
                end
            end

        end

        if love.keyboard.isDown('d') then
            if jogador.x + jogador.velocidade + jogador.largura <= love.graphics.getWidth() then
                jogador.image = love.graphics.newImage("imagens/guts_movimento_dir.png")
                jogador.x = jogador.x + jogador.velocidade
            else
                jogador.x = jogador.x
            end
            jogador.last_move_x = 'd'
        end

        -- if not love.keyboard.isDown('d') and jogador.last_move_x == 'd' then
        --     jogador.image = love.graphics.newImage("imagens/guts_parado_dir.png")
        -- end

        if love.keyboard.isDown('a') then
            if jogador.x - jogador.velocidade >= 0 then
                jogador.image = love.graphics.newImage("imagens/guts_movimento_esq.png")
                jogador.x = jogador.x - jogador.velocidade
            else

                jogador.x = jogador.x
            end
            jogador.last_move_x = 'a'
        end

        -- if not love.keyboard.isDown('a') and jogador.last_move_x == 'a' then
        --     jogador.image = love.graphics.newImage("imagens/guts_parado_esq.png")
        -- end
    end
end

return gerencia
