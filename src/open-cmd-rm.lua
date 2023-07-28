        local confirmToRemoveProject = readInput("¿Estás seguro de que quieres eliminar el proyecto " .. terminalTextColorBold .. projectData.projectSavedName .. terminalTextColorReset .. ", ubicado en " .. terminalTextColorBold .. projectData.projectSavedPath .. terminalTextColorReset .. " para siempre?\n" .. terminalTextColorRed .. terminalTextColorBold .. "ESTA ACCIÓN NO SE PUEDE DESHACER, PERDERÁS TODO LO QUE HICISTE" .. terminalTextColorReset .. " (s/n)")
        if confirmToRemoveProject == "s" then
          wantsToDoSmth = true
          local rmDirCommand
          if package.config:sub(1, 1) == '\\' then -- Verify if the user is teamWindows or teamLinux
            rmDirCommand = "rmdir /s /q " .. projectData.projectSavedPath
          else
            rmDirCommand = "rm -r " .. projectData.projectSavedPath
          end

          local rmDirSuccess = os.execute(rmDirCommand)

          if rmDirSuccess then
            print("El directorio fue eliminado exitosamente.")
          else
            print(terminalTextColorRed .. "No se pudo eliminar el directorio. Error RMx001. (Ver https://optix.rf.gd/apps/devhome/errors#rm)" .. terminalTextColorReset)
          end

          local rmProjectData = removeProjectByName(projectData.projectSavedName)

          if rmProjectData then
            print(terminalTextColorGreen .. "Proyecto eliminado de la existencia con éxito ;]" .. terminalTextColorReset)
          else
            print(terminalTextColorRed .. "No se pudo sobrescribir el guardado. Error RMx002. (Ver https://optix.rf.gd/apps/devhome/errors#rm)" .. terminalTextColorReset)
          end
        end