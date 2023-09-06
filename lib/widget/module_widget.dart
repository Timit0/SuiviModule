import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/student_list_screen.dart';

class ModuleWidget extends Module{
  ModuleWidget({
    required super.nom, 
    required super.description, 
    required super.horaire, 
    required super.classe, 
    required super.eleve,
  });

  late BuildContext context;

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
      classNumb = " (${provider.modules[index].eleve?.length} ${textEleve(provider.modules[index].eleve!.length)})";
    }catch(e){}
    print("Index : $index, classNumb :${classNumb}");
    classe += classNumb;

    return Draggable(
      data: Module(nom: nom, description: description, horaire: horaire, classe: classe, eleve: eleve),
      feedback: Card(
          color: Color.fromARGB(255, 216, 216, 216),
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
                              fontSize: 35
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
              Padding(
                padding: EdgeInsets.only(left: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nom, style: const TextStyle(fontSize: 30),),
                    Text(description, 
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    ),
                    Text(horaire)
                  ],
                ),
              ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 100, right: 100),
              //   child: Column(
              //     children: [
              //       Text("45%",
              //         style: TextStyle(fontSize: 25),
              //       ),
              //     ],
              //   ),
              // ),
      
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  classe,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      childWhenDragging: Card(
        color: Color.fromARGB(255, 216, 216, 216),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 216, 216, 216),
                Color.fromARGB(255, 90, 90, 90),
                //Color.fromARGB(255, 216, 216, 216),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(StudentListScreen.routeName, arguments: this.nom);
        },
        child: Card(
          color: Color.fromARGB(255, 216, 216, 216),
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
                              fontSize: 35
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
              Padding(
                padding: EdgeInsets.only(left: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nom, style: const TextStyle(fontSize: 30),),
                    Text(description, 
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    ),
                    Text(horaire)
                  ],
                ),
              ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 100, right: 100),
              //   child: Column(
              //     children: [
              //       Text("45%",
              //         style: TextStyle(fontSize: 25),
              //       ),
              //     ],
              //   ),
              // ),
      
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  classe,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
