require("board")
debug = false

function love.load()
	board.load()
	board.grid = board.createBoard()
end

function love.update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(51, 102, 204)
	board.draw(50)
	board.drawBar()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end
