board = {}
board.grid = {}

local tile_img = {}
local icon_img = {}

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
	tile_img["brick"] = love.graphics.newImage("assets/images/tiles/brick.png")
	tile_img["iron"] = love.graphics.newImage("assets/images/tiles/iron.png")
	tile_img["wheat"] = love.graphics.newImage("assets/images/tiles/wheat.png")
	tile_img["wood"] = love.graphics.newImage("assets/images/tiles/wood.png")
	tile_img["wool"] = love.graphics.newImage("assets/images/tiles/wool.png")
	-- empty
	tile_img["desert"] = love.graphics.newImage("assets/images/tiles/desert.png")
	tile_img["water"] = love.graphics.newImage("assets/images/tiles/water.png")

	tile_width = tile_img["brick"]:getWidth()
	tile_height = tile_img["brick"]:getHeight()

	icon_img["brick"] = love.graphics.newImage("assets/images/icons/brick.png")
	icon_img["iron"] = love.graphics.newImage("assets/images/icons/iron.png")
	icon_img["wheat"] = love.graphics.newImage("assets/images/icons/wheat.png")
	icon_img["wood"] = love.graphics.newImage("assets/images/icons/wood.png")
	icon_img["wool"] = love.graphics.newImage("assets/images/icons/wool.png")
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

				love.graphics.draw(tile_img[board.grid[xi][yi].tile], xpos, ypos)
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

function board.drawBar()
	-- background bar
	local x = 100
	local y = love.graphics.getHeight() - 40
	local width = love.graphics.getWidth() - 200
	local height = 35

	--love.graphics.setColor(82, 50, 23)
	love.graphics.setColor(117, 32, 4)
	love.graphics.rectangle("fill", x, y, width, height)
	love.graphics.setColor(255,255,255)

	local icon_x = x + 80
	local icon_y = y - 10
	local icon_distance = 50
	love.graphics.draw(icon_img["brick"], icon_x, icon_y)
	icon_x = icon_x + icon_img["brick"]:getWidth() + icon_distance
	love.graphics.draw(icon_img["iron"], icon_x, icon_y)
	icon_x = icon_x + icon_img["iron"]:getWidth() + icon_distance
	love.graphics.draw(icon_img["wheat"], icon_x, icon_y)
	icon_x = icon_x + icon_img["wheat"]:getWidth() + icon_distance
	love.graphics.draw(icon_img["wood"], icon_x, icon_y)
	icon_x = icon_x + icon_img["wood"]:getWidth() + icon_distance
	love.graphics.draw(icon_img["wool"], icon_x, icon_y)
	icon_x = icon_x + icon_img["wool"]:getWidth() + icon_distance
	--[[
	-- like this the order would be undefined
	for i, v in pairs(icon_img) do
		love.graphics.draw(v, icon_x , icon_y)
		icon_x = icon_x + v:getWidth() + icon_distance
	end
	--]]
end
