import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'toprated_tv_event.dart';
part 'toprated_tv_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv getTopRatedTv;

  TvTopRatedBloc(
    this.getTopRatedTv,
  ) : super(TvTopRatedEmpty()) {
    on<TvTopRatedGetEvent>((event, emit) async {
      emit(TvTopRatedLoading());
      final result = await getTopRatedTv.execute();
      result.fold(
        (failure) {
          emit(TvTopRatedError(failure.message));
        },
        (data) {
          emit(TvTopRatedLoaded(data));
        },
      );
    });
  }
}
