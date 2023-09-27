import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/eleve_add_edit_screen.dart';
import 'package:suivi_de_module/screen/module_screen.dart';
import 'package:suivi_de_module/widget/pick_file.dart';

import '../provider/student_provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<ModuleProvider>(context, listen: false).fetchAndSetModules();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        child: InkWell(
          onTap: () async {
            try{
              String myFileData = await PickFile.builder() as String;
              try{
                await Provider.of<ModuleProvider>(context, listen: false).addModuleFromCsv(myFileData);
              }catch(e){
                await Provider.of<ModuleProvider>(context, listen: false).addModuleFromJson(myFileData);
              }
              setState(() {
                Provider.of<ModuleProvider>(context, listen: false).fetchAndSetModules();
              });
            }catch(e){
              print(e);
            }
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Icon(
                  Icons.file_upload,
                  color: Colors.black
                ),
                Text('Importer un fichier')
              ]
            ),
          ),
        ),
      )
    );
  }
  
  Widget screenDisplay(int _selectedIndex){
    switch(_selectedIndex){
      case 0:
        StageScreen.instance.setStageScreen(Stage.module);
        setState(() {
          
        });
        return ModuleScreen();
      case 1:
        return EleveAddEditScreen();
      default:
        return ModuleScreen();
    }
  }
}