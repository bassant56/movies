import 'package:flutter/material.dart';
import 'package:movieex/models/detmovie_models.dart';
import 'package:movieex/models/movie_models.dart';
import 'package:movieex/service/detmovie_service.dart';

class MovieDetails extends StatefulWidget {
  final Result movie;
  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late DetmovieModels detmovieModels;
  bool loading = true;

  getMyMovie() async {
    detmovieModels = await DetmovieService(id: widget.movie.id).getDetMovie();
    setState(() {
      loading = false;
    });
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
        backgroundColor: Colors.black,
        title: const Text("Overview"),
      ),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/w500${detmovieModels.backdropPath}",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "${detmovieModels.title} (${detmovieModels.releaseDate.year})",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < (detmovieModels.voteAverage / 2).round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        children:
                            detmovieModels.genres
                                .map(
                                  (genre) => Chip(
                                    label: Text(genre.name),
                                    backgroundColor: Colors.grey[800],
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text(
                        "Storyline",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        detmovieModels.overview,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
    );
  }
}
