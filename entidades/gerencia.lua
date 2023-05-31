Lu = require('../luaunit')
local gerencia = {};
local width;
local height;

local background;

gerencia.load = function()

    love.window.setTitle('Berserk')
    love.window.setFullscreen(true)

    background = love.graphics.newImage('imagens/Background.jpeg')

    width, height = love.window.getDesktopDimensions();

    print('Aquiii \n\n');
    print(width, height)
    print('Aquiii \n\n');

end

gerencia.draw = function(jogador)

    local sx = love.graphics.getWidth() / background:getWidth()
    local sy = love.graphics.getHeight() / background:getHeight()
    love.graphics.draw(background, 0, 0, 0, sx, sy) -- x: 0, y: 0, rot: 0, scale x and scale y

    --  for i = 0, love.graphics.getWidth() / Background:getWidth() do
    --      love.graphics.draw(Background, i * Background:getWidth(), height/2)
    --  end

    if jogador.sprites.current.animation.direction == 'right' then
        love.graphics.draw(jogador.sprites.current.sprite,
            jogador.sprites.current.quads[jogador.sprites.current.animation.frame], jogador.char.x, jogador.char.y)
    else
        love.graphics.draw(jogador.sprites.current.sprite,
            jogador.sprites.current.quads[jogador.sprites.current.animation.frame], jogador.char.x, jogador.char.y, 0,
            -1, 1, jogador.sprites.current.quad_w, 0)
    end

    -- love.graphics.print("Posicao Y:        " .. jogador.y)
    -- love.graphics.print(
    --     "\n\nCalc:                  " .. (-1 * ((jogador.y - jogador.velocidade) - jogador.inicio_salto)),
    --     jogador.x, jogador.y)
    -- love.graphics.print("\n\n\nCalc:        " .. (love.graphics.getHeight() / 5) * 3 + 36)
    -- love.graphics.print("\n\n\n\n\n\nSaltando:        " .. tostring(jogador.esta_saltando), jogador.x, jogador.y)

end

gerencia.update = function(jogador, dt, p2)

    if love.keyboard.isDown('1') then
        p2.sprites.current = p2.sprites.walk;

        p2.sprites.current.animation.idle = false;
        p2.sprites.current.animation.direction = 'right'
    elseif love.keyboard.isDown('2') then
        p2.sprites.current = p2.sprites.walk;

        p2.sprites.current.animation.idle = false;
        p2.sprites.current.animation.direction = 'left'
    else
        p2.sprites.current.animation.idle = true;

        p2.sprites.current = p2.sprites.stopped;

        p2.sprites.current.animation.direction = 'right'
        p2.sprites.current.animation.idle = false;

    end

    if not p2.sprites.current.animation.idle then
        p2.sprites.current.animation.timer = p2.sprites.current.animation.timer + dt;

        if p2.sprites.current.animation.timer > p2.sprites.current.animation.duration then
            p2.sprites.current.animation.timer = 0.1;

            p2.sprites.current.animation.frame = p2.sprites.current.animation.frame + 1;

            if p2.sprites.current.animation.direction == "right" and love.keyboard.isDown('1') then
                p2.char.x = p2.char.x + p2.sprites.current.animation.speed;
            elseif p2.sprites.current.animation.direction == "left" and love.keyboard.isDown('2') then
                p2.char.x = p2.char.x - p2.sprites.current.animation.speed;
            end

            if p2.sprites.current.animation.frame > p2.sprites.current.animation.max_frames then
                p2.sprites.current.animation.frame = 1
            end
        end

    end

    if love.keyboard.isDown('w') then
        jogador.velocidade = 4

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

    if (love.keyboard.isDown('s') and jogador.abaixado == false) then
        if (jogador.abaixado == false) then
            jogador.abaixado = true;
            jogador.y = (((love.graphics.getHeight() / 5) * 3) + 45);
            jogador.image = love.graphics.newImage("imagens/abaixa.png");
        end

        if (jogador.y + jogador.velocidade < Chao) then
            jogador.y = jogador.y + jogador.velocidade
        else
            jogador.y = jogador.y
            jogador.esta_saltando = false
        end
    end

    -- RESET ESTADO abaixado
    if (not love.keyboard.isDown('s') and jogador.abaixado == true) then
        jogador.abaixado = false;
        jogador.y = (((love.graphics.getHeight() / 5) * 3) + 16);
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
        jogador.velocidadeY = 3
        jogador.velocidade = 3.5

        if (jogador.last_move_x == 'd' and not love.keyboard.isDown('w') and not love.keyboard.isDown('s') and
            not love.keyboard.isDown('j')) then
            jogador.image = love.graphics.newImage("imagens/guts_parado_dir.png")
        else
            if (jogador.last_move_x == 'a' and not love.keyboard.isDown('w') and not love.keyboard.isDown('s') and
                not love.keyboard.isDown('j')) then
                jogador.image = love.graphics.newImage("imagens/guts_parado_esq.png")
            end
        end
    end

    -- if love.keyboard.isDown('d') then
    --     if jogador.x + jogador.velocidade + jogador.largura <= love.graphics.getWidth() then
    --         jogador.image = love.graphics.newImage("imagens/guts_movimento_dir.png")
    --         jogador.x = jogador.x + jogador.velocidade
    --     else
    --         jogador.x = jogador.x
    --     end

    --     jogador.last_move_x = 'd'

    -- end

    -- if love.keyboard.isDown('a') then
    --     if jogador.x - jogador.velocidade >= 0 then
    --         jogador.image = love.graphics.newImage("imagens/guts_movimento_esq.png")
    --         jogador.x = jogador.x - jogador.velocidade
    --     else
    --         jogador.x = jogador.x
    --     end
    --     jogador.last_move_x = 'a'
    -- end

    -- MOVIMENTAÇÃO DE ATAQUE
    if love.keyboard.isDown('j') then
        -- if(jogador.em_ataque == false)then
        if (jogador.last_move_x == 'd') then
            jogador.em_ataque = true
            jogador.image = love.graphics.newImage("imagens/ataque.png")

        end
        if (jogador.last_move_x == 'a') then
            jogador.em_ataque = true
            jogador.image = love.graphics.newImage("imagens/ataque_esq.png")
        end
        ---end
    end

    if (not love.keyboard.isDown('j')) then
        jogador.em_ataque = false
    end

end

-- Animação Sprite
gerencia.generate_sprite = function(player, name_sprite, sprite, sprite_w, sprite_h, quad_w, quad_h, quant_quads,
    direction, current, duration)

    player.sprites[name_sprite] = {
        sprite = sprite,
        sprite_w = sprite_w,
        sprite_h = sprite_h,
        quad_w = quad_w,
        quad_h = quad_h,
        animation = {
            direction = direction,
            idle = false,
            frame = 1,
            max_frames = quant_quads,
            speed = 10,
            timer = 0.1,
            duration = duration
        }
    }

    for key, value in pairs(player.sprites.walk) do
        print('\t', key, value)
    end

    player.sprites[name_sprite].quads = {};
    for i = 1, quant_quads do
        player.sprites[name_sprite].quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w,
            sprite_h);
    end

    if (current) then
        player.sprites.current = {}

        player.sprites.current = {
            sprite = sprite,
            sprite_w = sprite_w,
            sprite_h = sprite_h,
            quad_w = quad_w,
            quad_h = quad_h,
            animation = {
                direction = direction,
                idle = false,
                frame = 1,
                max_frames = quant_quads,
                speed = 10,
                timer = 1,
                duration = duration
            }
        }

        player.sprites.current.quads = {};
        for i = 1, quant_quads do
            player.sprites.current.quads[i] = love.graphics.newQuad(quad_w * (i - 1), 0, quad_w, quad_h, sprite_w,
                sprite_h);
        end
    end

end

-- Info sprite imagens/sprites/corridaDirSpriteSheet.png quad_w->180, quad_h->120
return gerencia
