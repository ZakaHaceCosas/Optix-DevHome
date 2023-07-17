dofile("config.lua")

-- this is actually not necesary as we got rid of the old, useless .optixData, but I keep it here to
-- clear the screen and keep it clean
if package.config:sub(1, 1) == '\\' then
    os.execute("cls")
else
    os.execute("clear")
end

-- function to verify if the project exists (or not)
local function isExistingProject(projectName)
  configFile:seek("set")
  local line = configFile:read()
  while line do
      local decodedLine = json.decode(line)
      if decodedLine and decodedLine.projectSavedName == projectName then
          return true
      end
      line = configFile:read()
  end
  return false
end

-- this will keep asking for a name over and over until you say something you havent said before
local isProjectNameValid = false
while not isProjectNameValid do
  projectName = readInput("\nPonle nombre a tu proyecto\n")
  if isExistingProject(projectName) then
      print(terminalTextColorRed .. "\nEl proyecto ya existe. ¡Intenta con otro nombre!" .. terminalTextColorReset)
  else
      print(terminalTextColorGreen .. "\n¡Perfecto! Sigamos" .. terminalTextColorReset)
      isProjectNameValid = true
      break
  end
end

-- default directory to store our projects
-- dhp = DevHomeProject
local defaultDestination = homeDir .. "/dhp-" .. projectName

-- we ask for a URL
local repoURL = readInput("\nIntroduce la URL del repositorio Git\n")

-- where do I create this project? if empty, uses defaultDestination.
local destinationPath = readInput("\n¿Dónde lo guardarás? (Deja en blanco para usar la predeterminada: " .. defaultDestination .. ")\n")

-- as I said 3 lines ago, if empty, uses defaultDestination.
if destinationPath == "" then
    destinationPath = defaultDestination
end

-- we verify if the dir we want to use is real. if it's not, we ask if we want to create it.
local folderExists = os.execute("cd " .. destinationPath)

-- if exists, we just print that the directory, indeed, exists in your file system
-- if not, as i said 4 lines ago, we ask if we want to create it
if folderExists then
    print(terminalTextColorGreen .. "\nVale, la carpeta de destino existe.\n" .. terminalTextColorReset)
else
    print(terminalTextColorYellow .. "\nLa carpeta de destino no existe." .. terminalTextColorReset)

    -- now we actually ask to create it (or not)
    local createFolder = readInput(terminalTextColorBold .. "¿Deseas crear la carpeta " .. destinationPath .. "? (s/n)" .. terminalTextColorReset)

    if createFolder:lower() == "s" then
        local createCommand = "mkdir " .. destinationPath
        local createSuccess = os.execute(createCommand)

        if createSuccess then
            print(terminalTextColorGreen .. "\nCarpeta creada con éxito.\n" .. terminalTextColorReset)
        else
            print(terminalTextColorRed .. "\nError al crear la carpeta. Verifica los permisos de escritura.\n" .. terminalTextColorReset)
            return
            -- WARN: wrong behavior, since now if you dont create the dir the program closes.
        end
    else
        -- "Proportionate another destination path"
        -- I havent got this line ever while testing the program, I swear XD.
        -- From v0.0.1 until now (0.0.7), never.
        print("\nProporciona otra ruta de destino.\n")
        return
    end
end

-- we use git to normally clone the code in our file system
-- NOTE: idea: if user doesnt have git installed, ask him if he wants Optix DevHome to install it for him.
-- (maybe we could even pack git directly with the .exe or .deb program file, who knows?)
local gitCommand = string.format("git clone %s %s", repoURL, destinationPath)
local cloneSuccess = os.execute(gitCommand)

if cloneSuccess then
    -- IT WORKED YOUR PROJECT WAS CREATEDq!!11111
    print(terminalTextColorGreen .. terminalTextColorBold .. "\n¡Proyecto creado en " .. destinationPath .. " con éxito!\n" .. terminalTextColorReset)
else
    -- nope, it did NOT work
    print(terminalTextColorRed .. "\nError al clonar el repositorio. Verifica la URL y la ruta de destino.\n" .. terminalTextColorReset)
end

-- we define the JSON structure
local projectSavedData = {
    projectSavedName = projectName,
    projectSavedPath = destinationPath,
    projectSavedRepo = repoURL
}

-- we write the JSON using the JSON structure we defined a few lines ago
configFile:seek("end")
configFile:write(json.encode(projectSavedData) .. "\n")
configFile:flush()
configFile:close()

-- and that's it