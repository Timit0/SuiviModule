class Eleve {
  String id;

  // nom
  String name;

  // prenom
  String firstname;

  Eleve({required this.id, required this.name, required this.firstname});

  Eleve copyWith({String? id, String? name, String? firstname}) => Eleve(
      id: id ?? this.id,
      name: name ?? this.name,
      firstname: firstname ?? this.firstname);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'nickname': firstname};

  factory Eleve.fromJson(Map<String, dynamic> json) =>
      Eleve(id: json['id'], name: json['name'], firstname: json['nickname']);

  factory Eleve.base() =>
      Eleve(id: 'cp-99abc', name: 'abcd', firstname: 'efgh');

  factory Eleve.error() =>
      Eleve(id: 'ERROR', name: 'ERROR', firstname: 'ERROR');

  @override
  String toString() {
    return "id:\t$id\nname.\t$name\nfirstname:\t$firstname";
  }
}
