part of 'watchlist_tv_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class GetListEvent extends TvWatchlistEvent {}

class GetStatusTvEvent extends TvWatchlistEvent {
  final int id;

  const GetStatusTvEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddItemTvEvent extends TvWatchlistEvent {
  final TvDetail tvDetail;

  const AddItemTvEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveItemTvEvent extends TvWatchlistEvent {
  final TvDetail tvDetail;

  const RemoveItemTvEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
