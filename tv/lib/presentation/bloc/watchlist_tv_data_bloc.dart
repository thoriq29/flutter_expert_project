import 'package:bloc/bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_status.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist.dart';
import 'package:tv/domain/usecases/tv/save_watchlist.dart';

part 'watchlist_tv_data_event.dart';
part 'watchlist_tv_data_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistTvBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistTvEmpty());

  @override
  Stream<WatchlistTvState> mapEventToState(
    WatchlistTvEvent event,
  ) async* {
    if (event is AddToWatchList) {
      final result = await _saveWatchlist.execute(event.tv);
      yield* result.fold(
        (failure) async* {
          yield WatchlistTvError(failure.message);
        },
        (data) async* {
          yield WatchlistTvStatus(true);
        },
      );
    } else if (event is RemoveWatchList) {
      final result = await _removeWatchlist.execute(event.tv);
      yield* result.fold(
        (failure) async* {
          yield WatchlistTvError(failure.message);
        },
        (data) async* {
          yield WatchlistTvStatus(false);
        },
      );
    } else if (event is LoadWatchListStatus) {
      final result = await _getWatchListStatus.execute(event.id);
      yield WatchlistTvStatus(result);
    }
  }
}
