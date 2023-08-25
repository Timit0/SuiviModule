import 'package:suivi_de_module/models/module.dart';

abstract class Service{
  void addData();
  void getAll();
  Future<void> addModule(Module module);
}