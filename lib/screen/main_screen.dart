import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/eleve_add_edit_screen.dart';
import 'package:suivi_de_module/screen/module_screen.dart';
import 'package:suivi_de_module/widget/app_bottom_nagiation_bar_widget.dart';
import 'package:suivi_de_module/widget/pick_file.dart';

import '../provider/student_provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  static void Refresh()
  {
    _refreshCode?.call();
  }

  static Function? _refreshCode;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  @override
  Widget build(BuildContext context) {
    MainScreen._refreshCode = (){
      setState(() {
        
      });
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text("Module"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Row(
        children: [
          NavigationRail(
            elevation: 2,
            backgroundColor: const Color.fromARGB(255, 207, 207, 207),
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;

                //level = Stage.module;
              });
            },
            destinations: const[
              NavigationRailDestination(
                icon: Icon(Icons.view_module), 
                label: Text("Modules"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_add), 
                label: Text("Ajouter/Modifier/Supprimer\nélèves"),
              ),
            ], 
            selectedIndex: _selectedIndex,
            labelType: labelType,
          ),
          Flexible(
            child: screenDisplay(_selectedIndex)
          ),
        ],
      ),
      //bottomNavigationBar: AppBottomNavigationBar(stage: StageScreen.instance.getStageScreen())
    );
  }

  // Widget bottomActionBarThing(Stage selectedMode)
  // {
  //   if (selectedMode == Stage.module)
  //   {
  //     return Container(
  //       height: 60,
  //       color: Colors.white,
  //       child: InkWell(
  //         onTap: () async {
  //           try{
  //             String myFileData = await PickFile.builder() as String;
  //             try{
  //               await Provider.of<ModuleProvider>(context, listen: false).addModuleFromCsv(myFileData);
  //             }catch(e){
  //               await Provider.of<ModuleProvider>(context, listen: false).addModuleFromJson(myFileData);
  //             }
  //             setState(() {
  //               Provider.of<ModuleProvider>(context, listen: false).fetchAndSetModules();
  //             });
  //           }catch(e){
  //             print(e);
  //           }
  //         },
  //         child: const Padding(
  //           padding: EdgeInsets.only(top: 8),
  //           child: Column(
  //             children: [
  //               Icon(
  //                 Icons.file_upload,
  //                 color: Colors.black
  //               ),
  //               Text('Importer un fichier')
  //             ]
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   else if (selectedMode == Stage.eleves)
  //   {
  //     return BottomNavigationBar(items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Retour'),
  //       BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Ajouter un eleve'), 
  //     ]);
  //   }

  //   return Placeholder();
  // }
  
  ///C'est le our le changement de screen quand on clique sur la NavigationRail (le truc a gauche)
  Widget screenDisplay(int _selectedIndex){
    switch(_selectedIndex){
      case 0:
        StageScreen.instance.setStageScreen(Stage.module);
        return ModuleScreen();
      case 1:
        return EleveAddEditScreen();
      default:
        StageScreen.instance.setStageScreen(Stage.module);
        return ModuleScreen();
    }
  }
}