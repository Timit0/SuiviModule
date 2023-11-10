import 'package:bloc/bloc.dart';
import 'package:eleve_repository/eleve_repository.dart';
import 'package:meta/meta.dart';
import 'package:module_repository/module_repository.dart';

import 'dart:developer' as dev;

part 'modules_screen_bloc_event.dart';
part 'modules_screen_bloc_state.dart';



class ModulesScreenBlocBloc extends Bloc<MainScreenBlocEvent, ModulesScreenBlocState> {
  final ModuleRepository _moduleRepository;

  ModulesScreenBlocBloc({required ModuleRepository moduleRepository}) 
  : _moduleRepository = moduleRepository, super(ModulesScreenBlocInitial()) {

    on<ModulesScreenBlocModules>((event, emit) async {
      emit(ModulesScreenBlocLoading());
      try
      {
        final List<Module> modules = await _moduleRepository.get();
        emit(ModulesScreenBlocSuccess(modules));
      }catch(e){
        emit(ModulesScreenBlocError());
        dev.log(e.toString());
      }
    });
  }
}
