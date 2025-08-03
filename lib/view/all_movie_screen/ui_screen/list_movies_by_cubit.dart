import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieex/shared/components/default_stars.dart';

import 'package:movieex/view/all_movie_screen/logic/movie_cubit/movie_cubit_cubit.dart';
import 'package:movieex/view/movie_details_screen/ui_screen/movie_details_by_cubit.dart';

class MoviesCubitScreen extends StatelessWidget {
  const MoviesCubitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieCubitCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Watch Now"),
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<MovieCubitCubit, MovieCubitState>(
          builder: (context, state) {
            if (state is MovieCubitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieCubitLoaded) {
              final movies = state.movie;

              return GridView.builder(
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
                          builder:
                              (context) => MovieDetailsScreen(
                                movie: movie,
                                movieId: movie.id,
                              ),
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
                          DefaultStars(voteAverage: movie.voteAverage ?? 0),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is MovieCubitError) {
              return Center(
                child: Text(
                  state.errorMesssage,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const Center(
                child: Text("No data", style: TextStyle(color: Colors.white)),
              );
            }
          },
        ),
      ),
    );
  }
}
