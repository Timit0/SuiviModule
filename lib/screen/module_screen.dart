import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_repository/module_repository.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/blocs/module/get_module_bloc/get_module_bloc.dart';
import 'package:suivi_de_module/enum/mode.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/screen/eleve_add_edit_screen.dart';
import 'package:suivi_de_module/screen/main_screen.dart';
import 'package:suivi_de_module/screen/student_list_screen.dart';
import 'package:suivi_de_module/widget/app_bottom_nagiation_bar_widget.dart';
import 'package:suivi_de_module/widget/module_form.dart';

import '../provider/student_provider.dart';
import '../widget/module_widget.dart';

class ModuleScreen extends StatefulWidget {
  ModuleScreen({super.key});
  @override
  State<ModuleScreen> createState() => _ModuleScreenState();

  static Mode mode = Mode.none;

  static void Refresh() {
    _refreshCode?.call();
  }

  static void ResetMode() {
    _resetModeCode?.call();
  }

  static Function? _resetModeCode;
  static Function? refreshInsideCode;
  static Function? _refreshCode;

  static String modId = "";
}

class _ModuleScreenState extends State<ModuleScreen> {
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
    // List<Module> modules = [];

    ModuleScreen._refreshCode = () {
      // if(mounted){
      setState(() {
        ModuleScreen.refreshInsideCode?.call();
      });
      // }
    };

    ModuleScreen._resetModeCode = () {
      if (mounted) {
        setState(() {
          ModuleScreen.mode = Mode.none;
        });
      }
    };

    return Scaffold(
      body: (() {
        if (StageScreen.instance.getStageScreen() == Stage.module) {
          BlocBuilder<GetModuleBloc, GetModuleBlocState>(
            builder: (context, state) {
              if (state is GetModuleBlocLoading) {
                return const CircularProgressIndicator();
              } else if (state is GetModuleBlocSuccess) {
                List<Module> modules = state.module;

                if (modules.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 100, right: 100, bottom: 0.0, top: 50),
                    child: Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            itemCount: modules.length,
                            itemBuilder: (context, index) {
                              return displayModule(
                                  index, selectedModule, modules);
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
                } else if (ModuleScreen.mode == Mode.none) {
                  return const Center(
                    child: Text(
                      "Aucun module n'a été crée",
                      style: TextStyle(fontSize: 40),
                    ),
                  );
                } else {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 100, right: 100, top: 50),
                    child: Center(child: addWidget()),
                  );
                }
              }

              if (state is GetModuleBlocFailure) {
                return Center(
                  child: Text((state as GetModuleBlocFailure).errorMessage),
                );
              }

              return Placeholder();
            },
          );
        }

        if (StageScreen.instance.getStageScreen() == Stage.eleves) {
          return StudentListScreen(moduleId: ModuleScreen.modId);
        } else if (StageScreen.instance.getStageScreen() == Stage.eleveDetail) {
          return const DetailsStudentScreen();
        }
      }()),
      bottomNavigationBar: AppBottomNavigationBar(
          stage: StageScreen.instance.getStageScreen(),
          extraBehavior: () {
            moduleClassController.text = "";
            moduleDescriptionController.text = "";
            moduleDayDateController.text = "";
            moduleNameController.text = "";
            setState(() {
              ModuleScreen.mode = Mode.moduleAdditionMode;
            });
          }),
    );
  }

  Widget displayModule(int index, Module selectedModule, List<Module> modules) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 28.0),
        child: InkWell(
          onTap: () {
            selectedModule = Module(
                nom: modules[index].nom,
                description: modules[index].description,
                horaire: modules[index].horaire,
                classe: modules[index].classe,
                eleve: modules[index].eleve);
            setState(() {
              StageScreen.instance.setStageScreen(Stage.eleves);
              ModuleScreen.modId = selectedModule.nom;
            });

            // setState(() {level = Stage.eleves;});
          },
          child: ModuleWidget(
              nom: modules[index].nom,
              description: modules[index].description,
              horaire: modules[index].horaire,
              classe: modules[index].classe,
              eleve: modules[index].eleve as List<EleveReference>,
              editionBehavior: () {
                moduleNameController.text = modules[index].nom;
                moduleClassController.text = modules[index].classe;
                moduleDayDateController.text = modules[index].horaire;
                moduleDescriptionController.text = modules[index].description;

                // setState(() {
                // mode = Mode.moduleEditionMode;
                // });
              }).buildWidget(context, index),
        ),
      ),
      //Center(child: textButton(selectedModule, moduleProvider, index: index)),
    ]);
  }

  Widget? textButton(Module selectedModule, ModuleProvider moduleProvider,
      {int index = 0}) {
    if (moduleProvider.modules.length > 0 &&
            index == moduleProvider.modules.length - 1 ||
        moduleProvider.modules.length == 0) {
      return TextButton(
          onPressed: () {
            moduleClassController.text = "";
            moduleDescriptionController.text = "";
            moduleDayDateController.text = "";
            moduleNameController.text = "";
            setState(() {
              ModuleScreen.mode = Mode.moduleAdditionMode;
            });
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.grey),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Ajouter un module',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
          ));
    }
  }

  Widget addWidget() {
    switch (ModuleScreen.mode) {
      case Mode.moduleAdditionMode:
        return ModuleForm(
          modules: selectedModule,
          eleveRefController: eleveRefController,
          moduleClassController: moduleClassController,
          moduleDayDateController: moduleDayDateController,
          moduleDescriptionController: moduleDescriptionController,
          moduleNameController: moduleNameController,
          moduleNumController: moduleNumController,
          formKey: formKey,
          moduleId: null,
        );
      case Mode.moduleEditionMode:
        return ModuleForm(
          modules: selectedModule,
          eleveRefController: eleveRefController,
          moduleClassController: moduleClassController,
          moduleDayDateController: moduleDayDateController,
          moduleDescriptionController: moduleDescriptionController,
          moduleNameController: moduleNameController,
          moduleNumController: moduleNumController,
          formKey: formKey,
          moduleId: ModuleScreen.modId,
        );
      default:
        return Container();
    }
  }
}
