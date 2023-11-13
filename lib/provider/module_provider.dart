import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/models/module.dart';

import '../enum/mode.dart';

class ModuleProvider with ChangeNotifier{
  
  final List<Module> _modules = [];
  final List<Module> _pendingModules = [];

  // ModuleProvider(this.service);
  // Service service;

  List<Module> get modules => [..._modules].reversed.toList();
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

  Future<void> createOrUpdateModule(Module module, Mode mode) async{
    List<Eleve> listEleve = [];
    List<EleveReference> listRef = [];
    if(mode == Mode.moduleEditionMode){
      final data = await FirebaseDBService.instance.getAllEleveFromOneModule(module.nom);
      listEleve = data;
      for (var v in listEleve) {
        listRef.add(new EleveReference(id: v.id));
      }
    }
    module.eleve = listRef;
    await FirebaseDBService.instance.addOrUpdateModule(module);
    if(mode == Mode.moduleAdditionMode){
      _modules.add(module);
    }
    notifyListeners();
  }

  Future<void> editModule(Module module) async{
    await FirebaseDBService.instance.addOrUpdateModule(module);
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

  Future<void> addModuleFromJson(String json) async {
    var data = await FirebaseDBService.instance.addModuleFromJson(json);
    if(data != null){
      _modules.addAll(data);
    }
    notifyListeners();
  }

  Future<void> addModuleFromCsv(String csv) async {
    var data = await FirebaseDBService.instance.addModuleFromCsv(csv);
    _modules.addAll(data);
    notifyListeners();
  }
}