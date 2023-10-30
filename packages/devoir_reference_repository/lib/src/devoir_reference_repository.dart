import '../devoir_reference_repository.dart';

abstract class DevoirReferenceRepository{
  Future<DevoirReference> add({required DevoirReference devoirReference});

  Future<void> remove({required String id});
}