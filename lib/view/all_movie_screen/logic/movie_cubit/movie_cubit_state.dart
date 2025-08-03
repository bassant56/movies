part of 'movie_cubit_cubit.dart';

@immutable
sealed class MovieCubitState {}

final class MovieCubitInitial extends MovieCubitState {}

final class MovieCubitLoading extends MovieCubitState {}

final class MovieCubitLoaded extends MovieCubitState {
  final List<Result> movie;
  MovieCubitLoaded(this.movie);
}

final class MovieCubitError extends MovieCubitState {
  final String errorMesssage;
  MovieCubitError(this.errorMesssage);
}
