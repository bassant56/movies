part of 'details_cubit_cubit.dart';

@immutable
sealed class DetailsCubitState {}

final class DetailsCubitInitial extends DetailsCubitState {}

final class DetailsCubitLoading extends DetailsCubitState {}

final class DetailsCubitLoaded extends DetailsCubitState {
  final DetmovieModels detalisMovie;
  DetailsCubitLoaded(this.detalisMovie);
}

final class DetailsCubitError extends DetailsCubitState {
  String errorMesssage;
  DetailsCubitError(this.errorMesssage);
}
