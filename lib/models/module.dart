import 'dart:js_interop';

import 'package:suivi_de_module/models/devoir.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/models/test.dart';

class Module{
  
  final String nom;
  final String description;
  final String horaire;
  String classe;
  final List<EleveReference>? eleve;
  List<Devoir> devoirs;
  List<Test> tests;

  Module({
    required this.nom,
    required this.description,
    required this.horaire,
    required this.classe,
    required this.eleve,
    this.devoirs = const [],
    this.tests = const []
  });

  factory Module.fromJson(Map<dynamic, dynamic> json)
  {

    List<EleveReference>? temp1 = [];
    List<Test>? temp2 = [];
    List<Devoir>? temp3 = [];
    
    try{
      Map<String, dynamic> json2 = json['eleve'];
      Map<String, dynamic> json3 = json['devoir'];
      Map<String, dynamic> json4 = json['test'];

      json2.forEach((key, value){temp1.add(EleveReference.fromJson(value));}); 
      json3.forEach((key, value){temp3.add(Devoir.fromJson(value));});
      json4.forEach((key, value){temp2.add(Test.fromJson(value));});

    }catch(e){print(e);}

    return Module(
      nom: json["nom"], 
      description: json["description"], 
      horaire: json["horaire"], 
      classe: json["classe"],
      eleve: temp1,
      tests: temp2,
      devoirs: temp3
    );
  }

  factory Module.base() => Module(
    nom: 'base',
    description: 'base',
    horaire: 'base',
    classe: 'base',
    eleve: []
  );

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

  String getOnlyNumbOfName(String s){
    List<String> number = [];
    number.addAll(s.split("-"));
    return number[1];
  }

  static String getOnlyNumbOfNameStatic(String s){
    List<String> number = [];
    number.addAll(s.split("-"));
    return number[1];
  }
}