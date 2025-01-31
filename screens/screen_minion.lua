

minion_options={"create","edit","delete"}
selected_minion=1

function init_minion()
	music(2)
end

function update_minion()
	if btnp(⬅️) then selected_minion -=1 sfx(10) end
	if btnp(➡️) then selected_minion +=1 sfx(10) end
	selected_minion=mid(1,selected_minion,#minions)
	if btnp(🅾️) then
		init_menu()
		_update60=update_menu
		_draw=draw_menu
	end
end

function draw_minion()
	cls(6)
	printc("minion browser",64,2,0)
	print("⬅️",2,64,0)
	print("➡️",118,64,0)
	rectfill(12,10,114,118,0)
	
	--draw selected minion
	local mn=minions[selected_minion]
	local sx=mn["body"].spr<<3&120
	local sy=mn["body"].spr>>>1&120
	palt(14,true)
	sspr(sx,sy,8,8,48,20,32,32)
	pal()
	printc(mn["body"].name,64,64,7)

	-- stats
	print("ap: "..mn["brain"].ap,16,76,7)
	print("hp: "..mn["body"].hp,16,84,7)
	print("mp: "..mn["body"].mp,16,92,7)
	print("speed: "..calc_spd(mn),16,100,7)
	print("cost: "..calc_cost(mn),16,108,7)
	
	-- weapon
	print(mn["weapon"].name,60,76,8)
	print(mn["weapon"].type,60,84,9)
	print("range: "..mn["weapon"].range,60,92,7)
	print("damage: "..mn["weapon"].damage,60,100,7)
end

function calc_cost(unit)
	local retval=0
	retval+=unit["brain"].ap*costs.ap
	retval+=unit["brain"].spd*costs.spd
	retval+=unit["body"].hp*costs.hp
	retval+=unit["body"].mp*costs.mp
	retval+=unit["body"].spd*costs.spd
	if unit["weapon"].type=="melee" then
		retval+=costs.melee
	else
		retval+=unit["weapon"].range*costs.range
	end
	retval+=unit["weapon"].damage*costs.damage
	return retval
end