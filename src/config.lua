-- we look for /home/[user]/OptixDevHome/projects.OPTdhData
-- .OPTdhData = OPTix devhome data (the custom extension is just to avoid using .txt)
lfs = require "lfs"
osSeparator = package.config:sub(1, 1) -- We get the OS path separator

-- These are the paths for our project files
homeDir = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
directoryPath = homeDir .. osSeparator .. "OptixDevHome"
filePath = directoryPath .. osSeparator .. "projects.OPTdhData"