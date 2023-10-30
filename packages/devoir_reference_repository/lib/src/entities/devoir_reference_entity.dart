class DevoirReferenceEntity {
  
  String id;
  bool done;

  DevoirReferenceEntity({
    required this.id,
    required this.done
  });

  factory DevoirReferenceEntity.fromJson(Map<String, dynamic> json) => DevoirReferenceEntity(
    id: json['id'], 
    done: json['done'] == "true" ? true : false
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "done":done,
  };
}