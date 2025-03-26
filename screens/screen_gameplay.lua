tabletop={}
tabletop_size=24
tiles_empty={1,1,1,1,1,1,1,1,3,4}
selected_action=1

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
		--rect(x,y,x+7,y+7,7)
		palt(14,true)
		spr(58,x,y)
		pal(14,false)
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
	 x=mid(0,x,72)
	 y=mid(0,y,72)
	end,
	draw=function(_ENV)
		camera(x,y)
	end
})

function init_game()
	generate_tabletop()
	create_units()
	place_units()
end

function update_game()
	_update60=update_action_view
end

function draw_game()	
	_draw=draw_action_view
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
			tabletop[row][column]=mget(row,column)
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
				if tabletop[tile_x][tile_y]==1 or 
					tabletop[tile_x][tile_y]==3 or 
					tabletop[tile_x][tile_y]==4 then
					spot_found=true
				end
			end
			unit.tile_x=tile_x
			unit.tile_y=tile_y
			log("Placing unit \""..unit.name.." at {"..unit.tile_x..","..unit.tile_y.."}")
		end
		game_cam.target=gm.units[gm.active_unit]
end

function create_units()
	for i=0,10 do 
		unit = model:new()
		unit.name=generate_name()
		unit.firepower=rnd({"d6","d8","d10"})
		unit.prowess=rnd({"d6","d8","d10"})
		unit.defense=rnd({"d6","d8","d10"})
		unit.willpower=rnd({"d6","d8","d10"})
		unit.speed=rnd({1,2,3})
		unit.actions={}
		add(unit.actions,action_move)
		add(unit.actions,action_shoot)
		add(unit.actions,action_fight)
		add(unit.actions,action_pass)
		add(gm.units,unit)
	end
end

function draw_units()
	--draw units
	for unit in all(gm.units) do 
		palt(14,true)
		palt(0, false)
		spr(unit.sprite,unit.tile_x*8,unit.tile_y*8)
		palt()
	end
end

function draw_unit_stats()
	local unit = gm.units[gm.active_unit]
	strlen=print(unit.name,0,-10,7)
	print("\#0"..unit.name,126-strlen,2,7)

	for i=1,unit.speed do 
		circfill(6*i, 90, 3, 0)
		circfill(6*i, 90, 2, 7)
	end

	print("\#0f: "..unit.firepower,2,96,7)
	print("\#0p: "..unit.prowess,2,104,7)
	print("\#0d: "..unit.defense,2,112,7)
	print("\#0w: "..unit.willpower,2,120,7)
end

function draw_los()
	mx,my=stat(32),stat(33)
	start_pos={}
	start_pos.x=gm.units[gm.active_unit].tile_x*8 +4
	start_pos.y=gm.units[gm.active_unit].tile_y*8 +4
	end_pos={}
	end_pos.x=mx
	end_pos.y=my

	if line_of_sight(start_pos,end_pos) then
		line(start_pos.x,start_pos.y,mx,my,11)
		circ(mx,my,4,11)
	else
		line(start_pos.x,start_pos.y,mx,my,8)
		circ(mx,my,4,8)
	end	
end
