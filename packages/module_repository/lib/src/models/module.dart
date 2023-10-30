import 'dart:js_interop';
import 'package:devoir_repository/devoir_repository.dart';
import 'package:eleve_reference_repository/eleve_reference_repository.dart';
import 'package:test_repository/test_repository.dart';

class Module /*implements Equatable*/{
  
  final String nom;
  final String description;
  final String horaire;
  String classe;
  List<EleveReference>? eleve;
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

    return Module(
      nom: json["nom"], 
      description: json["description"], 
      horaire: json["horaire"], 
      classe: json["classe"],
      eleve: listEleveRefs,
      tests: ListTest,
      devoirs: ListDevoir
    );
  }

  factory Module.base() => Module(
    nom: 'base',
    description: 'base',
    horaire: 'base',
    classe: 'base',
    eleve: []
  );

  factory Module.error() => Module(
    nom: 'Error', 
    description: 'Error', 
    horaire: 'Error', 
    classe: 'Error', 
    eleve: [EleveReference.error()]
  );

  Map<String, dynamic> fromCsvToJson(){
    Map<String, Map<String, dynamic>> eleveListToJson = {};
    List<Map<String, dynamic>> devoirListToJson = [];
    List<Map<String, dynamic>> testListToJson = [];
    
    if(eleve != null){
      for (var v in eleve!) {
        eleveListToJson["${v.id}"] = v.toJson();
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
      "eleve":eleveListToJson,
      //"eleve":eleve,
      "devoir": devoirListToJson,
      "test": testListToJson

    };
  }

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
  
  @override
  List<Object?> get props => [
    nom,
    description,
    horaire,
    classe,
    eleve,
    devoirs,
    tests
  ];
  
  @override
  bool? get stringify => true;
}