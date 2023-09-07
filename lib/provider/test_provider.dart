import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/test.dart';

class TestProvider with ChangeNotifier
{
  List<Test> _tests = [];

  List<Test> get tests => [..._tests];

  Future<void> fetchAndSetTests(String moduleID) async
  {
    _tests.clear();
    final data = await FirebaseDBService.instance.getAllTest(moduleID);
    _tests.addAll(data as Iterable<Test>);
    notifyListeners();
  }

  Future<void> createTest(Test test, String moduleID) async
  {
    await FirebaseDBService.instance.addTest(test, moduleID);
    _tests.add(test);
    notifyListeners();
  }

  Future<void> editTest(Test test, String moduleID) async
  {
    await FirebaseDBService.instance.addTest(test, moduleID);
    for (var v in _tests)
    {
      if (v.id == test.id)
      {
        v = test;
      }
    }
    notifyListeners();
  }
}