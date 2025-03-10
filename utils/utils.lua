function lerp(a,b,t)
	return a+t*(b-a)  
end

function printc(str,x,y,col)
	local strlen=print(str,0,-20)
	print(str,x-(strlen/2),y,col)
end

function sortBySpeed(table)
	for i=1,#table do
			local j = i
			while j > 1 and calc_spd(table[j-1]) < calc_spd(table[j]) do
				table[j],table[j-1] = table[j-1],table[j]
					j = j - 1
			end
	end
	local retval={}
	for i=#table,1,-1 do
		add(retval,table[i])
	end
	table = retval
end

function calc_spd(unit)
	return unit["brain"].spd+unit["body"].spd
end

function log(str)
	printh(get_time_stamp()..str,"log.txt",false)
end

function get_time_stamp()
	return ""..stat(80).."/"..stat(81).."/"..stat(82).."\t"..stat(83)..":"..stat(84)..":"..stat(85).." -\t"
end

function line_of_sight(start_pos,end_pos)
	local dx = abs(end_pos.x - start_pos.x)
  local dy = abs(end_pos.y - start_pos.y)
  local sx = start_pos.x < end_pos.x and 1 or -1
  local sy = start_pos.y < end_pos.y and 1 or -1
  local err = dx - dy
  x, y = start_pos.x, start_pos.y

  while true do	
    -- Skip the starting cell if needed. Here, we check every cell.
    if fget(mget(flr(x/8),flr(y/8)),0) then
      return false
    end

    if x == end_pos.x and y == end_pos.y then
      break
    end

    local e2 = 2 * err
    if e2 > -dy then
      err = err - dy
      x = x + sx
    end
    if e2 < dx then
      err = err + dx
      y = y + sy
    end
  end
  return true
end