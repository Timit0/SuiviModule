import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/firebase_options.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/screen/login_screen.dart';
import 'package:suivi_de_module/screen/module_screen.dart';
import 'package:suivi_de_module/screen/student_list_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //FirebaseDBService.instance.addData();
    //final service = FirebaseDbService.instance;

    return ChangeNotifierProvider(
      // create: (context) => ModuleProvider(service),
      create: (context) => ModuleProvider(),
      child: MaterialApp(
        //scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ModuleScreen(),
        routes: {
          StudentListScreen.routeName:(context) => StudentListScreen(),
          DetailsStudentScreen.routeName:(context) => DetailsStudentScreen(),
        }
        // home: LoginScreen(),
      ),
    );
  }
}
