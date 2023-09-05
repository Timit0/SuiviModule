import 'dart:developer' as dev;

import 'package:firebase_database/firebase_database.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/models/module.dart';

class FirebaseDBService {


  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseDBService._();

  // singleton
  FirebaseDBService._() {
    db.useDatabaseEmulator(/*"10.0.2.2"*/ "127.0.0.1", 9000);
    _ref = db.ref();
  }

  // =================================| CRUD pour Eleve |=======================================
  Future<Eleve> addEleve(Eleve eleve, String id) async {

      await _ref.child("eleve/${eleve.id}").set(eleve.toJson());
      
      await _ref.child("$moduleNode/$id/$eleveNode/${eleve.id}").update(EleveReference.base().toJson());
      
    return Eleve.base();
    //return eleve;
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

  Future<void> removeEleve(Eleve eleve) async {
    _ref.child('eleves/${eleve.id}').remove().then((_) => null).catchError((e) {
      dev.log(e);
    });
  }

  Future<void> removeEleveAndRef(Eleve eleve) async{
    await _ref.child('$eleveNode/${eleve.id}').remove();
      print(eleve.id);
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

  Future<List<Eleve>> getAllFromOneModuleEleves(String id) async {
    final snapshot = await _ref.child('$moduleNode/$id/eleve').get();

    if (snapshot.exists) {

      final eleveRefs = <EleveReference>[];
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

  Future<List<Eleve>> getAllEleves() async {
    final snapshot = await _ref.child('$eleveNode').get();

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

  
  void addData() async {
    await _ref.child(moduleNode).remove();
    await _ref.child(eleveNode).remove();

    final data = await rootBundle.loadString("./json/module.json");
    List<dynamic> json = jsonDecode(data);

    final eleveData = await rootBundle.loadString("./json/eleve.json");
    List<dynamic> eleveJson = jsonDecode("[" + eleveData + "]"); // <-- si il y a une autre facon de le farie, ce serais cool :)

    for(int i = 0; i < json.length; i++){
      await _ref.child("$moduleNode/${json[i]["nom"]}").update(json[i]);
    }

    for(int i = 0; i < eleveJson.length; i++){
      await _ref.update(eleveJson[i]);
    }
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
  }

  Future<void> removeModule(String id) async {
    await _ref.child('$moduleNode/$id').remove();
  }
  // ====================================================================================
}