dofile("config.lua")

local projectToOpen = readInput("¿Qué proyecto te gustaría abrir?")

local archivo = configFilePath
local datos = {}
local entrada = {}
local lineaActual = ""

for linea in archivo:lines() do
  if linea:match("%S") then -- Ignorar líneas en blanco
    local nivelIndentacion = linea:match("^%s*"):len()
    local contenidoLinea = linea:match("%s*(.*)")

    if nivelIndentacion == 0 then
      -- Comienza una nueva entrada
      if next(entrada) ~= nil then
        table.insert(datos, entrada)
        entrada = {}
      end
      entrada.nombre = contenidoLinea
    else
      -- Procesar datos dentro de la entrada actual
      local clave, valor = contenidoLinea:match("^%s*([^:]+):%s*(.*)")
      if clave and valor then
        entrada[clave] = valor
      end
    end
  end
end

if next(entrada) ~= nil then
  table.insert(datos, entrada)
end

archivo:close()

local cantidadEntradas = #datos
print("Cantidad de entradas:", cantidadEntradas)

for i, entrada in ipairs(datos) do
  print("Entrada #" .. i)
  for clave, valor in pairs(entrada) do
    print(clave .. ":", valor)
  end
  print() -- Línea en blanco para separar las entradas
end