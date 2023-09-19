import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
//import 'package:suivi_de_module/widget/student_list_widget.dart';

class ModuleWidget extends Module{
  ModuleWidget({
    required super.nom, 
    required super.description, 
    required super.horaire, 
    required super.classe, 
    required super.eleve,
    required this.editionBehavior
  });

  late BuildContext context;

  void Function()? editionBehavior;

  void setContext(BuildContext context){
    this.context = context;
  }


  //final String nom;
  String textEleve(int x){
    if(x >= 2)
      return "Elèves";
    else
      return "Elève";
  }


  Widget buildWidget(BuildContext context, int index) {
    this.context = context;

    final provider = Provider.of<ModuleProvider>(context);

    String classNumb = "";
    // Future<int> asyncValue = provider.getLengthFromAllEleveFromOneModule(provider.modules[index].nom);
    // asyncValue = asyncValue.then((value) {
    //   return (value);
    // });

    classNumb = " (0 Elève)";
    try{
      // print("${provider.modules[index].eleve!.first}");
      // print("${provider.modules[index].nom} : ${provider.modules[index].eleve!.length}");
      classNumb = " (${provider.modules[index].eleve?.length} ${textEleve(provider.modules[index].eleve!.length)})";
    }catch(e){}
    classe += classNumb;

    return Card(
      color: const Color.fromARGB(255, 216, 216, 216),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
    
          Expanded(  
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.only(left: 50, right: 50),
                    alignment: Alignment.center,
                    child: Text(
                      classe,
                      style: const TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(children: [
                  IconButton(onPressed: () => editionBehavior!.call(), icon: const Icon(Icons.edit, size: 50)),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: IconButton(onPressed: (){
                      Provider.of<ModuleProvider>(context, listen: false).removeModule(moduleNom: nom);
                    }, icon: const Icon(Icons.delete, size: 50)),
                  ),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
