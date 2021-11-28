import 'package:movie/common/exception.dart';
import 'package:movie/data/models/watchlist_table.dart';

import 'database_helper.dart';

abstract class MovieWatchListDataSource {
  Future<String> insertWatchlist(WatchlistTable watchlistData);
  Future<String> removeWatchlist(WatchlistTable watchlistData);

  Future<WatchlistTable?> getMovieById(int id);
  Future<List<WatchlistTable>> getWatchlistMovies();
}

class MovieWatchListDataSourceImpl implements MovieWatchListDataSource {

  final MovieDatabaseHelper databaseHelper;

  MovieWatchListDataSourceImpl({required this.databaseHelper});

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
    final result = await databaseHelper.getWatchlistByID(id);
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
}