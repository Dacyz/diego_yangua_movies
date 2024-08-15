import 'package:bloc/bloc.dart';
import 'package:diego_yangua_movies/data/models/genre_enum.dart';
import 'package:diego_yangua_movies/data/models/movie_model.dart';
import 'package:diego_yangua_movies/data/repositories/movie_repositories.dart';
import 'package:equatable/equatable.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final provider = MockProvider();
  MoviesBloc() : super(MoviesInitial()) {
    on<GetMovies>(_onStarted);
    on<SearchMovie>(_onSearchMovie);
    on<RateMovie>(_onRateMovie);
  }

  Future<void> _onStarted(GetMovies event, Emitter<MoviesState> emit) async {
    try {
      emit(MoviesLoading());
      final movies = await provider.getMovies();
      emit(MoviesLoaded(movies: movies));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  Future<void> _onSearchMovie(SearchMovie event, Emitter<MoviesState> emit) async {
    try {
      emit(MoviesLoading());
      final movies = await provider.getMovies();
      final test = event.genre == Genre.notFound
          ? (Movie movie) => movie.title.contains(event.movie)
          : (Movie movie) => movie.title.contains(event.movie) && movie.genre == event.genre;
      final filteredMovies = movies.where(test).toList();
      emit(MoviesLoaded(movies: filteredMovies));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  Future<void> _onRateMovie(RateMovie event, Emitter<MoviesState> emit) async {
    try {
      // Rate a movie from good to bad
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }
}
