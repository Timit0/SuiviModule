import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/eleve.dart';

class StudentCard extends StatelessWidget {
  StudentCard({super.key, required this.eleve});

  final Eleve eleve;

  @override
  Widget build(BuildContext context) {

    print(eleve.photoFilename);

    try
    {
    return Card(child: Column(children: [
      Image.network(eleve.photoFilename),
      Text(eleve.firstname),
      Text(eleve.name)
    ]));
    }
    catch (e)
    {
      return Card(child: Column(children: [
        Image.asset(Eleve.error().photoFilename),
        Text(Eleve.error().firstname),
        Text(Eleve.error().name)
      ]));
    }
  }
}
