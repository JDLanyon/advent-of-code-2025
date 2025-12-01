local current_number = 50

function get_rotations()
  print("getting rotations from day1.txt")
  local file = io.open('day1.txt', 'r')
  io.input(file) -- sets default input file as day1.txt

  local rotations = {} -- store list of rotations from the input
  
  for line in io.lines() do
    table.insert(rotations, line)
    print("added " .. line)
  end

  print("-----\nrotations loaded from file")
  
  return rotations
end

function decode_password(rotations)
  local password = 0
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


-- print solution
print("-----\nsolution:\n" .. decode_password(get_rotations()))