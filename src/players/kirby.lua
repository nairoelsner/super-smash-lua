kirby = world:newRectangleCollider(625, 100, 46, 46)
kirby.height = 46
kirby.width = 46
kirby.x, kirby.y = kirby:getPosition()
kirby.speed = 240
kirby.jumpCount = 0
kirby.damage = 0
kirby.deaths = 0
kirby.direction = 1 -- right: 1, left: -1
kirby:setCollisionClass('Player')
kirby:setFixedRotation(true)


function kirbyUpdate(dt)
    if kirby.body then
        local px, py = kirby:getPosition()
        local colliders = world:queryRectangleArea(kirby:getX() - 46 / 2, kirby:getY() + 23, 46, 2, {'Platform'})

        if #colliders > 0 then
            kirby.jumpCount = 0
        end

        if love.keyboard.isDown('down') then
            --kirby:setHeight(40)
        else
            --kirby:setHeight(80)
        end

        if love.keyboard.isDown('left') then
            kirby:setX(px - kirby.speed*dt)
            kirby.direction = -1
        end

        if love.keyboard.isDown('right') then
            kirby:setX(px + kirby.speed*dt)
            kirby.direction = 1
        end

        if kirby:enter('Danger') then
            local deaths = kirby.deaths
            kirby:destroy()
            kirby = world:newRectangleCollider(550, 100, 46, 46)
            kirby.height = 46
            kirby.width = 46
            kirby.x, kirby.y = kirby:getPosition()
            kirby.speed = 240
            kirby.jumpCount = 0
            kirby.damage = 0
            kirby.deaths = deaths + 1
            kirby.direction = 1 -- right: 1, left: -1
            kirby:setCollisionClass('Player')
            kirby:setFixedRotation(true)
        end
    end
end

function kirbyPressedKey(key)
    if key == 'up' then
        kirbyJump()
    end

    if key == ';' then
        kirbyAttack()
    end
end

function kirbyJump()
    local colliders = world:queryRectangleArea(kirby:getX() - 20, kirby:getY() + 35, 40, 2, {'Platform'})
    if #colliders > 0 or kirby.jumpCount < 2 then
        kirby:applyLinearImpulse(0, -2500)
        kirby.jumpCount = kirby.jumpCount + 1
    end
end

function kirbyAttack()
    if kirby.direction == 1 then
        colliders = world:queryRectangleArea(kirby:getX() + 25, kirby:getY() - 20, 50, 25, {'Player'})
    else
        colliders = world:queryRectangleArea(kirby:getX() - 75, kirby:getY() - 20, 50, 25, {'Player'})
    end

    for i, c in ipairs(colliders) do
        c:applyLinearImpulse(50 * c.damage * kirby.direction, -150 * c.damage)
        c.damage = c.damage + 2
    end
end