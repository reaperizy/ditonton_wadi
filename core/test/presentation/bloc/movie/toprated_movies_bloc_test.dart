import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie/toprated_movie/toprated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'toprated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies, TopRatedsMoviesBloc])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedsMoviesBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = TopRatedsMoviesBloc(mockGetTopRatedMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(movieTopRatedBloc.state, TopRatedsMoviesEmpty());
  });

  group(
    'Top Rated Movies BLoC Test',
    () {
      blocTest<TopRatedsMoviesBloc, TopRatedsMoviesState>(
        'Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(movieList));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(TopRatedsMoviesGetEvent()),
        expect: () => [TopRatedsMoviesLoading(), TopRatedsMoviesLoaded(movieList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );

      blocTest<TopRatedsMoviesBloc, TopRatedsMoviesState>(
        'Should emit [Loading, Error] when get top rated is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(TopRatedsMoviesGetEvent()),
        expect: () =>
            [TopRatedsMoviesLoading(), const TopRatedsMoviesError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );
    },
  );
}
