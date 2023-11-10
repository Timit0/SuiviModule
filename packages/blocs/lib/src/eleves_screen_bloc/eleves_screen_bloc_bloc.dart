import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'eleves_screen_bloc_event.dart';
part 'eleves_screen_bloc_state.dart';

class ElevesScreenBlocBloc extends Bloc<ElevesScreenBlocEvent, ElevesScreenBlocState> {
  ElevesScreenBlocBloc() : super(ElevesScreenBlocInitial()) {
    on<ElevesScreenBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
