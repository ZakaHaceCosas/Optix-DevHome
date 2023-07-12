dofile("config.lua") -- tidy up by moving variables here
local isTestingGUIBeta = true

if isTestingGUIBeta == true then
local userWantsGUIBeta = readInput(terminalTextColorYellow .. "Hey, developers! Want to try the new GTK based GUI? (y/n)" .. terminalTextColorReset .. terminalTextColorRed .. "\n(IT IS VERY UNSTABLE, MAY NOT WORK AS EXPECTED)" .. terminalTextColorReset)
local userWantsGUIBeta = readInput(terminalTextColorYellow .. "Hey, developers! Want to try the new LGI / GTK based GUI? (y/n)" .. terminalTextColorReset .. terminalTextColorRed .. "\n(Hit 'n', as the 'windows.lua' file is not included yet)" .. terminalTextColorReset)
    if userWantsGUIBeta == "y" then
        dofile("windows.lua")
    elseif userWantsGUIBeta == "n" then
        print("\nOptix DevHome will now run from your terminal\n")
    else
        print("\nOptix DevHome will now run from your terminal\n")
    end
end

print(terminalTextColorGreen .. terminalTextColorBold .. "Optix DevHome ALPHA 0.0.5 - 'Development just has to be connected.' - Idioma: ES\n------\n" .. terminalTextColorReset)

-- we nicely say welcome, then ask if create project or open project
isStartPromptValid = false

dofile("ascii.lua")

print(terminalTextColorGreen .. terminalTextColorBold .. "Optix DevHome ALPHA 0.0.5 - 'Development just has to be connected.' - Idioma: ES\n------\n" .. terminalTextColorReset)

while not isStartPromptValid do
    local atStartPrompt = readInput("Bienvenido a Optix DevHome. ¿Qué quieres hacer?\nnew - Crear nuevo proyecto.\nopn - Abrir proyecto existente\nabout - Información sobre Optix DevHome\nend - Salir del programa")
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

print("\nSaliendo de Optix DevHome, ¡nos vemos!\n")