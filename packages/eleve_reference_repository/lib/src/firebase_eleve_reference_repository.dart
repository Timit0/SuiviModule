import 'dart:math';
import 'dart:developer' as dev;
 
import '../eleve_reference_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseEleveReference implements EleveReferenceRepository{
  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseEleveReference._();

  // singleton
  FirebaseEleveReference._() {
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _ref = db.ref();
  }

  @override
  Future<EleveReference> add({required EleveReference eleveReference}) async {
    try{
      await _ref.child("path").update(eleveReference.toEntity().toJson());
      return eleveReference;
    }
    catch(e){
      dev.log(e.toString());
      return eleveReference;
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