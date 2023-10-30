import 'dart:js_interop';

import 'package:eleve_reference_repository/eleve_reference_repository.dart';
import 'package:devoir_repository/devoir_repository.dart';
import 'package:test_repository/test_repository.dart';

class ModuleEntity {
  final String nom;
  final String description;
  final String horaire;
  String classe;
  List<EleveReference>? eleve;
  List<Devoir> devoirs;
  List<Test> tests;

  ModuleEntity({
    required this.nom,
    required this.description,
    required this.horaire,
    required this.classe,
    required this.eleve,
    this.devoirs = const [],
    this.tests = const []
  });

  Map<String, dynamic> toJson(){
    List<Map<String, dynamic>> eleveListToJson = [];
    List<Map<String, dynamic>> devoirListToJson = [];
    List<Map<String, dynamic>> testListToJson = [];
    
    if(eleve != null){
      for (var v in eleve!) {
        eleveListToJson.add(v.toJson());
      }
    }

    if (!devoirs.isNull) {
      for (var v in devoirs) {
        devoirListToJson.add(v.toJson());
      }
    }

    if (!tests.isNull) {
      for (var v in tests) {
        testListToJson.add(v.toJson());
      }
    }

    return {
      "nom":nom,
      "description":description,
      "horaire":horaire,
      "classe":classe,
      //"eleve":eleveListToJson,
      "eleve":eleve,
      "devoir": devoirListToJson,
      "test": testListToJson

    };
  }

  factory ModuleEntity.fromJson(Map<dynamic, dynamic> json)
  {
    List<EleveReference>? listEleveRefs = [];
    List<Test>? ListTest = [];
    List<Devoir>? ListDevoir = [];
    
    try{
      Map<String, dynamic> jsonEleve = json['eleve'];
      jsonEleve.forEach((key, value){listEleveRefs.add(EleveReference.fromJson(value));}); 
    }catch(e){print("ELEVE + $e");}

    try{
      Map<String, dynamic> jsonDevoir = json['devoir'];
      jsonDevoir.forEach((key, value){ListDevoir.add(Devoir.fromJson(value));});
    }catch(e){print("DEVOIR + $e");}

    try{
      Map<String, dynamic> jsonTest = json['test'];
      jsonTest.forEach((key, value){ListTest.add(Test.fromJson(value));});
    }catch(e){print("TEST + $e");}

    return ModuleEntity(
      nom: json["nom"], 
      description: json["description"], 
      horaire: json["horaire"], 
      classe: json["classe"],
      eleve: listEleveRefs,
      tests: ListTest,
      devoirs: ListDevoir
    );
  }
}