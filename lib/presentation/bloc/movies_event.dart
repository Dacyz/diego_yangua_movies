part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMovies extends MoviesEvent {}

class SearchMovie extends MoviesEvent {
  final String movie;
  final Genre genre;

  const SearchMovie(this.movie, [this.genre = Genre.notFound]);

  @override
  List<Object> get props => [movie, genre];
}

class RateMovie extends MoviesEvent {
  final double rate;
  final Movie movie;

  const RateMovie(this.rate, this.movie);

  @override
  List<Object> get props => [rate, movie];
}

class UpdateMovies extends MoviesEvent {
  final Movie movie;

  const UpdateMovies(this.movie);

  @override
  List<Object> get props => [movie];
}
