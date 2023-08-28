import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/eleve.dart';

class StudentCard extends StatelessWidget {
  StudentCard({super.key, required this.eleve});

  late Eleve eleve;

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: [
      Image.asset(eleve.photoFilename),
      Text(eleve.firstname),
      Text(eleve.name)
    ]));
  }
}
