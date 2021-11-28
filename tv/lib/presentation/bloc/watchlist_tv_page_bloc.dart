import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tv.dart';

part 'watchlist_tv_page_event.dart';
part 'watchlist_tv_page_state.dart';

class TvWatchlistPageBloc extends Bloc<FetchWatchlistTvSeries, WatchlistPageState> {
  final GetWatchlistTvSeries getWatchlistTv;
  
  TvWatchlistPageBloc(this.getWatchlistTv) : super(WatchlistPageEmpty());

  @override
  Stream<WatchlistPageState> mapEventToState(
    FetchWatchlistTvSeries event,
  ) async* {
    if (event is FetchWatchlistTvSeries) {
      yield WatchlistPageLoading();
      final result = await getWatchlistTv.execute();
      yield* result.fold(
        (failure) async* {
          yield WatchlistPageError(failure.message);
        },
        (data) async* {
          yield WatchlistPageLoaded(data);
        },
      );
    }
  }

}
