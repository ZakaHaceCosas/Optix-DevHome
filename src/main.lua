if package.config:sub(1, 1) == '\\' then
    os.execute("cls")
else
  os.execute("clear")
end

dofile("config.lua")

-- some ASCII art, some text over, a nice way to welcome the user
isStartPromptValid = false

dofile("ascii.lua")

print(terminalTextColorGreen .. terminalTextColorBold .. "Optix DevHome ALPHA 0.0.8 - 'Development just has to be connected.' - Idioma: ES\n------\n" .. terminalTextColorReset)
print("Potenciado por",_VERSION, "\n" .. terminalTextColorBlue .. "Copyright © 1994–2023 Lua.org, PUC-Rio.\n" .. terminalTextColorReset)
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
print("\nCerrando Optix DevHome.\n")