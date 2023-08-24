import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';

import '../widget/student_card.dart';

import 'package:suivi_de_module/models/eleve.dart';

class StudentListScreen extends StatefulWidget {
  StudentListScreen({super.key});

  static const routeName = '/student_list_screen';

  final db = FirebaseDBService.instance;

  bool loaded = false;
  List<Eleve> studentList = [];

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {

  @override
  void didChangeDependencies() async {

    if (!widget.loaded)
    {
      widget.studentList.clear();
      widget.studentList = await widget.db.getAllEleves();
      setState(() {
        widget.loaded = true;
      });
    }
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: !widget.loaded ? const Center(child: Text('Chargement en cours...')) : Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: SizedBox(
          width: 900,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: widget.studentList.length, itemBuilder: (context, index) => StudentCard(eleve: widget.studentList[index])),
        ),
      ),
    ), );
  }
}
