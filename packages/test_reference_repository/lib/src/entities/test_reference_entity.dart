class TestReferenceEntity {
  
  final String id;
  bool done;
  var note;

  TestReferenceEntity({
    required this.id,
    required this.done,
    this.note
  });

    
  factory TestReferenceEntity.fromJson(Map<String, dynamic> json) => TestReferenceEntity(
    id: json['id'],
    done: json['done'] == "true" ? true : false,
    note: json['note'] ?? 0.0
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "done":done,
    "note":note
  };
}