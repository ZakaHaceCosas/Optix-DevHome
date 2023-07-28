dofile("config.lua")

-- Function to search for the project
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

-- Function to remove the project from existence
local function removeProjectByName(name)
  configFile:seek("set")
  local content = configFile:read("*a")
  local decodedData = json.decode(content)

  if type(decodedData) == "table" then
    local found = false
    for i, project in ipairs(decodedData) do
      if project.projectSavedName == name then
        table.remove(decodedData, i)
        found = true
        break
      end
    end

    if found then
      configFile:seek("set")
      configFile:write(json.encode(decodedData))
      return true  -- Success flag
    else
      return false  -- Failure flag
    end
  else
    return false  -- Failure flag if the JSON content is not valid
  end
end

local function listAllProjects()
  configFile:seek("set")
  local line = configFile:read()
  while line do
    local decodedLine = json.decode(line)
    if decodedLine then
      print("Nombre: " .. decodedLine.projectSavedName)
      print("Ruta: " .. decodedLine.projectSavedPath)
      print("Repo: " .. decodedLine.projectSavedRepo)
      print("------")
    end
    line = configFile:read()
  end
end

-- Function to check if GINIT is working
local function isGINITWorking()
  local isGINITWorkingCommand = "git rev-parse --is-inside-work-tree"
  local isGINITWorkingHandle = io.popen(isGINITWorkingCommand)
  local isGINITWorkingResult = isGINITWorkingHandle:read("*a")
  isGINITWorkingHandle:close()
  return isGINITWorkingResult:match("^true$")
end

-- Main function to handle user input
local function main()
  local projectNameToOpen = readInput("\n¿Qué proyecto buscas?\nDale a Enter sin introducir nada para listar todos tus proyectos\n")
  -- Check if the user entered a project name
  if projectNameToOpen == "" then
    -- If no project name provided, list all projects
    listAllProjects()
    main() -- Ask again for the project name
    return
  end

  local projectData = searchProjectToOpen(projectNameToOpen)

  if projectData then
    print(terminalTextColorGreen .. "\nEncontrado:" .. terminalTextColorReset)
    print("  Nombre: " .. projectData.projectSavedName)
    print("  Ruta: " .. projectData.projectSavedPath)
    print("  Repo: " .. projectData.projectSavedRepo)
    print("------")

    local wantsToDoSmth = false
    while not wantsToDoSmth do
      print("¿Qué deseas hacer ahora?")
      print("  Actualizar: " .. terminalTextColorBold .. "update" .. terminalTextColorReset)
      print("  Enviar cambios: " .. terminalTextColorBold .. "submit" .. terminalTextColorReset)
      print("  Eliminar: " .. terminalTextColorBold .. "rm" .. terminalTextColorReset)
      print("")
      print("  Ayuda sobre cada comando: " .. terminalTextColorBold .. "help" .. terminalTextColorReset)

      local whatToDo = readInput("")
      if whatToDo == "help" then
        -- use open-cmd-[command] to optimise this code
        -- (open-cmd = open project command)
        dofile("open-cmd-help.lua")
      elseif whatToDo == "update" then
        dofile("open-cmd-update.lua")
      elseif whatToDo == "rm" then
        -- you may have realised we dont use /open-cmds or something like that
        -- dofile() doesn't support that as of now
        dofile("open-cmd-rm.lua")
      elseif whatToDo == "submit" then
        dofile("open-cmd-submit.lua")
      else
        print(terminalTextColorRed .. "\nComando desconocido\n" .. terminalTextColorReset)
      end
    end
  else
    print(terminalTextColorRed .. "\nError: Comando no reconocido O el proyecto no existe.\n" .. terminalTextColorReset)
  end
end

-- Execute the main function
main()