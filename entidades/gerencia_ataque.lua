local gerencia_ataque_module = {}

gerencia_ataque_module.update = function (player, enemy)
end

gerencia_ataque_module.valida_ataque = function(player, enemy, is_player_attack)


    local modulo_distancia = player.char.x - enemy.posX;
    local dir;

    if (modulo_distancia < 0) then
        modulo_distancia = modulo_distancia * -1;
        dir = 'right';
    else
        dir = 'left';
    end

    if player.state == 'attacking' and not(State == 'death') and modulo_distancia <= 140 and player.char.last_move_x == dir then

        print("Current Pré Ataque HP Orc: " .. enemy.vida);
        print('Acertou');

        --State = 'damaged';
        enemy.vida = enemy.vida - player.dano_espada;
        print("Current HP Orc: " .. enemy.vida);

        if(enemy.vida <= 0)then
            State = 'death';
        end

    end

    if State == 'attacking' and modulo_distancia <= 100 and player.char.last_move_x == dir then

        print("Current Pré Ataque HP Player: " .. player.vida);
        print('Orc Acertou');

        --State = 'damaged';
        player.vida = player.vida - enemy.forca;
        print("Current HP Player: " .. player.vida);

        if(player.vida <= 0)then
            player.state = 'death';
        end

    end
end

return gerencia_ataque_module;
