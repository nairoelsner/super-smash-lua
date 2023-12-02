dangerZone1 = world:newRectangleCollider(0, 590, 800, 10, {collision_class = "Danger"})
dangerZone1:setType('static')

dangerZone2 = world:newRectangleCollider(0, 0, 10, 600, {collision_class = "Danger"})
dangerZone2:setType('static')

dangerZone3 = world:newRectangleCollider(790, 0, 10, 600, {collision_class = "Danger"})
dangerZone3:setType('static')