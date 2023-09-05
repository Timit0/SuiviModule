import 'dart:html' as html; // window.reload.location.reload();

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwebapp_reload_detector/flutterwebapp_reload_detector.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/test.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/widget/devoir_test_widget.dart';
import 'package:suivi_de_module/widget/program_action_button.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/widget/student_list_widget.dart';
import '../widget/app_button_widget.dart';

import '../widget/student_card.dart';

import 'package:suivi_de_module/models/eleve.dart';

enum Mode
{
  student,
  module
}

class StudentListScreen extends StatefulWidget {
  StudentListScreen({super.key});

  static const routeName = '/student_list_screen';

  // final db = FirebaseDBService.instance;

  // bool loaded = false;
  // List<Eleve> studentList = [];

  final _formKey = GlobalKey();

  // String tempID = "";
  // String tempName = "";
  // String tempNickname = "";
  // String tempPhotoUrl = "";

  // bool valid = true;

  Mode mode = Mode.student;

  Map<Mode, Widget?> modeScreens = {
    Mode.student: null /*StudentListWidget()*/,
    Mode.module: DevoirTestWidget()
  };

  Map<Mode, String> appBarTitles = {
    Mode.student : 'Eleves',
    Mode.module : 'Devoirs/tests'
  };


  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {

  // @override
  // void didChangeDependencies() async {
  //   // widget.loaded = false;
    
  //   // final arguments = ModalRoute.of(context)?.settings.arguments;

    

  //   if (!widget.loaded)
  //   {
  //     // debug
  //     // print(arguments.toString());
  //     widget.studentList = [];
  //     widget.studentList = await widget.db.getAllEleves(arguments.toString());
  //     setState(() {
  //       widget.loaded = true;
  //     });
      
  //     WebAppReloadDetector.onReload((){setState(() {
  //       Navigator.of(context).pop();
  //     });}); 
  //   }
    
  //   super.didChangeDependencies();
  // }



  @override
  Widget build(BuildContext context) {

    widget.modeScreens[Mode.student] = StudentListWidget(arguments: ModalRoute.of(context)?.settings.arguments);

    //final provider = Provider.of<StudentProvider>(context);
    //final arguments = ModalRoute.of(context)?.settings.arguments;


    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.appBarTitles[widget.mode]!, style: const TextStyle(color: Colors.white)),
          centerTitle: true,
          foregroundColor: Colors.white
          ,
          backgroundColor: Colors.grey,
        ),
        body: /*!widget.loaded ? const Center(child: Text('Chargement en cours...')) :*/ Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Row(children: [
                /*Card(
                  color: const Color.fromARGB(255, 189, 189, 189), 
                  elevation: 1, 
                  child: TextButton(onPressed: () => setState(() => widget.mode = Mode.student), 
                  child: const Text('Eleves', style: TextStyle(color: Colors.white)))
                ),*/
                AppButtonWidget(func: (){setState(() { widget.mode = Mode.student; });}, text: 'Eleves'),
                //TextButton(onPressed: () => setState(() => widget.mode = Mode.module), child: const Text('Devoirs/Tests'))
                AppButtonWidget(func: (){setState(() { widget.mode = Mode.module; });}, text: 'Devoirs/Tests')
              ]),
            ),
            /*Container(width: 900),*/
            
            Flexible(child: widget.modeScreens[widget.mode]!),

            /*Center(
              child: SizedBox(
                width: 900,
                child: GridView.builder(
                  shrinkWrap: true,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (widget.studentList.length < 3) ? 2 : widget.studentList.length, 
                    mainAxisSpacing: 100
                  ),
                  itemCount: widget.studentList.length, 
                  itemBuilder: (context, index) => InkWell(onTap: () {
                    Navigator.of(context).pushNamed(DetailsStudentScreen.routeName, arguments:{
                      'eleve': widget.studentList[index],
                      'module': arguments
                      }
                    );
                  }, child: StudentCard(eleve: widget.studentList[index], dbInstance: widget.db, kind: widget.studentList.length < 3 ? Kind.big : Kind.small,))),
              ),
            )*/
            Container(width: 900)
          ],
        ),
      ),),
    );
  }
}
