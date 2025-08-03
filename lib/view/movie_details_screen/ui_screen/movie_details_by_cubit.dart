import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieex/models/details_movie.dart';
import 'package:movieex/models/movie_models.dart';
import 'package:movieex/shared/components/default_stars.dart';
import 'package:movieex/view/movie_details_screen/logic/details_cubit/details_cubit_cubit.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailsScreen({
    super.key,
    required this.movieId,
    required Result movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Overview"),
      ),
      body: BlocProvider(
        create: (_) => DetailsCubitCubit()..getMovieDetails(movieId),
        child: BlocConsumer<DetailsCubitCubit, DetailsCubitState>(
          listener: (context, state) {
            if (state is DetailsCubitError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMesssage)));
            }
          },
          builder: (context, state) {
            if (state is DetailsCubitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailsCubitLoaded) {
              final DetmovieModels movie = state.detalisMovie;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "${movie.title} (${movie.releaseDate.year})",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    DefaultStars(voteAverage: movie.voteAverage),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children:
                            movie.genres
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
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
                        movie.overview,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "No data available",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
