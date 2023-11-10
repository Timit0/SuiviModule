

import 'package:eleve_repository/eleve_repository.dart';

import '../eleve_reference_repository.dart';

abstract class EleveReferenceRepository{
  Future<EleveReference> add({required EleveReference eleveReference, required String moduleId});

  Future<void> removeAll({required String id});

  Future<void> removeFrom({required String moduleId, required String id});

  Future<List<EleveReference>?> get({String? id = null});
}