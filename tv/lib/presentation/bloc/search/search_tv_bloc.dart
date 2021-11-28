import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv/get_search_tv.dart';

part 'search_tv_state.dart';
part 'search_tv_event.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTV _getSearchTv;

  SearchTvBloc(this._getSearchTv) : super(SearchTvEmpty());

  @override
  Stream<SearchTvState> mapEventToState(
    SearchTvEvent event,
  ) async* {
    if (event is FetchSearchTv) {
      yield SearchTvLoading();
      final result = await _getSearchTv.execute(event.query);
      yield* result.fold(
        (failure) async* {
          yield SearchTvError(failure.message);
        },
        (data) async* {
          yield SearchTvLoaded(data);
        },
      );
    }
  }
}