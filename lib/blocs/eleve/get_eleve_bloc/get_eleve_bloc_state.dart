part of 'get_eleve_bloc.dart';

sealed class GetEleveBlocState extends Equatable {
  const GetEleveBlocState();
  
  @override
  List<Object> get props => [];
}

final class GetEleveBlocInitial extends GetEleveBlocState {}

final class GetEleveBlocLoading extends GetEleveBlocState {}
final class GetEleveBlocSuccess extends GetEleveBlocState {
  final List<Eleve> eleves;
  const GetEleveBlocSuccess({required this.eleves});
}
final class GetEleveBlocFailure extends GetEleveBlocState {
  final String errorMessage;

  const GetEleveBlocFailure({required this.errorMessage});
}
