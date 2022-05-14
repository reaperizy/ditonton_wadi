part of 'popular_tv_bloc.dart';

abstract class TvPopularEvent extends Equatable {
  const TvPopularEvent();

  @override
  List<Object> get props => [];
}

class TvPopularGetEvent extends TvPopularEvent {}
