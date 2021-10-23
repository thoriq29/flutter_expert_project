import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlisttvseries = <Tv>[];
  List<Tv> get watchlistTvSeries => _watchlisttvseries;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlisttvseries});

  final GetWatchlistTvSeries getWatchlisttvseries;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlisttvseries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesData) {
        _watchlistState = RequestState.Loaded;
        _watchlisttvseries = tvseriesData;
        notifyListeners();
      },
    );
  }
}
