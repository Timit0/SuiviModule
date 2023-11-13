import 'package:module_repository/module_repository.dart';

abstract class ModuleRepository {
  Future<Module> create({required Module module});

  Future<void> remove({required String id});

  Future<List<Module>> get({String? id});

  Future<Module?> update(Module module);
}