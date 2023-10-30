import 'package:eleve_reference_repository_A/eleve_reference_repository.dart';

abstract class EleveReferenceRepository{
  Future<EleveReference> add({required EleveReference eleveReference});

  Future<void> remove({required String id});
}