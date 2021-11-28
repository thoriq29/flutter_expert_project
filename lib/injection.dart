import 'package:ditonton/presentation/bloc/system/system_bloc.dart';
import 'package:movie/data/datasource/database_helper.dart';
import 'package:movie/data/datasource/movie_remote_data_source.dart';
import 'package:movie/data/datasource/watchlist_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:movie/presentation/bloc/search/search_movie_bloc.dart';
import 'package:tv/data/datasources/database_helper.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/datasources/watchlist_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repository/tv_repository.dart';
import 'package:tv/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/tv/get_popular_tv.dart';
import 'package:tv/domain/usecases/tv/get_search_tv.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:tv/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/tv/get_tv_season_episodes.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_status.dart' as tvGetWatchStatus;
import 'package:tv/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist.dart' as tvRemoveWatchList;
import 'package:tv/domain/usecases/tv/save_watchlist.dart' as tvSaveWatchList;
import 'package:get_it/get_it.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/detail/watchlist_movie_bloc.dart';
import 'package:movie/presentation/bloc/list/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/list/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/list/recommendations_bloc.dart';
import 'package:movie/presentation/bloc/list/top_rated_movies_bloc.dart';
import 'package:tv/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/search/search_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/detail/tv_season_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendations_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_data_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_page_bloc.dart';

import 'common/ssl_pinning.dart';


final locator = GetIt.instance;

void init() {

  // bloc
  locator.registerFactory(
    () => SystemBloc(),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      getNowPlayingMovies: locator()
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator()
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator()
    ),
  );
   locator.registerFactory(
    () => SearchMovieBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingTvBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => TvRecommendationBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvBloc(
      locator()
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistPageBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeasonBloc(
      locator(),
    ),
  );
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // tv use case
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => tvGetWatchStatus.GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => tvSaveWatchList. SaveWatchlist(locator()));
  locator.registerLazySingleton(() => tvRemoveWatchList.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeasonEpisodes(locator()));


  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvWatchListDataSource>(
      () => WatchListDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<MovieWatchListDataSource>(
      () => MovieWatchListDataSourceImpl(databaseHelper: locator()));
      
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));

  // helper
  locator
      .registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
   locator.registerLazySingleton(() => SSLPinning.client);
}
