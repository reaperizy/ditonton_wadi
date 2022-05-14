part of 'toprated_movie_bloc.dart';

abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

class MovieTopRatedGetEvent extends MovieTopRatedEvent {}
