import 'dart:developer' as dev show log;
import 'dart:js_interop';

import 'package:eleve_repository/eleve_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:eleve_reference_repository/eleve_reference_repository.dart';
import 'package:flutter/widgets.dart';

class FirebaseEleveRepository implements EleveRepository {

  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseEleveRepository._();

  FirebaseEleveRepository._() {
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _ref = db.ref();
  }

  final String elevesNode = "Eleves";

  @override
  Future<Eleve> create({required Eleve eleve}) async {
    await _ref.child("$elevesNode/${eleve.id}").update(eleve.toEntity().toJson());
    return eleve;
  }

  @override
  Future<void> remove({required String id}) async {
    await _ref.child("$elevesNode/$id").remove();
    await FirebaseEleveReferenceRepository.instance.removeAll(id: id);
  }
  
  @override
  Future<List<Eleve>> get({String? id = null}) async {
    List<Eleve> listEleve = [];
    if(id.isNull){
      final data = await _ref.child(elevesNode).get();
      for(var v in data.children){
        listEleve.add(v as Eleve);
      }
    }else{
      listEleve.add(await _ref.child("$elevesNode/$id").get() as Eleve);
    }
      // listEleve.addAll(await _ref.child("$elevesNode ${id == null ? "" : "/$id"}").get() as List<Eleve>);
    return listEleve;
  }
  
  @override
  Future<Eleve?> update(Eleve eleve) async {
    await _ref.child("$elevesNode/${eleve.id}").update(eleve.toEntity().toJson());

    return eleve;
  }
}