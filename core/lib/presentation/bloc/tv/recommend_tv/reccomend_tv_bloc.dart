import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'reccomend_tv_event.dart';
part 'reccomend_tv_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvRecommendations getTvRecommendations;

  TvRecommendationBloc({
    required this.getTvRecommendations,
  }) : super(TvRecommendationEmpty()) {
    on<GetTvRecommendationEvent>((event, emit) async {
      emit(TvRecommendationLoading());
      final result = await getTvRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(TvRecommendationError(failure.message));
        },
        (data) {
          emit(TvRecommendationLoaded(data));
        },
      );
    });
  }
}
