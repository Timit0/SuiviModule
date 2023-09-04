import 'dart:html' as html;
import 'dart:js_interop';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';

import '../infrastructure/firebase_db_service.dart';

enum Kind
{
  big,
  small
}

class StudentCard extends StatefulWidget {
  StudentCard({super.key, required this.eleve, this.dbInstance, this.kind = Kind.big});

  final Eleve eleve;
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
    return Card(child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MouseRegion(
            onHover: (event) => studentRemoveOnHoverDesignChange(event),
            onExit: (event) => studentRemoveOnExitDesignChange(event),
            child: Stack(
              children: [Container(
                width: widget.kind == Kind.big ? 70 : 30, 
                height: widget.kind == Kind.big ? 70 : 30, decoration: BoxDecoration(color: widget.studentRemoveButtonBackgroundColor)), IconButton(onPressed: (){
                showDialog(context: context, builder:(context) => AlertDialog(scrollable: true,
                  content: Column( children: [
                    const Icon(Icons.help, size: 50),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('Souhaitez - vous retirer cet élève?'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        TextButton(onPressed:() {
                          if (!widget.dbInstance.isNull)
                          {
                            widget.dbInstance!.removeEleve(widget.eleve);
                          }
                      
                          Navigator.of(context).pop();
                          html.window.location.reload();
                        }, child: const Text('Oui')),
                        TextButton(onPressed:() => Navigator.of(context).pop(), child: const Text('Non'))
                        ]),
                    )
                  ]),
                ));
              }, icon: Padding(
                padding: EdgeInsets.all(widget.kind == Kind.big ? 8.0 : 0),
                child: Icon(
                  Icons.close,
                  color: widget.studentRemoveButtonForegroundColor,
                  size: widget.kind == Kind.big ? 40 : 30
                ),
              ))],
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: widget.kind == Kind.big ? 10 : 0),
        child: ClipOval(
          child: CachedNetworkImage(imageUrl: "https://pbs.twimg.com/profile_images/945853318273761280/0U40alJG_400x400.jpg",
            width: widget.kind == Kind.big ? 100.0 : 70.0,
            height: widget.kind == Kind.big ? 100.0 : 70.0,
            placeholder: (context, url) => Image.asset("assets/img/placeholderImage.png"),
            errorWidget: (context, url, error) => Image.asset("assets/img/errorImage.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: widget.kind == Kind.small ? 18.0 : 0),
        child: Text('${widget.eleve.firstname} ${widget.eleve.name}', style: TextStyle(fontSize: widget.kind == Kind.big ? 50 : 20)),
      ),
      Text(widget.eleve.id, style: const TextStyle(fontSize: 20))
    ]));
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
