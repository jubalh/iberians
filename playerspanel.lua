-- playerspanel draws the information about how many resources the other
-- players have and their names

require("board")

playerspanel = {}
local font_height = 0
local totheleft = 0

local function drawPlayerPanel(player, x, y)
	-- in case we have less than 4 players
	-- player can be nil
	if player ~= nil then

		-- draw panel, in players color, around the text
		love.graphics.setColor(player.color.r, player.color.g, player.color.b)
		love.graphics.rectangle("fill", x - 10, y - 5, 90, 180)
		love.graphics.setColor(255,255,255)

		love.graphics.print(player.name, x, y)
		y = y + font_height + 10 -- spacing

		for k, v in ipairs(resource_list) do
			-- draw resource icon
			love.graphics.draw(icon_img[v], x, y, 0, 0.5, 0.5)
			-- print amount
			love.graphics.print(player.resource[v], x + 50, y)
			y = y + icon_img[v]:getHeight()/2 + 5
		end
	end
end

function playerspanel.load()
	local std_font = love.graphics.newFont(12)
	font_height = std_font:getHeight()
	space_from_right = std_font:getWidth("wheat 100") + 20
end

function playerspanel.draw()
	love.graphics.setColor(117, 32, 4)

	drawPlayerPanel(player[2], love.graphics.getWidth() - space_from_right, 20)
	drawPlayerPanel(player[3], love.graphics.getWidth() - space_from_right, 210)
	drawPlayerPanel(player[4], love.graphics.getWidth() - space_from_right, 400)
	-- reset color
	love.graphics.setColor(255, 255, 255)
end

