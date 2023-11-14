import 'dart:js_interop';

import 'package:firebase_database/firebase_database.dart';
import 'package:module_repository/module_repository.dart';
import 'package:module_repository/src/module_repository.dart';

import 'dart:developer' as dev;

class FirebaseModuleRepository extends ModuleRepository{

  final FirebaseDatabase db = FirebaseDatabase.instance;
  late DatabaseReference _ref;

  static final instance = FirebaseModuleRepository._();

  FirebaseModuleRepository._() {
    db.useDatabaseEmulator("127.0.0.1", 9000);
    _ref = db.ref();
  }

  final String modulesNode = "module";

  @override
  Future<Module> create({required Module module}) async {
    try {
      await _ref.child("$modulesNode/${module.nom}").update(module.toEntity().toJson());
      return module;
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> remove({required String id}) async {
    try {
      await _ref.child("$modulesNode/$id").remove();
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<List<Module>> get({String? id}) async {
    try {  
      List<Module> listModule = [];
      if(id.isNull){
        final data = await _ref.child(modulesNode).get();
        for(var v in data.children){
          try{
          listModule.add(Module.fromJson(v.value as Map<dynamic, dynamic>));
          }catch(e){
            dev.log(e.toString());
          }
        }
      }else{
        listModule.add(await _ref.child("$modulesNode/$id").get() as Module);
      }
      // listModule = await _ref.child("path ${id == null ? "" : "/$id"}").get() as List<Module>;

      return listModule;
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
    
  }
  
  @override
  Future<Module?> update(Module module) async {
    try {      
      await _ref.child("$modulesNode/${module.nom}").update(module.toEntity().toJson());
      return module;
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }

}