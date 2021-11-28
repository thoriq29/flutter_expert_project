import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/common/failure.dart';
import 'package:movie/presentation/bloc/list/recommendations_bloc.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import '../../dummy_data/dummy_objects.dart';
import 'recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationBloc movieRecomendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecomendations;

  setUp(() {
    mockGetMovieRecomendations = MockGetMovieRecommendations();
    movieRecomendationBloc =
        MovieRecommendationBloc(mockGetMovieRecomendations);
  });

  final tId = 1;

  blocTest<MovieRecommendationBloc, RecommendationState>(
    'Test return (loading, loaded) when data is loaded successfully',
    build: () {
      when(mockGetMovieRecomendations.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));

      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendation(tId)),
    expect: () => [RecommendationLoading(), RecommendationLoaded(testMovieList)],
  );

  blocTest<MovieRecommendationBloc, RecommendationState>(
    'Test return (loading, error) when data is failed to loaded ',
    build: () {
      when(mockGetMovieRecomendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecomendationBloc;
    },
    act: (bloc) => bloc.add(FetchMovieRecommendation(tId)),
    expect: () =>
        [RecommendationLoading(), RecommendationError('Server Failure')],
  );
}
