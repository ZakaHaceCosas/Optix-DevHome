lfs = require "lfs"
osSeparator = package.config:sub(1, 1) -- Obtenemos el separador de ruta del sistema operativo

-- Estas son las rutas para nuestros archivos de proyecto
homeDir = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
configDirectoryPath = homeDir .. osSeparator .. ".OptixDevHome"
configFilePath = configDirectoryPath .. osSeparator .. "projects.optixData"

terminalTextColorRed = "\27[31m"
terminalTextColorGreen = "\27[32m"
terminalTextColorBold = "\27[1m" -- un formato, no un color
terminalTextColorYellow = "\27[33m"
terminalTextColorBlue = "\27[36m"
terminalTextColorReset = "\27[0m" -- agregar esto al final de cada oración coloreada

-- Verificar si el directorio de configuración existe, crearlo si no
if not lfs.attributes(configDirectoryPath, "mode") then
  lfs.mkdir(configDirectoryPath)
end

-- Verificar si el archivo de configuración existe, crearlo si no
configFile = io.open(configFilePath, "a")
if not configFile then
  print("Error al abrir el archivo de configuración.")
  os.exit(1)
end
configFile:close()

-- Leer la entrada del usuario en la terminal
function readInput(prompt)
  io.write(prompt .. ": ")
  io.flush()
  return io.read()
end
