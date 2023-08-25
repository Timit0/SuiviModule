import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/infrastructure/service.dart';
import 'package:suivi_de_module/models/module.dart';

class ModuleProvider with ChangeNotifier{
  final List<Module> _modules = [];

  ModuleProvider(this.service);
  Service service;

  List<Module> get modules{
    return [..._modules];
  }

  Future<void> fetchAndSetModules() async {
    _modules.clear();
    final data = await FirebaseDbService.instance.getAll();
    _modules.addAll(data);
    notifyListeners();
  }

  Future<void> createModule(Module module) async{
    await FirebaseDbService.instance.addModule(module);
    _modules.add(module);
    notifyListeners();
  }

  Future<void> editModule(Module module) async{
    await FirebaseDbService.instance.addModule(module);
    for(var v in _modules){
      if(v.nom == module.nom){
        v = module;
      }
    }
    notifyListeners();
  }
}