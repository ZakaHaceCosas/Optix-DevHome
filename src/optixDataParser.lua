dofile("config.lua")

-- ERR: this entire file has something wrong that doesn't let it work, but i dont know what is it...
-- the idea is to create a function to analize our .optixData file, and use that function later
-- to open projects, avoid duplicates, get project count, update projects, etc...

function analyzeConfigFile(configFile)
    local projects = {}
    local currentProject

    -- Open the file for reading
    local file = configFile
    if not file then
        print("Failed to open file: " .. configFile)
        return projects
    end

    -- Read the file line by line
    for line in file:lines() do
        -- Check if the line starts with a project name
        local projectName = line:match("^%s*(%w+)%s*{")
        if projectName then
            currentProject = { name = projectName }
            table.insert(projects, currentProject)
        else
            -- Check if the line contains variable assignments
            local key, value = line:match("^%s*([^:]+)%s*:%s*(.+)")
            if key and value and currentProject then
                currentProject[key] = value
            end
        end
    end

    -- Close the file
    file:close()

    return projects
end

local configFile = configFile
local result = analyzeConfigFile(configFile)

-- Iterate over the projects and print their variables
for _, project in ipairs(result) do
    print("Project Name: " .. project.name)
    print("Path: " .. project.path)
    print("Repo: " .. project.repo)
    print()
end