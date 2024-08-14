import 'package:diego_yangua_movies/presentation/bloc/movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoviesBloc()..add(GetMovies()),
      child: const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Hello World!'),
          ),
        ),
      ),
    );
  }
}
