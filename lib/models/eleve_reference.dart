import 'package:suivi_de_module/models/devoir_reference.dart';
import 'package:suivi_de_module/models/test_reference.dart';

class EleveReference
{
  String id;
  // List<DevoirReference>? devoirs;
  // List<TestReference>? tests;

  EleveReference({required this.id/*, this.devoirs, this.tests*/});

  factory EleveReference.error() => EleveReference(id: 'error');

  factory EleveReference.fromJson(Map<String, dynamic> json) {

    return EleveReference(
      id: json["id"],
    );
  }

  factory EleveReference.base(){

    return EleveReference(
      id: "00",
    );
  }

  Map<String, dynamic> toJson(){

    return {
      "id":id,
    };
  }
}