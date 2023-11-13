import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/mode.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/screen/module_screen.dart';
//import 'package:suivi_de_module/widget/student_list_widget.dart';
 
class ModuleWidget extends Module{
  static Mode? mode;
  bool? presentationMode = false;

  //static Mode mode;

  ModuleWidget({
    required super.nom, 
    required super.description, 
    required super.horaire, 
    required super.classe, 
    required super.eleve,
    required this.editionBehavior,
    this.presentationMode
  });

  late BuildContext context;

  void Function()? editionBehavior;

  void setContext(BuildContext context){
    this.context = context;
  }


  //final String nom;
  String textEleve(int x){
    if(x >= 2) {
      return "Elèves";
    } else {
      return "Elève";
    }
  }

  Widget buildWidget(BuildContext context, int index) {
    this.context = context;

    final provider = Provider.of<ModuleProvider>(context);

    String classNumb = "";

    classNumb = " (0 Elève)";
    try{
      classNumb = " (${provider.modules[index].eleve!.length} ${textEleve(provider.modules[index].eleve!.length)})";
    }catch(e){
    }
    classe += classNumb;
    
    editionBehavior = presentationMode == true ? (){} : () {
      if (mode != Mode.moduleEditionMode) {

        ModuleScreen.refreshInsideCode = () {
          ModuleScreen.mode = Mode.moduleEditionMode;
          ModuleScreen.modId = nom;
        };

        ModuleScreen.Refresh();
      }
      
    };

    return Card(
      color: const Color.fromARGB(255, 216, 216, 216),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    const SizedBox.expand(
                      child: ColoredBox(
                        color: Color.fromARGB(255, 110, 110, 110)
                      ),
                    ),
                    Center(
                      child: Text(
                        getOnlyNumbOfName(nom), 
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      )
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 150),
                    child: SizedBox.square(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(nom, style: const TextStyle(fontSize: 30),),
                          Text(description, 
                            style: const TextStyle(
                              fontSize: 20
                            ),
                          ),
                          Text(horaire),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        
        //TODO faire en sorte que le text soit responsive
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 300),
                child: Text(
                  classe,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                IconButton(onPressed: () => editionBehavior!.call(), icon: const Icon(Icons.edit, size: 30)),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: IconButton(onPressed: presentationMode == true ? (){} : (){
      
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text("Êtes - vous sûre de supprimer le module $nom?"),
                      content: SizedBox(
                        width: 10,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(onPressed: (){
                              Provider.of<ModuleProvider>(context, listen: false).removeModule(moduleNom: nom);
                              Navigator.of(context).pop();
                            }, child: const Text('oui', style: TextStyle(fontSize: 20))),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('non', style: TextStyle(fontSize: 20))
                            )
                          ]
                        ),
                      ),
                    ));
      
                    // TODO: a mettre lorsqu'on clique sur "oui"
                    //
                  }, icon: const Icon(Icons.delete, size: 30)),
                ),
              ])
            ],
          ),
        ],
      ),
    );
  }
}
