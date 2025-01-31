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
	target=curs,
	x=curs.x,
	y=curs.y,
	update=function(_ENV)
	 x=lerp(x,target.x-64,0.1)
	 y=lerp(y,target.y-64,0.1)
	end,
	draw=function(_ENV)
		camera(x,y)
	end
})

function draw_mode_test()
	curs:draw()
	draw_units()
	
	--draw_zone(1,1,4,4,11)
	curs:draw()
	draw_units()
	
	--draw_zone(1,1,4,4,11)
	
	-- draw ui stuff
	camera()
	color(7)
 	for i=1,#gm.player.units do 
		local unit = gm.player.units[i]
		print("\#0"..unit["body"].name..": "..calc_spd(unit),2,2+8*i,7)
	end
end

function update_mode_active_unit_choose_action()
	if btnp(❎) then
		gm.active_unit+=1
		if (gm.active_unit > #gm.units) gm.active_unit=1
		curs:set_target(gm.units[gm.active_unit])
	end
	curs:update()
	game_cam:update()
end

function draw_mode_active_unit_choose_action()
	-- Move Camera to active unit and display available actions
	cls(0)
	fillp(0x7ebd.1)
	rectfill(0,0,128,128,1)
	fillp()
	game_cam:draw()
	draw_tabletop()
	curs:draw()
	draw_units()

	local unit = gm.units[gm.active_unit]
	
	-- draw ui stuff
	camera()
	print("\#0choose action",2,2,7)
	print("\#0"..unit["brain"].name,2,10,7)
	for i=1,#unit.actions do 
		print("\#0"..sub(unit.actions[i],9),2,128-i*8,7)
	end
end

-- Gameplay Modes
current_draw_mode=draw_mode_active_unit_choose_action
current_update_mode=update_mode_active_unit_choose_action

function init_game()
	generate_tabletop()
	place_units()
	sortBySpeed(gm.units)
	curs:set_target(gm.units[gm.active_unit])
end

function update_game()
	current_update_mode()
end

function draw_game()	
	current_draw_mode()
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
				tile_y=tabletop_size-flr(rnd(8))
				printh("x: "..tile_x.." y: "..tile_y,"@clip")
				if tabletop[tile_x][tile_y]==1 then
					spot_found=true
				end
			end
			unit.tile_x=tile_x
			unit.tile_y=tile_y
		end
end

function draw_tabletop()
	-- draw tiles
	for w=1,tabletop_size do
		for h=1,tabletop_size do
			spr(tabletop[w][h],w*8,h*8)
		end
	end
end

function draw_units()
	--draw units
	for unit in all(gm.units) do 
		palt(14,true)
		spr(unit.body.spr,unit.tile_x*8,unit.tile_y*8)
		palt()
	end
end


