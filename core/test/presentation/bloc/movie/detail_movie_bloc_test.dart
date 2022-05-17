import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:core/presentation/bloc/movie/detailmovie/detail_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';
@GenerateMocks([DetailsMoviesBloc, GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late DetailsMoviesBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = DetailsMoviesBloc(getMovieDetail: mockGetMovieDetail);
  });

  const movieId = 1;

  test("initial state should be empty", () {
    expect(movieDetailBloc.state, MoviesDetailsEmpty());
  });

  group('Detail Movies BLoC Test', () {
    blocTest<DetailsMoviesBloc, DetailsMoviesState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(movieId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const GetDetailsMoviesEvent(movieId)),
      expect: () =>
      [MoviesDetailsLoading(), const MoviesDetailsLoaded(testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(movieId));
      },
    );

    blocTest<DetailsMoviesBloc, DetailsMoviesState>(
      'Should emit [Loading, Error] when get detail is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(movieId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const GetDetailsMoviesEvent(movieId)),
      expect: () =>
      [MoviesDetailsLoading(), const MoviesDetailsError('Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(movieId));
      },
    );
  });
}
