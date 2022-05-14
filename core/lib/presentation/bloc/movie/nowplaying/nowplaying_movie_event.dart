part of 'nowplaying_movie_bloc.dart';

abstract class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingGetEvent extends MovieNowPlayingEvent {}
