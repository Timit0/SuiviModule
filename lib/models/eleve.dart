class Eleve {
  String id;

  // nom
  String name;

  // prenom
  String firstname;

  String photoFilename;

  Eleve(
      {required this.id,
      required this.name,
      required this.firstname,
      required this.photoFilename});

  Eleve copyWith(
          {String? id,
          String? name,
          String? firstname,
          String? photoFilename}) =>
      Eleve(
          id: id ?? this.id,
          name: name ?? this.name,
          firstname: firstname ?? this.firstname,
          photoFilename: photoFilename ?? this.photoFilename);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nickname': firstname,
        'photoFilename': photoFilename
      };

  factory Eleve.fromJson(Map<String, dynamic> json) => Eleve(
      id: json['id'],
      name: json['name'],
      firstname: json['nickname'],
      photoFilename: json['photoFilename'] ?? "");

  factory Eleve.base() => Eleve(
      id: 'cp-99abc',
      name: 'abcd',
      firstname: 'efgh',
      photoFilename: 'assets/img/placeholderImage.png');

  factory Eleve.error() => Eleve(
      id: 'ERROR',
      name: 'ERROR',
      firstname: 'ERROR',
      photoFilename: 'assets/img/errorImage.png');

  @override
  String toString() {
    return "id:\t$id\nname.\t$name\nfirstname:\t$firstname\nphotoFilename:\t$photoFilename";
  }
}
