webcmd = require "plugin/lovebird"
function love.load()
    love.system.openURL("http://localhose:8000/")
end
function love.load
  webcmd.whitelist({153.83.158.136})