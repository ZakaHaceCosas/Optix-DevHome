lgi = require "lgi"
Gio = lgi.Gio
Gtk = require("lgi").Gtk
Gdk = require("lgi").Gdk
Pango = lgi.Pango
dofile("config.lua")

Gtk.init()

local window = Gtk.Window {
  title = "Optix DevHome",
  default_width = 650,
  default_height = 450,
  on_destroy = Gtk.main_quit
}

local icon = Gtk.Image.new_from_file("img/icon.png")
window:set_icon(icon:get_pixbuf())

local headerBar = Gtk.HeaderBar {
  title = "Optix DevHome",
  subtitle = "Versión 0.0.4 - Ahora con GUI"
}

local closeButton = Gtk.Button {
  image = Gtk.Image { icon_name = "window-close" },
  on_clicked = function()
    Gtk.main_quit()
  end
}

headerBar:pack_end(closeButton)

window:set_titlebar(headerBar)

local label = Gtk.Label {
  label = '¡Bienvenido a Optix DevHome!',
  halign = 'CENTER',
  valign = 'CENTER'
}

label:set_justify('CENTER')
label:set_markup('<big><b>¡Bienvenido a Optix DevHome!</b></big>')

local creareProjectBtn = Gtk.Button {
  label = 'Crear proyecto'
}

local openProjectBtn = Gtk.Button {
  label = 'Abrir proyecto'
}

local box = Gtk.VBox {
  label,
  creareProjectBtn,
  openProjectBtn
}

function creareProjectBtn:on_clicked()
  local createProjectQuestion1 = Gtk.Dialog {
    title = "Ponle nombre a tu proyecto",
    resizable = false,
    transient_for = window,
    modal = true,
    buttons = {
      { Gtk.STOCK_OK, Gtk.ResponseType.OK },
      { Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL },
    }
  }

  local createProjectQuestion1Entry = Gtk.Entry {}

  createProjectQuestion1Entry:set_size_request(700, 40)
  
  createProjectQuestion1:get_content_area():add(createProjectQuestion1Entry)

  createProjectQuestion1:show_all()

  local createProjectQuestion1Response = createProjectQuestion1:run()

  if createProjectQuestion1Response == Gtk.ResponseType.OK then
    local projectName = createProjectQuestion1Entry:get_text()
    local createProjectQuestion2 = Gtk.Dialog {
      title = "Introduce la URL del repositorio Git",
      resizable = false,
      transient_for = window,
      modal = true,
      buttons = {
        { Gtk.STOCK_OK, Gtk.ResponseType.OK },
        { Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL },
      }
    }

    local createProjectQuestion2Entry = Gtk.Entry {}

    createProjectQuestion2Entry:set_size_request(700, 40)
  
    createProjectQuestion2:get_content_area():add(createProjectQuestion2Entry)

    createProjectQuestion2:show_all()

    local createProjectQuestion2Response = createProjectQuestion2:run()

    if createProjectQuestion2Response == Gtk.ResponseType.OK then
      local repoURL = createProjectQuestion2Entry:get_text()
      local createProjectQuestion3 = Gtk.Dialog {
        title = "¿Donde lo guardarás?",
        resizable = false,
        transient_for = window,
        modal = true,
        buttons = {
          { Gtk.STOCK_OK, Gtk.ResponseType.OK },
          { Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL },
        }
      }
  
      local defaultDirectory = homeDir .. "/dhp-" .. projectName

      local createProjectQuestion3Entry = Gtk.Entry {
        text = defaultDirectory
      }
  
      createProjectQuestion3Entry:set_size_request(700, 40)
    
      createProjectQuestion3:get_content_area():add(createProjectQuestion3Entry)
  
      createProjectQuestion3:show_all()
  
      -- ERR: things break here
      local createProjectQuestion3Response = createProjectQuestion3:run()
  
      if createProjectQuestion3Response == Gtk.ResponseType.OK then
        local directoryPath = createProjectQuestion3Entry:get_text()
        local folderExists = os.execute("cd " .. directoryPath)

      if folderExists then
        local creatingProjectDialog = Gtk.MessageDialog {
          parent = window,
          message_type = Gtk.MessageType.INFO,
          buttons = Gtk.ButtonsType.OK,
          text = "Creando tu proyecto",
       }
       creatingProjectDialog:run()
      else
        local confirmCreateDirDialog = Gtk.MessageDialog {
          parent = window,
          message_type = Gtk.MessageType.INFO,
          buttons = {
            { Gtk.STOCK_OK, Gtk.ResponseType.OK },
            { Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL },
          }
          text = "Confirma si quieres crear el directorio",
          secondary_text = directoryPath
       }
       confirmCreateDirDialog:run()

       if confirmCreateDirDialog:get_response() == Gtk.ResponseType.OK then
        local createCommand = "mkdir " .. destinationPath
        local createSuccess os.execute(createCommand)

        if createSuccess then
          creatingProjectDialog:run()
        else
          local errDialog = Gtk.MessageDialog {
            parent = window,
            message_type = Gtk.MessageType.ERROR,
            buttons = Gtk.STOCK_OK, Gtk.ResponseType.OK,
            text = "Error al crear la carpeta. Verifica los permisos de escritura."
          }
          errDialog:run()
          return
  end
end

  createProjectQuestion1:destroy()
  createProjectQuestion2:destroy()
end
end

function openProjectBtn:on_clicked()
  label:set_markup('<big><b>Pronto...</b></big>')
end

window:add(box)
window:show_all()

Gtk.main()
