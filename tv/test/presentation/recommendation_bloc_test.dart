import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:tv/presentation/bloc/tv_recommendations_bloc.dart';

import '../dummy_data/dummy_objects.dart';
import 'recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationBloc tvRecommendationBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationBloc = TvRecommendationBloc(mockGetTvRecommendations);
  });

  final tId = 1;


  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'Test return (loading, loaded) when data is loaded successfully',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvList));

      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendation(tId)),
    expect: () => [TvRecommendationLoading(), TvRecommendationLoaded(testTvList)],
  );

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'Test return (loading, error) when data is failed to load',
    build: () {
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(FetchTvRecommendation(tId)),
    expect: () =>
        [TvRecommendationLoading(), TvRecommendationError('Server Failure')],
  );
}
