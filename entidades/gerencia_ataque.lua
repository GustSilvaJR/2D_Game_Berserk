local gerencia_ataque_module = {}

gerencia_ataque_module.update = function (player, enemy)
end

gerencia_ataque_module.valida_ataque_player = function(player)


    local modulo_distancia = player.char.x - Inimigos[1].posX;
    local dir;

    if (modulo_distancia < 0) then
        modulo_distancia = modulo_distancia * -1;
        dir = 'right';
    else
        dir = 'left';
    end

    if player.state == 'attacking' and not(State == 'death') and modulo_distancia <= 140 and player.char.last_move_x == dir then
        State = 'death';

        print("Current Pré Ataque HP Orc: " .. Inimigos[1].vida);
        print('Acertou');
        --State = 'damaged';
        Inimigos[1].vida = Inimigos[1].vida - player.dano_espada;
        print("Current HP Orc: " .. Inimigos[1].vida);

        
        Inimigos[1].sprites.current.sprite = false;
        Inimigos[1].sprites.run.sprite = false;
        Inimigos[1].sprites.stopped.sprite = false;
        Inimigos[1].sprites.attack_1.sprite = false;
        Inimigos[1].sprites.damaged.sprite = false;
        
    end
end

return gerencia_ataque_module;
