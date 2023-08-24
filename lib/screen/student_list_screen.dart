import 'dart:html' as html; // window.reload.location.reload();

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

  final _formKey = GlobalKey();

  String tempID = "";
  String tempName = "";
  String tempNickname = "";
  String tempPhotoUrl = "";

  bool valid = true;

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
    ), floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(context: context, builder: (context) => StatefulBuilder( // afin qu'on puisse faire un setState mais QUE pour ce widget - là
          builder:(context, setState) => AlertDialog(
          scrollable: true,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Ajout d\'un élève'), IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close))]),
          content: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [const Text('identifiant', textAlign: TextAlign.left), Padding(padding: const EdgeInsets.only(left: 8, bottom: 8), child: SizedBox(width: 300, child: TextField(onChanged: (value) {widget.tempID = value;}, decoration: const InputDecoration(border: OutlineInputBorder()))))]),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [const Text('nom', textAlign: TextAlign.left), Padding(padding: const EdgeInsets.only(left: 8, bottom: 8), child: SizedBox(width: 300, child: TextField(onChanged: (value) {widget.tempName = value;}, decoration: const InputDecoration(border: OutlineInputBorder()))))]),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [const Text('prénom', textAlign: TextAlign.left), Padding(padding: const EdgeInsets.only(left: 8, bottom: 8), child: SizedBox(width: 300, child: TextField(onChanged: (value) {widget.tempNickname = value;}, decoration: const InputDecoration(border: OutlineInputBorder()))))]),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [const Text('URL de l\'image', textAlign: TextAlign.left), Padding(padding: const EdgeInsets.only(left: 8, bottom: 8), child: SizedBox(width: 300, child: TextField(onChanged: (value) {widget.tempPhotoUrl = value;}, decoration: const InputDecoration(border: OutlineInputBorder()))))]),
        
            TextButton(onPressed: () {
              if
              (
                widget.tempID != "" &&
                widget.tempName != "" &&
                widget.tempNickname != ""
              )
              {
                Eleve newEleve = Eleve(id: widget.tempID, name: widget.tempName, firstname: widget.tempNickname, photoFilename: widget.tempPhotoUrl == "" ? "assets/img/placeholderImage.png" : widget.tempPhotoUrl);
        
                widget.db.addEleve(newEleve);
                widget.valid = true;
                
                Navigator.of(context).pop();

                // vue qu'on fait sur le web
                html.window.location.reload();
              }
              else
              {        
                setState(() {
                  widget.valid = false;
                });
              }
            }, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey), foregroundColor: MaterialStateProperty.all(Colors.white)), child: const Text('OK')),
            Text((widget.valid == false ? 'L\'identifiant, Le nom ainsi que le prénom doient être remplit!' : ''), style: const TextStyle(color: Colors.red))
          ])
              ),
        ));
    }, backgroundColor: const Color.fromARGB(255, 73, 73, 73), child: const Icon(Icons.person_add)));
  }
}
