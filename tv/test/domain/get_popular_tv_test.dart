import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetPopularTv(mockTvRpository);
  });

  final tTvs = <Tv>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv series from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getPopularTvSeries())
            .thenAnswer((_) async => Right(tTvs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvs));
      });
    });
  });
}
