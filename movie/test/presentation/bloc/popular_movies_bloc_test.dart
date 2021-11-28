import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/list/popular_movies_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';


@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(getPopularMovies: mockGetPopularMovies);
  });

  group('Now Playing Movies Bloc Test', () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
        'Test return (loading, loaded) when data is loaded successfully',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(PopularMoviesEvent()),
        expect: () =>
            [PopularMoviesLoading(), PopularMoviesLoaded(testMovieList)],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });

    blocTest<PopularMoviesBloc, PopularMoviesState>(
        'Test return (loading, error) when data is failed to loaded',
        build: () {
          when(mockGetPopularMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return popularMoviesBloc;
        },
        act: (bloc) => bloc.add(PopularMoviesEvent()),
        expect: () =>
            [PopularMoviesLoading(), PopularMoviesError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularMovies.execute());
        });
  });
}
