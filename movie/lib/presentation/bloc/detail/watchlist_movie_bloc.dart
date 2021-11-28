import 'package:bloc/bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist, this._getWatchlistMovies)
      : super(WatchlistMovieEmpty());

  @override
  Stream<WatchlistMovieState> mapEventToState(
    WatchlistMovieEvent event,
  ) async* {
    if (event is AddToWatchList) {
      final result = await _saveWatchlist.execute(event.movie);
      yield* result.fold(
        (failure) async* {
          yield WatchlistMovieError(failure.message);
        },
        (data) async* {
          yield WatchlistMovieStatus(true);
        },
      );
    } else if (event is RemoveWatchList) {
      final result = await _removeWatchlist.execute(event.movie);
      yield* result.fold(
        (failure) async* {
          yield WatchlistMovieError(failure.message);
        },
        (data) async* {
          yield WatchlistMovieStatus(false);
        },
      );
    } else if (event is LoadWatchListStatus) {
      final result = await _getWatchListStatus.execute(event.id);
      yield WatchlistMovieStatus(result);
    } else if (event is FetchWatchlistMovie) {
      final result = await _getWatchlistMovies.execute();
       yield* result.fold(
        (failure) async* {
        yield WatchlistMovieError(failure.message);
      }, (movie) async* {
        if(movie.length == 0) {
          yield WatchlistMovieEmpty();
        }
        yield WatchlistMovieLoaded(movie);
      });
    }
  }
}
