import 'dart:developer' as dev show log;

import 'package:eleve_repository/eleve_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:eleve_reference_repository/eleve_reference_repository.dart';

class FirebaseEleveRepository implements EleveRepository {

  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseEleveRepository._();

  FirebaseEleveRepository._() {
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _ref = db.ref();
  }

  @override
  Future<Eleve> add({required Eleve eleve}) async {
    try {
      await _ref.child("path").update(eleve.toEntity().toJson());
      return eleve;
    }
    catch (e) {
      dev.log(e.toString());
      return Eleve.error();
    }
  }

  @override
  Future<void> remove({required String id}) async {
    try {
      await _ref.child("path/$id").remove();
      await FirebaseEleveReference.instance.remove(id: id);
    }
    catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }
}