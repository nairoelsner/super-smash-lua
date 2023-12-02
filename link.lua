link = world:newRectangleCollider(350, 100, 40, 70)
link.height = 70
link.width = 40
link.x, link.y = link:getPosition()
link.speed = 240
link.jumpCount = 0
link.damage = 0
link.deaths = 0
link.direction = 1 -- right: 1, left: -1
link:setCollisionClass('Player')
link:setFixedRotation(true)


function linkUpdate(dt)
    if link.body then
        local px, py = link:getPosition()
        local colliders = world:queryRectangleArea(link:getX() - 40 / 2, link:getY() + 35, 40, 2, {'Platform'})

        if #colliders > 0 then
            link.jumpCount = 0
        end

        if love.keyboard.isDown('down') then
            --link:setHeight(40)
        else
            --link:setHeight(80)
        end

        if love.keyboard.isDown('a') then
            link:setX(px - link.speed*dt)
            link.direction = -1
        end

        if love.keyboard.isDown('d') then
            link:setX(px + link.speed*dt)
            link.direction = 1
        end

        if link:enter('Danger') then
            local deaths = link.deaths
            link:destroy()
            link = world:newRectangleCollider(350, 100, 40, 70, {collision_class = "Player"})
            link.height = 70
            link.width = 40
            link.x = 350
            link.y = 100
            link.speed = 240
            link.jumpCount = 0
            link.damage = 0
            link.deaths = deaths + 1
            link.direction = 1 -- right: 1, left: -1
            link:setFixedRotation(true)
        end
    end
end

function linkPressedKey(key)
    if key == 'w' then
        linkJump()
    end

    if key == 'space' then
        linkAttack()
    end
end

function linkJump()
    local colliders = world:queryRectangleArea(link:getX() - 20, link:getY() + 35, 40, 2, {'Platform'})
    if #colliders > 0 or link.jumpCount < 2 then
        link:applyLinearImpulse(0, -2500)
        link.jumpCount = link.jumpCount + 1
    end 
end

function linkAttack()
    if link.direction == 1 then
        colliders = world:queryRectangleArea(link:getX() + 25, link:getY() - 20, 50, 25, {'Player'})
    else
        colliders = world:queryRectangleArea(link:getX() - 75, link:getY() - 20, 50, 25, {'Player'})
    end
    
    --colliders = world:queryRectangleArea(link:getX() + 40 * link.direction, link:getY() - 20, 50, 25, {'Enemy'})
    for i, c in ipairs(colliders) do
        c:applyLinearImpulse(50 * c.damage * link.direction, -150 * c.damage)
        c.damage = c.damage + 2
    end
end