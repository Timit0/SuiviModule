import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:suivi_de_module/screen/student_summary_screen.dart';
import 'firebase_options.dart';

import 'infrastructure/firebase_db_service.dart';

import 'models/eleve.dart';

import 'screen/student_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // TODO: a retirer apres le premier run!

    // uniquement pour le debuggage
    // final instance = FirebaseDBService.instance;
    // for (var i = 0; i < 99; i++) {
    //   Eleve dummy = Eleve(
    //       id: 'cp-$i',
    //       name: i.toString(),
    //       firstname: (i * 2).toString(),
    //       photoFilename: 'assets/img/placeholderImage.png');
    //   instance.addEleve(dummy);
    // }

    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/':(context) => StudentListScreen(),
      StudentSummaryScreen.routeName:(context) => StudentSummaryScreen()
    });
  }
}
