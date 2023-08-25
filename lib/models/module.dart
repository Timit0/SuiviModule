import 'package:flutter/material.dart';
import 'package:suivi_de_module/widget/module_widget.dart';

class Module{
  
  final String nom;
  final String description;
  final String horaire;
  final String classe;

  Module({
    required this.nom,
    required this.description,
    required this.horaire,
    required this.classe,
  });

  factory Module.fromJson(Map<dynamic, dynamic> json){
    return Module(
      nom: json["nom"], 
      description: json["description"], 
      horaire: json["horaire"], 
      classe: json["classe"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "nom":nom,
      "description":description,
      "horaire":horaire,
      "classe":classe
    };
  }

  String getOnlyNumbOfName(String s){
    List<String> number = [];
    number.addAll(s.split("-"));
    return number[1];
  }
}