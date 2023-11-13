import 'package:flutter/material.dart';
import 'package:suivi_de_module/screen/main_screen.dart';
import 'package:suivi_de_module/screen/module_screen.dart';


class AppNavigationRail extends StatefulWidget {
  const AppNavigationRail({super.key});

  @override
  State<AppNavigationRail> createState() => _AppNavigationRailState();
}

class _AppNavigationRailState extends State<AppNavigationRail> {

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      elevation: 2,
      backgroundColor: const Color.fromARGB(255, 207, 207, 207),
      onDestinationSelected: (value) {
        setState(() {
          _selectedIndex = value;

          switch(value){
            case 0:
              MainScreen.appBarTitleContent = "Module";
            case 1:
              MainScreen.appBarTitleContent = "Gestion des élèves";
          }

          ModuleScreen.ResetMode();
          //level = Stage.module;
        });
      },
      destinations: const[
        NavigationRailDestination(
          icon: Icon(Icons.view_module), 
          label: Text("Modules"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_rounded), 
          label: Text(
            "Gestion des élèves",
            textAlign: TextAlign.center,
          ),
        ),
      ], 
      selectedIndex: _selectedIndex,
      labelType: labelType,
    );
  }
}