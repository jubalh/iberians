board = {}
board.grid = {}

local img = {}

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

function board.createBoard()
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

function board.load()
	-- resources
	img["brick"] = love.graphics.newImage("assets/images/brick.png")
	img["iron"] = love.graphics.newImage("assets/images/iron.png")
	img["wheat"] = love.graphics.newImage("assets/images/wheat.png")
	img["wood"] = love.graphics.newImage("assets/images/wood.png")
	img["wool"] = love.graphics.newImage("assets/images/wool.png")
	-- empty
	img["desert"] = love.graphics.newImage("assets/images/desert.png")
	img["water"] = love.graphics.newImage("assets/images/water.png")

	tile_width = img["brick"]:getWidth()
	tile_height = img["brick"]:getHeight()
end

function board.draw(x, y)
	if x == nil then x = 0 end
	if y == nil then y = 0 end

	for xi = 1, #board.grid do
		for yi = 1, #board.grid[xi] do
			if board.grid[xi][yi].tile ~= nil then
				local xpos = (xi-1) * tile_width
				local ypos = (yi-1) * tile_height

				if(yi % 2 == 0) then
					xpos = xpos + tile_width/2
				end
				if yi > 1 then
					ypos = ypos - (tile_height/4*(yi-1))
				end

				xpos = xpos + x
				ypos = ypos + y

				love.graphics.draw(img[board.grid[xi][yi].tile], xpos, ypos)
			end
		end
	end
	if debug then
		love.graphics.setColor(255,0,0)
		-- height is -1 because we 4 times subtract a quarter (see above
		love.graphics.rectangle("line", x, y, tile_width * #board.grid[3], tile_height * (#board.grid - 1))
		love.graphics.setColor(255,255,255)
	end
end
