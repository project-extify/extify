#!/usr/bin/env lua

-- extify - a browser extension boilerplate generator

local script_path = arg[0]
local base_dir = script_path:match("(.*/)") or "./"
local templates_dir = base_dir .. "templates/"

local function get_templates()
    local templates = {}
    local handle = io.popen("ls -d " .. templates_dir .. "* 2>/dev/null")
    if not handle then return templates end
    for line in handle:lines() do
        local name = line:match(".*/(.+)")
        if name then
            table.insert(templates, name)
        end
    end
    handle:close()
    return templates
end

local function file_exists(path)
    local f = io.open(path, "r")
    if f then f:close() return true else return false end
end

local function read_file(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local content = f:read("*a")
    f:close()
    return content
end

local function write_file(path, content)
    local f = io.open(path, "w")
    if not f then return false end
    f:write(content)
    f:close()
    return true
end

local function replace_placeholders(content, data)
    for k, v in pairs(data) do
        content = content:gsub("{{ " .. k .. " }}", v)
        content = content:gsub("{{" .. k .. "}}", v)
    end
    return content
end

local function init_project()
    local templates = get_templates()
    if #templates == 0 then
        print("Error: No templates found in " .. templates_dir)
        return
    end

    print("--- extify init ---")
    
    io.write("Extension Name: ")
    local name = io.read() or "My Extension"
    
    io.write("Description: ")
    local desc = io.read() or "A browser extension"
    
    io.write("Version (default 1.0.0): ")
    local version = io.read()
    if version == "" then version = "1.0.0" end
    
    io.write("Author: ")
    local author = io.read() or ""

    print("\nAvailable Templates:")
    for i, t in ipairs(templates) do
        print(string.format("[%d] %s", i, t))
    end
    
    io.write("Select template [1]: ")
    local choice = tonumber(io.read()) or 1
    local template_name = templates[choice] or templates[1]

    print("\nScaffolding project using template: " .. template_name .. "...")

    local template_path = templates_dir .. template_name .. "/"
    local handle = io.popen("find " .. template_path .. " -type f 2>/dev/null")
    if not handle then
        print("Error: Could not list template files.")
        return
    end

    local data = {
        NAME = name,
        DESCRIPTION = desc,
        VERSION = version,
        AUTHOR = author
    }

    for file_path in handle:lines() do
        local relative_path = file_path:sub(#template_path + 1)
        print("Creating " .. relative_path .. "...")
        
        -- Create directory if needed
        local dir = relative_path:match("(.+)/[^/]+$")
        if dir then
            os.execute("mkdir -p " .. dir)
        end
        
        local content = read_file(file_path)
        if content then
            content = replace_placeholders(content, data)
            write_file(relative_path, content)
        end
    end
    handle:close()

    print("\nDone! Your extension is ready.")
end

local function show_help()
    print("extify - Browser Extension Boilerplate Generator")
    print("\nUsage:")
    print("  extify init      Initialize a new extension in the current directory")
    print("  extify help      Show this help message")
end

local args = {...}
local command = args[1]

if command == "init" then
    init_project()
elseif command == "help" or not command then
    show_help()
else
    print("Unknown command: " .. command)
    show_help()
end
