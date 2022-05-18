part of 'reccomend_movie_bloc.dart';

abstract class RecommendMoviesEvent extends Equatable {
  const RecommendMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendMoviesEvent extends RecommendMoviesEvent {
  final int id;

  const GetRecommendMoviesEvent(this.id);

  @override
  List<Object> get props => [];
}
