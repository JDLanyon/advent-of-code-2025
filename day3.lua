function part_1()
  -- read input
  local file = io.open('inputs/day3.txt', 'r')
  io.input(file)

  -- lol they called it joltage
  local total_joltage = 0

  for line in io.lines() do
    local largest_joltage = 0 -- will be double digit

    -- iterate over every character
    for i=1, #line - 1 do -- -1 since we are considering an extra digit
      local d = tonumber(line:sub(i,i)) -- get current digit
      local max_second = 0 -- find maximum 2nd digit

      -- find maximum 2nd digit
      for j = i + 1, #line do -- iterate to the end of the line
        local d_2 = tonumber(line:sub(j,j)) -- get 2nd digit at j
        -- check if it's larger than max_second
        if d_2 > max_second then
          max_second = d_2
        end
      end

      -- form the two digits and check if it's larger than largest_joltage
      local current_joltage = (d * 10 + max_second) -- joltage considering d and the second largest
      if current_joltage > largest_joltage then
        largest_joltage = current_joltage
      end
    end
    print(largest_joltage)
    total_joltage = total_joltage + largest_joltage
  end
  return total_joltage
end


function part_2(digits)
    -- read input
  local file = io.open('inputs/day3.txt', 'r')
  io.input(file)

  -- lol they called it joltage again
  local total_joltage = 0

  for line in io.lines() do
    local n = #line
    if n < digits then return 0 end -- catch when the line length is less than requested digits
    
    -- Use a table to build the largest number
    local stack = {}
    local to_remove = n - digits  -- How many digits we can remove
    
    for i = 1, n do
        local digit = tonumber(line:sub(i, i))
        
        -- while digits can be removed from stack and current digit is larger
        while #stack > 0 and to_remove > 0 and digit > stack[#stack] do
            table.remove(stack)
            to_remove = to_remove - 1
        end
        
        table.insert(stack, digit)
    end
    
    -- Convert stack to the largest voltage
    local largest_joltage = 0
    for i = 1, digits do
        largest_joltage = largest_joltage * 10 + stack[i]
    end
    
    print("largest voltage for row " .. n .. ": " .. largest_joltage)
    total_joltage = total_joltage + largest_joltage
  end
  return total_joltage
end


-- print(part_1())
print(part_2(12))