import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/list/now_playing_movies_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late NowPlayingMoviesBloc nowplayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowplayingMoviesBloc = NowPlayingMoviesBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  group('Now Playing Movies BLoC Test', () {
    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
        'Test return (loading, loadedData) when data is loaded successfully',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return nowplayingMoviesBloc;
        },
        act: (bloc) => bloc.add(NowPlayingMoviesEvent()),
        expect: () =>
            [NowPlayingMoviesLoading(), NowPlayingMoviesLoaded(testMovieList)],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
        'Test return (loading, error) when data is failed to loaded',
        build: () {
          when(mockGetNowPlayingMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return nowplayingMoviesBloc;
        },
        act: (bloc) => bloc.add(NowPlayingMoviesEvent()),
        expect: () =>
            [NowPlayingMoviesLoading(), NowPlayingMoviesError('Server Failure')],
        verify: (bloc) {
          verify(mockGetNowPlayingMovies.execute());
        });
  });
}
