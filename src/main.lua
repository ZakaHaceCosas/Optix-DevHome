dofile("config.lua")

-- a short modal to try out the GUI version
local isTestingGUIBeta = true

if isTestingGUIBeta == true then
local userWantsGUIBeta = readInput(terminalTextColorYellow .. "¡Hola, Dev! ¿Quieres probar la nueva versión GUI basada en GTK? (y/n)" .. terminalTextColorReset .. terminalTextColorRed .. "\n(ES INESTABLE, PUEDE TENER ERRORES)" .. terminalTextColorReset)
    if userWantsGUIBeta == "y" then
        dofile("windows.lua")
    elseif userWantsGUIBeta == "n" then
        print("\nOptix DevHome correrá en la terminal (modo CLI)\n")
    else
        print("\nOptix DevHome correrá en la terminal (modo CLI)\n")
    end
end

-- some ASCII art, some text over, a nice way to welcome the user
print(terminalTextColorGreen .. terminalTextColorBold .. "Optix DevHome ALPHA 0.0.7 - 'Development just has to be connected.' - Idioma: ES\n------\n" .. terminalTextColorReset)

isStartPromptValid = false

dofile("ascii.lua")

-- a loop. we wait until he opens a project, creates a project, ends the program, or reads the about
while not isStartPromptValid do
    local atStartPrompt = readInput(terminalTextColorBold .. terminalTextColorGreen .. "Bienvenido a Optix DevHome. ¿Qué quieres hacer?" .. terminalTextColorReset .. "\nnew - Crear nuevo proyecto.\nopn - Abrir proyecto existente\nabout - Información sobre Optix DevHome\nend - Salir del programa")
    if atStartPrompt == "new" then
        isStartPromptValid = true
        dofile("create-project.lua")
    elseif atStartPrompt == "opn" then
        dofile("open-project.lua")
        isStartPromptValid = true
    elseif atStartPrompt == "about" then
        dofile("about.lua")
    elseif atStartPrompt == "end" then
        break
    else
        print(terminalTextColorRed .. "Comando no válido, prueba otra vez.\n" .. terminalTextColorReset)
    end
end

-- this will print whenever the program stops (when you're running from main.lua)
print("\nSaliendo de Optix DevHome.\n")