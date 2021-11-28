import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tv.dart';

import '../dummyData/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';


void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvSeries(mockTvRepository);
  });

  test('should get list of Tvs from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
