tabletop={}
tabletop_size=24
tiles_empty={1,1,1,1,1,1,1,1,3,4}

-- cursor
curs=class:new({
	x=tabletop_size/2*8,
	y=tabletop_size/2*8,
	target=0,
	update=function(_ENV)
		--[[
		if btnp(⬅️) then x -=8 end
		if btnp(➡️) then x +=8 end
		if btnp(⬆️) then y -=8 end
		if btnp(⬇️) then y +=8 end
		x=mid(8,x,(tabletop_size*8)) --clamp val
		y=mid(8,y,(tabletop_size*8))
		]]
	end, 
	draw=function(_ENV)
		rect(x,y,x+7,y+7,7)
	end,
	set_target=function(_ENV, a)
		target=a
		x=target.tile_x*8
		y=target.tile_y*8
	end
})

-- gameplay camera
game_cam=class:new({
	target=gm.units[gm.active_unit],
	x=0,
	y=0,
	update=function(_ENV)
	 x=lerp(x,(target.tile_x*8)-64,0.1)
	 y=lerp(y,(target.tile_y*8)-64,0.1)
	 x=mid(8,x,72)
	 y=mid(8,y,72)
	end,
	draw=function(_ENV)
		camera(x,y)
	end
})

function draw_mode_test()
	cls(0)
	game_cam:draw()
	draw_tabletop()
	curs:draw()
	circ(gm.units[gm.active_unit].tile_x*8 +4,gm.units[gm.active_unit].tile_y*8+4,4,8)
	draw_units()
	-- draw ui stuff
	camera()
end

function init_game()
	generate_tabletop()
	create_units()
	place_units()
end

function update_game()
	curs:update()
	game_cam:update()
	if btnp(⬆️) then gm.active_unit+=1 end
	if btnp(⬇️) then gm.active_unit-=1 end
	gm.active_unit=mid(1,gm.active_unit,#gm.units)
	game_cam.target=gm.units[gm.active_unit]
end

function draw_game()	
	draw_mode_test()
end

-- used to draw deployment zones or aoe
function draw_zone(tile_x,tile_y,width,height,clr)
	-- zone test
 fillp(0b0011001111001100.1)
 rectfill(tile_x*8,tile_y*8,(tile_x*8)+(width*8)-1,(tile_y*8)+(height*8)-1,clr)
 fillp()
end

function generate_tabletop()
	for row=1,tabletop_size do
		tabletop[row]={}
		for column=1,tabletop_size do
			if rnd(10) <= 9 then
				tabletop[row][column]=rnd(tiles_empty)
			else			
				tabletop[row][column]=rnd({2,6})
			end
		end
	end
end

function place_units()
		for unit in all(gm.units) do 
			local spot_found = false
			local tile_x,tile_y
			while not spot_found do 
				tile_x=flr(rnd(tabletop_size)+1)
				tile_y=flr(rnd(tabletop_size)+1)
				if tabletop[tile_x][tile_y]==1 then
					spot_found=true
				end
			end
			unit.tile_x=tile_x
			unit.tile_y=tile_y
			log("Placing unit \""..unit.name.." at {"..unit.tile_x..","..unit.tile_y.."}")
		end
		game_cam.target=gm.units[gm.active_unit]
end

function draw_tabletop()
	-- draw tiles
	for w=1,tabletop_size do
		for h=1,tabletop_size do
			spr(tabletop[w][h],w*8,h*8)
		end
	end
end

function create_units()
	for i=0,10 do 
		unit = model:new()
		unit.name="Unit"..i
		add(gm.units,unit)
	end
end

function draw_units()
	--draw units
	for unit in all(gm.units) do 
		palt(14,true)
		spr(unit.sprite,unit.tile_x*8,unit.tile_y*8)
		palt()
	end
end


