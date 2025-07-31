import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieex/models/details_movie.dart';
import 'package:movieex/service/detmovie_service.dart';

part 'details_cubit_state.dart';

class DetailsCubitCubit extends Cubit<DetailsCubitState> {
  DetailsCubitCubit() : super(DetailsCubitInitial());

  Future<void> getMovieDetails(int id) async {
    emit(DetailsCubitLoading());
    try {
      final result = await DetmovieService(id: id).getDetMovie();
      emit(DetailsCubitLoaded(result));
    } catch (e) {
      emit(DetailsCubitError(e.toString()));
    }
  }
}
