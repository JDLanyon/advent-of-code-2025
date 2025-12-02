function get_invalid_ids(ids)
  local invalid_ids = {}
  -- iterate between each range of ids
  for id_range in string.gmatch(ids, "([^,]+)") do -- split commas 
    min, max = string.match(id_range, "([^,]+)-([^,]+)") -- split by hyphen

    -- find invalid ids within range
    print("iterating from " .. min .. " - " .. max)
    for i = tonumber(min), tonumber(max), 1 do
      -- if the id is invalid, add to the ids table
      if is_invalid(i) then
        table.insert(invalid_ids, i)
        print("invalid id: " .. i)
      end
    end
  end
  return invalid_ids
ends

-- returns the repeating section of the id, otherwise returns 0
function is_invalid(id)
    local str = tostring(id) -- id as a string
    if math.floor(#str / 2) then -- check the id can be split

      -- compare both halves of the id
      local middle_point = math.ceil(#str / 2)
      local first_half = str:sub(1, middle_point)
      local second_half = str:sub(middle_point + 1)

      if first_half == second_half then
        return true
      end

    end
    return false
end


-- find all invalid ids from day2.txt

-- read input file
print("getting input from day2.txt")
local file = io.open('inputs/day2.txt', 'r')
io.input(file) -- sets default input file
local ids = io.read()
print("loaded ids:\n" .. ids .. "\n")

-- generate a full table of invalid ids
local invalid_ids = get_invalid_ids(ids)

-- find the sum of all_invalid_ids
-- https://stackoverflow.com/questions/8695378/how-to-sum-a-table-of-numbers-in-lua
local sum = 0
for i = 1, #invalid_ids do
  sum = sum + invalid_ids[i]
end

print("\nTotal sum:\n" .. sum)