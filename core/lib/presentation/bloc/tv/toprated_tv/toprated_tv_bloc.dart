import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'toprated_tv_event.dart';
part 'toprated_tv_state.dart';

class TopRatedsTvsBloc extends Bloc<TopRatedsTvsEvent, TopRatedsTvsState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedsTvsBloc(
    this.getTopRatedTv,
  ) : super(TopRatedsTvsEmpty()) {
    on<TopRatedsTvsGetEvent>((event, emit) async {
      emit(TopRatedsTvsLoading());
      final result = await getTopRatedTv.execute();
      result.fold(
        (failure) {
          emit(TopRatedsTvsError(failure.message));
        },
        (data) {
          emit(TopRatedsTvsLoaded(data));
        },
      );
    });
  }
}
