class Test
{
  String id;
  String nom;
  String description;
  //DateTime date;
  String date;
  /*Float?*/ //var note; // <- moyenne
  bool done;

  Test({
    required this.id,
    required this.nom,
    required this.description,
    required this.date,
    // this.note,
    this.done = false,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json['id'], 
    nom: json['nom'], 
    description: json['description'] ?? "Default",
    // note: json['note'] ?? 0,
    date: json['date'] ?? DateTime.now().toString(),
    done: json['done'] ?? false
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': nom,
    'description': description,
    'date': date,
    // 'note': note,
    'done': done
  };
}