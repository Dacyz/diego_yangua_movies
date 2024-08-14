part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMovies extends MoviesEvent {}

class ToggleGenre extends MoviesEvent {
  final Genre genre;

  const ToggleGenre(this.genre);

  @override
  List<Object> get props => [genre];
}

class SearchMovie extends MoviesEvent {
  final String movie;

  const SearchMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class RateMovie extends MoviesEvent {
  final double rate;
  final Movie movie;

  const RateMovie(this.rate, this.movie);

  @override
  List<Object> get props => [rate, movie];
}
