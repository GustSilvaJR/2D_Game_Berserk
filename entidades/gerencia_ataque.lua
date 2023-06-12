local gerencia_ataque_module = {}

gerencia_ataque_module.data = {}

function gerencia_ataque_module.update(player, enemy)
    local modulo_distancia = player.char.x - enemy.posX;
    local dir;

    if (modulo_distancia < 0) then
        modulo_distancia = modulo_distancia * -1;
        dir = 'right';
    else
        dir = 'left';
    end

    if player.state == 'attacking' and modulo_distancia<=140 and player.char.last_move_x == dir then
        print("Current Pré Ataque HP Orc: ".. enemy.vida);
        print('Acertou');
        State = 'damaged';
        enemy.vida = enemy.vida - player.dano_espada;
        print("Current HP Orc: ".. enemy.vida);
    end

end

return gerencia_ataque_module;
