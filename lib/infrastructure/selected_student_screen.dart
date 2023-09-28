import 'package:suivi_de_module/models/eleve.dart';

class SelectedStudentScreen
{
  static Eleve? eleve;

  SelectedStudentScreen._(){}

  static final instance = SelectedStudentScreen._();

  void setSelectedEleve(Eleve elevee)
  {
    eleve = elevee;
  }

  Eleve? getSelectedEleve() => eleve;
}