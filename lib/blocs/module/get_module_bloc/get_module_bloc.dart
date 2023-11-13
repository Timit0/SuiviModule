import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:module_repository/module_repository.dart';

part 'get_module_bloc_event.dart';
part 'get_module_bloc_state.dart';

class GetModuleBloc extends Bloc<GetModuleBlocEvent, GetModuleBlocState> {
  GetModuleBloc() : super(GetModuleBlocInitial()) {
    on<GetModules>((event, emit) async {
      emit(GetModuleBlocLoading());
      try{
        emit(GetModuleBlocSuccess(module: await FirebaseModuleRepository.instance.get()));
      }catch(e){
        emit(GetModuleBlocFailure(errorMessage: e.toString()));
      }
    });
  }
}
