part of 'popular_movie_bloc.dart';

abstract class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();

  @override
  List<Object> get props => [];
}

class MoviePopularGetEvent extends MoviePopularEvent {}
