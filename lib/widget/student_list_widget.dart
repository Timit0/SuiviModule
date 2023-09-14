import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutterwebapp_reload_detector/flutterwebapp_reload_detector.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/widget/program_action_button.dart';
import 'package:suivi_de_module/widget/student_card.dart';

import '../infrastructure/firebase_db_service.dart';
import '../models/eleve.dart';
import '../provider/student_provider.dart';
import '../screen/details_student_screen.dart';

class StudentListWidget extends StatefulWidget {
  StudentListWidget({super.key, required this.arguments});

  List<Eleve> studentList = [];

  final db = FirebaseDBService.instance;

  final arguments;

  bool loaded = false;

  String tempID = "";
  String tempName = "";
  String tempNickname = "";
  String tempPhotoUrl = "";

  bool valid = true;

  @override
  State<StudentListWidget> createState() => _StudentListWidgetState();
}

class _StudentListWidgetState extends State<StudentListWidget> {

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    // widget.loaded = false;

    

    if (_isInit)
    {
      _isLoading = true;

      // debug
      // print(arguments.toString());
      await Provider.of<StudentProvider>(context, listen: false).fetchAndSetStudents(widget.arguments.toString());
      await Provider.of<StudentProvider>(context, listen: false).fetchAndSetAllStudents();
      
      print(widget.arguments.toString());

      _isInit = true;
      setState(() {
        _isLoading = false;
      });
      
      WebAppReloadDetector.onReload((){setState(() {
        Navigator.of(context).pop();
      });}); 
    }

    _isInit = false;
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    return Scaffold(
      body: _isLoading ? const Center(child: Text('Chargement en cours...')) : Center(
        child: SizedBox(
          width: 900,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: provider.eleves.length < 2 ? 1 : provider.eleves.length,
              childAspectRatio: provider.eleves.length == 1 ? (.9/.5) : 1,
              mainAxisSpacing: 100
            ),
            itemCount: provider.eleves.length, 
            itemBuilder: (context, index) => InkWell(onTap: () {
              Navigator.of(context).pushNamed(DetailsStudentScreen.routeName, arguments:{
                'eleve': provider.eleves[index],
                'module': widget.arguments
                }
              );
            }, child: StudentCard(moduleId: widget.arguments.toString(), eleve: provider.eleves[index], dbInstance: widget.db, kind: provider.eleves.length < 3 ? Kind.big : Kind.small, deleteButtonBehavios: (){}, detailButtonBehavior: (){},))),
        )
      ),
      floatingActionButton: ProgramActionButton(func: () {
          showDialog(context: context, builder: (context) => StatefulBuilder( // afin qu'on puisse faire un setState mais QUE pour ce widget - là
            builder:(context, setState) => AlertDialog(
            scrollable: true,
            title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Ajout d\'un élève'), IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close))]),
            content: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [const Text('identifiant', textAlign: TextAlign.left), Padding(padding: const EdgeInsets.only(left: 8, bottom: 8), child: SizedBox(width: 300, child: TextField(onChanged: (value) {widget.tempID = value;}, decoration: const InputDecoration(border: OutlineInputBorder()))))]),
              TextButton(onPressed: () {
                provider.fetchAndSetStudents(widget.arguments.toString());
                for (var v in provider.allEleves) {
                  if (v.id == widget.tempID)
                  {
                    Eleve newEleve = Eleve(id: widget.tempID, name: widget.tempName, firstname: widget.tempNickname, photoFilename: widget.tempPhotoUrl == "" ? "assets/img/placeholderImage.png" : widget.tempPhotoUrl);

                    widget.valid = true;
      
                    provider.createEleve(newEleve, widget.arguments.toString());
      
                    // vue qu'on fait sur le web
                    html.window.location.reload();
                  }
                  else
                  {        
                    setState(() {
                      widget.valid = false;
                    });
                  }
                
                }
              }, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey), foregroundColor: MaterialStateProperty.all(Colors.white)), child: const Text('OK')),
              Text((widget.valid == false ? 'L\'identifiant, doit être remplit!' : ''), style: const TextStyle(color: Colors.red))
            ])
                ),
          ));
      }, icon: Icons.person_add)
    );
  }
}