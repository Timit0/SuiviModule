part of 'get_module_bloc.dart';

sealed class GetModuleBlocState extends Equatable {
  const GetModuleBlocState();
  
  @override
  List<Object> get props => [];
}

final class GetModuleBlocInitial extends GetModuleBlocState {}

final class GetModuleBlocLoading extends GetModuleBlocState {}
final class GetModuleBlocSuccess extends GetModuleBlocState {
  final List<Module> module;

  const GetModuleBlocSuccess({required this.module});
}
final class GetModuleBlocFailure extends GetModuleBlocState {
  final String errorMessage;

  GetModuleBlocFailure({required this.errorMessage});
}
