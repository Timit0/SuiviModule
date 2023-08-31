class TestReference
{
  final String id;
  bool done;
  var note;

  factory TestReference.fromJson(Map<String, dynamic> json) => TestReference(
    id: json['id'],
    done: json['done'] == "true" ? true : false,
    note: json['note'] ?? 0.0
  );

  TestReference({required this.id, this.done = false, this.note});
}