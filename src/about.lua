-- About Optix DevHome.
dofile("config.lua")

if package.config:sub(1, 1) == '\\' then
    os.execute("cls")
  else
    os.execute("clear")
  end
  
dofile("ascii.lua")

print("Development just has to be connected.\nOptix DevHome is an open-source project that aims to create a simple and productive interface for developers to speed up their workflow.\nCheck the source code at GitHub! https://github.com/LeOptix/Optix-DevHome")