require("board")

debug = false
player = {}

resource_list = { "brick", "iron", "wheat", "wood", "wool" }

function love.load()
	-- initialize players
	for i = 1, 4 do
		player[i] = {}
		player[i].name = "Player"..i
		player[i].resource = {}

		-- initialize players resources
		for k, v in ipairs(resource_list) do
			player[i].resource[v] = 100
		end
	end

	board.load()
	board.grid = board.createBoard()
end

function love.update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(51, 102, 204)
	board.draw(162, 30)
	board.drawBar()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end
