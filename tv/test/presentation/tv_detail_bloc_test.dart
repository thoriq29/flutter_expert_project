import 'package:bloc_test/bloc_test.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../dummyData/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
])
void main() {
  late TvDetailBloc getTvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    getTvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  final tId = 1;


  group('Movie Detail BLoC Test', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'Test return (loading, loaded) when data is loaded successfully',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvDetail));
          return getTvDetailBloc;
        },
        act: (bloc) => bloc.add(GetTvDetailData(tId)),
        expect: () {
          return [TvDetailLoading(), TvDetailLoaded(testTvDetail)];
        });

    blocTest<TvDetailBloc, TvDetailState>(
      'Test return (loading, error) when data is failed to loaded',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getTvDetailBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailData(tId)),
      expect: () {
        return [TvDetailLoading(), TvDetailError('Server Failure')];
      },
    );
  });
}
