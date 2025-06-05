function love.load()
   printx = 0
   printy = 0
end
function love.mousepressed(x, y, button, istouch)
   if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
      printx = x
      printy = y
   end
end

function love.draw()
  love.graphics.print(printx, 100, 0)
  love.graphics.print(printy, 0, 100)
end
function love.update(dt)
  print(printx, printy)
end


local console = {
    x = 100, y = 100,
    width = 400, height = 250,
    drag = false, resize = false,
    minimized = false, closed = false,
    dragOffset = {x = 0, y = 0},
    messages = {
        "Warning: Welcome",
        "This Plugin are use",
        "FUL To iOS and",
        "Android Device",
        "For Print Basic"
    }
}

local logger = {}

local function safeInsert(msg)
    table.insert(console.messages, msg)
    if #console.messages > 100 then
        table.remove(console.messages, 1)
    end
end
local function drawTopBar()
    love.graphics.setColor(0.1, 0.1, 0.4)
    love.graphics.rectangle("fill", console.x, console.y, console.width, 30)
    -- Minimize [-]
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("fill", console.x + console.width - 60, console.y, 30, 30)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("-", console.x + console.width - 50, console.y + 8)
    -- Close [X]
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", console.x + console.width - 30, console.y, 30, 30)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("X", console.x + console.width - 20, console.y + 8)
end  


local baseFontSize = 14
local baseFont = love.graphics.newFont(baseFontSize)
love.graphics.setFont(baseFont)

local function updateFont()
    local scaleFactor = math.max(0.5, console.height / 250) -- scale but keep readable
    local newSize = math.floor(baseFontSize * scaleFactor)
    love.graphics.setFont(love.graphics.newFont(newSize))
end

function love.update(dt)
end

function love.draw()
    if console.closed then return end

    -- Full window
    love.graphics.setColor(0.2, 0.2, 0.8)
    love.graphics.rectangle("fill", console.x, console.y, console.width, console.height)

    drawTopBar()

    if not console.minimized then
        -- Inner area
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", console.x + 5, console.y + 35, console.width - 10, console.height - 40)

        love.graphics.setColor(1, 1, 1)
        local y = console.y + 40
        for i, line in ipairs(console.messages) do
            love.graphics.print(line, console.x + 10, y)
            y = y + 18
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        if x >= console.x + console.width - 30 and y >= console.y and y <= console.y + 30 then
            console.closed = true
        elseif x >= console.x + console.width - 60 and y >= console.y and y <= console.y + 30 then
            console.minimized = not console.minimized
        elseif x >= console.x and x <= console.x + console.width and y >= console.y and y <= console.y + 30 then
            console.drag = true
            console.dragOffset.x = x - console.x
            console.dragOffset.y = y - console.y
        elseif x >= console.x + console.width - 10 and y >= console.y + console.height - 10 then
            console.resize = true
        end
    end
end
function love.mousereleased(x, y, button)
    if button == 1 then
        console.drag = false
        console.resize = false
    end
end

function love.mousemoved(x, y, dx, dy)
    if console.drag then
        console.x = x - console.dragOffset.x
        console.y = y - console.dragOffset.y
    elseif console.resize then
        console.width = math.max(200, x - console.x)
        console.height = math.max(100, y - console.y)
    end
end

function love.keypressed(key)
    if key == "f9" or key == "`" or key == "," then
        console.closed = not console.closed
        if not console.closed then
            print.warning("Console opened")
        end
    end
end

print("hello")
-- Custom print system
myprint = {}
function warprint(msg)
    safeInsert("[Warning] " .. msg)
end

function errprint(msg)
    safeInsert("[Error] " .. msg)
end

function print(msg)
    safeInsert("[log] " .. (msg))
end

print("yo")
errprint("boo did i scare you this is job applicetion")
warprint("me too")
-- Override standard print
function log(msg)
    table.insert(console.message, tostring(msg))
end
-- Override standard print
local _print = print
function print(msg)
    safeInsert(tostring(msg))
end
function love.load() 
  local os = love.system.getOS()
local theme = "xp"
end

if os == "Windows" then
    local ver = os.getenv("ver") or ""
    if ver:find("6.1") then
        theme = "win7"
    elseif ver:find("10.0") then
        theme = "win10"
    else
        theme = "xp"
    end
elseif os == "Linux" or os == "OS X" or os == "BSD" then
    theme = "xp"
else
    theme = "basic"
end

if theme == "xp" then
    love.graphics.setColor(0.1, 0.1, 0.4)
    love.graphics.rectangle("fill", console.x, console.y, console.width, 30)
elseif theme == "win7" then
    love.graphics.setColor(0.2, 0.4, 1, 0.45) -- transparent blue
    love.graphics.rectangle("fill", console.x, console.y, console.width, 30)
elseif theme == "win10" or theme == "basic" then
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.rectangle("fill", console.x, console.y, console.width, 30)
end
if console.minimized then
        -- Draw only the mini bar
        love.graphics.setColor(0.4, 0.4, 0.4)
        love.graphics.rectangle("fill", console.x, console.y, console.width, 25)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Console (minimized)", console.x + 5, console.y + 5)
end
      