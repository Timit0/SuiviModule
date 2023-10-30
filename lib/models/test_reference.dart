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

  factory TestReference.base(String s){
    return TestReference(
      id: s,
      done: false,
      note: 2
    );
  }
  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "done":done,
      "note":note
    };
  }
}