local inimigo = {}

function inimigo.novo(enemy, forca, categoria, vida, move_px, posX, posY, name)

    enemy.forca = forca;
    enemy.categoria = categoria;
    enemy.vida = vida;

    enemy.dir = 0;
    enemy.dir_nome = 'stopped';
    enemy.move_px = move_px;
    enemy.state = 'peaceful';

    enemy.posX = posX;
    enemy.posY = posY;
    enemy.name = name;

end

return inimigo;
