part of 'nowplaying_movie_bloc.dart';

abstract class NowPlayingsMoviesState extends Equatable {
  const NowPlayingsMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingsMoviesEmpty extends NowPlayingsMoviesState {}

class NowPlayingsMoviesLoading extends NowPlayingsMoviesState {}

class NowPlayingsMoviesError extends NowPlayingsMoviesState {
  final String message;

  const NowPlayingsMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingsMoviesLoaded extends NowPlayingsMoviesState {
  final List<Movie> result;

  const NowPlayingsMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}
