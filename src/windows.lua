dofile("config.lua")

lgi = require "lgi"
Gio = lgi.Gio
Gtk = require("lgi").Gtk
Gdk = require("lgi").Gdk
Pango = lgi.Pango

Gtk.init()

local window = Gtk.Window {
  title = "Optix DevHome",
  default_height = 300,
  resizable = false,
  on_destroy = Gtk.main_quit
}

-- yes. in lua you write CSS to style things (most time). if you want to use classes:
-- myEpicItem:get_style_context():add_class('myEpicClass')

-- add a class to a variable item after it is defined, and before it is destroyed

-- some properties dont work here (like width or height), you'll need to use Gtk for them
local cssProvider = Gtk.CssProvider.new()
cssProvider:load_from_data([[
  window {
    background-color: #070707;
    font-family: "Outfit";
  }

  headerbar {
    background-color: #000;
  }

  .topbar {
    padding: 10px 20px;
    background-color: #000;
    color: #FFF;
    border-radius: 0px 0px 10px 10px;
  }

  label {
    color: #FFF;
  }

  dialog {
    background-color: #000;
    font-family: Outfit;
  }

  .bt-prim {
    background-color: #106090;
    border-radius: 5px;
  }

  .bt-prim:hover {
    background-color: #2070AA;
  }

  .bt-prim:active {
    background-color: #106090;
    opacity: 0.6;
  }
  
  .bt-sec {
    border-radius: 5px;
    background-color: #303030;
  }

  .bt-sec:hover {
    background-color: #2D2D2D;
  }

  .bt-sec:active {
    background-color: #303030;
    opacity: 0.6;
  }

  .entry {
    background-color: #303030;
  }

  .entry:active {
    background-color: #2D2D2D;
  }

  .entry:hover {
    background-color: #2D2D2D;
  }
]])

local screen = Gdk.Screen.get_default()
local context = Gtk.StyleContext()
context.add_provider_for_screen(screen, cssProvider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)

local icon = Gtk.Image.new_from_file("assets/icon.png")
window:set_icon(icon:get_pixbuf())

local favicon = Gtk.Image.new_from_file("assets/favicon.png")


local headerBar = Gtk.HeaderBar {
  title = "Optix DevHome",
  subtitle = "Versión 0.0.6 - LuaFTW"
}

local closeButton = Gtk.Button {
  image = Gtk.Image { icon_name = "window-close" },
  on_clicked = function()
    Gtk.main_quit()
  end
}

headerBar:pack_start(favicon)

headerBar:pack_end(closeButton)

window:set_titlebar(headerBar)

local topbar = Gtk.Label {
  label = 'Optix DevHome',
  halign = Gtk.Align.START,
  valign = Gtk.Align.START,
  sensitive = true,
  visible = true
}

topbar:get_style_context():add_class('topbar')
topbar:set_alignment(0, 0.5)
topbar:set_size_request(700, 10)

local label = Gtk.Label {
  label = '¡Bienvenido a Optix DevHome!',
  halign = Gtk.Align.CENTER,
  valign = Gtk.Align.CENTER,
  sensitive = true,
  visible = true
}

label:set_justify('CENTER')
label:set_markup('<big><b>¡Bienvenido a Optix DevHome!</b></big>')
label:set_size_request(500, 20)

local createProjectBtn = Gtk.Button {
  label = 'Crear proyecto',
  tooltip_text = '¡Hagamos algo nuevo!',
  halign = Gtk.Align.CENTER,
  valign = Gtk.Align.CENTER,
  relief = Gtk.ReliefStyle.NONE,
  sensitive = true,
  visible = true
}

local openProjectBtn = Gtk.Button {
  label = 'Abrir proyecto',
  tooltip_text = 'Pronto...',
  halign = Gtk.Align.CENTER,
  valign = Gtk.Align.CENTER,
  relief = Gtk.ReliefStyle.NONE,
  sensitive = true,
  visible = true
}

createProjectBtn:get_style_context():add_class('bt-prim')
createProjectBtn:set_size_request(200, 20)

openProjectBtn:get_style_context():add_class('bt-prim')
openProjectBtn:set_size_request(200, 20)

local box = Gtk.VBox {
  halign = Gtk.Align.FILL,
  topbar,
  label,
  createProjectBtn,
  openProjectBtn
}

function createProjectBtn:on_clicked()
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

  -- classes
  createProjectQuestion1:get_style_context():add_class('dialog')
  local createProjectQuestion1OkBtn = createProjectQuestion1:get_widget_for_response(Gtk.ResponseType.OK)
  createProjectQuestion1OkBtn:get_style_context():add_class('bt-prim')
  local createProjectQuestion1CancelBtn = createProjectQuestion1:get_widget_for_response(Gtk.ResponseType.CANCEL)
  createProjectQuestion1CancelBtn:get_style_context():add_class('bt-sec')
  local createProjectQuestion1Entry = Gtk.Entry {}

  createProjectQuestion1Entry:set_size_request(500, 30)
  createProjectQuestion1Entry:get_style_context():add_class('entry')

  createProjectQuestion1:get_content_area():add(createProjectQuestion1Entry)

  createProjectQuestion1:show_all()

  local createProjectQuestion1Response = createProjectQuestion1:run()

  if createProjectQuestion1Response == Gtk.ResponseType.OK then
    local projectName = createProjectQuestion1Entry:get_text()
    createProjectQuestion1:destroy()
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

    createProjectQuestion2:get_style_context():add_class('dialog')
    local createProjectQuestion2OkBtn = createProjectQuestion2:get_widget_for_response(Gtk.ResponseType.OK)
    createProjectQuestion2OkBtn:get_style_context():add_class('bt-prim')
    local createProjectQuestion2CancelBtn = createProjectQuestion2:get_widget_for_response(Gtk.ResponseType.CANCEL)
    createProjectQuestion2CancelBtn:get_style_context():add_class('bt-sec')

    local createProjectQuestion2Entry = Gtk.Entry {}

    createProjectQuestion2Entry:set_size_request(500, 30)
  
    createProjectQuestion2:get_content_area():add(createProjectQuestion2Entry)

    createProjectQuestion2:show_all()

    local createProjectQuestion2Response = createProjectQuestion2:run()

    if createProjectQuestion2Response == Gtk.ResponseType.OK then
      local repoURL = createProjectQuestion2Entry:get_text()
      createProjectQuestion2:destroy()
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
  
      createProjectQuestion3:get_style_context():add_class('dialog')
      local createProjectQuestion3OkBtn = createProjectQuestion3:get_widget_for_response(Gtk.ResponseType.OK)
      createProjectQuestion3OkBtn:get_style_context():add_class('bt-prim')
      local createProjectQuestion3CancelBtn = createProjectQuestion3:get_widget_for_response(Gtk.ResponseType.CANCEL)
      createProjectQuestion3CancelBtn:get_style_context():add_class('bt-sec')

      local defaultDirectory = homeDir .. "/dhp-" .. projectName

      local createProjectQuestion3Entry = Gtk.Entry {
        text = defaultDirectory
      }
  
      createProjectQuestion3Entry:set_size_request(500, 30)
    
      createProjectQuestion3:get_content_area():add(createProjectQuestion3Entry)
  
      createProjectQuestion3:show_all()
  
      local createProjectQuestion3Response = createProjectQuestion3:run()
      local directoryPath

      if createProjectQuestion3Response == Gtk.ResponseType.OK then
        directoryPath = createProjectQuestion3Entry:get_text()
        createProjectQuestion3:destroy()
  
        -- ERR: starting here, things don't work, you enter the projectPath and stops there
        -- verify if folder exists
        local folderExists = os.execute("cd " .. directoryPath)

        if folderExists then
          local gitCommand = string.format("git clone %s %s", repoURL, directoryPath)
          local cloneSuccess = os.execute(gitCommand)
            if cloneSuccess then
              createProjectQuestion3:destroy()
              local cloneSuccessWindow = Gtk.Dialog {
                parent = window,
                message_type = Gtk.MessageType.INFO,
                buttons = Gtk.ButtonsType.OK,
                text = "Proyecto creado en " .. directoryPath .." con éxito!"
              }
              cloneSuccessWindow:show_all()
            else
              createProjectQuestion3:destroy()
              local errDialog = Gtk.Dialog {
                parent = window,
                message_type = Gtk.MessageType.ERROR,
                buttons = Gtk.ButtonsType.OK,
                text = "Error al crear el proyecto."
              }
              errDialog:show_all()
          end
        else
        createProjectQuestion3:destroy()
        local confirmCreateDirDialog = Gtk.MessageDialog {
          parent = window,
          message_type = Gtk.MessageType.INFO,
          buttons = {
            { Gtk.STOCK_OK, Gtk.ResponseType.OK },
            { Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL },
          },
          text = "Confirma si quieres crear el directorio",
          secondary_text = directoryPath
        }
        confirmCreateDirDialog:show_all()

        local response = confirmCreateDirDialog:run()
          if response == Gtk.ResponseType.OK then
            local createCommand = "mkdir " .. directoryPath
            local createSuccess = os.execute(createCommand)
              if createSuccess then
                local gitCommand = string.format("git clone %s %s", repoURL, directoryPath)
                local cloneSuccess = os.execute(gitCommand)
                  if cloneSuccess then
                    confirmCreateDirDialog:destroy()
                    local cloneSuccessWindow = Gtk.Dialog {
                      parent = window,
                      message_type = Gtk.MessageType.INFO,
                      buttons = Gtk.ButtonsType.OK,
                      text = "Proyecto creado en " .. directoryPath .." con éxito!"
                    }
                    cloneSuccessWindow:show_all()
                  else
                    confirmCreateDirDialog:destroy()
                    local errDialog = Gtk.Dialog {
                      parent = window,
                      message_type = Gtk.MessageType.ERROR,
                      buttons = Gtk.ButtonsType.OK,
                      text = "Error al crear el proyecto."
                    }
                    errDialog:show_all()
                  end
              else
                createProjectQuestion3:destroy()
                local errDialog = Gtk.MessageDialog {
                  parent = window,
                  message_type = Gtk.MessageType.ERROR,
                  buttons = Gtk.ButtonsType.OK,
                  text = "Error al crear la carpeta. Verifica los permisos de escritura."
                }
                errDialog:show_all()
              return
            confirmCreateDirDialog:destroy()
          end
        end
      end
      else
        createProjectQuestion3:destroy()
      end
      else
        createProjectQuestion2:destroy()
      end
      else
        createProjectQuestion1:destroy()
      end
  end

function openProjectBtn:on_clicked()
  label:set_markup('<big><b>Pronto...</b></big>')
end

window:add(box)
window:show_all()

Gtk.main()
