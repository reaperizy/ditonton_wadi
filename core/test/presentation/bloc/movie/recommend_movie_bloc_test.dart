import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/movie/recommend_movie/reccomend_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommend_movie_bloc_test.mocks.dart';

@GenerateMocks([MovieRecommendationBloc,GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendation;
  late MovieRecommendationBloc movieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(
      getMovieRecommendations: mockGetMovieRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  const movieId = 1;
  final movieList = <Movie>[];

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(movieId))
          .thenAnswer((_) async => Right(movieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendationEvent(movieId)),
    expect: () =>
    [MovieRecommendationLoading(), MovieRecommendationLoaded(movieList)],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(movieId));
    },
  );

  group('Recommendation Movies BLoC Test', () {
    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'Should emit [Loading, Error] when get recommendation is unsuccessful',
      build: () {
        when(mockGetMovieRecommendation.execute(movieId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(const GetMovieRecommendationEvent(movieId)),
      expect: () => [
        MovieRecommendationLoading(),
        const MovieRecommendationError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendation.execute(movieId));
      },
    );
  },
  );
}