-- playerspanel draws the information about how many resources the other
-- players have and their names

require("board")

playerspanel = {}
local font_height = 0
local totheleft = 0

local function drawPlayerPanel(player, x, y)
	love.graphics.print(player.name, x, y)
	y = y + font_height
	for k, v in ipairs(resource_list) do
		love.graphics.print(v .. " " .. player.resource[v], x, y)
		y = y + font_height
	end
end

function playerspanel.load()
	local std_font = love.graphics.newFont(12)
	font_height = std_font:getHeight()
	space_from_right = std_font:getWidth("wheat 100") + 20
	-- 6 lines = 5 resources + playername
	-- 35 = panel height
	space_from_bottom = std_font:getHeight("wheat 100") * 6 + 35 + 50
end

function playerspanel.draw()
	love.graphics.setColor(117, 32, 4)

	drawPlayerPanel(player[2], 10, 10)
	drawPlayerPanel(player[3], love.graphics.getWidth() - space_from_right, 10)
	drawPlayerPanel(player[4], love.graphics.getWidth() - space_from_right, love.graphics.getHeight() - space_from_bottom)
	-- reset color
	love.graphics.setColor(255, 255, 255)
end

