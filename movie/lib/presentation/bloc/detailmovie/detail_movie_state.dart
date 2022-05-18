part of 'detail_movie_bloc.dart';

abstract class DetailsMoviesState extends Equatable {
  const DetailsMoviesState();

  @override
  List<Object> get props => [];
}

class MoviesDetailsEmpty extends DetailsMoviesState {}

class MoviesDetailsLoading extends DetailsMoviesState {}

class MoviesDetailsError extends DetailsMoviesState {
  final String message;

  const MoviesDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesDetailsLoaded extends DetailsMoviesState {
  final MovieDetail movieDetail;

  const MoviesDetailsLoaded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
