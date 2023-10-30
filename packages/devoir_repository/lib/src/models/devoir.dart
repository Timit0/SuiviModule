class Devoir
{
  String id;
  String nom;
  String description;
  /*DateTime*/String date;
  bool done;

  Devoir({
    required this.id,
    required this.nom,
    required this.description,
    required this.date,
    this.done = false,
  });

  factory Devoir.fromJson(Map<String, dynamic> json) => Devoir(
    id: json['id'], 
    nom: json['nom'], 
    description: json['description'],
    //date: DateTime.parse(json['date'])
    date: json['date'],
    done: json['done']
  );

  factory Devoir.base() => Devoir(
    id: 'none',
    nom: 'base',
    description: 'base',
    date: 'base'
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': nom,
    'description': description,
    'date': date,
    'done': done
  };
}