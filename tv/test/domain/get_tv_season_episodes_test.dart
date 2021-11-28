import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_season_episodes.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeasonEpisodes usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeasonEpisodes(mockTvRepository);
  });

  final tId = 1;
  final tSeasonId = 1;

  test('should get tv season eps from the repository', () async {
    // arrange
    when(mockTvRepository.getTvSeasonEpisodes(tId, tSeasonId))
        .thenAnswer((_) async => Right(testTvSeasonEpisode));
    // act
    final result = await usecase.execute(tId, tSeasonId);
    // assert
    expect(result, Right(testTvSeasonEpisode));
  });
}
