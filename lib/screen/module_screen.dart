// import 'dart:js_util';

import 'dart:html';
import 'dart:js_interop';

import 'package:flutter/foundation.dart';
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
import 'package:intl/intl.dart'; // DateFormat


enum Mode
{
  none,
  moduleAdditionMode
}

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

  final formKey = GlobalKey<FormState>();

  final moduleNameController = TextEditingController();
  final moduleDescriptionController = TextEditingController();
  final moduleDayDateController = TextEditingController();
  final moduleClassController = TextEditingController();

  Mode mode = Mode.none; 

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
            backgroundColor: const Color.fromARGB(255, 207, 207, 207),
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
          Container(
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            
            child: Form(
              key: formKey,
              child: Column(
                children: mode == Mode.none
                  ? []
                  : mode == Mode.moduleAdditionMode
                    ? [
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('Ajout de module', style: TextStyle(fontSize: 25)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38.0),
                        child: SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: moduleNameController,
                            validator: (value){
                              if (value == "") { return "Le module doit avoir un identifiant"; }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'L\'identifiant du module',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 38.0),
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: TextFormField(
                            maxLines: 255,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.black,
                              hintText: 'Description du module',
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 100,
                        child: TextFormField(
                          controller: moduleDayDateController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.black,
                            hintText: 'La date (JJ.MM.AAAA)',
                            border: OutlineInputBorder()
                          ),
                          validator: (value) {


                            value = (value == "" || value.isNull) ? DateFormat('dd.mm.yyyy').format(DateTime.now()).toString() : value;

                            final temp = value!.split('.');
                            
                            if (value != DateFormat('dd.mm.yyyy').format(DateTime.now()).toString())
                            {
                              if (temp.length != 3) { return "La date doit être marquée de la manière suivante : jj.mm.aaaa"; }
                              
                              if
                              (
                                int.tryParse(temp[0]) == null ||
                                int.tryParse(temp[1]) == null ||
                                int.tryParse(temp[2]) == null
                              )
                              {
                                return "La date doit être marquée de la manière suivante : jj.mm.aaaa";
                              }

                              if
                              (
                                (int.tryParse(temp[0])! <= 0 || int.tryParse(temp[0])! > 31) ||
                                (int.tryParse(temp[1])! <= 0 || int.tryParse(temp[1])! > 12) ||
                                (int.tryParse(temp[2])! <= 1925)
                              )
                              {
                                return "La date doit être marquée de la manière suivante : jj.mm.aaaa";
                              }
                              return null;
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 100,
                        child: TextFormField(
                          controller: moduleClassController,
                          decoration: const InputDecoration(
                            hintText: 'Le nom de la classe',
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.black,
                            border: OutlineInputBorder()
                          ),
                          validator: ((value) => value == "" ? "Il faut que ce champ soit rempli!" : null)
                        )
                      ),
                      TextButton(
                        onPressed: (){
                          if (formKey.currentState!.validate())
                          {
                            if (moduleDayDateController.text == DateFormat('dd.MM.yyyy').format(DateTime.now()))
                            {
                              Provider.of<ModuleProvider>(context, listen: false).createModule(Module(
                                nom: moduleNameController.text,
                                classe: moduleClassController.text,
                                description: moduleDescriptionController.text,
                                eleve: [],
                                horaire: moduleDayDateController.text,
                                devoirs: [],
                                tests: []
                              ));

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Le module à bien était ajouté dans la base de donnée!'))
                              );

                              setState((){});
                            }
                            else
                            {
                              
                              Provider.of<ModuleProvider>(context, listen: false).createPendingModule(Module(
                                nom: moduleNameController.text,
                                classe: moduleClassController.text,
                                description: moduleDescriptionController.text,
                                eleve: [],
                                horaire: moduleDayDateController.text,
                                devoirs: [],
                                tests: []
                              ));
                            
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Le module sera ajouté dans la list le ${moduleDayDateController.text}'))
                              );

                              setState((){});
                            }
                            
                          }
                          else
                          {

                          }
                        }, 
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 73, 73, 73))
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Envoyer!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                        )
                      )
                    ]
                    : []
                  
              ),
            )
          )
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

                onPressed: () => setState(() {
                  mode = Mode.moduleAdditionMode;
                }) , style: const ButtonStyle(
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