import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/presentation/bloc/tv/detail_tv/detail_tv_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail, TvDetailBloc])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late TvDetailBloc tvDetailBloc;
  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(getTvDetail: mockGetTvDetail);
  });

  const tvId = 1;

  test("initial state should be empty", () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  group('Top Rated Movies BLoC Test', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tvId))
            .thenAnswer((_) async => Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const GetTvDetailEvent(tvId)),
      expect: () => [TvDetailLoading(), TvDetailLoaded(testTvDetail)],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tvId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, Error] when get detail is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tvId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const GetTvDetailEvent(tvId)),
      expect: () => [TvDetailLoading(), const TvDetailError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tvId));
      },
    );
  },);
}