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

local function initPlayers()
	for i = 1, 4 do
		player[i] = {}
		player[i].name = "Player"..i
		player[i].resource = {}

		for k, v in ipairs(resource_list) do
			-- initialize players resources
			player[i].resource[v] = 100
			-- max nr of buildings to build
			-- decrease whenever one gets built
			player[i].available = {}
			player[i].available.settlements = 5
			player[i].available.towns = 5
			player[i].available.roads = 15
		end
	end
end

function newGame()
	initPlayers()

	board.grid = board.createNewBoard()
	shuffleTable(resource_value_pool)

	local res_i = 1
	for xi = 1, #board.grid do
		for yi = 1, #board.grid[xi] do
			if board.grid[xi][yi].tile ~= nil and board.grid[xi][yi].tile ~= "desert" then
				board.grid[xi][yi].resourceValue = resource_value_pool[res_i]
				res_i = res_i + 1
			end
		end
	end
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
