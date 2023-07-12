-- we look for /home/[user]/.OptixDevHome/projects.optixData
lfs = require "lfs"
osSeparator = package.config:sub(1, 1) -- We get the OS path separator

-- These are the paths for our project files
homeDir = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
configDirectoryPath = homeDir .. osSeparator .. ".OptixDevHome"
configFilePath = configDirectoryPath .. osSeparator .. "projects.optixData"

terminalTextColorRed = "\27[31m"
terminalTextColorGreen = "\27[32m"
terminalTextColorBold = "\27[1m" -- a format, not a color tho
terminalTextColorYellow = "\27[33m"
terminalTextColorBlue = "\27[36m"
terminalTextColorReset = "\27[0m" -- add this at the end of each colored sentence

-- Check if the config directory exists, create it if not
if not lfs.attributes(configDirectoryPath, "mode") then
  lfs.mkdir(configDirectoryPath)
end

-- Check if the config file exists, create it if not
configFile = io.open(configFilePath, "a")
if not configFile then
  configFile = io.open(configFilePath, "a")
end
-- Now we have the data file. This will store our projects.

-- We read user's prompt onto the terminal
function readInput(prompt)
    io.write(prompt .. ": ")
    io.flush()
    return io.read()
end