local console = require "plugin/console"
love.keyboard.setKeyRepeat(true) -- Not required.

function love.keypressed(key, scancode, isrepeat)
  console.keypressed(key, scancode, isrepeat)
end

function love.textinput(text)
  console.textinput(text)
end

function love.draw()
  console.draw()
end

-- This function is run when the user types "save" into the console.
console.COMMANDS.save = function()
  -- Example: save game state
end

-- This table is available as "player" in the console scope.
console.ENV.player = {x = 100, y = 5}