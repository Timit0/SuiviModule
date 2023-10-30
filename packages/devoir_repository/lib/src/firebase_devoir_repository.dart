import 'dart:developer' as dev show log;

import 'package:devoir_reference_repository/devoir_reference_repository.dart';
import 'package:devoir_repository/src/devoir_repository.dart';
import 'package:devoir_repository/src/models/devoir.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_db_service_repository/firebase_db_service_repository.dart';

class FirebaseDevoirRepository implements DevoirRepository{

  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseDevoirRepository._();

  // singleton
  FirebaseDevoirRepository._() {
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _ref = db.ref();
  }

  // TODO: implementer la methode add et remove de FirebaseDevoirRepository

  @override
  Future<Devoir> add({ required Devoir devoir}) async {
    try {
      await _ref.child("").update(devoir.toJson());
      return devoir;
    }
    catch (e) {
      dev.log(e.toString());
      return Devoir.base();
    }
  }

  @override
  Future<void> remove({required String id}) async {
    try {
       await _ref.child("/$id").remove();
       await FirebaseDevoirReferenceRepository.instance.toString();
    }
    catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }

}