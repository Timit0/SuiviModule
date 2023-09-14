import 'dart:html' as html;
import 'dart:js_interop';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/models/test.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';

import '../infrastructure/firebase_db_service.dart';

enum Kind
{
  big,
  small
}

class StudentCard extends StatefulWidget {
  StudentCard({super.key, required this.eleve, this.dbInstance, this.kind = Kind.big, required this.moduleId});

  final Eleve eleve;
  final String moduleId;
  FirebaseDBService? dbInstance;

  @override
  State<StudentCard> createState() => _StudentCardState();

  Color? studentRemoveButtonBackgroundColor;
  Color studentRemoveButtonForegroundColor = Colors.red;

  Kind kind;
}

class _StudentCardState extends State<StudentCard> {
  late BuildContext context;
  
  
  void studentRemoveOnHoverDesignChange(PointerEvent e)
  {
    setState(() {
      widget.studentRemoveButtonBackgroundColor = Colors.red;
      widget.studentRemoveButtonForegroundColor = Colors.white;
    });
  }

  void studentRemoveOnExitDesignChange(PointerEvent e)
  {
    setState(() {
      widget.studentRemoveButtonForegroundColor = Colors.red;
      widget.studentRemoveButtonBackgroundColor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Card(
        color: const Color.fromARGB(255, 216, 216, 216),
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SizedBox(
          child: Expanded(
            child: Row(children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    Container(color: const Color.fromARGB(255, 110, 110, 110)),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.eleve.photoFilename,
                        placeholder: (context, url) => Image.asset('assets/img/placeholderImage.png'),
                        errorWidget: (context, url, error) => Image.asset('assets/img/errorImage.png'),
                        width: 50,
                      ),
                    )
                  ] 
                ),
              ),
              Column(children: [
                Text('${widget.eleve.firstname} ${widget.eleve.name}', style: const TextStyle(fontSize: 36)),
                Text(Provider.of<ModuleProvider>(context).getModuleFromId(widget.moduleId).classe)
              ])
            ],),
          ),
        ),
      )
    );
  }

  void gonOnDetailStudentScreen(BuildContext context){
    Navigator.of(context).pushNamed(DetailsStudentScreen.routeName, arguments: Eleve(
      id: widget.eleve.id, 
      name: widget.eleve.name, 
      firstname: widget.eleve.firstname, 
      photoFilename: widget.eleve.photoFilename,),
    );
  }
}
