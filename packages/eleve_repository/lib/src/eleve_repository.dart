import 'package:eleve_repository/eleve_repository.dart';

abstract class EleveRepository {

  /// <summary>
  /// ajout d'un eleve dans la base de donnée
  /// </summary>
  Future<Eleve> create({required Eleve eleve});

  /// <summary>
  /// suppression d'un eleve de la base de donnée
  /// </summary>
  Future<void> remove({required String id});

  Future<List<Eleve>> get({String? id = null});
  
  Future<Eleve?> update(Eleve eleve);
}