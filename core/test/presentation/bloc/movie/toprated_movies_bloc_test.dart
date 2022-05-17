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

@GenerateMocks([GetTopRatedMovies, MovieTopRatedBloc])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  group(
    'Top Rated Movies BLoC Test',
    () {
      blocTest<MovieTopRatedBloc, MovieTopRatedState>(
        'Should emit [Loading, Loaded] when data is gotten successfully',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => Right(movieList));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(MovieTopRatedGetEvent()),
        expect: () => [MovieTopRatedLoading(), MovieTopRatedLoaded(movieList)],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );

      blocTest<MovieTopRatedBloc, MovieTopRatedState>(
        'Should emit [Loading, Error] when get top rated is unsuccessful',
        build: () {
          when(mockGetTopRatedMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return movieTopRatedBloc;
        },
        act: (bloc) => bloc.add(MovieTopRatedGetEvent()),
        expect: () =>
            [MovieTopRatedLoading(), const MovieTopRatedError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedMovies.execute());
        },
      );
    },
  );
}
