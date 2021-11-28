import 'package:bloc_test/bloc_test.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../dummyData/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';



@GenerateMocks([
  GetTopRatedTv,
])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });


  group('Now Playing Tv Bloc Test', () {
    blocTest<TopRatedTvBloc, TopRatedTvState>(
        'Test return (loading, loaded) when data is loaded successfully',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Right(testTvList));
          return topRatedTvBloc;
        },
        act: (bloc) => bloc.add(TopRatedTvEvent()),
        expect: () => [TopRatedTvLoading(), TopRatedTvLoaded(testTvList)],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        });

    blocTest<TopRatedTvBloc, TopRatedTvState>(
        'Test return (loading, error) when data is failed to loaded',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return topRatedTvBloc;
        },
        act: (bloc) => bloc.add(TopRatedTvEvent()),
        expect: () => [TopRatedTvLoading(), TopRatedTvError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        });
  });
}
