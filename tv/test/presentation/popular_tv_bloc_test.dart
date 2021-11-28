import 'package:bloc_test/bloc_test.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/usecases/tv/get_popular_tv.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../dummyData/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularTv,
])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  group('Now Playing Tv BLoC Test', () {
    blocTest<PopularTvBloc, PopularTvState>(
        'Test return (loading, loaded) when data is loaded successfully',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(testTvList));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(PopularTvEvent()),
        expect: () => [PopularTvLoading(), PopularTvLoaded(testTvList)],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });

    blocTest<PopularTvBloc, PopularTvState>(
        'Test return (loading, error) when data is failed to loaded',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(PopularTvEvent()),
        expect: () => [PopularTvLoading(), PopularTvError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });
  });
}
