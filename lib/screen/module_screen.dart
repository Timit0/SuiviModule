import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/mode.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/screen/eleve_add_edit_screen.dart';
import 'package:suivi_de_module/screen/student_list_screen.dart';
import 'package:suivi_de_module/widget/app_bottom_nagiation_bar_widget.dart';

import '../models/module.dart';
import '../provider/student_provider.dart';
import '../widget/module_widget.dart';

class ModuleScreen extends StatefulWidget {
  ModuleScreen({super.key});
  @override
  State<ModuleScreen> createState() => _ModuleScreenState();

  Mode _mode = Mode.none;

  static void Refresh()
  {
    _refreshCode?.call();
  }

  static void ResetMode()
  {
    _resetModeCode?.call();
  }

  static Function? _resetModeCode;

  static Function? _refreshCode;
}

class _ModuleScreenState extends State<ModuleScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _isAdd = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     _isLoading = true;
  //     // Provider.of<ModuleProvider>(context).fetchAndSetModules();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }


  final formKey = GlobalKey<FormState>();

  final moduleNumController = TextEditingController();
  final moduleNameController = TextEditingController();
  final moduleDescriptionController = TextEditingController();
  final moduleDayDateController = TextEditingController();
  final moduleClassController = TextEditingController();

  final eleveRefController = TextEditingController();

  Module selectedModule = Module.base();

  String modId = "";

  @override
  Widget build(BuildContext context) {
    ModuleScreen._refreshCode = (){
      // if(mounted){
        setState(() {
          
        });
      // }
    };

    ModuleScreen._resetModeCode = (){
      if(mounted){
        setState(() {
          widget._mode = Mode.none;
        });
      }
    };

    ModuleProvider moduleProvider = Provider.of<ModuleProvider>(context);
    return _isLoading ? const Center(child: CircularProgressIndicator())
        : Scaffold(
          body: (() {
            if(StageScreen.instance.getStageScreen() == Stage.module){
              if(moduleProvider.modules.length != 0){
                return Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100, bottom: 200, top: 50),
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView.builder(      
                          itemCount: moduleProvider.modules.length,
                          itemBuilder: (context, index) {
                            return displayModule(index, selectedModule, moduleProvider);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 48.0),
                        child: addWidget(),
                      )
                    ],
                  ),
                );
              }else{
                return Center(
                  child: textButton(selectedModule, moduleProvider));
              }
            }
            
            
            if(StageScreen.instance.getStageScreen() == Stage.eleves) {
              return StudentListScreen(moduleId: modId);
            }
            else if (StageScreen.instance.getStageScreen() == Stage.eleveDetail) {
            return DetailsStudentScreen();
            }
          }()),
            bottomNavigationBar: AppBottomNavigationBar(stage: StageScreen.instance.getStageScreen()),
        );
  }

  Widget displayModule(int index, Module selectedModule, ModuleProvider moduleProvider){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 28.0),
          child: InkWell(
            onTap: () {
              selectedModule = Module(
                nom: moduleProvider.modules[index].nom, 
                description: moduleProvider.modules[index].description, 
                horaire: moduleProvider.modules[index].horaire, 
                classe: moduleProvider.modules[index].classe, 
                eleve: moduleProvider.modules[index].eleve
              );
              setState(() {
                StageScreen.instance.setStageScreen(Stage.eleves);
                modId = selectedModule.nom;
              });
  
              // setState(() {level = Stage.eleves;});
            },
            child: ModuleWidget(
              nom: moduleProvider.modules[index].nom, 
              description: moduleProvider.modules[index].description, 
              horaire: moduleProvider.modules[index].horaire, 
              classe: moduleProvider.modules[index].classe,
              eleve: moduleProvider.modules[index].eleve,
              editionBehavior: () {
                moduleNameController.text = moduleProvider.modules[index].nom;
                moduleClassController.text = moduleProvider.modules[index].classe;
                moduleDayDateController.text = moduleProvider.modules[index].horaire;
                moduleDescriptionController.text = moduleProvider.modules[index].description;
          
                // setState(() {
                  // mode = Mode.moduleEditionMode;
                // });
              }
            ).buildWidget(context, index),
          ),
        ),
        Center(child: textButton(selectedModule, moduleProvider, index: index)),
      ]
    );
  }

  Widget? textButton(Module selectedModule, ModuleProvider moduleProvider, {int index = 0} ){
    if(moduleProvider.modules.length > 0 && index == moduleProvider.modules.length-1 || moduleProvider.modules.length == 0){
      return TextButton(
        onPressed: () {
            moduleClassController.text = "";
            moduleDescriptionController.text = "";
            moduleDayDateController.text = "";
            moduleNameController.text = "";
            setState(() {
              widget._mode = Mode.moduleAdditionMode;
            });
        } , style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.grey),
      ), 
      child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: 
          Text(
            'Ajouter un module',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30
            )
          ),
        )
      );
    }
  }

  Widget addWidget()
  {
    switch (widget._mode) {
      case Mode.moduleAdditionMode:
        return Container(
          child: Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(children: [
                    const Text('Numero du module'),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'ex. ICH-123',
                          border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un numero';
                          }
                
                          return null;
                        },
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(
                    children: [
                    const Text('Description du module'),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'ex. Le design thinking',
                          border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un nom';
                          }
                          return null;
                        },
                      ),
                    ),
                    
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(children: [
                    const Text('La date'),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'ex. 23.07.2023',
                          border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer une date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(children: [
                    const Text('Le nom de la classe'),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'ex. ICH-2',
                          border: OutlineInputBorder()
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un nom';
                          }
                
                          return null;
                        },
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38.0, bottom: 25),
                  child: InkWell(
                    onTap: (){
                      if (formKey.currentState!.validate())
                      {
                        // faire l'update

                        // String temp

                        const SnackBar alert = SnackBar(content: Text('module ajouté avec succés!'));
                        ScaffoldMessenger.of(context).showSnackBar(alert);

                        setState(() {
                          widget._mode = Mode.none;
                        });

                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                        child: Text('Ajouter', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                        )),
                      ),
                    ),
                  ),
                )
              ]
            ),
          )
        );
      case Mode.moduleEditionMode:
        return Container();
      default:
        return Container();
    }
  }
}