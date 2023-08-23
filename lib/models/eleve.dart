class Eleve {
  String id;

  // nom
  String name;

  // prenom
  String nickname;

  Eleve({required this.id, required this.name, required this.nickname});

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'nickname': nickname};

  factory Eleve.fromJson(Map<String, dynamic> json) =>
      Eleve(id: json['id'], name: json['name'], nickname: json['nickname']);
}
