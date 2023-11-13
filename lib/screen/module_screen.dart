import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/blocs/module/get_module_bloc/get_module_bloc.dart';
import 'package:suivi_de_module/enum/mode.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/screen/eleve_add_edit_screen.dart';
import 'package:suivi_de_module/screen/main_screen.dart';
import 'package:suivi_de_module/screen/student_list_screen.dart';
import 'package:suivi_de_module/widget/app_bottom_nagiation_bar_widget.dart';

import '../models/module.dart';
import '../provider/student_provider.dart';
import '../widget/module_widget.dart';

class ModuleScreen extends StatefulWidget {
  ModuleScreen({super.key});
  @override
  State<ModuleScreen> createState() => _ModuleScreenState();

  static Mode _mode = Mode.none;

  static void set mode(Mode mode)
  {
    _mode = mode;
  }

  static void Refresh()
  {
    _refreshCode?.call();
  }

  static void ResetMode()
  {
    _resetModeCode?.call();
  }

  static Function? _resetModeCode;
  static Function? refreshInsideCode;
  static Function? _refreshCode;

  static String modId = "";
}

class _ModuleScreenState extends State<ModuleScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _isAdd = false;


  final formKey = GlobalKey<FormState>();

  final moduleNumController = TextEditingController();
  final moduleNameController = TextEditingController();
  final moduleDescriptionController = TextEditingController();
  final moduleDayDateController = TextEditingController();
  final moduleClassController = TextEditingController();

  final eleveRefController = TextEditingController();

  Module selectedModule = Module.base();

  @override
  Widget build(BuildContext context) {
    ModuleScreen._refreshCode = (){
      // if(mounted){
        setState(() {
          ModuleScreen.refreshInsideCode?.call();
        });
      // }
    };

    ModuleScreen._resetModeCode = (){
      if(mounted){
        setState(() {
          ModuleScreen._mode = Mode.none;
        });
      }
    };

    ModuleProvider moduleProvider = Provider.of<ModuleProvider>(context);
    BlocBuilder<GetModuleBloc, GetModuleBlocState>(
      builder: (context, state) {
        if(state == GetModuleBlocLoading){
          return CircularProgressIndicator();
        }
        if(state == GetModuleBlocSuccess){
          return displayScaffold();
        }
        return Text(state.errorMessage);
      },
    );
        
  }

  Widget displayScaffold(){
    return Scaffold(
      body: (() {
        if(StageScreen.instance.getStageScreen() == Stage.module){
          if(moduleProvider.modules.length != 0){
            return Padding(
              padding: const EdgeInsets.only(left: 100, right: 100, bottom: 0.0, top: 50),
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
                  ),
                  //textButtonWidget()
                ],
              ),
            );
          }else if(ModuleScreen._mode == Mode.none){
            return const Center(
              child: Text(
                "Aucun module n'a été créer",
                style: TextStyle(
                  fontSize: 40
                ),
              ),
            );
          }else{
            return Padding(
              padding: const EdgeInsets.only(left: 100, right: 100, top: 50),
              child: Center(
                child: addWidget()
              ),
            );
          }
        }
        
        
        if(StageScreen.instance.getStageScreen() == Stage.eleves) {
          return StudentListScreen(moduleId: ModuleScreen.modId);
        }
        else if (StageScreen.instance.getStageScreen() == Stage.eleveDetail) {
        return DetailsStudentScreen();
        }
      }()),
        bottomNavigationBar: AppBottomNavigationBar(stage: StageScreen.instance.getStageScreen(), extraBehavior: (){
          moduleClassController.text = "";
          moduleDescriptionController.text = "";
          moduleDayDateController.text = "";
          moduleNameController.text = "";
          setState(() {
            ModuleScreen._mode = Mode.moduleAdditionMode;
          });
        }),
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
                ModuleScreen.modId = selectedModule.nom;
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
        //Center(child: textButton(selectedModule, moduleProvider, index: index)),
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
              ModuleScreen._mode = Mode.moduleAdditionMode;
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
    switch (ModuleScreen._mode) {
      case Mode.moduleAdditionMode:
        return formForAddModule();
      case Mode.moduleEditionMode:
        return formForAddModule(moduleId: ModuleScreen.modId);
      default:
        return Container();
    }
  }

  Widget formForEditModule(String moduleId) {
    final moduleParam = Provider.of<ModuleProvider>(context, listen: false).getModuleFromId(moduleId);
    moduleClassController.text = moduleParam.classe;
    moduleDayDateController.text = moduleParam.horaire;
    moduleDescriptionController.text = moduleParam.description;
    moduleNameController.text = moduleParam.nom;
      
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){
              moduleClassController.text = "";
              moduleDayDateController.text = "";
              moduleDescriptionController.text = "";
              moduleNumController.text = "";
              setState(() => ModuleScreen._mode = Mode.none);
            },
            icon: const Icon(Icons.close), color: Colors.red
          ),
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                returnIfIsAddition(),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(
                    children: [
                    const Text('Description du module'),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        initialValue: moduleDescriptionController.text,
                        decoration: const InputDecoration(
                          hintText: 'ex. Le design thinking',
                          border: OutlineInputBorder()
                        ),
                        onChanged: (value) {
                          moduleDescriptionController.text = value;
                        },
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
                        initialValue: moduleDayDateController.text,
                        decoration: const InputDecoration(
                          hintText: 'ex. 23.07.2023',
                          border: OutlineInputBorder()
                        ),
                        onChanged: (value) {
                          moduleDayDateController.text = value;
                        },
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
                        initialValue: moduleClassController.text,
                        decoration: const InputDecoration(
                          hintText: 'ex. ICH-2',
                          border: OutlineInputBorder()
                        ),
                        onChanged: (value) {
                          moduleClassController.text = value;
                        },
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
                    onTap: () async {
                      if (formKey.currentState!.validate())
                      {
                        // faire l'upload
                        await Provider.of<ModuleProvider>(context, listen: false).createOrUpdateModule(Module(
                          nom: moduleNameController.text,
                          description: moduleDescriptionController.text,
                          horaire: moduleDayDateController.text,
                          classe: moduleClassController.text,
                          eleve: []
                        ), ModuleScreen._mode);

                            SnackBar alert = SnackBar(content: Text(
                              ModuleScreen._mode == Mode.moduleAdditionMode ? 'module ajouté avec succés!' : 'Module modifié avec succés!'
                            ));
                            
                            ScaffoldMessenger.of(context).showSnackBar(alert);

                        setState(() {
                          ModuleScreen._mode = Mode.none;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                        child: Text(
                          returnAddOrEdit(),
                          style: const TextStyle(
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
          ),
        ],
      )
    );
  }

  Widget formForAddModule({String? moduleId}){
    if(moduleId != null){
      final moduleParam = Provider.of<ModuleProvider>(context, listen: false).getModuleFromId(moduleId);
      moduleClassController.text = moduleParam.classe;
      moduleDayDateController.text = moduleParam.horaire;
      moduleDescriptionController.text = moduleParam.description;
      moduleNameController.text = moduleParam.nom;
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){
              moduleClassController.text = "";
              moduleDayDateController.text = "";
              moduleDescriptionController.text = "";
              moduleNumController.text = "";
              setState(() => ModuleScreen._mode = Mode.none);
            },
            icon: const Icon(Icons.close), color: Colors.red
          ),
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                returnIfIsAddition(),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(
                    children: [
                    const Text('Description du module'),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        initialValue: moduleDescriptionController.text,
                        decoration: const InputDecoration(
                          hintText: 'ex. Le design thinking',
                          border: OutlineInputBorder()
                        ),
                        onChanged: (value) {
                          moduleDescriptionController.text = value;
                        },
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
                        initialValue: moduleDayDateController.text,
                        decoration: const InputDecoration(
                          hintText: 'ex. 23.07.2023',
                          border: OutlineInputBorder()
                        ),
                        onChanged: (value) {
                          moduleDayDateController.text = value;
                        },
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
                        initialValue: moduleClassController.text,
                        decoration: const InputDecoration(
                          hintText: 'ex. ICH-2',
                          border: OutlineInputBorder()
                        ),
                        onChanged: (value) {
                          moduleClassController.text = value;
                        },
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
                    onTap: () async {
                      if (formKey.currentState!.validate())
                      {
                        // faire l'upload
                        await Provider.of<ModuleProvider>(context, listen: false).createOrUpdateModule(Module(
                          nom: moduleNameController.text,
                          description: moduleDescriptionController.text,
                          horaire: moduleDayDateController.text,
                          classe: moduleClassController.text,
                          eleve: []
                        ), ModuleScreen._mode);

                            const SnackBar alert = SnackBar(content: Text('module ajouté avec succés!'));
                            ScaffoldMessenger.of(context).showSnackBar(alert);

                        setState(() {
                          ModuleScreen._mode = Mode.none;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                        child: Text(
                          returnAddOrEdit(),
                          style: const TextStyle(
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
          ),
        ],
      )
    );
  }

  String returnAddOrEdit(){
    if(ModuleScreen._mode == Mode.moduleAdditionMode){
      return "Ajouter";
    }
    return "Modifier";
  }

  Widget returnIfIsAddition(){
    if(ModuleScreen._mode != Mode.moduleAdditionMode){
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Column(children: [
        const Text('Numero du module'),
        SizedBox(
          width: 300,
          height: 100,
          child: TextFormField(
            initialValue: moduleNameController.text,
            decoration: const InputDecoration(
              hintText: 'ex. ICH-123',
              border: OutlineInputBorder()
            ),
            onChanged: (value) {
              moduleNameController.text = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un numero';
              }
              else if ((value.split('-').length != 2) || int.parse(value.split('-')[1]).isNull) {
                return 'il faut ecrire de la façon suivante: "ICH-[nombre]"!';
              }
    
              return null;
            },
          ),
        ),
      ]),
    );
  }
}