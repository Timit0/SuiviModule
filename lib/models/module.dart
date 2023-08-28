import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/widget/module_widget.dart';

class Module{
  
  final String nom;
  final String description;
  final String horaire;
  final String classe;
  final List<Eleve>? eleve;

  Module({
    required this.nom,
    required this.description,
    required this.horaire,
    required this.classe,
    required this.eleve,
  });

  factory Module.fromJson(Map<dynamic, dynamic> json)
  {
    // dev.log("===========================================");
    // dev.log(json["eleve"]["cp-21tih"]);
    // dev.log("===========================================");

    // var list = json["eleve"]["cp-21tih"] as List;
    // List<Eleve> i = list.map((e) => Eleve.fromJson(e)).toList();

    List<Eleve> temp = [];
    temp.add(Eleve.fromJson(json["eleve"]["cp-21tih"]));    

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