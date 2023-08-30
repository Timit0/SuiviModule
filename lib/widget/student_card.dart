import 'dart:html' as html;
import 'dart:js_interop';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/eleve.dart';

import '../infrastructure/firebase_db_service.dart';

class StudentCard extends StatelessWidget {
  StudentCard({super.key, required this.eleve, this.dbInstance});

  final Eleve eleve;

  FirebaseDBService? dbInstance;

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: (){
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
                      if (!dbInstance.isNull)
                      {
                        dbInstance!.removeEleve(eleve);
                      }

                      Navigator.of(context).pop();
                      html.window.location.reload();
                    }, child: const Text('Oui')),
                    TextButton(onPressed:() => Navigator.of(context).pop(), child: const Text('Non'))
                    ]),
                )
              ]),
            ));
          }, icon: const Icon(Icons.close, color: Colors.red)),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ClipOval(
          child: CachedNetworkImage(imageUrl: "https://pbs.twimg.com/profile_images/945853318273761280/0U40alJG_400x400.jpg",
            width: 100.0,
            height: 100.0,
            placeholder: (context, url) => Image.asset("assets/img/placeholderImage.png"),
            errorWidget: (context, url, error) => Image.asset("assets/img/errorImage.png"),
          ),
        ),
      ),
      Text(eleve.firstname),
      Text(eleve.name)
    ]));
  }
}
