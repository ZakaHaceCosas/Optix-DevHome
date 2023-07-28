http = require "socket.http" -- LuaSocket (Unused (For now)) -- With this we can make HTTP and HTTPS requests.
json = require "rapidjson" -- RapidJSON - It's JSON. It's Rapid. Over.
lfs = require "lfs" -- LuaFileSystem - easier interaction with user's file system
osSeparator = package.config:sub(1, 1) -- We get the system separatory path

-- paths for our files
homeDir = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
configDirectoryPath = homeDir .. osSeparator .. ".OptixDevHome"
configFilePath = configDirectoryPath .. osSeparator .. "projects.json"

-- cool terminals deserve cool colors
terminalTextColorRed = "\27[31m"
terminalTextColorGreen = "\27[32m"
terminalTextColorBold = "\27[1m" -- this is a text format, not a color tho
terminalTextColorYellow = "\27[33m"
terminalTextColorBlue = "\27[36m"
terminalTextColorReset = "\27[0m" -- add this after a colored print statement, or else all the terminal will get colored

-- verify if we have .OptixDevHome directory, create if not
if not lfs.attributes(configDirectoryPath, "mode") then
  lfs.mkdir(configDirectoryPath)
end

-- verify if we have projects.json, create if not
configFile = io.open(configFilePath, "r+")
if not configFile then
  print("Error al acceder a tus proyectos.")
  os.exit(1)
end

-- the most important part of a program: LET THE USER ACTUALLY USE IT
function readInput(prompt)
  io.write(prompt .. ": ")
  io.flush()
  return io.read()
end
