require("board")
debug = true

function love.load()
	board.load()
	board.grid = board.createBoard()
end


function love.update(dt)
end

function love.draw()
	board.draw()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end
