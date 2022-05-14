part of 'reccomend_movie_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetMovieRecommendationEvent extends MovieRecommendationEvent {
  final int id;

  const GetMovieRecommendationEvent(this.id);

  @override
  List<Object> get props => [];
}
