import 'package:dio/dio.dart';
import 'package:movieex/models/details_movie.dart';

class DetmovieService {
  final int id;
  final Dio _client = Dio();
  late String endpoint;
  DetmovieService({required this.id}) {
    endpoint = 'https://api.themoviedb.org/3/movie/$id';
  }

  Future<DetmovieModels> getDetMovie() async {
    late DetmovieModels detmovieModels;
    try {
      _client.options.headers.addAll({
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDI2MWVhZTBkODNlZjRlNzJhMzQ5OTU5MzJhZmVkYiIsIm5iZiI6MTc1Mzc4MzA4OC42MjcsInN1YiI6IjY4ODg5YjMwYzJhZGFkZTI0MDU1ZmM2MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JX9q1HhhxzYzNjtzUHhGTo4gxedYprDCdIOUvAobvIM',
        'version': 120,
      });
      var response = await _client.get(endpoint);
      var data = response.data;
      print(data);

      detmovieModels = detmovieModelsFromJson(response.data);
    } catch (e) {
      print(e);
    }
    return detmovieModels;
  }
}
