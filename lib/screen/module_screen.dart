// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/widget/eleve_action_screen.dart';
import 'package:suivi_de_module/widget/module_widget.dart';
import 'package:suivi_de_module/widget/pop_up_module_creation.dart';
import 'package:suivi_de_module/widget/program_action_button.dart';

class ModuleScreen extends StatefulWidget {
  static const routeName = '/details_student_screen';
  const ModuleScreen({super.key});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {

  var _isInit = true;
  var _isLoading = false;
  int _selectedIndex = 0;
  

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<ModuleProvider>(context).fetchAndSetModules();
      //await Provider.of<StudentProvider>(context).fetchAndSetAllStudents();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final moduleProvider = Provider.of<ModuleProvider>(context);
    NavigationRailLabelType labelType = NavigationRailLabelType.all;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Module", 
          style: 
          TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),

      body: Row(
        children: [
          NavigationRail(
            elevation: 2,
            backgroundColor: Color.fromARGB(255, 207, 207, 207),
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;
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
            child: screen(moduleProvider),
          ),
        ],
      ),
    );
  }

  Widget screen(ModuleProvider moduleProvider){
    if(_selectedIndex == 0){
      return screenModule(moduleProvider);
    }else{
      return EleveActionScreen();
    }
    
  }

  Widget screenModule(ModuleProvider moduleProvider){
    return _isLoading ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Padding(
        padding: const EdgeInsets.only(left: 100, right: 100, bottom: 200),
        child: ListView.builder(
          itemCount: moduleProvider.modules.length,
          itemBuilder: (context, index) {
            return index+1 == moduleProvider.modules.length ? Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: ModuleWidget(
                  nom: moduleProvider.modules[index].nom, 
                  description: moduleProvider.modules[index].description, 
                  horaire: moduleProvider.modules[index].horaire, 
                  classe: moduleProvider.modules[index].classe,
                  eleve: moduleProvider.modules[index].eleve,
                ).buildWidget(context, index),
              ),
              TextButton(

                onPressed: (){}, style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.grey),
                ), 
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ajouter un module',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                      )
                    ),
                )
                )
            ]) : Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ModuleWidget(
                nom: moduleProvider.modules[index].nom, 
                description: moduleProvider.modules[index].description, 
                horaire: moduleProvider.modules[index].horaire, 
                classe: moduleProvider.modules[index].classe,
                eleve: moduleProvider.modules[index].eleve,
              ).buildWidget(context, index),
            );
          },
        ),
      ),
    );
  }

  void createModule(){
    PopUpModuleCreation popUpModuleCreation = PopUpModuleCreation();
    popUpModuleCreation.popUp(context);
    // setState(() {
      
    // });
  }
}