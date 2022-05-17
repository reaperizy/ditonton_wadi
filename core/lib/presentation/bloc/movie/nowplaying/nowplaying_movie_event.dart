part of 'nowplaying_movie_bloc.dart';

abstract class NowPlayingsMoviesEvent extends Equatable {
  const NowPlayingsMoviesEvent();

  @override
  List<Object> get props => [];
}

class NowPlayingsMoviesGetEvent extends NowPlayingsMoviesEvent {}
