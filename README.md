#Overview

This is modification of CityGML plugin version 1.8 to work in SketchUp 2015. There are some differences like versions of Ruby, plugin sources paths
and so one, between SketchUp 2013 and 2015. We take care of these changes.

#Instalation

1. Download this repo to Plugins path of your SketchUp. In windows it will be typically in `C:\Users\<Username>\AppData\Roaming\SketchUp\SketchUp 2015\SketchUp\Plugins\` .
2. If the plugin is not visible in SketchUp, go to SketchUp menu WINDOWS -> PREFERENCES -> EXTENSION and check the CityGML plugin.
3. Check if setting "Extensions Policy" is "unrestricted".
3. Start using plugin.

#Main changes

* adjust plugin source paths
* load proper Win32Api
* fix encoding problems
