import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/tv/get_popular_tv.dart';
import 'package:core/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv, PopularsTvsBloc])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularsTvsBloc tvPopularBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvPopularBloc = PopularsTvsBloc(mockGetPopularTv);
  });

  final TvList = <Tv>[];

  test("initial state should be empty", () {
    expect(tvPopularBloc.state, PopularsTvsEmpty());
  });

  group('Popular Tv BLoC Test', () {
    blocTest<PopularsTvsBloc, PopularsTvsState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(TvList));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(PopularsTvsGetEvent()),
      expect: () => [PopularsTvsLoading(), PopularsTvsLoaded(TvList)],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularsTvsBloc, PopularsTvsState>(
      'Should emit [Loading, Error] when get popular is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(PopularsTvsGetEvent()),
      expect: () => [PopularsTvsLoading(),  const PopularsTvsError('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  },);
}