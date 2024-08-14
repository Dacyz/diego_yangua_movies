import 'package:diego_yangua_movies/data/models/movie_model.dart';

abstract class MovieProvider {
  Future<List<Movie>> getMovies();
  Future<Movie> getMovie(Movie movie);
  Future<Movie> createMovie(Movie movie);
  Future<bool> updateMovie(Movie movie);
  Future<bool> deleteMovie(Movie movie);
}
