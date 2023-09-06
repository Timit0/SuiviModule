import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/module.dart';

class ModuleProvider with ChangeNotifier{
  final List<Module> _modules = [];

  // ModuleProvider(this.service);
  // Service service;

  List<Module> get modules{
    return [..._modules];
  }

  Future<void> fetchAndSetModules() async {
    _modules.clear();
    final data = await FirebaseDBService.instance.getAllModule();
    _modules.addAll(data);
    notifyListeners();
  }

  Future<void> createModule(Module module) async{
    await FirebaseDBService.instance.addModule(module);
    _modules.add(module);
    //fetchAndSetModules();
    notifyListeners();
  }

  Future<void> editModule(Module module) async{
    await FirebaseDBService.instance.addModule(module);
    for(var v in _modules){
      if(v.nom == module.nom){
        v = module;
      }
    }
    notifyListeners();
  }

  Future<void> removeModule({required String moduleNom}) async {
    await FirebaseDBService.instance.removeModule(moduleNom);
    _modules.removeWhere((element) => element.nom == moduleNom);
    notifyListeners();
  }

  Future<int> getLengthFromAllEleveFromOneModule(String s) async{
    final list = await FirebaseDBService.instance.getAllFromOneModuleEleves(s);
    return list.length;
  }
}