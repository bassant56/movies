import 'package:flutter/material.dart';
import 'package:movieex/service/service_model.dart';
import 'package:movieex/models/movie_models.dart';
import 'package:movieex/shared/components/default_stars.dart';
import 'package:movieex/view/movie_details_screen/ui_screen/movie_details.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<Result> movies = [];
  bool loading = true;

  getMyMovie() async {
    movies = (await MovieService().getMovie()).results; //?
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMyMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Watch Now"),
        backgroundColor: Colors.black,
      ),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.6,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final imageUrl =
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}';

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetails(movie: movie),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              imageUrl,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DefaultStars(voteAverage: movie.voteAverage),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
