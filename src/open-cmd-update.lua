        wantsToDoSmth = true
        local wantsToUpdate = readInput(terminalTextColorBlue .. "\n¿Deseas actualizar? (y/n)\n" .. terminalTextColorReset .. terminalTextColorRed .. "¡Esto sobrescribirá todos los cambios que hayas hecho!" .. terminalTextColorReset)
        if wantsToUpdate == "y" then
          local clearCommand = string.format("rm -rf %s", projectData.projectSavedPath)
          local clearSuccess = os.execute(clearCommand)
          if clearSuccess then
            print(terminalTextColorGreen .. "\nDespejado con éxito, actualizando...\n" .. terminalTextColorReset)
            local gitCommand = string.format("git clone %s %s", projectData.projectSavedRepo, projectData.projectSavedPath)
            local updateSuccess = os.execute(gitCommand)
            if updateSuccess then
              print(terminalTextColorGreen .. "\nActualizado con éxito.\n" .. terminalTextColorReset)
            else
              print(terminalTextColorRed .. "\nError al actualizar el repositorio: Error de Git\n" .. terminalTextColorReset)
            end
          else
            print(terminalTextColorRed .. "\nError al actualizar el repositorio: No se pudo despejar el directorio del proyecto\n" .. terminalTextColorReset)
          end
        end