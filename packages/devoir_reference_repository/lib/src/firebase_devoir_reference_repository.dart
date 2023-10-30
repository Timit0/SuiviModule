import 'package:devoir_reference_repository/devoir_reference_repository.dart';
import 'package:devoir_reference_repository/src/devoir_reference_repository.dart';
import 'package:firebase_database/firebase_database.dart';

import 'dart:developer' as dev;

class FirebaseDevoirReferenceRepository implements DevoirReferenceRepository{
  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseDevoirReferenceRepository._();

  // singleton
  FirebaseDevoirReferenceRepository._() {
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _ref = db.ref();
  }

  @override
  Future<DevoirReference> add({required DevoirReference devoirReference}) async {
    try{
      await _ref.child("path").update(devoirReference.toEntity().toJson());
      return devoirReference;
    }
    catch(e){
      dev.log(e.toString());
      return DevoirReference.base(devoirReference.id);
    }
  }

  @override
  Future<void> remove({required String id}) async {
    try{
      await _ref.child("path/$id").remove();
    }
    catch(e){
      dev.log(e.toString());
    }
  }

}