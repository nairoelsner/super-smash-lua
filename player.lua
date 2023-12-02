player = world:newRectangleCollider(350, 100, 40, 70)
player.height = 70
player.width = 40
player.x = 350
player.y = 100
player.speed = 240
player.jumpCount = 0
player.damage = 0
player.direction = 1 -- right: 1, left: -1
player:setCollisionClass('Player')
player:setFixedRotation(true)


function playerUpdate(dt)

    if player.body then
        local px, py = player:getPosition()
        local colliders = world:queryRectangleArea(player:getX() - 40 / 2, player:getY() + 35, 40, 2, {'Platform'})

        if #colliders > 0 then
            player.jumpCount = 0
        end

        if love.keyboard.isDown('down') then
            --player:setHeight(40)
        else
            --player:setHeight(80)
        end

        if love.keyboard.isDown('left') then
            player:setX(px - player.speed*dt)
            player.direction = -1
        end

        if love.keyboard.isDown('right') then
            player:setX(px + player.speed*dt)
            player.direction = 1
        end

        if player:enter('Danger') then
            player:destroy()
            player = world:newRectangleCollider(350, 100, 40, 70, {collision_class = "Player"})
            player.height = 70
            player.width = 40
            player.x = 350
            player.y = 100
            player.speed = 240
            player.jumpCount = 0
            player.damage = 0
            player.direction = 1 -- right: 1, left: -1
            player:setFixedRotation(true)
        end
    end

end