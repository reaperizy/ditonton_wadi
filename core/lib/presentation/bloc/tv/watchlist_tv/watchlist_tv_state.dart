part of 'watchlist_tv_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistEmpty extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  const TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistSuccess extends TvWatchlistState {
  final String message;

  const TvWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistLoaded extends TvWatchlistState {
  final List<Tv> result;

  const TvWatchlistLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvWatchlistStatusLoaded extends TvWatchlistState {
  final bool result;

  const TvWatchlistStatusLoaded(this.result);

  @override
  List<Object> get props => [result];
}
