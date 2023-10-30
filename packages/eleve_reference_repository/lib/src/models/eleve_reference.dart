import 'package:equatable/equatable.dart';

import '../../eleve_reference_repository.dart';

class EleveReference implements Equatable
{
  String id;

  EleveReference({required this.id});

  factory EleveReference.error() => EleveReference(id: 'error');

  factory EleveReference.fromJson(Map<String, dynamic> json) {

    return EleveReference(
      id: json["id"],
    );
  }

  EleveReferenceEntity toEntity() => EleveReferenceEntity(
    id :id
  );

  static EleveReference fromEntity(EleveReferenceEntity eleveReferenceEntity) => EleveReference(
    id: eleveReferenceEntity.id
  );

  factory EleveReference.base(){

    return EleveReference(
      id: "00",
    );
  }

  Map<String, dynamic> toJson(){

    return {
      "id":id,
    };
  }
  
  @override
  List<Object?> get props => [id];
  
  @override
  bool? get stringify => true;
}