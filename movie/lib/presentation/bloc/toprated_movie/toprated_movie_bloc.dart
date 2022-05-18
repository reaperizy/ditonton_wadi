import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'toprated_movie_event.dart';
part 'toprated_movie_state.dart';

class TopRatedsMoviesBloc
    extends Bloc<TopRatedsMoviesEvent, TopRatedsMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedsMoviesBloc(
    this.getTopRatedMovies,
  ) : super(TopRatedsMoviesEmpty()) {
    on<TopRatedsMoviesGetEvent>((event, emit) async {
      emit(TopRatedsMoviesLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(TopRatedsMoviesError(failure.message));
        },
        (data) {
          emit(TopRatedsMoviesLoaded(data));
        },
      );
    });
  }
}
