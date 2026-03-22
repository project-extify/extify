local args = {...}

local command = args[1]


local function createNewFile()
  io.write("Enter your extension name: ")
  local name = io.read()
  io.write("Enter your extension description: ")
  local desc = io.read()
  io.write("Enter your project version: ")
  local version = io.read()

  return {
    name = name,
    description = desc,
    version = version,
  }
end

if command == "create" then
  local file = io.open("hello.txt","a")
    if file ~= nil then
      local data = createNewFile()
      file:write("Name: " .. data.name)
      file:write("\nDescription: " .. data.description)
      file:write("\nVersion: " .. data.version)
      file:close()
    else
      print("Could not open the file")
    end
else
  print("Command not found, run extify help for more info")
end
