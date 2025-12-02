function get_invalid_ids(ids, part)
  local invalid_ids = {}
  -- iterate between each range of ids
  for id_range in string.gmatch(ids, "([^,]+)") do -- split commas 
    min, max = string.match(id_range, "([^,]+)-([^,]+)") -- split by hyphen

    -- find invalid ids within range
    print("iterating from " .. min .. " - " .. max)
    for i = tonumber(min), tonumber(max), 1 do
      -- if the id is invalid, add to the ids table
      if is_invalid(i, part) then
        table.insert(invalid_ids, i)
        print("invalid id: " .. i)
      end
    end
  end
  return invalid_ids
end

-- returns the repeating section of the id, otherwise returns 0
function is_invalid(id, part)
  local str = tostring(id) -- id as a string

  -- check the id can be split
  if not math.floor(#str / 2) then
    return false
  end

  -- part one - check for repeating duplicate
  if part == 1 then
    -- compare both halves of the id
    local middle_point = math.ceil(#str / 2)
    local first_half = str:sub(1, middle_point)
    local second_half = str:sub(middle_point + 1)

    if first_half == second_half then
      return true
    end
    return false

  else -- part 2 - any repeates
    for i = 1, math.floor(#str / 2) do
      if #str % i == 0 then
        local pattern = string.sub(str, 1, i)
        local expected = string.rep(pattern, #str / i)
        if expected == str then
          return true
        end
      end
    end
    return false
  end
end


-- find the sum of all invalid ids
-- https://stackoverflow.com/questions/8695378/how-to-sum-a-table-of-numbers-in-lua
function get_sum(ids)
local sum = 0
  for i = 1, #ids do
    sum = sum + ids[i]
  end
  return sum
end

-- find all invalid ids from day2.txt

-- read input file
print("getting input from day2.txt")
local file = io.open('inputs/day2.txt', 'r')
io.input(file) -- sets default input file
local ids = io.read()
print("loaded ids:\n" .. ids .. "\n")

-- generate a full table of invalid ids for parts 1 and 2
local part_1_ids = get_invalid_ids(ids, 1)
local part_2_ids = get_invalid_ids(ids, 2)



print("\nTotal sum (part1):\n" .. get_sum(part_1_ids))
print("\nTotal sum (part2):\n" .. get_sum(part_2_ids))
