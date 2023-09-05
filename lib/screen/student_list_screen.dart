import 'dart:html' as html; // window.reload.location.reload();

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/widget/devoir_test_widget.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/widget/student_list_widget.dart';
import '../widget/app_button_widget.dart';

enum Mode
{
  student,
  module
}

class StudentListScreen extends StatefulWidget {
  StudentListScreen({super.key});

  static const routeName = '/student_list_screen';

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

  @override
  Widget build(BuildContext context) {

    widget.modeScreens[Mode.student] = StudentListWidget(arguments: ModalRoute.of(context)?.settings.arguments);


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
        body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Row(children: [
                AppButtonWidget(func: (){setState(() { widget.mode = Mode.student; });}, text: 'Eleves'),
                AppButtonWidget(func: (){setState(() { widget.mode = Mode.module; });}, text: 'Devoirs/Tests')
              ]),
            ),            
            Flexible(child: widget.modeScreens[widget.mode]!),
            Container(width: 900)
          ],
        ),
      ),),
    );
  }
}
