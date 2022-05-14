part of 'reccomend_tv_bloc.dart';

abstract class TvRecommendationState extends Equatable {
  const TvRecommendationState();

  @override
  List<Object> get props => [];
}

class TvRecommendationEmpty extends TvRecommendationState {}

class TvRecommendationLoading extends TvRecommendationState {}

class TvRecommendationError extends TvRecommendationState {
  final String message;

  const TvRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvRecommendationLoaded extends TvRecommendationState {
  final List<Tv> tv;

  const TvRecommendationLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}
