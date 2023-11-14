import 'package:flutter/material.dart';
import 'package:module_repository/module_repository.dart';

import '../enum/mode.dart';
import '../screen/module_screen.dart';

class ModuleForm extends StatefulWidget {
  ModuleForm({
    super.key,
    required this.modules,
    required this.eleveRefController,
    required this.moduleClassController,
    required this.moduleDayDateController,
    required this.moduleDescriptionController,
    required this.moduleNameController,
    required this.moduleNumController,
    required this.formKey,
    required this.moduleId,
  });

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Module modules;
  TextEditingController moduleNumController = TextEditingController();
  TextEditingController moduleNameController = TextEditingController();
  TextEditingController moduleDescriptionController = TextEditingController();
  TextEditingController moduleDayDateController = TextEditingController();
  TextEditingController moduleClassController = TextEditingController();

  TextEditingController eleveRefController = TextEditingController();

  String? moduleId;

  @override
  State<ModuleForm> createState() => _ModuleFormState();
}

class _ModuleFormState extends State<ModuleForm> {
  @override
  Widget build(BuildContext context) {
    return form();
  }

  Widget form({String? moduleId}) {
    GlobalKey<FormState> formKey = widget.formKey;
    Module modules = widget.modules;
    TextEditingController moduleNumController = widget.moduleNumController;
    TextEditingController moduleNameController = widget.moduleNameController;
    TextEditingController moduleDescriptionController =
        widget.moduleDescriptionController;
    TextEditingController moduleDayDateController =
        widget.moduleDayDateController;
    TextEditingController moduleClassController = widget.moduleClassController;

    TextEditingController eleveRefController = widget.eleveRefController;

    if (moduleId != null) {
      final moduleParam = modules;
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
            onPressed: () {
              moduleClassController.text = "";
              moduleDayDateController.text = "";
              moduleDescriptionController.text = "";
              moduleNumController.text = "";
              setState(() => ModuleScreen.mode = Mode.none);
            },
            icon: const Icon(Icons.close),
            color: Colors.red),
        Form(
          key: formKey,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                returnIfIsAddition(),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(children: [
                    const Text('Description du module'),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        initialValue: moduleDescriptionController.text,
                        decoration: const InputDecoration(
                            hintText: 'ex. Le design thinking',
                            border: OutlineInputBorder()),
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
                            border: OutlineInputBorder()),
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
                            border: OutlineInputBorder()),
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
                      if (formKey.currentState!.validate()) {
                        Module module = Module(
                          nom: moduleNameController.text,
                          description: moduleDescriptionController.text,
                          horaire: moduleDayDateController.text,
                          classe: moduleClassController.text,
                          eleve: [],
                        );

                        if (moduleId == null) {
                          await FirebaseModuleRepository.instance
                              .create(module: module);
                        } else {
                          await FirebaseModuleRepository.instance
                              .update(module);
                        }

                        const SnackBar alert = SnackBar(
                            content: Text('module ajouté avec succés!'));
                        ScaffoldMessenger.of(context).showSnackBar(alert);

                        setState(() {
                          ModuleScreen.mode = Mode.none;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 18),
                        child: Text(
                            ModuleScreen.mode == Mode.moduleAdditionMode
                                ? "Ajouter"
                                : "Modifier",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ],
    ));
  }

  Widget returnIfIsAddition() {
    if (ModuleScreen.mode != Mode.moduleAdditionMode) {
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
            initialValue: widget.moduleNameController.text,
            decoration: const InputDecoration(
                hintText: 'ex. ICH-123', border: OutlineInputBorder()),
            onChanged: (value) {
              widget.moduleNameController.text = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un numero';
              } else if ((value.split('-').length != 2) ||
                  int.parse(value.split('-')[1]) == null) {
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
