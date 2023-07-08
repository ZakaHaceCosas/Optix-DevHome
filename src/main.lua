-- We read user's prompt onto the terminal
local function readInput(prompt)
    io.write(prompt .. ": ")
    io.flush()
    return io.read()
end

-- Where is the user folder? This line answers that
local homeDir = os.getenv("HOME") or os.getenv("USERPROFILE")

-- Default location of the folder we'll use for our repo
local defaultDestination = homeDir .. "/dhr-[nombre de tu proyecto]"

-- Here we ask for the proyect name
local projectName = readInput("Introduce el nombre del proyecto")

-- We ask for the URL of the repo, so we can clone the repo.
local repoURL = readInput("Introduce la URL del repositorio Git")

-- We ask for where to save the project. If empty, will use defaultDestination.
-- WAR: when you leave empty it doesn't act as expected. will fix it.
local destinationPath = readInput("Introduce la ruta de destino (por defecto: " .. defaultDestination .. ")")

-- well this is the line that should make use of the defaultDestination if you don't provide anything...
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

-- uses the native git command for cloning the repo.
-- NOTE: we should make it verify if you have git or not, and if you dont, idk if ask to install it
-- or make it come preinstalled on /lib
local gitCommand = string.format("git clone %s %s", repoURL, destinationPath)
local cloneSuccess = os.execute(gitCommand)

if cloneSuccess then
    print("¡Clonación exitosa!")
else
    print("Error al clonar el repositorio. Verifica la URL y la ruta de destino.")
end