dofile("config.lua")

-- We ask what to open
local projectNameToOpen = readInput("\n¿Qué proyecto buscas?\n")

-- We look on our configFile
local function searchProjectToOpen(name)
  configFile:seek("set")
  local line = configFile:read()
  while line do
    local decodedLine = json.decode(line)
    if decodedLine and decodedLine.projectSavedName == name then
      return decodedLine
    end
    line = configFile:read()
  end
  return nil
end

-- we execute the function
local projectData = searchProjectToOpen(projectNameToOpen)

if projectData then
  -- print the data (to prove we actually found it)
  print(terminalTextColorGreen .. "\nEncontrado:" .. terminalTextColorReset)
  print("  Nombre: " .. projectData.projectSavedName)
  print("  Ruta: " .. projectData.projectSavedPath)
  print("  Repo: " .. projectData.projectSavedRepo)
  print("------")
  -- some elements are commented, as they aren't implemented yet
  print("¿Qué deseas hacer ahora?")
  print("  Actualizar: " .. terminalTextColorBold .. "update" .. terminalTextColorReset)
  -- print("  Enviar cambios: " .. terminalTextColorBold .. "pull" .. terminalTextColorReset)
  -- print("  Comparar cambios y actualizar: " .. terminalTextColorBold .. "sync" .. terminalTextColorReset)
  print("  Ayuda sobre cada comando: " .. terminalTextColorBold .. "help" .. terminalTextColorReset)
  -- print(terminalTextColorYellow .. "  Iniciar: " .. terminalTextColorBold .. "Iniciar el proyecto" .. terminalTextColorReset)
  local whatToDo = readInput("")
  if whatToDo == "help" then
    print("\n" .. terminalTextColorBold .. "update" .. terminalTextColorReset .. " - Actualiza directamente el código fuente, sobrescribiendo el contenido anterior.")
  elseif whatToDo == "update" then
    local wantsToUpdate = readInput(terminalTextColorBlue .. "\n¿Deseas actualizar? (y/n)\n" .. terminalTextColorReset .. terminalTextColorRed .. "¡Esto sobrescribirá todos los cambios que hayas hecho!" .. terminalTextColorReset)
    if wantsToUpdate == "y" then
      local repoURL = projectData.projectSavedRepo
      local destinationPath = projectData.projectSavedPath
      
      local clearCommand = string.format("rm -rf %s", destinationPath)
      local clearSuccess = os.execute(clearCommand)
      if clearSuccess then
        print(terminalTextColorGreen .. "\nDespejado con éxito, actualizando...\n" .. terminalTextColorReset)
        local gitCommand = string.format("git clone %s %s", repoURL, destinationPath)
        local updateSuccess = os.execute(gitCommand)
        if updateSuccess then
          print(terminalTextColorGreen .. "\nActualizado con éxito.\n" .. terminalTextColorReset)
        else
          print(terminalTextColorRed .. "\nError al actualizar el repositorio: Error de Git\n" .. terminalTextColorReset)
        end
      else
        print(terminalTextColorRed .. "\nError al actualizar el repositorio: No se pudo despejar el directorio del proyecto\n" .. terminalTextColorReset)
      end
    end
  else
  -- 404 - Not found (bruh this is not HTTP)
  print(terminalTextColorRed .. "\nNo se encontró el proyecto.\n" .. terminalTextColorReset)
  end
end