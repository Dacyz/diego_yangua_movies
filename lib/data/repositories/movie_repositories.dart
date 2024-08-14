import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:diego_yangua_movies/data/providers/base_provider.dart';
import 'package:diego_yangua_movies/data/providers/movie_provider.dart';

/// Class that provides methods to make HTTP requests to the API
/// to get, create, update and delete movies.
class MockProvider extends BaseProvider implements MovieProvider {
  /// The collection name for this provider.
  static const collection = 'movies';

  /// Gets a list of movies from the API.
  ///
  /// Returns a list of [Movie] objects.
  @override
  Future<List<Movie>> getMovies() async {
    final response = await super.get(collection);
    final list = response.data as List<dynamic>;
    return list.map((i) => Movie.fromJson(i as Map<String, dynamic>)).toList();
  }

  /// Gets a movie from the API by its ID.
  ///
  /// Parameters:
  ///   - movie: The movie to get.
  ///
  /// Returns a [Movie] object.
  @override
  Future<Movie> getMovie(Movie movie) async {
    final response = await super.get('$collection/${movie.id}');
    return Movie.fromJson(response.data as Map<String, dynamic>);
  }

  /// Creates a new movie in the API.
  ///
  /// Parameters:
  ///   - movie: The movie to create.
  ///
  /// Returns a [Movie] object.
  @override
  Future<Movie> createMovie(Movie movie) async {
    final response = await super.post(collection, movie.toJson());
    return Movie.fromJson(response.data as Map<String, dynamic>);
  }

  /// Updates a movie in the API.
  ///
  /// Parameters:
  ///   - movie: The movie to update.
  ///
  /// Returns a boolean indicating if the update was successful.
  @override
  Future<bool> updateMovie(Movie movie) async {
    final response = await super.put('$collection/${movie.id}', movie.toJson());
    return response.statusCode == 200;
  }

  /// Deletes a movie from the API.
  ///
  /// Parameters:
  ///   - movie: The movie to delete.
  ///
  /// Returns a boolean indicating if the delete was successful.
  @override
  Future<bool> deleteMovie(Movie movie) async {
    final response = await super.delete('$collection/${movie.id}');
    return response.statusCode == 200;
  }
}
