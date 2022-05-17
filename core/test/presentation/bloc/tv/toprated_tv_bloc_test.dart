import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:core/presentation/bloc/tv/toprated_tv/toprated_tv_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'toprated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv, TvTopRatedBloc])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTopRatedTv);
  });

  final tvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvTopRatedBloc.state, TvTopRatedEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tvList));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(TvTopRatedGetEvent()),
      expect: () => [TvTopRatedLoading(), TvTopRatedLoaded(tvList)],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'Should emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(TvTopRatedGetEvent()),
      expect: () =>
      [TvTopRatedLoading(), const TvTopRatedError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  },);
}