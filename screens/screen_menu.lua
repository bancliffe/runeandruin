options={"new game","unit browser","quit"}
selected_menu_item=1

particles={}
max_particles=512

function init_menu()
	particles={}
	for i=1,max_particles do
		add_menu_particle()
	end
	music(0)
end

function update_menu()
	if btnp(⬆️) then selected_menu_item-=1 sfx(10) end
	if btnp(⬇️) then selected_menu_item+=1 sfx(10) end
	if selected_menu_item > #options then
		selected_menu_item=1
	elseif selected_menu_item<1 then
		selected_menu_item=#options
	end	
	if btnp(❎) or btnp(🅾️) then
		if selected_menu_item==1 then
			music(-1)
			init_game()
			_update60=update_game
			_draw=draw_game
		elseif selected_menu_item==2 then
			music(-1)
			init_minion()
			_update60=update_minion
			_draw=draw_minion
		elseif selected_menu_item==3 then
			extcmd("shutdown")
		end
	end
	update_menu_particles()
end

function draw_menu()
	cls(0)
	draw_menu_particles()
	for y=1,#options do
			col=7
			if(y==selected_menu_item)col=8
			printc("\#0"..options[y],64,86+(y*8),col)
	end
	sspr(56,0,32,24,16,16,96,72)
	print("\#0SQUIZM",102,120,7)
end

function update_menu_particles()
	for p in all(particles) do
		p.y-=p.dy
		p.act-=1
		p.x+=sin(p.ang)*0.5
  p.ang+=0.01
		if p.act<0 then
			del(particles,p)
			add_menu_particle()
		end
		if p.act<50 then p.clr=9 end
		if p.act<10 then p.clr=2 end
	end
end

function draw_menu_particles()
	for p in all(particles) do
		circfill(p.x, p.y,p.rad,p.clr)
	end
end

function add_menu_particle()
	add(particles,{
			x=rnd(128),
			y=128,
			dx=rnd(2)+1,
			dy=rnd(2)-1,
			rad=rnd(2),
			act=30+rnd(60),
			clr=10,
			ang=rnd(1)
		})
end