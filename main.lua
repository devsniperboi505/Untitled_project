local a = 1
key1 = love.keyboard.isdown(',')
key2 = love.keyboard.isDown("f9")
local console = {
    lines = {},
    max_lines = 10,
    font = nil,
    isVisible = false,
    width = 0,
    height = 0
}

-- Override basic print
function print(msg)
    if console.font then  -- only if font is ready
        console:addLine(tostring(msg), {1, 1, 1}) -- white
    end
end

-- Custom warning
function warnprint(msg)
    if console.font then
        console:addLine("WARNING: " .. tostring(msg), {1, 1, 0}) -- yellow
    end
end

-- Custom error
function errprint(msg)
    if console.font then
        console:addLine("ERROR: " .. tostring(msg), {1, 0, 0}) -- red
    end
end

function console:addLine(text, color)
    table.insert(self.lines, { text = text, color = color or {1, 1, 1} })

    -- Overflow check: if total text height is more than screen
    local totalHeight = #self.lines * (self.font:getHeight() + 2)
    if totalHeight > self.height - 20 then
        self.lines = {} -- clear logs
        table.insert(self.lines, { text = "Console cleared (overflow)", color = {0.5, 0.5, 0.5} })
        table.insert(self.lines, { text = text, color = color })
    end

    if #self.lines > self.max_lines then
        table.remove(self.lines, 1)
    end
end

function love.load() -- print function target
    console.font = love.graphics.newFont(14)
    love.graphics.setFont(console.font)

    console.width = love.graphics.getWidth()
    console.height = love.graphics.getHeight()

    -- ✅ Now that font is ready, safe to print
    print("hello world")
    warnprint("this is a warning")
    errprint("this is an error")
    print("yogurt")
    warnprint("what is 1 + " .. a)
end

function love.draw()
    if console.isVisible then
        love.graphics.setFont(console.font)
        local y = 10
        for _, line in ipairs(console.lines) do
            love.graphics.setColor(line.color)
            love.graphics.print(line.text, 10, y)
            y = y + console.font:getHeight() + 2
        end
        love.graphics.setColor(1, 1, 1)
    end
end

function summon()
    if key1 or key2 then
        console.isVisible = not console.isVisible
    end
end