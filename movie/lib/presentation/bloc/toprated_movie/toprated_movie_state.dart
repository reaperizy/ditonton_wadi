part of 'toprated_movie_bloc.dart';

abstract class TopRatedsMoviesState extends Equatable {
  const TopRatedsMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedsMoviesEmpty extends TopRatedsMoviesState {}

class TopRatedsMoviesLoading extends TopRatedsMoviesState {}

class TopRatedsMoviesError extends TopRatedsMoviesState {
  final String message;

  const TopRatedsMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedsMoviesLoaded extends TopRatedsMoviesState {
  final List<Movie> result;

  const TopRatedsMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}
