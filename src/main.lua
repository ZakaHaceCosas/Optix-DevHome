dofile("config.lua") -- tidy up by moving variables here

-- Check if the directory exists, create it if not
if not lfs.attributes(directoryPath, "mode") then
  lfs.mkdir(directoryPath)
end

-- Check if the file exists, create it if not
local file = io.open(filePath, "a")
if not file then
  file = io.open(filePath, "a")
end
-- Now we have the data file. This will store our projects.

-- We read user's prompt onto the terminal
local function readInput(prompt)
    io.write(prompt .. ": ")
    io.flush()
    return io.read()
end

-- Default location of the folder we'll use for our repo
local defaultDestination = homeDir .. "/dhr-[nombreProyecto]"

-- Here we ask for the proyect name
local projectName = readInput("Introduce el nombre del proyecto")

-- We ask for the URL of the repo, so we can clone the repo.
local repoURL = readInput("Introduce la URL del repositorio Git")

-- We ask for where to save the project. If empty, will use defaultDestination.
-- WAR: when you leave empty it doesn't act as expected. will fix it.
local destinationPath = readInput("Introduce la ruta de destino (por defecto: " .. defaultDestination .. ")")

-- if we give an empty path, use default
if destinationPath == "" then
    destinationPath = defaultDestination .. "/dhr-" .. projectName
end

-- Verify if directory you gave exists. if it does, ok. if not, asks wether to create it or not.
-- NOTE: if you dont create it, it will close with a message. will change it so it goes back to the
-- naming step.
local folderExists = os.execute("cd " .. destinationPath)

if folderExists then
    print("La carpeta de destino existe.")
else
    print("La carpeta de destino no existe.")

    -- Create this non-existant directory?
    local createFolder = readInput("¿Deseas crear la carpeta de destino? (s/n)")

    if createFolder:lower() == "s" then
        local createCommand = "mkdir " .. destinationPath
        local createSuccess = os.execute(createCommand)

        if createSuccess then
            print("Carpeta creada con éxito.")
        else
            print("Error al crear la carpeta. Verifica los permisos de escritura.")
            return
        end
    else
        print("Proporciona otra ruta de destino.")
        return
    end
end

-- we save the project to our .OPTdhData file
file:write(projectName .. " {\n")
file:write("    path: " .. destinationPath .. "\n")
file:write("    repo: " .. repoURL .. "\n")
file:write("}\n")

file:flush()
file:close()
-- ERR: this is unstable. sometimes works, sometimes not, sometimes writes once and not twice...
-- needs reviewing.

-- uses the native git command for cloning the repo.
-- NOTE: we should make it verify if you have git or not, and if you dont, ask to install it
local gitCommand = string.format("git clone %s %s", repoURL, destinationPath)
local cloneSuccess = os.execute(gitCommand)

if cloneSuccess then
    print("¡Clonación exitosa!")
else
    print("Error al clonar el repositorio. Verifica la URL y la ruta de destino.")
end