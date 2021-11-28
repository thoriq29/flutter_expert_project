import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummyData/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });
}