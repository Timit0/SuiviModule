import 'dart:async';
import 'dart:js_interop';
import 'dart:math';
import 'dart:developer' as dev;
 
import 'package:eleve_repository/src/models/eleve.dart';
import 'package:module_repository/module_repository.dart';

import '../eleve_reference_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseEleveReferenceRepository implements EleveReferenceRepository{
  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseEleveReferenceRepository._();

  // singleton
  FirebaseEleveReferenceRepository._() {
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _ref = db.ref();
  }

  final String modulesNode = "Modules";

  @override
  Future<EleveReference> add({required EleveReference eleveReference, required String moduleId}) async {
    await _ref.child("$modulesNode/$moduleId/eleve/${eleveReference.id}").update(eleveReference.toEntity().toJson());

    return eleveReference;
  }

  @override
  Future<void> removeAll({required String id}) async {
    final data = await _ref.child(modulesNode).get();
    for (var v in data.children) {
      for (var w in v.children) {
        Module module = w as Module;
        if(!module.eleve.isNull){
          for (var x in module.eleve!) {
            if(x.id == id){
              await _ref.child("$modulesNode/${module.nom}/eleve/${x.id}").remove();
            }
          } 
        }
        
      }
    }
  }

  @override
  Future<List<EleveReference>?> get({String? id = null}) async {
    List<EleveReference>? listEleveReference = [];
    listEleveReference.addAll(await _ref.child("path ${id == null ? "" : "/$id"}").get() as List<EleveReference>);

    return listEleveReference;
  }
  
  @override
  Future<void> removeFrom({required String moduleId, required String id}) async {
    await _ref.child("$modulesNode/$moduleId/eleve/$id").remove();
  }


}