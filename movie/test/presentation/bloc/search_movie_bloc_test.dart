import 'package:bloc_test/bloc_test.dart';
import 'package:movie/common/failure.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/search/search_movie_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_bloc_test.mocks.dart';


@GenerateMocks(
  [SearchMovies]
)
void main() {
  late SearchMovieBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchMovieBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchMovieEmpty());
  });

  final tQuery = 'spiderman';

  blocTest<SearchMovieBloc, SearchMovieState>(
  'Test return  (Loading, HasData) when fetch data successfully',
  build: () {
    when(mockSearchMovies.execute(tQuery))
        .thenAnswer((_) async => Right(testMovieList));
    return searchBloc;
  },
  act: (bloc) => bloc.add(FetchSearchMovie(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    SearchMovieLoading(),
    SearchMovieLoaded(testMovieList),
  ],
  verify: (bloc) {
    verify(mockSearchMovies.execute(tQuery));
  },
);
 
blocTest<SearchMovieBloc, SearchMovieState>(
  'Test return (Loading, Error) when fetch search is unsuccessful',
  build: () {
    when(mockSearchMovies.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    return searchBloc;
  },
  act: (bloc) => bloc.add(FetchSearchMovie(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    SearchMovieLoading(),
    SearchMovieError('Server Failure'),
  ],
  verify: (bloc) {
    verify(mockSearchMovies.execute(tQuery));
  },
);
}
