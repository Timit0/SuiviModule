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

  factory EleveReference.base(){
    List<DevoirReference> devoirRefs = [];
    List<TestReference> testRefs = [];

    devoirRefs.add(DevoirReference.base("devoir01"));
    testRefs.add(TestReference.base("test01"));


    return EleveReference(
      devoirs: devoirRefs,
      tests: testRefs,
    );
  }

  Map<String, dynamic> toJson(){
    List<Map<String, dynamic>> testListToJson = [];
    List<Map<String, dynamic>> devoirListToJson = [];

    if(testListToJson != null){
      for (var v in tests!) {
        testListToJson.add(v.toJson());
      }
    }

    if(devoirListToJson != null){
      for (var v in devoirs!) {
        devoirListToJson.add(v.toJson());
      }
    }


    Map<String, Map<String, dynamic>> testMap = {};

    for (var v in testListToJson) {
      testMap["${v.keys}"] = v;
    }


    Map<String, Map<String, dynamic>> devoirMap = {};

    for (var v in devoirListToJson) {
      devoirMap["${v.keys}"] = v;
    }

    print(devoirMap);

    return {
      "test":testMap,
      "devoir":devoirMap
    };
  }

  @override
  String toString() {
    return "Test REfs : ${tests?[0].id} Devoir REfs : ${devoirs?[0].id}";
  }
}