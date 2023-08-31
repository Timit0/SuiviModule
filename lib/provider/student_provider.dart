import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';

import '../models/eleve.dart';

class StudentProvider with ChangeNotifier
{
  final List<Eleve> _eleves = [];

  List<Eleve> get eleves => [..._eleves];

  String? _module;

  Future<void> fetchAndSetModules(String moduleID) async
  {
    _eleves.clear();
    final data = await FirebaseDBService.instance.getAllEleves(moduleID);
    _eleves.addAll(data);
    notifyListeners();
  }

  Future<void> createEleve(Eleve eleve) async
  {
    await FirebaseDBService.instance.addEleve(eleve, _module!);
    _eleves.add(eleve);
    notifyListeners();
  }

  Future<void> editEleve(Eleve eleve) async
  {
    await FirebaseDBService.instance.addEleve(eleve, _module!);
    for (var element in _eleves) {
      if (element.id == eleve.id) { element = eleve; }
    }
    notifyListeners();
  }
}