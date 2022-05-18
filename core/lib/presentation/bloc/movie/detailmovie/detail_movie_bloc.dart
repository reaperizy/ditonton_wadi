import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailsMoviesBloc extends Bloc<DetailsMoviesEvent, DetailsMoviesState> {
  final GetMovieDetail getMovieDetail;

  DetailsMoviesBloc({
    required this.getMovieDetail,
  }) : super(MoviesDetailsEmpty()) {
    on<GetDetailsMoviesEvent>((event, emit) async {
      emit(MoviesDetailsLoading());
      final result = await getMovieDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(MoviesDetailsError(failure.message));
        },
        (data) {
          emit(MoviesDetailsLoaded(data));
        },
      );
    });
  }
}
