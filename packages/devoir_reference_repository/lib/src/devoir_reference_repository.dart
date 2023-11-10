import '../devoir_reference_repository.dart';

abstract class DevoirReferenceRepository{
  Future<DevoirReference> create({required DevoirReference devoirReference});

  Future<void> remove({required String id});
}