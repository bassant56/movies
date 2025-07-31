import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieex/view/movie_details_screen/logic/details_cubit/details_cubit_cubit.dart';

class Userlistbycubit extends StatelessWidget {
  final int movieId;
  const Userlistbycubit({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              final movie = state.detalisMovie;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(movie.overview),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
