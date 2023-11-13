class EleveEntity {
  String id;
  String name;
  String firstname;
  String photoFilename;

  EleveEntity({
    required this.id,
    required this.name,
    required this.firstname,
    required this.photoFilename
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'firstname': firstname,
    'photoFilename': photoFilename
  };

  static EleveEntity fromJson(Map<String, dynamic> json) => EleveEntity(
    id: json['id'] as String,
    name: json['name'] as String,
    firstname: json['firstname'] as String,
    photoFilename: json['photoFilename'] as String
  );

  @override
  String toString() {
    return '''EleveEntity
    {
      id : $id,
      name: $name,
      firstname: $firstname,
      photoFilename: $photoFilename
    }''';
  }
}