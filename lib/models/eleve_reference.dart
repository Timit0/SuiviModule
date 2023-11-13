class EleveReference
{
  String id;

  EleveReference({required this.id});

  factory EleveReference.error() => EleveReference(id: 'error');

  factory EleveReference.fromJson(Map<String, dynamic> json) {

    return EleveReference(
      id: json["id"],
    );
  }

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
}