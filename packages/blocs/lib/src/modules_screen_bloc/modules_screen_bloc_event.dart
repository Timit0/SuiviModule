part of 'modules_screen_bloc_bloc.dart';

@immutable
sealed class MainScreenBlocEvent {
  const MainScreenBlocEvent();
}

class ModulesScreenBlocModules extends MainScreenBlocEvent{
  const ModulesScreenBlocModules();
}

class MainScreenBlocEleves extends MainScreenBlocEvent{
  const MainScreenBlocEleves();
}
