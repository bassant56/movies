part of 'details_cubit_cubit.dart';

@immutable
abstract class DetailsCubitState {}

class DetailsCubitInitial extends DetailsCubitState {}

class DetailsCubitLoading extends DetailsCubitState {}

class DetailsCubitLoaded extends DetailsCubitState {
  final DetmovieModels detalisMovie;
  DetailsCubitLoaded(this.detalisMovie);
}

class DetailsCubitError extends DetailsCubitState {
  final String errorMesssage;
  DetailsCubitError(this.errorMesssage);
}
