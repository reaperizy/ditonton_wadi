part of 'toprated_movie_bloc.dart';

abstract class TopRatedsMoviesEvent extends Equatable {
  const TopRatedsMoviesEvent();

  @override
  List<Object> get props => [];
}

class TopRatedsMoviesGetEvent extends TopRatedsMoviesEvent {}
