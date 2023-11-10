import 'package:blocs/blocs.dart';
import 'package:eleve_repository/eleve_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_repository/module_repository.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GESTION",
    
      home: BlocBuilder<ModulesScreenBlocBloc, ModulesScreenBlocState>(
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ModulesScreenBlocBloc(moduleRepository: context.read<ModuleRepository>(),
                ),
              )
            ], 
            child:
          );
        },
      ),
    );
  }
}