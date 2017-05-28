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
player = {}

resource_list = { "brick", "iron", "wheat", "wood", "wool" }

resource_value_pool = { 2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12 }

local function shuffleTable(t)
	local iter = #t
	local j

	for i = iter, 2, -1 do
		j = love.math.random(i)
		t[i], t[j] = t[j], t[i]
	end
end

function newGame()
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

	board.grid = board.createBoard()
	shuffleTable(resource_value_pool)
end

function love.load()
	intro.load()
	board.load()
	panel.load()
	playerspanel.load()
	newGame()
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
