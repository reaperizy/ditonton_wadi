import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv getPopularTv;

  TvPopularBloc(
    this.getPopularTv,
  ) : super(TvPopularEmpty()) {
    on<TvPopularGetEvent>((event, emit) async {
      emit(TvPopularLoading());
      final result = await getPopularTv.execute();
      result.fold(
        (failure) {
          emit(TvPopularError(failure.message));
        },
        (data) {
          emit(TvPopularLoaded(data));
        },
      );
    });
  }
}
