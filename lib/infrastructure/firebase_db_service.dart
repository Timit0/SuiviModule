import 'dart:developer' as dev;
import 'dart:js_interop';

import 'package:csv/csv.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:suivi_de_module/models/devoir.dart';
import 'package:suivi_de_module/models/devoir_reference.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/models/test.dart';
import 'package:suivi_de_module/models/test_reference.dart';

class FirebaseDBService {


  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseDBService._();

  // singleton
  FirebaseDBService._() {
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _ref = db.ref();
  }

  final String testNode = "test";
  final String devoirNode = "devoir";
  final String modulePendingListNode = "pendingModule";

  Future<List<Module>> getAllPendingModules() async
  {
    final data = await _ref.child(modulePendingListNode).get();
    if (data.exists)
    {
      List<Module>? pendingMods = [];
      for (dynamic v in data.children)
      {
        pendingMods.add(Module.fromJson(v.value));
      }
      return pendingMods;
    }
    return [];
  }

  Future<List<Test?>> getAllTest(String idModule) async {
    final data = await _ref.child("$moduleNode/$idModule/$testNode").get();

    if(data.exists){
      List<Test>? test = [];

      for (dynamic v in data.children) {
        test.add(Test.fromJson(v.value));
      }
      
      return test;
    }
    return [];
  }

  Future<List<Devoir?>> getAllDevoir(String idModule) async {
    final data = await _ref.child("$moduleNode/$idModule/$devoirNode").get();

    if(data.exists){
      List<Devoir>? devoir = [];

      for (dynamic v in data.children) {
        
        devoir.add(Devoir.fromJson(v.value));
        
      }
      
      return devoir;
    }
    return [];
  }


  Future<Test?> getTest(String idTest, String idModule) async {
    final data = await _ref.child("$moduleNode/$idModule/$testNode/$idTest").get();

    if(data.exists){
      Test? test;

      Map<String, dynamic> map = {};
      for (dynamic v in data.children) {
        map[v.key] = v.value;
      }
      test = Test.fromJson(map);
      return test;
    }
  }

  Future<Devoir?> getDevoir(String idDevoir, String idModule) async {
    final data = await _ref.child("$moduleNode/$idModule/$devoirNode/$idDevoir").get();

    if(data.exists){
      Devoir? devoir;
      Map<String, dynamic> map = {};
      for (dynamic v in data.children) {
        
        map[v.key] = v.value;
        
      }
      devoir = Devoir.fromJson(map);
      return devoir;
    }
  }




  Future<List<TestReference>?> getTestsForOneStudent({required String studentId, required String moduleId}) async {
    final data = await _ref.child("$moduleNode/$moduleId/$eleveNode/$studentId/$testNode").get();
    
    if(data.exists){
      List<TestReference>? testList = [];
    
      for (dynamic v in data.children) {
        testList.add(TestReference.fromJson(v.value));
      }

      return testList;
    }
  }

   Future<List<DevoirReference>?> getDevoirsForOneStudent({required String studentId, required String moduleId}) async {
    final data = await _ref.child("$moduleNode/$moduleId/$eleveNode/$studentId/$devoirNode").get();
    
    if(data.exists){
      List<DevoirReference>? testList = [];
    
      for (dynamic v in data.children) {
        testList.add(DevoirReference.fromJson(v.value));
      }
      return testList;
    }
  }


  Future<Module> addPendingModule(Module module) async
  {
    await _ref.child("$modulePendingListNode/${module.nom}").update(module.toJson());
    return Module.base();
  }

  Future<Eleve> addEleve(Eleve eleve, String id) async {
    await _ref.child("$moduleNode/$id/$eleveNode/${eleve.id}").update(EleveReference(id: eleve.id).toJson());
    return Eleve.base();
  }

  Future<Eleve> createOrEditOneEleve(Eleve eleve) async {
    await _ref.child('$eleveNode/${eleve.id}').update(eleve.toJson());
    return eleve;
  }

  Future<Eleve> updateEleve(Eleve eleve) async {
    _ref
        .child('eleves/${eleve.id}')
        .update(eleve.toJson())
        .then((_) => null)
        .catchError((e) {
      dev.log(e);
    });

    return eleve;
  }

  Future<Module> updatePendingModule(Module module) async
  {
    _ref.child("$modulePendingListNode/${module.nom}").update(module.toJson()).then((value) => null).catchError((e) => dev.log(e));
    return module;
  }

  Future<void> removeEleveRefOnModule(String eleveReferenceId, String moduleId) async
  {
    await _ref.child("$moduleNode/$moduleId/$eleveNode/$eleveReferenceId").remove();
    //return module;
  }

  Future<void> addDevoir(Devoir devoir, String moduleId) async
  {
    await _ref.child("$moduleNode/$moduleId/$devoirNode/${devoir.id}").update(devoir.toJson());
  }

  Future<void> addTest(Test test, String moduleId) async
  {
    await _ref.child("$moduleNode/$moduleId/$testNode/${test.id}").update(test.toJson());
  }

  Future<void> removePendingModule(Module module) async
  {
    _ref.child("$modulePendingListNode/${module.nom}").remove().then((value) => null).catchError((e) => dev.log(e));
  }

  Future<void> removeEleve(Eleve eleve, String moduleId) async {
    _ref.child('$moduleNode/$moduleId/$eleveNode/${eleve.id}').remove().then((_) => null).catchError((e) {
      dev.log(e);
    });
  }

  Future<void> removeEleveAndRef(Eleve eleve) async{
    await _ref.child('$eleveNode/${eleve.id}').remove();
    try{
      List<Module> modules = await getAllModule();


      for (Module v in modules) {
        try{
          _ref.child("$moduleNode/${v.nom}/$eleveNode/${eleve.id}").remove();
        }catch(e){

        }
      }

    }catch(e){

    }
    
  }

  Future<List<Eleve>> getAllEleveFromOneModule(String id) async {
    final snapshot = await _ref.child('$moduleNode/$id/$eleveNode').get();

    if (snapshot.exists) {

      final eleveRefs = <EleveReference>[];
      final eleves = <Eleve>[];

      for (dynamic v in snapshot.children)
      {
        final tempID = v.key.toString();

        try{
          final DataSnapshot tempSnapshot = await _ref.child("$eleveNode/$tempID").get();

          eleves.add(Eleve.fromJson(tempSnapshot.value as Map<String, dynamic>));
        }catch(e){
          //TODO retour a letat de base
          //print(e);
        }
        
      }

      return eleves;
    }

    return [];
  }

  Future<List<Devoir>> getDevoirsFromModule(String moduleID) async
  {
    final snapshot = await _ref.child('$moduleNode/$moduleID/$devoirNode').get();
    if (snapshot.exists)
    {
      final devoirs = <Devoir>[];

      for (dynamic v in snapshot.children)
      {
        devoirs.add(Devoir.fromJson(v.value as Map<String, dynamic>));
      }

      return devoirs;
    }
    return [];
  }

  Future<List<Eleve>> getAllEleves() async {
    final snapshot = await _ref.child(eleveNode).get();

    if (snapshot.exists) {
      final eleves = <Eleve>[];

      for (dynamic v in snapshot.children)
      {
        final tempID = v.key.toString();

        final DataSnapshot tempSnapshot = await _ref.child("$eleveNode/$tempID").get();

        eleves.add(Eleve.fromJson(tempSnapshot.value as Map<String, dynamic>));
      }

      return eleves;
    }

    return [];
  }

  final String moduleNode = "module";
  final String eleveNode = "eleve";
  
  Future<List<Module>?> addModuleFromJson(String data) async {
    List<Module>? moduleList = [];
    // final data = await rootBundle.loadString("./json/module.json");
    List<dynamic> json = jsonDecode(data);
    for(int i = 0; i < json.length; i++){
      await _ref.child("$moduleNode/${json[i]["nom"]}").update(json[i]);
      moduleList.add(Module.fromJson(json[i]));
    }
    return moduleList;
  }

  Future<List<Module>> addModuleFromCsv(String data) async {
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(
      fieldDelimiter: ";",
    ).convert(data);
    
    List<Module> moduleList = [];
    for(int i = 1; i < rowsAsListOfValues.length; i++){
      final moduleArray = rowsAsListOfValues[i][4].split("|");

      

      List<EleveReference>? eleveReferenceList = [];
      for (var v in moduleArray) {
        eleveReferenceList.add(EleveReference(id: v));
      }


      moduleList.add(
        Module(
          nom: rowsAsListOfValues[i][0], 
          description: rowsAsListOfValues[i][1], 
          horaire: rowsAsListOfValues[i][2], 
          classe: rowsAsListOfValues[i][3], 
          eleve: eleveReferenceList,
        ),
      );
    }

    for(int i = 0; i < moduleList.length; i++){
      await _ref.child("$moduleNode/${moduleList[i].nom}").update(moduleList[i].fromCsvToJson());
    }

    return moduleList;
  }

  
  Future<List<Module>> getAllModule() async {
      final data = await _ref.child("$moduleNode/").get();

      if(data.exists){
 
        var modules = <Module>[];

        for(dynamic v in data.children){
          modules.add(Module.fromJson(v.value));
        }

        return modules;
      }
      return [];
  }
  

  Future<void> addModule(Module module) async {
    await _ref.child("$moduleNode/${module.nom}").update(module.toJson());
    await _ref.child("$moduleNode/${module.nom}").update({
      devoirNode: '',
      testNode: ''
    });
  }

  Future<void> removeModule(String id) async {
    await _ref.child('$moduleNode/$id').remove();
  }
  // ====================================================================================


  Future<void> addModuleDummy()async {
    List<Module>? moduleList = [];
    final data = await rootBundle.loadString("./json/module.json");
    List<dynamic> json = jsonDecode(data);
    for(int i = 0; i < json.length; i++){
      await _ref.child("$moduleNode/${json[i]["nom"]}").update(json[i]);
      moduleList.add(Module.fromJson(json[i]));
    }
  }
}