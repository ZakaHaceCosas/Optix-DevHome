dofile("config.lua")
dofile("optixDataParser.lua")

function openProject()
    local projectName = readInput("\nIngresa el nombre del proyecto que deseas abrir:\n")
  
    local project = projects[projectName]
  
    if project then
      print("\nAbriendo proyecto: " .. projectName)
      print("Ruta del proyecto: " .. project.path)
      print("URL del repositorio: " .. project.repo)
  
    else
      print("\nEl proyecto '" .. projectName .. "' no existe.")
      print("Por favor, verifica el nombre del proyecto e intenta nuevamente.")
    end
  end
  
  openProject()  