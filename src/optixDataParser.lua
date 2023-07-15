dofile("config.lua")

projects = {}
readConfigFile = io.open(configFilePath, "r")

function string.trim(s)
  return s:match('^%s*(.-)%s*$')
end

currentProject = nil
for line in readConfigFile:lines() do
  trimmedLine = string.trim(line)

  if trimmedLine ~= "" then
    key, value = trimmedLine:match("([^:]+):%s*(.*)")
    if key and value then
      key = string.lower(key)
      if key == "name" then
        currentProject = {}
        projects[value] = currentProject
      elseif currentProject then
        currentProject[key] = value
      end
    end
  end
end

print(projects)

readConfigFile:close()