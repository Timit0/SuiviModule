import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'infrastructure/firebase_db_service.dart';

import 'models/eleve.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // creation d'un eleve dummy
    Eleve dummyEleve = Eleve.base();
    Eleve dummyEleveUpdated =
        Eleve(id: dummyEleve.id, name: 'name', firstname: 'yey');
    FirebaseDBService.instance.removeEleve(dummyEleveUpdated);
    return const Placeholder();
  }
}
