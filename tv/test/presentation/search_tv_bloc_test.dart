import 'package:bloc_test/bloc_test.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/domain/usecases/tv/get_search_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/search/search_tv_bloc.dart';

import '../dummyData/dummy_objects.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late SearchTvBloc searchBloc;
  late MockSearchTV mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTV();
    searchBloc = SearchTvBloc(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchTvEmpty());
  });

  final tQuery = 'spiderman';

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(testTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(FetchSearchTv(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(FetchSearchTv(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}
