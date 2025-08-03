import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieex/models/movie_models.dart';
import 'package:movieex/service/service_model.dart';

part 'movie_cubit_state.dart';

class MovieCubitCubit extends Cubit<MovieCubitState> {
  MovieCubitCubit() : super(MovieCubitInitial()) {
    getMoviee();
  }

  void getMoviee() async {
    emit(MovieCubitLoading());
    try {
      final response = await MovieService().getMovie();
      emit(MovieCubitLoaded(response.results.cast<Result>()));
    } catch (e) {
      emit(MovieCubitError(e.toString()));
    }
  }
}
