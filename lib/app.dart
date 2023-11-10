import 'package:blocs/blocs.dart';
import 'package:eleve_repository/eleve_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_repository/module_repository.dart';
import 'package:suivi_de_module/app_view.dart';

class MainApp extends StatelessWidget {
  final ModuleRepository moduleRepository;
  final EleveRepository eleveRepository;

  const MainApp(this.moduleRepository, this.eleveRepository,{super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ModulesScreenBlocBloc(moduleRepository: moduleRepository, eleveRepository: eleveRepository),
        )
      ], 
      child: AppView()
    );
  }
}