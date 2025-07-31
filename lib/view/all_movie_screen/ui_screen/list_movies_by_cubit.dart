import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieex/models/movie_models.dart';
import 'package:movieex/view/all_movie_screen/logic/movie_cubit/movie_cubit_cubit.dart';

class Userlistbycubit extends StatefulWidget {
  const Userlistbycubit({super.key});

  @override
  State<Userlistbycubit> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Userlistbycubit> {
  List<Movies> moviess = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MovieCubitCubit(),
        child: BlocConsumer<MovieCubitCubit, MovieCubitState>(
          listener: (context, state) {
            if (state is MovieCubitError) {
              SnackBar snackBar = SnackBar(content: Text(state.errorMesssage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is MovieCubitLoaded) {
              moviess = state.movie;
            }
          },
          builder: (context, state) {
            if (state is MovieCubitLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieCubitLoaded) {
              return ListView.builder(
                itemCount: moviess.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(moviess[index].results as String),
                  );
                },
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
