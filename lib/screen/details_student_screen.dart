// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterwebapp_reload_detector/flutterwebapp_reload_detector.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/devoir.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/models/card_state.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/models/test.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/provider/test_provider.dart';
import 'package:suivi_de_module/widget/moyenne_widget.dart';
import 'package:suivi_de_module/widget/avatar_widget.dart';
import 'package:suivi_de_module/widget/widget_card.dart';

import '../provider/test_and_devoir_provider.dart';


class DetailsStudentScreen extends StatefulWidget {
  const DetailsStudentScreen({super.key});

  static const routeName = '/details_student_screen';

  @override
  State<DetailsStudentScreen> createState() => _DetailsStudentScreenState();

}

class _DetailsStudentScreenState extends State<DetailsStudentScreen> {

  var _isInit = true;
  var _isLoading = false;

   @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
      Eleve args = arguments['eleve'] ?? Eleve.base();
      String module = arguments['module'] ?? "ICH-450";

      await Provider.of<TestAndDevoirProvider>(context, listen: false).getTestAndDevoirFromOneStudent(id: args.id, moduleId: module);
      await Provider.of<TestAndDevoirProvider>(context, listen: false).fetchAndSetDevoirAndTestForOneModule(module);

      //await Provider.of<StudentProvider>(context).fetchAndSetAllStudents();
      setState(() {
        _isLoading = false;
      });
    }


    WebAppReloadDetector.onReload(
      (){setState(() {
        Navigator.of(context).pop();
      });}
    );

    _isInit = false;
    
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    Eleve args = arguments['eleve'] ?? Eleve.base();
    String module = arguments['module'] ?? "ICH-450";


    final ScrollController controllerDevoir = ScrollController();
    final ScrollController controllerTest = ScrollController();
    final varDebug = 8;
    double paddingList = 50;

    WebAppReloadDetector.onReload((){setState(() {
      Navigator.of(context).pop();
    });}); 

    
    final provider = Provider.of<TestAndDevoirProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Devoir - Test",
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                children:[ 
                  SizedBox(
                    height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
                    width: 400,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 80, 80, 80),
                            Colors.grey
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    child: Column(
                      children: [
                      
                        Center(
                          child: AvatarWidget(photoUrl: args.photoFilename),
                        ),
                        Text(
                          args.firstname,//"Ogan",
                          style: const TextStyle(
                            fontSize: 45
                          ),
                        ),
                        Text(
                          args.name,//"Ozkul",
                          style: const TextStyle(
                            fontSize: 25
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 58.0),
                          child: MoyenneWidget(),
                        )
                      ], 
                    ),
                  ),
                ]
              ),
            ]
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 2
                        ),
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2
                        )
                      )
                    ),
                    child: Text(
                      Module.getOnlyNumbOfNameStatic(module), //ICH-322
                      style: TextStyle(
                        fontSize: 50
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: paddingList),
                      child: const Text(
                        "Devoirs",
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                    ),
                    listOf(CardState.Devoir, controllerDevoir, varDebug, paddingList, provider, module),
                    
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: paddingList),
                      child: const Text(
                        "Tests",
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                    ),
                    listOf(CardState.Test, controllerTest, varDebug, paddingList, provider, module),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget listOf(CardState cardState, ScrollController controller, int varDebug, double paddingList, TestAndDevoirProvider provider, String module){
    int listLength = 0;
    if(cardState == CardState.Devoir){
      listLength = provider.devoirsRef.length;
    }else{
      listLength = provider.testsRef.length;
    }
    return Padding(
      padding: EdgeInsets.only(left: paddingList, right: paddingList),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Scrollbar(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              controller: controller,
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              //padding: const EdgeInsets.all(15),
              itemCount: listLength,
              itemBuilder: (context, index) {
                return CardWidget(type: cardState, name: _getName(index, cardState, provider));
                
              },
            ),
          ),
        ),
      ),
    );
  }

  String _getName(int index, CardState cardState, TestAndDevoirProvider provider){
    if(cardState == CardState.Test){
      for (var v in provider.tests) {
        if(v!.id == provider.testsRef[index].id){
          return v.nom;
        }
      }
    }else{
      for (var v in provider.devoirs) {
        if(v!.id == provider.devoirsRef[index].id){
          return v.nom;
        }
      }
    }

    return "NULLLL";
  }

  Widget checkWidget(){
    bool checkState = false;
    return GestureDetector(
      onTap: () {
        if(checkState){
          checkState = false;
        }else{
          checkState = true;
        }
        print("Clik : "+checkState.toString());
        setState(() {
          
        });
      },
      child: SizedBox(
        height: 40,
        width: 40,
        child: Center(
          child: isChecked(checkState)
        ),
      ),
    );
  }

  Widget? isChecked(bool b){
    if(b){
      return const Icon(
        Icons.check,
        size: 40,
      );
    }else{
      return const ClipOval(
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.abc),
        ),
      );
    }

  }

  Widget addCard(){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (context) => AlertDialog(
          scrollable: true,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Ajout d\'un contenu'), IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close))]),
          content: Column(children: [
            // TODO: eventuellement a faire
          ]),
        ));
      },
      child: Card(
        elevation: 4,
        color: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const SizedBox(
              height: 230,
              width: 230,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                color: const Color.fromARGB(255, 201, 201, 201),
                child: const SizedBox(
                  width: 230,
                  height: 230,
                ),
              ),
            ),
            const Icon(
              Icons.add,
              size: 100,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}