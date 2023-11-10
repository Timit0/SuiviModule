part of 'modules_screen_bloc_bloc.dart';

@immutable
sealed class ModulesScreenBlocState {}

final class ModulesScreenBlocInitial extends ModulesScreenBlocState {}

final class ModulesScreenBlocLoading extends ModulesScreenBlocState {}
final class ModulesScreenBlocSuccess extends ModulesScreenBlocState {
  final List<Module> modules;
  ModulesScreenBlocSuccess(this.modules);
}
final class ModulesScreenBlocError extends ModulesScreenBlocState {}
