import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tv/common/exception.dart';
import 'package:tv/common/failure.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/datasources/watchlist_data_source.dart';
import 'package:tv/data/models/watchlist_table.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repository/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvWatchListDataSource localDataSource;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource
  });

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTvSeries() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTvSeries() async {
    try {
        final result = await remoteDataSource.getTopRatedTvSeries();
        return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvSeriesDetail(int id) async {
     try {
        final result = await remoteDataSource.getTvSeriesDetail(id);
        return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTvSeries(String query) async{
    try {
        final result = await remoteDataSource.searchTvSeries(query);
        return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvSeriesRecommendations(int id) async {
    try {
        final result = await remoteDataSource.getTvRecommendations(id);
        return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTvSeries() async {
    final result = await localDataSource.getWatchlistTvSeries();
    return Right(result.map((data) => data.toTvEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }
  
  @override
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchlist(WatchlistTable.fromTvEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchlist(WatchlistTable.fromTvEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, Season>> getTvSeasonEpisodes(int id, int seasonNumber) async {
    try {
        final result = await remoteDataSource.getTvSeasonEpisodes(id, seasonNumber);
        return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}