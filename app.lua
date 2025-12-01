local function format_day_dir(day)
	return string.format("day%d", day)
end

local function run_solution(day)
	local day_dir = format_day_dir(day)
	local filename = day_dir .. ".lua"
	
	-- Check if the file exists before trying to run it
	local file = io.open(filename, "r")
	if file then
		file:close()
		print("--- Running day " .. day .. " ---")
		dofile(filename)
	else
		print("Day " .. day .. " solution file not found: " .. filename)
	end
end

local args = { ... }

if #args == 0 then
	for day = 1, 25 do
		run_solution(day)
	end
elseif #args == 1 then
	local day = tonumber(args[1])
	if day and day >= 1 and day <= 25 then
		run_solution(day)
	else
		print("Invalid day. Please provide a number between 1 and 25.")
		print("Usage:")
		print("  lua app.lua               -- Runs all solutions")
		print("  lua app.lua <day>         -- Runs solution for the specified day (e.g., lua app.lua 1)")
	end
else
	print("Usage:")
	print("  lua app.lua               -- Runs all solutions")
	print("  lua app.lua <day>         -- Runs solution for the specified day (e.g., lua app.lua 1)")
end