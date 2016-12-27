require("board")

debug = false
game = {}
game.stats = {}
game.stats.player = {}
game.stats.player.resource = {}

resource_list = { "brick", "iron", "wheat", "wood", "wool" }

function love.load()
	-- initialize players resources
	for k, v in ipairs(resource_list) do
		game.stats.player.resource[v] = 100
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
