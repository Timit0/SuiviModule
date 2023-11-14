part of 'get_module_bloc.dart';

sealed class GetModuleBlocEvent extends Equatable {
  const GetModuleBlocEvent();

  @override
  List<Object> get props => [];
}

class GetModules extends GetModuleBlocEvent {
  GetModules();
}
