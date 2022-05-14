import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onair_tv_event.dart';
part 'onair_tv_state.dart';

class TvOnAirBloc extends Bloc<TvOnAirEvent, TvOnAirState> {
  final GetNowPlayingTv getOnAirTv;

  TvOnAirBloc(
    this.getOnAirTv,
  ) : super(TvOnAirEmpty()) {
    on<TvOnAirGetEvent>((event, emit) async {
      emit(TvOnAirLoading());
      final result = await getOnAirTv.execute();
      result.fold(
        (failure) {
          emit(TvOnAirError(failure.message));
        },
        (data) {
          emit(TvOnAirLoaded(data));
        },
      );
    });
  }
}
