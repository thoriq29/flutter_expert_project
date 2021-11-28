import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv/get_search_tv.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late SearchTV usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTV(mockTvRepository);
  });

  final tTvs = <Tv>[];
  final tQuery = 'Squid';

  test('should get list of Tvs from the repository', () async {
    // arrange
    when(mockTvRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvs));
  });
}
