import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist.dart';

import '../dummyData/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlist(mockTvRepository);
  });

  test('should remove watchlist Tv from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
