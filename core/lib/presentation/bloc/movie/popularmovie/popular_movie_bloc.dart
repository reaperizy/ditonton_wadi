import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies getPopularMovies;

  MoviePopularBloc(
    this.getPopularMovies,
  ) : super(MoviePopularEmpty()) {
    on<MoviePopularGetEvent>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(MoviePopularError(failure.message));
        },
        (data) {
          emit(MoviePopularLoaded(data));
        },
      );
    });
  }
}
