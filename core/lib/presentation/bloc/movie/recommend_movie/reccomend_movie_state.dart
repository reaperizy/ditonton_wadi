part of 'reccomend_movie_bloc.dart';

abstract class RecommendMoviesState extends Equatable {
  const RecommendMoviesState();

  @override
  List<Object> get props => [];
}

class RecommendMoviesEmpty extends RecommendMoviesState {}

class RecommendMoviesLoading extends RecommendMoviesState {}

class RecommendMoviesError extends RecommendMoviesState {
  final String message;

  const RecommendMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendMoviesLoaded extends RecommendMoviesState {
  final List<Movie> movie;

  const RecommendMoviesLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}
