import 'dart:developer' as dev;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/firebase_options.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/provider/devoir_provider.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/provider/test_and_devoir_provider.dart';
import 'package:suivi_de_module/provider/test_provider.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/screen/main_screen.dart';

import 'package:bloc/bloc.dart';

import 'blocs/module/get_module_bloc/get_module_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = SimpleBlocObserver(); 


  runApp(const MyApp());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    super.onCreate(bloc);
    dev.log("onCreate -- bloc ${bloc.runtimeType}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    dev.log("onEvent -- bloc ${bloc.runtimeType}, event: $event");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    dev.log('onChange -- bloc ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    dev.log('onTransition -- bloc ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
    dev.log('onError -- blov ${bloc.runtimeType}, error: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose
    super.onClose(bloc);
    dev.log('onClose -- bloc ${bloc.runtimeType}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //FirebaseDBService.instance.addModuleDummy(); // <-- UNIQUEMENT POUR LE DEBUGGING!!!
    //final service = FirebaseDbService.instance;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModuleProvider>(
          create: (_) => ModuleProvider(),
        ),
        ChangeNotifierProvider<StudentProvider>(
          create: (_) => StudentProvider(),
        ),
        ChangeNotifierProvider<DevorProvider>(
          create: (_) => DevorProvider(),
        ),
        ChangeNotifierProvider<TestProvider>(create: (_) => TestProvider()),
        ChangeNotifierProvider<TestAndDevoirProvider>(
            create: (_) => TestAndDevoirProvider()),
      ],
      child: BlocProvider(
        create: (context) =>
          GetModuleBloc()..add(GetModules()),
        child: MaterialApp(
            //scrollBehavior: MyCustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: MainScreen(),
            /*BlocProvider(
                  create: (context) {
                    return GetModuleBloc()..add(GetModules());
                  },
                  child: MainScreen(),
                ),*/
            routes: {
              // StudentListScreen.routeName:(context) => StudentListScreen(),
              DetailsStudentScreen.routeName: (context) =>
                  DetailsStudentScreen(),
            }
            // home: LoginScreen(),
            ),
      ),
    );
  }
}
