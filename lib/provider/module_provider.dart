import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/module.dart';

class ModuleProvider with ChangeNotifier{
  
  final List<Module> _modules = [];
  final List<Module> _pendingModules = [];

  // ModuleProvider(this.service);
  // Service service;

  List<Module> get modules => [..._modules];
  List<Module> get pendingModules => [..._pendingModules];

  Future<void> fetchAndSetModules() async {
    _modules.clear();
    final data = await FirebaseDBService.instance.getAllModule();
    _modules.addAll(data);
    notifyListeners();
  }

  Future<void> fetchAndSetPendingModules() async{
    _pendingModules.clear();
    final data = await FirebaseDBService.instance.getAllPendingModules();
    _pendingModules.addAll(data);
    notifyListeners();
  }

  Future<void> createPendingModule(Module module) async
  {
    await FirebaseDBService.instance.addPendingModule(module);
    _pendingModules.add(module);
    notifyListeners();
  }

  Future<void> editPendingModule(Module module) async
  {
    await FirebaseDBService.instance.addPendingModule(module);
    for (var v in _pendingModules) {
      if (v.nom == module.nom) {
        v = module;
      }
    }
    notifyListeners();
  }

  Future<void> removePendingModule(Module module) async
  {
    await FirebaseDBService.instance.removePendingModule(module);
    _pendingModules.removeWhere((element) => element.nom == module.nom);
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