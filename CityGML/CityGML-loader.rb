#Es werden nur Klassen geladen, die sich direkt im Plugins-Ordner befinden
#Deshalb müssen alle Dateien aus dem Unterordner CityGML beim Starten bekannt gemacht werden

require 'CityGML/Win32API'

require 'CityGML/Export/CityGMLExport'
require 'CityGML/Export/BatchExporter'

require 'CityGML/UI/Menu'
require 'CityGML/UI/Contextmenu'

require 'CityGML/External/rubytoolbar'
require 'CityGML/External/htmlentities'