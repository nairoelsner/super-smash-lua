function love.load()
    wf = require('libraries/windfield')
    world = wf.newWorld(0, 800, false)
    world:setQueryDebugDrawing(true)

    world:addCollisionClass('Platform')
    world:addCollisionClass('Player', {ignores = {'Player'}})
    world:addCollisionClass('Danger')

   require('./src/players/link')
   require('./src/players/kirby')
   require('./src/map/platforms')
   require('./src/map/dangerZones')
end

function love.update(dt)
    world:update(dt)
    linkUpdate(dt)
    kirbyUpdate(dt)
end

function love.draw()
    world:draw()
    love.graphics.print("Kirby damage %: " .. kirby.damage .. "   Deaths: " .. kirby.deaths, 15, 5)
    love.graphics.print("Link damage %: " .. link.damage .. "    Deaths: " .. link.deaths, 15, 25)
end

function love.keypressed(key)
    if link.body then
        linkPressedKey(key)
    end

    if kirby.body then
        kirbyPressedKey(key)
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