dofile("config.lua") -- tidy up by moving variables here

-- Here we ask for the proyect name
local projectName = readInput("\nPonle nombre a tu proyecto\n")

-- Default location of the folder we'll use for our repo
local defaultDestination = homeDir .. "/dhp-" .. projectName

-- We ask for the URL of the repo, so we can clone the repo.
local repoURL = readInput("\nIntroduce la URL del repositorio Git\n")

-- We ask for where to save the project. If empty, will use defaultDestination.
local destinationPath = readInput("\n¿Donde lo guardarás? (Deja en blanco para usar predeterminada: " .. defaultDestination .. ")\n")

-- if we give an empty path, use default
if destinationPath == "" then
    destinationPath = defaultDestination
end

-- Verify if directory you gave exists. if it does, ok. if not, asks wether to create it or not.
-- NOTE: if you dont create it, it will closes. will change it so it goes back to the naming step.
local folderExists = os.execute("cd " .. destinationPath)

if folderExists then
    print("\nVale, la carpeta de destino existe.\n")
else
    print("\nLa carpeta de destino no existe.")

    -- asks to create directory
    local createFolder = readInput("¿Deseas crear la carpeta " .. destinationPath .."? (s/n)")

    if createFolder:lower() == "s" then
        local createCommand = "mkdir " .. destinationPath
        local createSuccess = os.execute(createCommand)

        if createSuccess then
            print("\nCarpeta creada con éxito.\n")
        else
            print("\nError al crear la carpeta. Verifica los permisos de escritura.\n")
            return
        end
    else
        print("\nProporciona otra ruta de destino.\n")
        return
    end
end

-- we save the project to our .optixData configFile
-- WARN - skipped behavior: this check doesnt work, projects still allow duplicates
local function projectExists(projectName, configFile)
    configFile:seek("set") --
    local line = configFile:read("*line")
    while line do
      if line == projectName then
        return true -- exists
      end
      line = configFile:read("*line")
    end
    return false -- does not exist (so we can create it)
  end
  
  -- is it already on the file?
  if projectExists(projectName, configFile) then
    print(terminalTextColorRed .. "¡Error! El proyecto ya existe." .. terminalTextColorReset)
    return -- end
  end
  
  -- if we create it, we write it to configFile
  configFile:seek("end")
  configFile:write(projectName .. "\n")
  configFile:write("    path: " .. destinationPath .. "\n")
  configFile:write("    repo: " .. repoURL .. "\n")
  configFile:write("\n")
  
  configFile:flush()
  configFile:close()
  
-- uses the native git command for cloning the repo.
-- NOTE: we should make it verify if you have git or not, and if you dont, ask to install it
local gitCommand = string.format("git clone %s %s", repoURL, destinationPath)
local cloneSuccess = os.execute(gitCommand)

if cloneSuccess then
    print("\n¡Proyecto creado en " .. destinationPath .. " con éxito!\n")
else
    print("\nError al clonar el repositorio. Verifica la URL y la ruta de destino.\n")
end