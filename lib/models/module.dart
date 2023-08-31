import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';

class Module{
  
  final String nom;
  final String description;
  final String horaire;
  final String classe;
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

    List<EleveReference> temp = [];
    Map<String, dynamic> json2 = json['eleve'];

    json2.forEach((key, value) {temp.add(EleveReference.fromJson(json['eleve'][key])); });

    return Module(
      nom: json["nom"], 
      description: json["description"], 
      horaire: json["horaire"], 
      classe: json["classe"],
      eleve: temp,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "nom":nom,
      "description":description,
      "horaire":horaire,
      "classe":classe,
      "eleve":eleve,
    };
  }

  String getOnlyNumbOfName(String s){
    List<String> number = [];
    number.addAll(s.split("-"));
    return number[1];
  }
}