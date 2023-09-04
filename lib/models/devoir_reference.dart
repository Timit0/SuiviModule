class DevoirReference
{
  final String id;
  bool done;

  factory DevoirReference.fromJson(Map<String, dynamic> json) => DevoirReference(id: json['id'], done: json['done'] == "true" ? true : false);

  DevoirReference({required this.id, this.done = false});

  factory DevoirReference.base(String s){
    return DevoirReference(
      id: s,
      done: false,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "done":done  
    };
  }
}