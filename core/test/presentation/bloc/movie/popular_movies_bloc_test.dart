import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/presentation/bloc/movie/popularmovie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([PopularsMoviesBloc,GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularsMoviesBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = PopularsMoviesBloc(mockGetPopularMovies);
  });

  final movieList = <Movie>[];

  test("initial state should be empty", () {
    expect(moviePopularBloc.state, PopularsMoviesEmpty());
  });

  group('Popular Movies BLoC Test', () {
    blocTest<PopularsMoviesBloc, PopularsMoviesState>(
        'Should emit [loading, loaded] when data is loaded successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(movieList));
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(PopularsMoviesGetEvent()),
        expect: () =>
        [PopularsMoviesLoading(), PopularsMoviesLoaded(movieList)],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });

    blocTest<PopularsMoviesBloc, PopularsMoviesState>(
        'Should emit [loading, error] when data is failed to loaded',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
          return moviePopularBloc;
        },
        act: (bloc) => bloc.add(PopularsMoviesGetEvent()),
        expect: () =>
        [PopularsMoviesLoading(), const PopularsMoviesError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}