import 'dart:js';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/provider/module_provider.dart';

import '../models/module.dart';

class PopUpModuleCreation{

  bool createNewModule = true;

  final TextEditingController getNom = TextEditingController();
  final TextEditingController getDescription = TextEditingController();
  final TextEditingController getHoraire = TextEditingController();
  final TextEditingController getClasse = TextEditingController();

  late BuildContext contextVar;

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    getNom.dispose();
    getDescription.dispose();
    getHoraire.dispose();
    getClasse.dispose();
  }

  Future popUp(BuildContext context) => showDialog(
    context: context, 
    builder: (context) {
      contextVar = context;
      return Padding(
        padding: const EdgeInsets.only(bottom: 450),
        child: AlertDialog(
          title: const Text(
            "Creéer un nouveau module / Modifier um module"
          ),
          content: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: getNom,
                  decoration: const InputDecoration(
                    hintText: "Nom du module ex : ICH-000"
                  ),
                  validator: (value) {
                    if(value.isNull){
                      return "La valeur ne peut pas etre null";
                    }
          
                    if(!value!.contains("-") || !value.contains("ICH")){
                      return "La valeur n'est pas juste ! Suivez l'exemple";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    var moduleProvider = Provider.of<ModuleProvider>(context,listen: false);
                    for(var v in moduleProvider.modules){
                      if(v.nom == value){
                        createNewModule = false;
                        return;
                      }else{
                        createNewModule = true;
                        return;
                      }
                    }
                  },
                ),
                TextFormField(
                  controller: getDescription,
                  decoration: const InputDecoration(
                    hintText: "description du module"
                  ),
                  validator: (value) {
                    if(value == ""){
                      return "La valeur ne peut pas être null";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: getHoraire,
                  decoration: const InputDecoration(
                    hintText: "horaire du module ex : Vendredi - 14:05 - 15:35"
                  ),
                  validator: (value) {
                    if(value == ""){
                      return "La valeur ne peut pas être null";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: getClasse,
                  decoration: const InputDecoration(
                    hintText: "classe du module ex : ICH-3"
                  ),
                  validator: (value) {
                    if(value == ""){
                      return "La valeur ne peut pas être null";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => createModule(context), 
              child: const Text("Créer")
            )
          ],
        ),
      );
    },
  );

  void createModule(BuildContext context) async{
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    var moduleProvider = Provider.of<ModuleProvider>(contextVar,listen: false);
    Module module = Module(
      nom: getNom.text, 
      description: getDescription.text, 
      horaire: getHoraire.text, 
      classe: getClasse.text,
      eleve: null,
    );

    if(createNewModule){
      moduleProvider.createModule(module);
    }else{
      moduleProvider.editModule(module);
    }
    
    Navigator.pop(contextVar);
    //dispose();
  }
}