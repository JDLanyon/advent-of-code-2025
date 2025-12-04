local grid = {}
local heatmap = {}
local heatmap_mask = {}
local rows = 0
local cols = 0
local count = 0 -- count total
local heatmap_mask = {}

-- heatmap table for number of neighbours
local TARGET_CHARACTER = '@'


function check_if_inbounds(i, j)
  return i >= 1 and i <= rows and j >= 1 and j <= cols
end

-- gets number of neighbours within a radius at pos i, j
function get_neighbours(i, j, radius)
    local count = 0
    
    for delta_i = -1, 1 do
        for delta_j = -1, 1 do
            if not (delta_i == 0 and delta_j == 0) then  -- skip current cell
                local new_i, new_j = i + delta_i, j + delta_j
                if check_if_inbounds(new_i, new_j) and grid[new_i]:sub(new_j, new_j) == TARGET_CHARACTER then
                    count = count + 1
                end
            end
        end
    end
    
    return count
end


local function buildHeatmap(radius, includeSelf)
  local heatmap = {}
  
  for i = 1, rows do
    heatmap[i] = {}
    for j = 1, cols do
      heatmap[i][j] = get_neighbours(i, j, radius, includeSelf)
    end
    print(table.concat(heatmap[i], ", ")) -- print row of table
  end
  
  return heatmap
end


function generate_mask(heatmap)
  local heatmap_mask = {}
  for i, row in pairs(heatmap) do
      heatmap_mask[i] = {}
      for j, v in pairs(row) do
          if v < 4 then
              heatmap_mask[i][j] = 1 -- mask heatmap
              count = count + 1 -- add to count
          else
              heatmap_mask[i][j] = 0 -- mask heatmap
          end
      end
      print(table.concat(heatmap_mask[i], ", ")) -- print row of masked table
  end
  return heatmap_mask
end

-- iterates through and replaces 1s from the mask table to a . in grid
local function apply_mask(mask, radius, includeSelf)
  local rows, cols = #grid, #grid[1]
  local new_grid = {}
    
  -- Create a new grid with replacements
  local new_grid = {}
  for i = 1, rows do
    local new_row = {}
    for j = 1, cols do
      local current = grid[i]:sub(j, j)
      
      if current == "@" then
        local neighbours = get_neighbours(i, j, radius, includeSelf)
        if neighbours < 4 then
          table.insert(new_row, ".")
        else
          table.insert(new_row, "@")
        end
      else
        table.insert(new_row, current)
      end
    end
    new_grid[i] = table.concat(new_row)
  end

  return new_grid
end



function part_1()
  local file = io.open('inputs/day4.txt', 'r')
  io.input(file)

  -- build grid of values
  io.input(file)
  for line in io.lines() do
      table.insert(grid, line)
  end

  -- set dimensions
  rows = #grid
  cols = #grid[1]

  -- print grid
  print("grid:")
  print(table.concat(grid, "\n"))

  -- get heatmap of neighbours
  print("generating heatmap..")
  heatmap = buildHeatmap(1, false)

  -- count values in heatmap less than 4
  heatmap_mask = generate_mask(heatmap)

  print("generating masked heatmap..")

  return count
end

function part_2()
  local totalRemoved = 0
  local iteration = 0
  local changed = true -- track if the grid was changed during removal

  while changed do
    iteration = iteration + 1
    changed = false
    local removalCount = 0
    
    -- identify and remove rolls in one go
    local newGrid = {}
    for i = 1, rows do
      local newRow = ""
      for j = 1, cols do
        local current = grid[i]:sub(j, j)
        
        if current == TARGET_CHARACTER then
        local neighbors = get_neighbours(i, j, 1)
        if neighbors < 4 then
          newRow = newRow .. "."
          removalCount = removalCount + 1
          changed = true
        else
          newRow = newRow .. current
        end
      else
        newRow = newRow .. current
      end
    end
    newGrid[i] = newRow
  end
  
  -- Update grid for next iteration
  if changed then
    grid = newGrid
    totalRemoved = totalRemoved + removalCount
    print(string.format("Iteration %d: removed %d cells", iteration, removalCount))
    print("Current grid:")
    for i = 1, rows do
      print(grid[i])
    end
    end
  end

  print(string.format("\nTotal removed: %d", totalRemoved))
  return totalRemoved
end


print("part 1: " .. part_1())
print("part 2: " .. part_2())


-- this one was hard.