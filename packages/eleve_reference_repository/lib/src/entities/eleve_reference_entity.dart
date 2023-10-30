class EleveReferenceEntity{
  final String id;

  EleveReferenceEntity({required this.id});

  Map<String, dynamic> toJson(){

    return {
      "id":id,
    };
  }

  factory EleveReferenceEntity.fromJson(Map<String, dynamic> json) {

    return EleveReferenceEntity(
      id: json["id"],
    );
  }
}