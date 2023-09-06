import 'dart:js_interop';
import 'dart:math';

import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';

class Module{
  
  final String nom;
  final String description;
  final String horaire;
  String classe;
  final List<EleveReference>? eleve;

  Module({
    required this.nom,
    required this.description,
    required this.horaire,
    required this.classe,
    required this.eleve,
  });

  factory Module.fromJson(Map<dynamic, dynamic> json)
  {

    List<EleveReference>? temp = [];
    
    try{
      Map<String, dynamic> json2 = json['eleve'];
      //print(json["eleve"]);

      json2.forEach((key, value) 
      {
        //print("Add");
        temp.add(EleveReference.fromJson(value)); 
        //print(EleveReference.fromJson(value).id);
      }); 
    }catch(e){print(e);}

    //print(temp);
    try{
      print(temp.length);
    }catch(e){print(e);}

    return Module(
      nom: json["nom"], 
      description: json["description"], 
      horaire: json["horaire"], 
      classe: json["classe"],
      eleve: temp,
    );
  }

  Map<String, dynamic> toJson(){
    List<Map<String, dynamic>> eleveListToJson = [];
    
    if(eleve != null){
      for (var v in eleve!) {
        eleveListToJson.add(v.toJson());
      }
    }

    return {
      "nom":nom,
      "description":description,
      "horaire":horaire,
      "classe":classe,
      //"eleve":eleveListToJson,
      "eleve":eleve
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