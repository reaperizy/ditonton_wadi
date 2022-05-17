part of 'popular_movie_bloc.dart';

abstract class PopularsMoviesState extends Equatable {
  const PopularsMoviesState();

  @override
  List<Object> get props => [];
}

class PopularsMoviesEmpty extends PopularsMoviesState {}

class PopularsMoviesLoading extends PopularsMoviesState {}

class PopularsMoviesError extends PopularsMoviesState {
  final String message;

  const PopularsMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularsMoviesLoaded extends PopularsMoviesState {
  final List<Movie> result;

  const PopularsMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}
