import 'package:dio/dio.dart';
import 'package:movieex/models/movie_models.dart';

class MovieService {
  String endPoint =
      "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1";

  Future<List<Movie>> getMovie() async {
    List<Movie> movies = [];
    try {
      var response = await Dio().get(endPoint);
      var data = response.data;
      data.forEach((json) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      });
    } catch (e) {
      print(e);
    }
    return movies;
  }
}
