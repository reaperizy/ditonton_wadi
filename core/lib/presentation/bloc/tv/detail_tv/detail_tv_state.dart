part of 'detail_tv_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailLoaded extends TvDetailState {
  final TvDetail tvDetail;

  const TvDetailLoaded(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
