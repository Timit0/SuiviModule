import 'package:devoir_repository/src/models/devoir.dart';

abstract class DevoirRepository {

  Future<Devoir> add({required Devoir devoir});

  Future<void> remove({required String id});



}