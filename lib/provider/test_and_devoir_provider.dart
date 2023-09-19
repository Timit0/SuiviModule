import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/devoir.dart';

import '../infrastructure/firebase_db_service.dart';
import '../models/devoir_reference.dart';
import '../models/test.dart';
import '../models/test_reference.dart';

class TestAndDevoirProvider with ChangeNotifier{
  List<TestReference> _testsRef = [];
  List<TestReference> get testsRef => [..._testsRef];

  List<DevoirReference> _devoirsRef = [];
  List<DevoirReference> get devoirsRef => [..._devoirsRef];



  Future<void> getTestAndDevoirFromOneStudent({required String id, required String moduleId}) async {
    _testsRef.clear();
    _devoirsRef.clear();

    final testData = await FirebaseDBService.instance.getTestsForOneStudent(studentId: id, moduleId: moduleId);
    if(testData != null){
      _testsRef = testData;
    }
    
    final devoirData = await FirebaseDBService.instance.getDevoirsForOneStudent(studentId: id, moduleId: moduleId);
    if(devoirData != null){
      _devoirsRef = devoirData;
    }
    notifyListeners();
  }


  // Future<Test?> getTest(String idTest, String idModule) async {
  //   final data = await FirebaseDBService.instance.getTest(idTest, idModule);
  //   return data;
  // }

  // Future<Devoir?> getDevoir(String idDevoir, String idModule) async {
  //   final data = await FirebaseDBService.instance.getDevoir(idDevoir, idModule);
  //   return data;
  // }


  List<Test?> _tests = [];
  List<Test?> get tests => [..._tests];

  List<Devoir?> _devoirs = [];
  List<Devoir?> get devoirs => [..._devoirs];

  Future<void> getTest(String idTest, String idModule) async {
    _tests.clear();
    final data = await FirebaseDBService.instance.getTest(idTest, idModule);
    _tests.add(data);
  }

  Future<void> getDevoir(String idDevoir, String idModule) async {
    _devoirs.clear();
    final data = await FirebaseDBService.instance.getDevoir(idDevoir, idModule);
    _devoirs.add(data);
  }

  Future<void> fetchAndSetDevoirAndTestForOneModule(String idModule) async {
    _tests.clear();
    _devoirs.clear();
    final test = await FirebaseDBService.instance.getAllTest(idModule);
    final devoir = await FirebaseDBService.instance.getAllDevoir(idModule);

    _tests = test;
    _devoirs = devoir;

    notifyListeners();
  }


  
}