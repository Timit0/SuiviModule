import 'package:eleve_repository/eleve_repository.dart';

abstract class EleveRepository {

  /// <summary>
  /// ajout d'un eleve dans la base de donnée
  /// </summary>
  Future<Eleve> add({required Eleve eleve});

  /// <summary>
  /// suppression d'un eleve de la base de donnée
  /// </summary>
  Future<void> remove({required String id});
  
}