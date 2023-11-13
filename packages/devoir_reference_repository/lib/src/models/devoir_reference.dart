import 'dart:developer';

import 'package:devoir_reference_repository/devoir_reference_repository.dart';

class DevoirReference
{
  final String id;
  bool done;

  DevoirReference({required this.id, this.done = false});

  factory DevoirReference.base(String id){
    return DevoirReference(
      id: id,
      done: false,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "done":done  
    };
  }

  DevoirReferenceEntity toEntity() => DevoirReferenceEntity(id: id, done: done);

  static DevoirReference fromEntity(DevoirReferenceEntity entity) => DevoirReference(id: entity.id, done: entity.done); 
}