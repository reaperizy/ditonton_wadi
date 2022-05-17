import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularsTvsBloc extends Bloc<PopularsTvsEvent, PopularsTvsState> {
  final GetPopularTv getPopularTv;

  PopularsTvsBloc(
    this.getPopularTv,
  ) : super(PopularsTvsEmpty()) {
    on<PopularsTvsGetEvent>((event, emit) async {
      emit(PopularsTvsLoading());
      final result = await getPopularTv.execute();
      result.fold(
        (failure) {
          emit(PopularsTvsError(failure.message));
        },
        (data) {
          emit(PopularsTvsLoaded(data));
        },
      );
    });
  }
}
