import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../core/test/helpers/test_helper_tv.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTv(mockTvRepository);
  });

  final tTv = <Tv>[];
  const tQuery = 'Game of throne';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.searchTv(tQuery)).thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}
