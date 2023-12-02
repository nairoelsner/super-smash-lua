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