dofile("config.lua") -- tidy up by moving variables here

print("Optix DevHome ALPHA 0.0.3 - 'Development just has to be connected.' - Idioma: ES\n --- \n")

-- we nicely say welcome, then ask if create project or open project
local isStartPromptValid = false

while not isStartPromptValid do
    local atStartPrompt = readInput("Bienvenido a Optix DevHome. ¿Qué quieres hacer?\nnew - Crear nuevo proyecto.\nopn - Abrir proyecto existente\n")
    if atStartPrompt == "new" then
        isStartPromptValid = true
        dofile("create-project.lua")
    elseif atStartPrompt == "opn" then
        dofile("open-project.lua")
        isStartPromptValid = true
    else
        print("Comando no válido, prueba otra vez.\n")
    end
end
