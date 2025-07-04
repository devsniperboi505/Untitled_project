--       sprite slicer configuration zone
function love.load()
 playerimg = love.graphics.newImage("player.png")
 bottom_left = love.graphics.newQuad(0, 16, 16, 55, 55)
end
--             start here to code
function love.load() -- variable zone
 local player = {}
 local playerx = 100
 local playery = 50
 local playerXspeed = 4
 local playerYjump = 5
 local playerW = love.keyboard.isDown("w")
end
function love.load() -- code here zone
 -- gurt
end
function love.update(dt)
 if playerW then
  player.x = player.x + player.speed
 end
end
function love.draw()
 love.graphics.draw(playerimg, bottom_left, playerx, playery)
end