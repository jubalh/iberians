require("board")

setup = {}

local resource_value_pool = { 2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12 }

local function shuffleTable(t)
	local iter = #t
	local j

	for i = iter, 2, -1 do
		j = love.math.random(i)
		t[i], t[j] = t[j], t[i]
	end
end

local function initPlayers(player)
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

			player[i].color = {}
		end
	end

	-- set colors
	player[1].color.r = 135
	player[1].color.g = 31
	player[1].color.b = 42

	player[2].color.r = 0
	player[2].color.g = 161
	player[2].color.b = 83

	player[3].color.r = 204
	player[3].color.g = 153
	player[3].color.b = 51


	player[4].color.r = 112
	player[4].color.g = 31
	player[4].color.b = 130
end

local function distributeResourceValues(grid, pool)
	local res_i = 1
	for xi = 1, #grid do
		for yi = 1, #grid[xi] do
			if grid[xi][yi].tile ~= nil and grid[xi][yi].tile ~= "desert" then
				grid[xi][yi].resourceValue = pool[res_i]
				res_i = res_i + 1
			end
		end
	end
end

local function setTileByNr(cell, nr)
	if nr == 1 then
		cell.tile = "brick"
	elseif nr == 2 then
		cell.tile = "iron"
	elseif nr == 3 then
		cell.tile = "wheat"
	elseif nr == 4 then
		cell.tile = "wood"
	elseif nr == 5 then
		cell.tile = "wool"
	elseif nr == 6 then
		cell.tile = "desert"
	end
end

local function createShuffledBoard()
	-- create 2d board array
	local grid = {}
	for x = 1, 5 do
		grid[x] = {}
		for y = 1, 5 do
			grid[x][y] = {}
		end
	end

	-- generate a list with random numbers from one to 5 standing for each tile variant
	local r = {}
	for i = 1, 19 do
		r[i] = love.math.random(1, 5)
	end

	-- desert
	local desertpos = love.math.random(1,19)
	r[desertpos] = 6

	local i = 1

	-- init game grid
	for x = 2, 4 do
		setTileByNr(grid[x][1], r[i])
		i = i + 1
		setTileByNr(grid[x][5], r[i])
		i = i + 1
	end
	for x = 1, 4 do
		setTileByNr(grid[x][2], r[i])
		i = i + 1
		setTileByNr(grid[x][4], r[i])
		i = i + 1
	end
	for x = 1, 5 do
		setTileByNr(grid[x][3], r[i])
		i = i + 1
	end

	return grid
end

local function createNewBoard()
	grid = createShuffledBoard()

	-- position bandit on desert
	for xi = 1, #grid do
		for yi = 1, #grid[xi] do
			if grid[xi][yi].tile == "desert" then
				-- print(xi .. " ".. yi)
				grid[xi][yi].bandit = "true"
			end
		end
	end
	return grid
end

function setup.newGame(player)
	initPlayers(player)
	grid = createNewBoard()
	shuffleTable(resource_value_pool)
	distributeResourceValues(grid, resource_value_pool)
	return grid
end
