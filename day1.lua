local current_number = 50

function get_rotations()
  print("getting rotations from day1.txt")
  local file = io.open('inputs/day1.txt', 'r')
  io.input(file) -- sets default input file as day1.txt

  local rotations = {} -- store list of rotations from the input
  
  for line in io.lines() do
    table.insert(rotations, line)
    print("added " .. line)
  end

  print("-----\nrotations loaded from file")
  
  return rotations
end

function decode_password(rotations, part2)
  local password = 0
  if part2 then
  
    for k, v in pairs(rotations) do -- iterate over key, value pairs
      local delta_number = tonumber(string.sub(v, 2)) -- get number from rotation string
      
      if string.sub(v, 1, 1) == "L" then
        if current_number == 0 then
          password = password - 1 -- subtract one in advanced to avoid double counting later
        end
  
        current_number = current_number - delta_number
        if current_number <= 0 then
          password = password - math.floor((current_number - 1) / 100)
          current_number = current_number % 100
        end
      else -- "R" instead of "L"
        current_number = current_number + delta_number
        password = password + math.floor(current_number / 100)
        current_number = current_number % 100 -- to reset modulo 100, allowing for 0-99.
      end 
    end
    return password
    
  else -- part 1
    for k, v in pairs(rotations) do -- iterate over key, value pairs
      print(v)
      local number = tonumber(string.sub(v, 2)) -- get number from rotation string
      
      if string.sub(v, 1, 1) == "L" then
        number = -number -- change number to negative when rotating left
      end

      current_number = (current_number + number) % 100 -- modulo 100 allows 0-99.

      -- if 0 is hit, increment the password
      if current_number == 0 then
        password = password + 1
      end
      
    end

    return password
  end
end


-- print solution
print("-----\npart 1 solution:\n" .. decode_password(get_rotations(), false))
current_number = 50 -- reset current_number
print("-----\npart 2 solution:\n" .. decode_password(get_rotations(), true))