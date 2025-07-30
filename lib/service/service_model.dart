import 'package:dio/dio.dart';
import 'package:movieex/models/movie_models.dart';

class MovieService {
  final Dio _client = Dio();
  String endPoint =
      "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1";

  Future<Movies> getMovie() async {
    late Movies movies;
    try {
      _client.options.headers.addAll({
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDI2MWVhZTBkODNlZjRlNzJhMzQ5OTU5MzJhZmVkYiIsIm5iZiI6MTc1Mzc4MzA4OC42MjcsInN1YiI6IjY4ODg5YjMwYzJhZGFkZTI0MDU1ZmM2MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JX9q1HhhxzYzNjtzUHhGTo4gxedYprDCdIOUvAobvIM',
      });
      var response = await _client.get(endPoint);
      var data = response.data;

      movies = moviesFromJson(response.data);
    } catch (e) {
      print(e);
    }
    return movies;
  }
}
