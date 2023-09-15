import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/models/module.dart';

class ModuleProvider with ChangeNotifier{
  
  final List<Module> _modules = [];
  final List<Module> _pendingModules = [];

  // ModuleProvider(this.service);
  // Service service;

  List<Module> get modules => [..._modules];
  List<Module> get pendingModules => [..._pendingModules];

  Module getModuleFromId(String moduleID) => _modules.where((element) => element.nom == moduleID).first;
  
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

  int _moduleLength = 0;
  int get moduleLength => _moduleLength;
  Future<void> getLengthFromAllEleveFromOneModule(String s) async{
    _moduleLength = 0;
    final list = await FirebaseDBService.instance.getAllEleveFromOneModule(s);
    _moduleLength = list.length;
    //return list.length;
  }

  Future<void> addModuleFromJson(String json) async {
    await FirebaseDBService.instance.addModuleFromJson(json);
    // if(data != null){
    //   _modules.addAll(data);
    // }
    notifyListeners();
  }

  Future<void> addModuleFromCsv(String csv) async {
    await FirebaseDBService.instance.addModuleFromCsv(csv);
    //_modules.addAll(data);
    notifyListeners();
  }
}