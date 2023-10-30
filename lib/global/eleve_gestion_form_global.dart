import 'dart:math';

import 'package:suivi_de_module/models/eleve.dart';

class EleveGestionFormGlobal {
  static bool isFocusOnEleve = false;

  static String cp = "";
  static String name = "";
  static String nickName = "";
  static String picture = "";

  static void update(Eleve eleve){
    cp = eleve.id;
    name = eleve.name;
    nickName = eleve.firstname;
    picture = eleve.photoFilename;
  }

  static void reset(){
    cp = "";
    name = "";
    nickName = "";
    picture = "";
  }
}