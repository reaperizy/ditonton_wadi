part of 'detail_movie_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int id;

  const GetMovieDetailEvent(this.id);

  @override
  List<Object> get props => [];
}
