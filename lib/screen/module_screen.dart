import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/screen/student_list_screen.dart';
import 'package:suivi_de_module/widget/app_bottom_nagiation_bar_widget.dart';

import '../models/module.dart';
import '../provider/student_provider.dart';
import '../widget/module_widget.dart';

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({super.key});
  @override
  State<ModuleScreen> createState() => _ModuleScreenState();

  static void Refresh()
  {
    _refreshCode?.call();
  }

  static Function? _refreshCode;
}

class _ModuleScreenState extends State<ModuleScreen> {
  bool _isInit = true;
  bool _isLoading = false;

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
      setState(() {
        
      });
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
                  
                      //  Container(
                      //   width: double.infinity,
                      //   height: 400,
                      //   color: Colors.red,
                      // ),
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
            // setState(() {
            //   mode = Mode.moduleAdditionMode;
            // });
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
}