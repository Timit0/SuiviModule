import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:suivi_de_module/infrastructure/service.dart';

import 'dart:convert';

import 'package:suivi_de_module/models/module.dart';

class FirebaseDbService implements Service{
  
  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _dbRef;
  final String moduleNode = "module";

  static final instance = FirebaseDbService._();

  FirebaseDbService._(){
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _dbRef = db.ref();
  }
  
  @override
  void addData() async {
    await _dbRef.child(moduleNode).remove();
    final data = await rootBundle.loadString("./json/module.json");
    List<dynamic> json = jsonDecode(data);

    for(int i = 0; i < json.length; i++){
      await _dbRef.child("$moduleNode/${json[i]["nom"]}").update(json[i]);
    }
  }

  @override
  Future<List<Module>> getAll() async {
    final data = await _dbRef.child("$moduleNode/").get();
    
    if(data.exists){
      final modules = <Module>[];

      for(dynamic v in data.children){
        modules.add(Module.fromJson(v.value));
      }
      return modules;
    }

    return [];
  }
  
  @override
  Future<void> addModule(Module module) async {
    await _dbRef.child("$moduleNode/${module.nom}").update(module.toJson());
  }



}