import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;

  TvDetailBloc({
    required this.getTvDetail,
  }) : super(TvDetailEmpty()) {
    on<GetTvDetailEvent>((event, emit) async {
      emit(TvDetailLoading());
      final result = await getTvDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (data) {
          emit(TvDetailLoaded(data));
        },
      );
    });
  }
}
