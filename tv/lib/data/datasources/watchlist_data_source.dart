import 'package:tv/common/exception.dart';
import 'package:tv/data/models/watchlist_table.dart';

import 'database_helper.dart';

abstract class TvWatchListDataSource {
  Future<String> insertWatchlist(WatchlistTable watchlistData);
  Future<String> removeWatchlist(WatchlistTable watchlistData);

  Future<WatchlistTable?> getTvById(int id);
  Future<List<WatchlistTable>> getWatchlistTvSeries();
}

class WatchListDataSourceImpl implements TvWatchListDataSource {

  final TvDatabaseHelper databaseHelper;

  WatchListDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable data) async {
    try {
      await databaseHelper.insertWatchlist(data);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable data) async {
    try {
      await databaseHelper.removeWatchlist(data);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getTvById(int id) async {
    final result = await databaseHelper.getWatchlistByID(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }

}