import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nowplaying_movie_event.dart';
part 'nowplaying_movie_state.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieNowPlayingBloc(
    this.getNowPlayingMovies,
  ) : super(MovieNowPlayingEmpty()) {
    on<MovieNowPlayingGetEvent>((event, emit) async {
      emit(MovieNowPlayingLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(MovieNowPlayingError(failure.message));
        },
        (data) {
          emit(MovieNowPlayingLoaded(data));
        },
      );
    });
  }
}
