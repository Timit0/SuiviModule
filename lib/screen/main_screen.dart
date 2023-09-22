import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/screen/eleve_add_edit_screen.dart';
import 'package:suivi_de_module/screen/module_screen.dart';

import '../provider/student_provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // bool _isInit = true;
  // bool _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     _isLoading = true;
  //     Provider.of<StudentProvider>(context).fetchAndSetStudents(widget.moduleId);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  @override
  Widget build(BuildContext context) {
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
    );
  }
  
  Widget screenDisplay(int _selectedIndex){
    switch(_selectedIndex){
      case 0:
        StageScreen.instance.setStageScreen(Stage.module);
        return ModuleScreen();
      case 1:
        return EleveAddEditScreen();
      default:
        return ModuleScreen();
    }
  }
}