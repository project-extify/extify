#!/usr/bin/env lua

local args = {...}

local command = args[1]


local function createNewFile()
  io.write("Enter your extension name: ")
  local name = io.read()
  io.write("Enter your extension description: ")
  local desc = io.read()
  io.write("Enter your project version: ")
  local version = io.read()
  
  local json = string.format([[
{
  "name" : "%s",
  "description" : "%s",
  "version" : "%s"
}
    ]], name, desc, version)

  return json
end


if command == "create" then
  local file = io.open("package.json","w")
    if file ~= nil then
      local data = createNewFile()
      file:write(data)
      file:close()
    else
      print("Could not open the file")
    end
else
  print("Command not found, run extify help for more info")
end

for i = 1, 100, 2 do
  io.write("\rDownloading... " .. i .. "%")
  io.flush()

  -- fake delay
  os.execute("sleep 0.05")
end

print("\nDone.")
