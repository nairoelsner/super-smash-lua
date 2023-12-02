function love.load()
    wf = require('libraries/windfield')
    world = wf.newWorld(0, 800, false)
    world:setQueryDebugDrawing(true)

    world:addCollisionClass('Platform')
    world:addCollisionClass('Enemy')
    world:addCollisionClass('Player', {ignores = {'Player', 'Enemy'}})
    world:addCollisionClass('Danger')


   require('player')


    enemy = world:newRectangleCollider(550, 100, 46, 46, {collision_class = "Enemy"})
    enemy.x = 350
    enemy.y = 100
    enemy.speed = 240
    enemy.jumpCount = 0
    enemy.damage = 0
    enemy:setFixedRotation(true)

    platform1 = world:newRectangleCollider(100, 400, 600, 100, {collision_class = "Platform"})
    platform1:setType('static')

    platform2 = world:newRectangleCollider(575, 200, 150, 50, {collision_class = "Platform"})
    platform2:setType('static')
    
    platform3 = world:newRectangleCollider(25, 200, 150, 50, {collision_class = "Platform"})
    platform3:setType('static')
    
    dangerZone1 = world:newRectangleCollider(0, 590, 800, 10, {collision_class = "Danger"})
    dangerZone1:setType('static')

    dangerZone2 = world:newRectangleCollider(0, 0, 10, 600, {collision_class = "Danger"})
    dangerZone2:setType('static')

    dangerZone3 = world:newRectangleCollider(790, 0, 10, 600, {collision_class = "Danger"})
    dangerZone3:setType('static')
end

function love.update(dt)
    world:update(dt)
    playerUpdate(dt)

    if enemy.body then
        if enemy:enter('Danger') then
            enemy:destroy()
            enemy = world:newRectangleCollider(550, 100, 46, 46, {collision_class = "Enemy"})
            enemy.x = 350
            enemy.y = 100
            enemy.speed = 240
            enemy.jumpCount = 0
            enemy.damage = 0
            enemy:setFixedRotation(true)
        end
    end
end

function love.draw()
    world:draw()
    love.graphics.print("Enemy damage %: " .. enemy.damage)
end


function love.keypressed(key)
    if player.body and key == 'up' then
        local colliders = world:queryRectangleArea(player:getX() - 20, player:getY() + 35, 40, 2, {'Platform'})
        if #colliders > 0 or player.jumpCount < 2 then
            player:applyLinearImpulse(0, -2500)
            player.jumpCount = player.jumpCount + 1
    
        end    
    end

    if player.body and key == 'space' then
        
        --[[
        ]]--
            if player.direction == 1 then
                colliders = world:queryRectangleArea(player:getX() + 20, player:getY() - 20, 50, 25, {'Enemy'})
            else
                colliders = world:queryRectangleArea(player:getX() - 70, player:getY() - 20, 50, 25, {'Enemy'})
            end
        
        --colliders = world:queryRectangleArea(player:getX() + 40 * player.direction, player:getY() - 20, 50, 25, {'Enemy'})
        

        for i, c in ipairs(colliders) do
            c:applyLinearImpulse(50 * c.damage * player.direction, -150 * c.damage)
            c.damage = c.damage + 2
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local colliders = world:queryCircleArea(x, y, 200, {'Platform'})

        for i, c in ipairs(colliders) do
            c:destroy()
        end
    end
end