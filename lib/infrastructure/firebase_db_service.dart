import 'dart:developer' as dev;
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/infrastructure/service.dart';

class FirebaseDBService implements Service {
  // pour traiter les donnees de l'eleve -> /eleve
  // final url = 'http://10.0.2.2:9000/';
  // final dbName = '/?ns=suivimodule-default-rtdb';

  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseDBService._();

  // singleton
  FirebaseDBService._() {
    db.useDatabaseEmulator(/*"10.0.2.2"*/ "127.0.0.1", 9000);
    _ref = db.ref();
  }

  // =================================| CRUD pour Eleve|=================================
  Future<Eleve> addEleve(Eleve eleve, String id) async {
    _ref.child('$moduleNode/$id/eleve/${eleve.id}').set(eleve.toJson()).then((_) {
      return eleve.copyWith(id: eleve.id);
    }).catchError((e) {
      dev.log(e.toString());
      return Eleve.error();
    });

    return Eleve.base();
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

  Future<List<Eleve>> getAllEleves(String id) async {
    final snapshot = await _ref.child('$moduleNode/$id/eleve').get();

    if (snapshot.exists) {
      final eleves = <Eleve>[];

      for (dynamic v in snapshot.children) {
        final tempID = v.key.toString();
        final tempMap = v.value as Map<String, dynamic>;

        eleves.add(Eleve.fromJson(tempMap));

      }
      return eleves;
    }

    return [];
  }



  // final FirebaseDatabase db = FirebaseDatabase.instance;
  //late DatabaseReference _dbRef;
  final String moduleNode = "module";

  // static final instance = FirebaseDbService._();

  // FirebaseDbService._(){
  //   db.useDatabaseEmulator("127.0.0.1", 9000);
  //   _dbRef = db.ref();
  // }
  
  @override
  void addData() async {
    await _ref.child(moduleNode).remove();
    final data = await rootBundle.loadString("./json/module.json");
    List<dynamic> json = jsonDecode(data);

    for(int i = 0; i < json.length; i++){
      await _ref.child("$moduleNode/${json[i]["nom"]}").update(json[i]);
    }
  }

  @override
  Future<List<Module>> getAll() async {
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
  

  @override
  Future<void> addModule(Module module) async {
    await _ref.child("$moduleNode/${module.nom}").update(module.toJson());
  }
  // ====================================================================================
}
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/services.dart';
// import 'package:suivi_de_module/infrastructure/service.dart';

// import 'dart:convert';

// import 'package:suivi_de_module/models/module.dart';

// class FirebaseDbService implements Service{
  
//   final FirebaseDatabase db = FirebaseDatabase.instance;
//   late DatabaseReference _dbRef;
//   final String moduleNode = "module";

//   static final instance = FirebaseDbService._();

//   FirebaseDbService._(){
//     db.useDatabaseEmulator("127.0.0.1", 9000);
//     _dbRef = db.ref();
//   }
  
//   @override
//   void addData() async {
//     await _dbRef.child(moduleNode).remove();
//     final data = await rootBundle.loadString("./json/module.json");
//     List<dynamic> json = jsonDecode(data);

//     for(int i = 0; i < json.length; i++){
//       await _dbRef.child("$moduleNode/${json[i]["nom"]}").update(json[i]);
//     }
//   }

//   @override
//   Future<List<Module>> getAll() async {
//     final data = await _dbRef.child("$moduleNode/").get();
    
//     if(data.exists){
//       final modules = <Module>[];

//       for(dynamic v in data.children){
//         modules.add(Module.fromJson(v.value));
//       }
//       return modules;
//     }

//     return [];
//   }
  

//   @override
//   Future<void> addModule(Module module) async {
//     await _dbRef.child("$moduleNode/${module.nom}").update(module.toJson());
//   }



// }