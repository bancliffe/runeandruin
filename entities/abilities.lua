ability=class:new({name="undefined", on_action=0})

ability_move=ability:new({
	name="move",
	on_action=function(destx,desty)
		-- move to that place
	end
})

ability_sprint=ability:new({
	name="sprint",
	on_action=function(destx,desty)
		-- move to that place
	end
})

ability_attack=ability:new({
	name="attack",
	on_action=function(target)
		-- attack the target
	end
})

ability_special=ability:new({
	name="special",
	on_action=function()
		-- do the special thing
	end
})