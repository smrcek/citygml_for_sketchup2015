require 'CityGML/Edit/reverseMaterial'
require 'CityGML/Edit/removeBackmaterial'
require 'CityGML/Attribute/attribute'
require 'CityGML/Attribute/AttributeDialog'
require 'CityGML/Attribute/AttributeRescue'

module FHGelsenkirchen
  begin
    UI::add_context_menu_handler do |menu|
      menu.add_separator

      if(Sketchup.active_model.selection.count >= 1)
        if(FHGelsenkirchen::hasface?(Sketchup.active_model.selection))
          correctionMenu = menu.add_submenu("Correction functions")

          correctionMenu.add_item("Reverse Faces"){
            ReverseMaterial.new(Sketchup.active_model.selection)
          }
          correctionMenu.add_item("Remove Backmaterial"){
            RemoveBackmaterial.new(Sketchup.active_model.selection)
          }
        end
      end

      $wallsurface = false
      $roofsurface = false
      $groundsurface = false
      $relieffeature = false
      ##
      $intbuildinginstallation = false
      $buildinginstallation = false
      $door = false
      $window = false
      $ceilingsurface = false
      $interiorwallsurface = false
      $floorsurface = false
      $outerfloorsurface = false
      ##
      if(Sketchup.active_model.selection.count >= 1)
        if(Sketchup.active_model.selection.count == 1)
          subMenu = menu.add_submenu("CityGML Attribute");
          subMenu.add_item("Edit") {
            AttributeEdit.new
          }
          subMenu.add_item("Copy") {
            AttributeRescue.new.copy_attribute(Sketchup.active_model.selection.first)
          }
          subMenu.add_item("Insert") {
            AttributeRescue.new.paste_attribute(Sketchup.active_model.selection.first)
          }
        end ## doplnit vybrane typy
        if(FHGelsenkirchen::hasface?(Sketchup.active_model.selection))
          subMenu = menu.add_submenu("CityGML Surfacetype");

          itemground = subMenu.add_item("GroundSurface") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "GroundSurface")
          }
          itemroof = subMenu.add_item("RoofSurface") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "RoofSurface")
          }
          itemwall = subMenu.add_item("WallSurface") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "WallSurface")
          }
          itemfloor = subMenu.add_item("FloorSurface") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "FloorSurface")
          }
          itemOuterFloor = subMenu.add_item("OuterFloorSurface") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "OuterFloorSurface")
          }
          ###
          itemintbuilding = subMenu.add_item("IntBuildingInstallation") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "IntBuildingInstallation")
          }
          itembuilding = subMenu.add_item("BuildingInstallation") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "BuildingInstallation")
          }
          itemdoor = subMenu.add_item("Door") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "Door")
          }
          itemwindow = subMenu.add_item("Window") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "Window")
          }
          itemceiling = subMenu.add_item("CeilingSurface") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "CeilingSurface")
          }
          iteminteriorwall = subMenu.add_item("InteriorWallSurface") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, "InteriorWallSurface")
          }
          ###
          itemnone = subMenu.add_item("None") {
            FHGelsenkirchen::setsurfacetype(Sketchup.active_model.selection, nil)
          }
          #surfaceid = subMenu.add_item("BoundarySurfaceType ID") {
          #  idhash = FHGelsenkirchen::setsurfaceid(Sketchup.active_model.selection, Hash.new())
          #  defaults = []
          #  prompts = ["SurfaceType ID"]
          #  if(idhash.size == 1)
          #    idhash.each_pair {|key, value|
          #      if(value.size == 1)
          #        value.each_pair {|key2, value2|
          #          defaults = [key2]
          #        }
          #      end
          #    }

          #    input = UI.inputbox prompts, defaults, "BoundarySurfaceType ID"
          #    FHGelsenkirchen::setid(Sketchup.active_model.selection, input[0]) if(input)
          #  else
          #    UI.messagebox("The selected faces are not on the same layer")
          #  end
          #}
          subMenu.set_validation_proc(itemground) {  ## doplnit vybrane typy

            if $groundsurface == true
              MF_CHECKED
            else $groundsurface == false
              MF_UNCHECKED
            end
          }
          subMenu.set_validation_proc(itemroof) {

            if $roofsurface == true
              MF_CHECKED
            else $roofsurface == false
              MF_UNCHECKED
            end
          }
          subMenu.set_validation_proc(itemwall) {
            if $wallsurface == true
              MF_CHECKED
            else $wallsurface == false
              MF_UNCHECKED
            end
          }
          subMenu.set_validation_proc(itemfloor) {
            if $floorsurface == true
              MF_CHECKED
            else $floorsurface == false
              MF_UNCHECKED
            end
          }
        subMenu.set_validation_proc(itemOuterFloor) {
            if $outerFloorSurface == true
              MF_CHECKED
            else $outerFloorSurface == false
              MF_UNCHECKED
            end
          }
          ##
           subMenu.set_validation_proc(itemintbuilding) {
            if $intbuildinginstallation == true
              MF_CHECKED
            else $intbuildinginstallation == false
              MF_UNCHECKED
            end
          }
          subMenu.set_validation_proc(itembuilding) {
            if $buildinginstallation == true
              MF_CHECKED
            else $buildinginstallation == false
              MF_UNCHECKED
            end
          }
          subMenu.set_validation_proc(itemdoor) {
            if $door == true
              MF_CHECKED
            else $door == false
              MF_UNCHECKED
            end
          }
          subMenu.set_validation_proc(itemwindow) {
            if $window == true
              MF_CHECKED
            else $window == false
              MF_UNCHECKED
            end
          }
          subMenu.set_validation_proc(itemceiling) {
            if $ceilingsurface == true
              MF_CHECKED
            else $ceilingsurface == false
              MF_UNCHECKED
            end
          }
          subMenu.set_validation_proc(iteminteriorwall) {
            if $interiorwallsurface == true
              MF_CHECKED
            else $interiorwallsurface == false
              MF_UNCHECKED
            end
          }
          
          ##
          #subMenu.set_validation_proc(itemrelief) {
          #  if $relieffeature == true
          #   MF_CHECKED
          # else $relieffeature == false
          #   MF_UNCHECKED
          # end
          # }
        end
        entities = Sketchup.active_model.selection
        typehash = Hash.new()
        FHGelsenkirchen::findtype(entities, typehash)

        if(typehash.size == 1) ## doplnit vybrane typy
          if(typehash["WallSurface"] != nil)
            $wallsurface = true
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
            ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false
            
          elsif(typehash["RoofSurface"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = true
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false
          elsif(typehash["GroundSurface"] != nil)
            $wallsurface = false
            $groundsurface = true
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false
        elsif(typehash["FloorSurface"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = true
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false
        elsif(typehash["OuterFloorSurface"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = true
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false
          elsif(typehash["ReliefFeature"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = true
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false
          ##  
          elsif(typehash["IntBuildingInstallation"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = true
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false  
          elsif(typehash["BuildingInstallation"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = true
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false    
          elsif(typehash["Door"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = true
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = false  
          elsif(typehash["Window"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = true
            $ceilingsurface = false
            $interiorwallsurface = false
          elsif(typehash["CeilingSurface"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = true
            $interiorwallsurface = false    
          elsif(typehash["InteriorWallSurface"] != nil)
            $wallsurface = false
            $groundsurface = false
            $roofsurface = false
            $floorsurface = false
            $outerFloorSurface = false
            $relieffeature = false
             ##           
            $intbuildinginstallation = false
            $buildinginstallation = false
            $door = false
            $window = false
            $ceilingsurface = false
            $interiorwallsurface = true  
          end
        end
      end
    end
  rescue => e
    puts e
    puts e.backtrace
  end
end