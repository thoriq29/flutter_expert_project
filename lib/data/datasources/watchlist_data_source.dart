import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/movie/watchlist_table.dart';

import 'db/database_helper.dart';

abstract class WatchListDataSource {
  Future<String> insertWatchlist(WatchlistTable watchlistData);
  Future<String> removeWatchlist(WatchlistTable watchlistData);

  Future<WatchlistTable?> getMovieById(int id);
  Future<List<WatchlistTable>> getWatchlistMovies();

  Future<WatchlistTable?> getTvById(int id);
  Future<List<WatchlistTable>> getWatchlistTvSeries();
}

class WatchListDataSourceImpl implements WatchListDataSource {

  final DatabaseHelper databaseHelper;

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
  Future<WatchlistTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }

  @override
  Future<WatchlistTable?> getTvById(int id) async {
    final result = await databaseHelper.getMovieById(id);
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