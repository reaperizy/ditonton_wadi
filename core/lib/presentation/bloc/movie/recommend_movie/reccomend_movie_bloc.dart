import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'reccomend_movie_event.dart';
part 'reccomend_movie_state.dart';

class RecommendMoviesBloc
    extends Bloc<RecommendMoviesEvent, RecommendMoviesState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendMoviesBloc({
    required this.getMovieRecommendations,
  }) : super(RecommendMoviesEmpty()) {
    on<GetRecommendMoviesEvent>((event, emit) async {
      emit(RecommendMoviesLoading());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(RecommendMoviesError(failure.message));
        },
        (data) {
          emit(RecommendMoviesLoaded(data));
        },
      );
    });
  }
}
