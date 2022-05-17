import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularsMoviesBloc extends Bloc<PopularsMoviesEvent, PopularsMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularsMoviesBloc(
    this.getPopularMovies,
  ) : super(PopularsMoviesEmpty()) {
    on<PopularsMoviesGetEvent>((event, emit) async {
      emit(PopularsMoviesLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(PopularsMoviesError(failure.message));
        },
        (data) {
          emit(PopularsMoviesLoaded(data));
        },
      );
    });
  }
}
