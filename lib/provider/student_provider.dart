import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/models/module.dart';

import '../models/eleve.dart';

class StudentProvider with ChangeNotifier
{
  final List<Eleve> _eleves = [];

  List<Eleve> get eleves => [..._eleves];

  final List<Eleve> _allEleves = [];

  List<Eleve> get allEleves => [..._allEleves];

  String? _module;



  ///fetch and set students, this function return himself
  Future<void> fetchAndSetStudents(String moduleID) async
  {
    _eleves.clear();
    final data = await FirebaseDBService.instance.getAllEleveFromOneModule(moduleID);
    _eleves.addAll(data);
    notifyListeners();
  }

  Future<void> fetchAndSetStudentsWithoutClearList(String moduleID) async {
    final data = await FirebaseDBService.instance.getAllEleveFromOneModule(moduleID);
    _eleves.addAll(data);
    //print(eleves.length);
    notifyListeners();
  }

  void clearList(){
    _eleves.clear();
  }

  Eleve getEleveFromId(String eleveId) {
    return _eleves.where((element) => element.id == eleveId).first;
  }

  Future<void> fetchAndSetAllStudents() async
  {
    _allEleves.clear();
    final data = await FirebaseDBService.instance.getAllEleves();
    _allEleves.addAll(data);
    notifyListeners();
  }

  Future<void> createEleve(Eleve eleve, String moduleID) async
  {
    await FirebaseDBService.instance.addEleve(eleve, moduleID);
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

  Future<void> createOrAddOneEleve(Eleve eleve) async {
    bool edit = false;
    await FirebaseDBService.instance.createOrEditOneEleve(eleve);
    for (var v in _allEleves) {
      if(eleve.id == v.id){
        v = eleve;
        edit = true;
      }
    }
    if(!edit){
      _allEleves.add(eleve);
    }
    notifyListeners();
  }

  Future<void> removeEleveAndRef(Eleve eleve) async{
    await FirebaseDBService.instance.removeEleveAndRef(eleve);
    _allEleves.removeWhere((element) {
      return element.id == eleve.id;
    },);

    notifyListeners();
  }

  Future<void> removeEleveFromOneModule(String eleveReferenceId, String moduleId) async{
    await FirebaseDBService.instance.removeEleveRefOnModule(eleveReferenceId, moduleId);
    _eleves.removeWhere((element) => element.id == eleveReferenceId);
    notifyListeners();
  }

  Future<int> getNumberOfStudentInThisModule(String moduleName)async{
    List<Eleve> eleves = await FirebaseDBService.instance.getAllEleveFromOneModule(moduleName);
    return eleves.length;
  }

  Future<void> addEleveRefToModule(String moduleId, String eleveRef) async{
    await FirebaseDBService.instance.addEleveRefToModule(moduleId, eleveRef);
    notifyListeners();
  }
}