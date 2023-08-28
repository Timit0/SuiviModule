import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

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

    List<Eleve> temp = [];

    for (var element in json['eleve']) {
      temp.add(Eleve.fromJson(element));
    }


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