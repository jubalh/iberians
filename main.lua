require("board")
require("intro")
require("legend")
require("panel")
require("playerspanel")

--
-- Debug variables
--
debug = false
show_res_val = true
--
--

game = {}
game.state = "intro"
game.action = "none"
game.activePlayer = 1
player = {}

resource_list = { "brick", "iron", "wheat", "wood", "wool" }

function love.load()
	intro.load()
	board.load()
	panel.load()
	playerspanel.load()
end

function love.update(dt)
end

function love.draw()
	if game.state == "intro" then
		intro.draw()
	elseif game.state == "game" then
		love.graphics.setBackgroundColor(51, 102, 204)
		board.draw(162, 30)
		panel.drawBar()
		playerspanel.draw()
	elseif game.state == "legend" then
		legend.draw()
	end
end

function love.keypressed(key)
	if key == "escape" then
		game.state = "intro"
	end
end

function love.mousepressed(x, y, button)
	if game.state == "intro" then
		intro.mousepressed(x, y, button)
	elseif game.state == "game" then
		panel.mousepressed(x, y, button)
	end
end

function love.mousemoved(x, y, dx, dy)
	if game.state == "game" then
		board.mousemoved_street(x, y, dx, dy)
	end
end
