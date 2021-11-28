import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_status.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatus usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListStatus(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
