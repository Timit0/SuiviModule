import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:eleve_repository/eleve_repository.dart';

part 'get_eleve_bloc_event.dart';
part 'get_eleve_bloc_state.dart';

class GetEleveBloc extends Bloc<GetEleveBlocEvent, GetEleveBlocState> {
  String? id;

  //Si il y'a un id la liste aura 1 seule élève sinon tous les élèves
  GetEleveBloc({this.id}) : super(GetEleveBlocInitial()) {
    on<GetEleves>((event, emit) async {
      emit(GetEleveBlocLoading());
      try{
        emit(GetEleveBlocSuccess(eleves: await FirebaseEleveRepository.instance.get(id: id)));
      }catch(e){
        emit(GetEleveBlocFailure(errorMessage: e.toString()));
      }
    });
  }
}
