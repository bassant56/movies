import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieex/models/movie_models.dart';
import 'package:movieex/service/service_model.dart';

part 'movie_cubit_state.dart';

class MovieCubitCubit extends Cubit<MovieCubitState> {
  MovieCubitCubit() : super(MovieCubitInitial()) {
    getMoviee();
  }

  getMoviee() async {
    try {
      emit(MovieCubitLoading());
      List<Movies> movie = [];
      movie = (await MovieService().getMovie()) as List<Movies>;
      emit(MovieCubitLoaded(movie));
    } catch (e) {
      emit(MovieCubitError(e.toString()));
    }
  }
}
