import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'reccomend_movie_event.dart';
part 'reccomend_movie_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc({
    required this.getMovieRecommendations,
  }) : super(MovieRecommendationEmpty()) {
    on<GetMovieRecommendationEvent>((event, emit) async {
      emit(MovieRecommendationLoading());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(MovieRecommendationError(failure.message));
        },
        (data) {
          emit(MovieRecommendationLoaded(data));
        },
      );
    });
  }
}
