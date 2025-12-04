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


print(part_1())
-- part_2()