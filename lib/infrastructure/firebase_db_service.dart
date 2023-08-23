import 'dart:developer' as dev;

import 'package:firebase_database/firebase_database.dart';
import 'package:suivi_de_module/models/eleve.dart';

class FirebaseDBService {
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

  Future<Eleve> addEleve(Eleve eleve) async {
    _ref.child('eleves/${eleve.id}').set(eleve.toJson()).then((_) {
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

  Future<List<Eleve>> getAllEleves() async {
    final snapshot = await _ref.child('eleves').get();

    if (snapshot.exists) {
      final eleves = <Eleve>[];

      for (dynamic v in snapshot.children) {
        final tempID = v.key.toString();
        final tempMap = v.value as Map<String, dynamic>;

        eleves.add(Eleve.fromJson(tempMap).copyWith(id: tempID));
      }
      return eleves;
    }

    return [];
  }

  // ====================================================================================
}
