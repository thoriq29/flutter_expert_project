import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';

import 'dart:convert';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:ditonton/data/models/tv/tv_season_model.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTvSeries();
  Future<List<TvModel>> getPopularTvSeries();
  Future<List<TvModel>> getTopRatedTvSeries();
  Future<List<TvModel>> searchTvSeries(String query);
  Future<TvDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<SeasonModel> getTvSeasonEpisodes(int id, int seasonNumber);
}
class TvRemoteDataSourceImpl implements TvRemoteDataSource {

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getNowPlayingTvSeries() async {
     final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvSeries() async {
    final response =
      await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvSeries(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvSeriesDetail(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response =
      await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonModel> getTvSeasonEpisodes(int id, int seasonNumber) async {
    final response =
      await client.get(Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return SeasonModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}