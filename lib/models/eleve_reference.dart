import 'package:suivi_de_module/models/devoir_reference.dart';
import 'package:suivi_de_module/models/test_reference.dart';

class EleveReference
{

  List<DevoirReference>? devoirs;
  List<TestReference>? tests;

  EleveReference({this.devoirs, this.tests});

  factory EleveReference.fromJson(Map<String, dynamic> json) {
    // ...

    List<DevoirReference> devoirRefs = [];
    List<TestReference> testRefs = [];

    Map<String, dynamic> jsonDevoirs = json['devoir'];
    Map<String, dynamic> jsonTests = json['test'];

    jsonDevoirs.forEach((key, value) { devoirRefs.add(DevoirReference.fromJson(json['devoir'][key])); });
    jsonTests.forEach((key, value) { testRefs.add(TestReference.fromJson(json['test'][key])); });

    return EleveReference(
      devoirs: devoirRefs,
      tests: testRefs
    );
  }
}