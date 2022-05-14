import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTv getWatchlistTv;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  TvWatchlistBloc({
    required this.getWatchlistTv,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvWatchlistEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(TvWatchlistLoading());
      final result = await getWatchlistTv.execute();
      result.fold(
        (failure) {
          emit(TvWatchlistError(failure.message));
        },
        (data) {
          emit(TvWatchlistLoaded(data));
        },
      );
    });

    on<GetStatusTvEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);

      emit(TvWatchlistStatusLoaded(result));
    });

    on<AddItemTvEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await saveWatchlist.execute(tvDetail);

      result.fold(
        (failure) {
          emit(TvWatchlistError(failure.message));
        },
        (successMessage) {
          emit(TvWatchlistSuccess(successMessage));
        },
      );
    });

    on<RemoveItemTvEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await removeWatchlist.execute(tvDetail);

      result.fold(
        (failure) {
          emit(TvWatchlistError(failure.message));
        },
        (successMessage) {
          emit(TvWatchlistSuccess(successMessage));
        },
      );
    });
  }
}
