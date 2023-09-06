import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/devoir.dart';

class DevorProvider with ChangeNotifier
{
  final List<Devoir> _devoirs = [];

  List<Devoir> get devoirs => [..._devoirs];

  Future<void> fetchAndSetDevoirs(String moduleId) async
  {
    _devoirs.clear();
    final data = await FirebaseDBService.instance.getDevoirsFromModule(moduleId);
    _devoirs.addAll(data);
    notifyListeners();
  }

  Future<void> createDevoir(Devoir devoir, String moduleId) async
  {
    await FirebaseDBService.instance.addDevoir(devoir, moduleId);
    _devoirs.add(devoir);
    notifyListeners();
  }

  Future<void> editDevoir(Devoir devoir, String moduleId) async
  {
    await FirebaseDBService.instance.addDevoir(devoir, moduleId);
    
    for (var v in _devoirs)
    {
      if (v.id == devoir.id)
      {
        v = devoir;
      }
    }
    
    notifyListeners();
  }
}