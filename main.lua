require("board")
require("intro")

debug = false
game = {}
game.state = "intro"
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

	intro.load()
	board.load()
	board.grid = board.createBoard()
end

function love.update(dt)
end

function love.draw()
	if game.state == "intro" then
		intro.draw()
	elseif game.state == "game" then
		love.graphics.setBackgroundColor(51, 102, 204)
		board.draw(162, 30)
		board.drawBar()
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end
