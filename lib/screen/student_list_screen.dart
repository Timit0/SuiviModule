import 'dart:html' as html; // window.reload.location.reload();

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/widget/program_action_button.dart';
import 'package:suivi_de_module/provider/student_provider.dart';

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
    widget.loaded = false;
    
    final arguments = ModalRoute.of(context)?.settings.arguments;

    

    if (!widget.loaded)
    {
      // debug
      // print(arguments.toString());
      widget.studentList = [];
      widget.studentList = await widget.db.getAllEleves(arguments.toString());
      setState(() {
        widget.loaded = true;
      });
    }
    
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Placeholder", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          foregroundColor: Colors.white
          ,
          backgroundColor: Colors.grey,
        ),
        body: !widget.loaded ? const Center(child: Text('Chargement en cours...')) : Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Container(width: 900),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 900,
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    children: [GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (widget.studentList.length < 3) ? 2 : 4, mainAxisSpacing: 100),
                      itemCount: widget.studentList.length, itemBuilder: (context, index) => InkWell(onTap: () {
                        //StudentSummaryScreen.eleve = widget.studentList[index];

                        Navigator.of(context).pushNamed(DetailsStudentScreen.routeName, arguments: widget.studentList[index]);
                      }, child: StudentCard(eleve: widget.studentList[index], dbInstance: widget.db)))],
                  ),
                ),
              ),
            ),
            Container(width: 900)
          ],
        ),
      ), floatingActionButton: ProgramActionButton(func: () {
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
          
                  //widget.db.addEleve(newEleve);
                  widget.valid = true;
    
                  FirebaseDBService.instance.addEleve(newEleve, arguments.toString());
                  
                  // Navigator.of(context).pop();
    
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
      }, icon: Icons.person_add)),
    );
  }
}
