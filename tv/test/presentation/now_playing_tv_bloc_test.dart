import 'package:bloc_test/bloc_test.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:tv/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTv,
])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  final tTvList = <Tv>[];

  group('Now Playing Tv BLoC Test', () {
    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Test return (loading, loaded) when data is loaded successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTvEvent()),
      expect: () => [NowPlayingTvLoading(), NowPlayingTvLoaded(tTvList)],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      }
    );

    blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'Test return (loading, error) when data is failed to loaded',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTvEvent()),
      expect: () => [NowPlayingTvLoading(), NowPlayingTvError('Server Failure')],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      }
    );
  });
}
