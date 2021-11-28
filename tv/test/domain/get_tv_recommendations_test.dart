import 'package:dartz/dartz.dart';
import 'package:tv/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummyData/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  final tId = 1;

  test('should get list of Tv recommendations from the repository',
      () async {
    // arrange
    when(mockTvRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvList));
  });
}
